-------------------------------------------------------------------------------
-- Title      : AXI4 Lite I2C MASTER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_i2c_master.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-17
-- Last update: 2024-03-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Lite I2C MASTER
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-17  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_axi4_lite;
library lib_axi4_lite_i2c_master;

library lib_i2c;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity axi4_lite_i2c_master is
  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 5 to 64          := 5;        -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64         := 32;       -- AXI4 Lite DATA WIDTH
    G_NB_DATA              : integer                        := 256;      -- FIFO DATA WIDTH
    G_FIFO_DATA_WIDTH      : integer                        := 8;        -- FIFO DATA WIDTH
    G_FIFO_DEPTH           : integer                        := 1024;     -- FIFO DEPTH
    G_I2C_FREQ             : integer range 100000 to 400000 := 400000;   -- '0' : 100kHz - '1' : 400kHz
    G_CLKSYS_FREQ          : integer                        := 50000000  -- clk_sys frequency
    );
  port (
    clk_sys   : in std_logic;                                            -- System Clock
    rst_n_sys : in std_logic;                                            -- Asynchronous Reset

    -- Write Address Channel signals
    awvalid : in  std_logic;                                              -- Address Write Valid
    awaddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
    awprot  : in  std_logic_vector(2 downto 0);                           -- Adress Write Prot
    awready : out std_logic;                                              -- Address Write Ready

    -- Write Data Channel
    wvalid : in  std_logic;                                                    -- Write Data Valid
    wdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);        -- Write Data
    wstrb  : in  std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
    wready : out std_logic;                                                    -- Write data Ready

    -- Write Response Channel
    bready : in  std_logic;                     -- Write Channel Response
    bvalid : out std_logic;                     -- Write Response Channel Valid
    bresp  : out std_logic_vector(1 downto 0);  -- Write Response Channel resp

    -- Read Address Channel
    arvalid : in  std_logic;                                              -- Read Channel Valid
    araddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot  : in  std_logic_vector(2 downto 0);                           --  Read Address channel Ready Prot
    arready : out std_logic;                                              -- Read Address Channel Ready

    -- Read Data Channel
    rready : in  std_logic;                                              -- Read Data Channel Ready
    rvalid : out std_logic;                                              -- Read Data Channel Valid
    rdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp  : out std_logic_vector(1 downto 0);                           -- Read Data Channel Response

    -- I2C MASTER I/F   
    sclk    : out std_logic;            -- SCLK
    sclk_en : out std_logic;            -- Enable SCLK
    sda_in  : in  std_logic;            -- Input Data
    sda_out : out std_logic;            -- Output Data
    sda_en  : out std_logic             -- Enable SDA
    );

end entity axi4_lite_i2c_master;

architecture rtl of axi4_lite_i2c_master is

  -- == INTERNAL Signals ==
  signal slv_start  : std_logic;                                                  -- Start the access
  signal slv_rw     : std_logic;                                                  -- Read or Write Access
  signal slv_addr   : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);      -- ADDR to reach
  signal slv_wdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Write Data
  signal slv_strobe : std_logic_vector((G_AXI4_LITE_DATA_WIDTH/8) - 1 downto 0);  -- Write Strobe
  signal slv_done   : std_logic;                                                  -- Access done
  signal slv_rdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Slave read data
  signal slv_status : std_logic_vector(1 downto 0);                               -- Slave status

  signal start_i2c     : std_logic;                                  -- START I2C Transaction
  signal rw            : std_logic;                                  -- I2C Read or Write access
  signal chip_addr     : std_logic_vector(6 downto 0);               -- I2C Slave Chip Addr
  signal nb_data       : std_logic_vector(log2(G_NB_DATA)downto 0);  -- Number of data on the I2C Access
  signal wr_en_fifo_tx : std_logic;                                  -- Write Enable FIFO TX
  signal wdata_fifo_tx : std_logic_vector(7 downto 0);               -- Write DATA FIFO TX
  signal rd_en_fifo_rx : std_logic;                                  -- Read Enable FIFO RX
  signal rdata_fifo_rx : std_logic_vector(7 downto 0);               -- Read DATA FIFO RX
  signal fifo_tx_empty : std_logic;                                  -- FIFO TX Empty flag
  signal fifo_tx_full  : std_logic;                                  -- FIFO TX Full flag
  signal fifo_rx_empty : std_logic;                                  -- FIFO RX Empty flag
  signal fifo_rx_full  : std_logic;                                  -- FIFO RX Full flag
  signal sack_error    : std_logic;                                  -- Salve ACK Error flag
  signal i2c_busy      : std_logic;                                  -- I2C Access ongoing flag
begin  -- architecture rtl

  -- Instanciation of AXI4 Lite Slave interface
  i_axi4_lite_slave_itf_0 : entity lib_axi4_lite.axi4_lite_slave_itf
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => G_AXI4_LITE_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI4_LITE_DATA_WIDTH
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid,
      awaddr  => awaddr,
      awprot  => awprot,
      awready => awready,

      -- Write Data Channel
      wvalid => wvalid,
      wdata  => wdata,
      wstrb  => wstrb,
      wready => wready,

      -- Write Response Channel
      bready => bready,
      bvalid => bvalid,
      bresp  => bresp,

      -- Read Address Channel
      arvalid => arvalid,
      araddr  => araddr,
      arprot  => arprot,
      arready => arready,

      -- Read Data Channel
      rready => rready,
      rvalid => rvalid,
      rdata  => rdata,
      rresp  => rresp,

      -- Slave Registers Interface
      slv_start  => slv_start,
      slv_rw     => slv_rw,
      slv_addr   => slv_addr,
      slv_wdata  => slv_wdata,
      slv_strobe => slv_strobe,

      slv_done   => slv_done,
      slv_rdata  => slv_rdata,
      slv_status => slv_status
      );


  -- Instanciation of LCD REGISTERS
  i_axi4_lite_i2c_master_registers_0 : entity lib_axi4_lite_i2c_master.axi4_lite_i2c_master_registers
    generic map(
      G_ADDR_WIDTH      => G_AXI4_LITE_ADDR_WIDTH,
      G_DATA_WIDTH      => G_AXI4_LITE_DATA_WIDTH,
      G_NB_DATA         => G_NB_DATA,
      G_FIFO_DATA_WIDTH => G_FIFO_DATA_WIDTH,
      G_FIFO_DEPTH      => G_FIFO_DEPTH
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- Slave Registers Interface
      slv_start  => slv_start,
      slv_rw     => slv_rw,
      slv_addr   => slv_addr,
      slv_wdata  => slv_wdata,
      slv_strobe => slv_strobe,

      slv_done   => slv_done,
      slv_rdata  => slv_rdata,
      slv_status => slv_status,

      -- Registers Interface
      -- I2C Control
      start_i2c => start_i2c,
      rw        => rw,
      chip_addr => chip_addr,
      nb_data   => nb_data,

      -- FIFO ITF
      wr_en_fifo_tx => wr_en_fifo_tx,
      wdata_fifo_tx => wdata_fifo_tx,

      rd_en_fifo_rx => rd_en_fifo_rx,
      rdata_fifo_rx => rdata_fifo_rx,

      -- Status
      fifo_tx_empty => fifo_tx_empty,
      fifo_tx_full  => fifo_tx_full,
      fifo_rx_empty => fifo_rx_empty,
      fifo_rx_full  => fifo_rx_full,
      sack_error    => sack_error,
      i2c_busy      => i2c_busy
      );

  -- Instanciation of I2C MASTER
  i_i2c_master_0 : entity lib_i2c.i2c_master
    generic map(
      G_I2C_FREQ        => G_I2C_FREQ,
      G_CLKSYS_FREQ     => G_CLKSYS_FREQ,
      G_NB_DATA         => G_NB_DATA,
      G_FIFO_DATA_WIDTH => G_FIFO_DATA_WIDTH,
      G_FIFO_DEPTH      => G_FIFO_DEPTH
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Control Signals
      start     => start_i2c,
      rw        => rw,
      chip_addr => chip_addr,
      nb_data   => nb_data,

      -- FIFO TX Control and Status
      wr_en_fifo_tx      => wr_en_fifo_tx,
      wdata_fifo_tx      => wdata_fifo_tx,
      fifo_empty_fifo_tx => fifo_tx_empty,
      fifo_full_fifo_tx  => fifo_tx_full,

      -- FIFO RX Control and Status
      rd_en_fifo_rx      => rd_en_fifo_rx,
      rdata_fifo_rx      => rdata_fifo_rx,
      fifo_empty_fifo_rx => fifo_rx_empty,
      fifo_full_fifo_rx  => fifo_rx_full,

      -- Status and data
      sack_error => sack_error,
      busy       => i2c_busy,

      -- I2C Interface    
      sclk    => sclk,
      sclk_en => sclk_en,
      sda_in  => sda_in,
      sda_out => sda_out,
      sda_en  => sda_en
      );

end architecture rtl;
