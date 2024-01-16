-------------------------------------------------------------------------------
-- Title      : AXI4 Lite SPI SLAVE
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_spi_slave.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-17
-- Last update: 2024-01-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Lite SPI SLAVE
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
library lib_axi4_lite_spi_slave;

library lib_spi_slave;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity axi4_lite_spi_slave is
  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 5 to 64  := 5;     -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32;    -- AXI4 Lite DATA WIDTH
    G_SPI_SIZE             : integer range 1 to 4   := 4;     -- SPI Size
    G_SPI_DATA_WIDTH       : integer                := 8;     -- SPI DATA WIDTH
    G_FIFO_DATA_WIDTH      : integer range 8 to 32  := 8;     -- FIFO DATA WIDTH
    G_FIFO_DEPTH           : integer                := 1024;  -- FIFO DEPTH
    G_CPHA                 : std_logic              := '0';   -- CPHA HARD Configuration
    G_CPOL                 : std_logic              := '0'    -- CPOL HARD Configuration
    );
  port (
    clk_sys   : in std_logic;                                 -- System Clock
    rst_n_sys : in std_logic;                                 -- Asynchronous Reset

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

    -- SPI SLAVE I/F
    spi_clk      : in  std_logic;                                  -- MASTER SPI Clock
    spi_cs_n     : in  std_logic;                                  -- MASTER SPI Chip Select
    spi_do       : out std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- SPI Data Oute
    spi_di       : in  std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- SPI Data In
    spi_slave_it : out std_logic                                   -- SPI Slave Interruption
    );

end entity axi4_lite_spi_slave;

architecture rtl of axi4_lite_spi_slave is

  -- == INTERNAL Signals ==
  signal slv_start         : std_logic;                                                  -- Start the access
  signal slv_rw            : std_logic;                                                  -- Read or Write Access
  signal slv_addr          : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);      -- ADDR to reach
  signal slv_wdata         : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Write Data
  signal slv_strobe        : std_logic_vector((G_AXI4_LITE_DATA_WIDTH/8) - 1 downto 0);  -- Write Strobe
  signal slv_done          : std_logic;                                                  -- Access done
  signal slv_rdata         : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Slave read data
  signal slv_status        : std_logic_vector(1 downto 0);                               -- Slave status
  signal rdata_fifo_rx     : std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);           -- FIFO RX Data
  signal rdata_fifo_rx_val : std_logic;                                                  -- FIFO RX Data Valid
  signal rd_en_fifo_rx     : std_logic;                                                  -- FIFO RX Read Enable
  signal spi_busy          : std_logic;                                                  -- SPI BUSY Flag

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
  i_axi4_lite_spi_slave_registers_0 : entity lib_axi4_lite_spi_slave.axi4_lite_spi_slave_registers
    generic map(
      G_ADDR_WIDTH      => G_AXI4_LITE_ADDR_WIDTH,
      G_DATA_WIDTH      => G_AXI4_LITE_DATA_WIDTH,
      G_SPI_DATA_WIDTH  => G_SPI_DATA_WIDTH,
      G_FIFO_DATA_WIDTH => G_FIFO_DATA_WIDTH
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Slave Registers Interface
      slv_start  => slv_start,
      slv_rw     => slv_rw,
      slv_addr   => slv_addr,
      slv_wdata  => slv_wdata,
      slv_strobe => slv_strobe,

      slv_done   => slv_done,
      slv_rdata  => slv_rdata,
      slv_status => slv_status,

      -- FIFO RX FLAG
      fifo_rx_empty => '0',             -- Not used yet
      fifo_rx_full  => '0',             -- Not used yet

      -- FIFO TX FLAG
      fifo_tx_empty => '0',             -- Not used yet
      fifo_tx_full  => '0',             -- Not used yet

      -- Registers Interface
      rd_fifo_rx_en     => rd_en_fifo_rx,
      rdata_fifo_rx     => rdata_fifo_rx,
      rdata_fifo_rx_val => rdata_fifo_rx_val,
      spi_busy          => spi_busy
      );

  -- Instanciation of SPI SLAVE
  i_spi_slave_0 : entity lib_spi_slave.spi_slave
    generic map (
      G_SPI_SIZE        => G_SPI_SIZE,
      G_DATA_WIDTH      => G_SPI_DATA_WIDTH,
      G_FIFO_DATA_WIDTH => G_FIFO_DATA_WIDTH,
      G_FIFO_DEPTH      => G_FIFO_DEPTH,
      G_CPHA            => G_CPHA,
      G_CPOL            => G_CPOL
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- FIFO RX
      spi_rd_en     => rd_en_fifo_rx,
      spi_rdata     => rdata_fifo_rx,
      spi_rdata_val => rdata_fifo_rx_val,

      -- SPI Control
      spi_clk      => spi_clk,
      spi_cs_n     => spi_cs_n,
      spi_do       => spi_do,
      spi_di       => spi_di,
      spi_busy     => spi_busy,
      spi_slave_it => spi_slave_it
      );

end architecture rtl;
