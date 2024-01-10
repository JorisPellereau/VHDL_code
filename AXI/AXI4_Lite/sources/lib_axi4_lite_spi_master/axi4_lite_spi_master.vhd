-------------------------------------------------------------------------------
-- Title      : AXI4 Lite SPI MASTER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_spi_master.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-17
-- Last update: 2024-01-10
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Lite SPI MASTER
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
library lib_axi4_lite_spi_master;

library lib_spi_master;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity axi4_lite_spi_master is
  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 5 to 64  := 5;    -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32;   -- AXI4 Lite DATA WIDTH
    G_SPI_SIZE             : integer range 1 to 4   := 4;    -- SPI Size
    G_SPI_DATA_WIDTH       : integer                := 8;    -- SPI DATA WIDTH
    G_FIFO_DATA_WIDTH      : integer range 8 to 32  := 8;    -- FIFO DATA WIDTH
    G_FIFO_DEPTH           : integer                := 1024  -- FIFO DEPTH
    );
  port (
    clk_sys   : in std_logic;                                -- System Clock
    rst_n_sys : in std_logic;                                -- Asynchronous Reset

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

    -- SPI MASTER I/F
    spi_clk  : out std_logic;                                  -- MASTER SPI Clock
    spi_cs_n : out std_logic;                                  -- MASTER SPI Chip Select
    spi_do   : out std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- SPI Data Oute
    spi_di   : in  std_logic_vector(G_SPI_SIZE - 1 downto 0)   -- SPI Data In
    );

end entity axi4_lite_spi_master;

architecture rtl of axi4_lite_spi_master is

  -- == INTERNAL Signals ==
  signal slv_start   : std_logic;                                                  -- Start the access
  signal slv_rw      : std_logic;                                                  -- Read or Write Access
  signal slv_addr    : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);      -- ADDR to reach
  signal slv_wdata   : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Write Data
  signal slv_strobe  : std_logic_vector((G_AXI4_LITE_DATA_WIDTH/8) - 1 downto 0);  -- Write Strobe
  signal slv_done    : std_logic;                                                  -- Access done
  signal slv_rdata   : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Slave read data
  signal slv_status  : std_logic_vector(1 downto 0);                               -- Slave status
  signal enable      : std_logic;                                                  -- Enable signal
  signal cmd_start   : std_logic;                                                  -- Command Start
  signal cmd         : std_logic_vector(13 downto 0);                              -- Command
  signal cmd_data    : std_logic_vector(7 downto 0);                               -- Command Data
  signal matrix_idx  : std_logic_vector(log2(G_MATRIX_NB) - 1 downto 0);           -- Matrix Index
  signal fifo_full   : std_logic;                                                  -- FIFO FULL
  signal fifo_empty  : std_logic;                                                  -- FIFO Empty
  signal ctrl_status : std_logic;                                                  -- Control Status
  signal ctrl_done   : std_logic;                                                  -- Control done

  signal start_spi         : std_logic;                                          -- Start SPI
  signal cpha              : std_logic;                                          -- CPHA Configuration
  signal cpol              : std_logic;                                          -- CPOL Configuration
  signal full_duplex       : std_logic;                                          -- Full Duplex Configuration
  signal clk_div           : std_logic_vector(7 downto 0);                       -- Clock Division Configuration
  signal nb_wr             : std_logic_vector(log2(G_FIFO_DEPTH) - 1 downto 0);  -- Number of Write to perform
  signal nb_rd             : std_logic_vector(log2(G_FIFO_DEPTH) - 1 downto 0);  -- Number of Read to perform
  signal wdata_fifo_tx     : std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);   -- FIFO TX Data
  signal wr_en_fifo_tx     : std_logic;                                          -- FIFO TX Write Enable    
  signal rdata_fifo_rx     : std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);   -- FIFO RX Data
  signal rdata_fifo_rx_val : std_logic;                                          -- FIFO RX Data Valid
  signal rd_en_fifo_rx     : std_logic;                                          -- FIFO RX Read Enable
  signal fifo_tx_empty     : std_logic;                                          -- FIFO TX Empty Flag
  signal fifo_tx_full      : std_logic;                                          -- FIFO TX Full Flag
  signal fifo_rx_empty     : std_logic;                                          -- FIFO RX Empty Flag
  signal fifo_rx_full      : std_logic;                                          -- FIFO RX Full Flag
  signal spi_busy          : std_logic;                                          -- SPI BUSY Flag

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
  i_axi4_lite_spi_master_registers_0 : entity lib_axi4_lite_spi_master.axi4_lite_spi_master_registers
    generic map(
      G_ADDR_WIDTH      => G_AXI4_LITE_ADDR_WIDTH,
      G_DATA_WIDTH      => G_AXI4_LITE_DATA_WIDTH,
      G_SPI_DATA_WIDTH  => G_SPI_DATA_WIDTH,
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
      start_spi         => start_spi,
      cpha              => cpha,
      cpol              => cpol,
      full_duplex       => full_duplex,
      clk_div           => clk_div,
      nb_wr             => nb_wr,
      nb_rd             => nb_rd,
      wdata_fifo_tx     => wdata_fifo_tx,
      wr_en_fifo_tx     => wr_en_fifo_tx,
      rdata_fifo_rx     => rdata_fifo_rx,
      rdata_fifo_rx_val => rdata_fifo_rx_val,
      rd_en_fifo_rx     => rd_en_fifo_rx,
      fifo_tx_empty     => fifo_tx_empty,
      fifo_tx_full      => fifo_tx_full,
      fifo_rx_empty     => fifo_rx_empty,
      fifo_rx_full      => fifo_rx_full,
      spi_busy          => spi_busy
      );

  -- Instanciation of SPI MASTER
  i_spi_master_0 : entity lib_spi_master.spi_master
    generic map (
      G_SPI_SIZE        => G_SPI_SIZE,
      G_SPI_DATA_WIDTH  => G_SPI_DATA_WIDTH,
      G_FIFO_DATA_WIDTH => G_FIFO_DATA_WIDTH,
      G_FIFO_DEPTH      => G_FIFO_DEPTH
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- FIFO TX Interface
      wr_en_fifo_tx => wr_en_fifo_tx,
      wdata_fifo_tx => wdata_fifo_tx,

      -- FIFO RX Interface
      rd_en_fifo_rx => rd_en_fifo_rx,
      rdata_fifo_rx => rdata_fifo_rx,

      -- SPI Control
      start       => start_spi,
      nb_wr       => nb_wr,
      nb_rd       => nb_rd,
      full_duplex => full_duplex,
      cpha        => cpha,
      cpol        => cpol,
      clk_div     => clk_div,
      spi_clk     => spi_clk,
      spi_cs_n    => spi_cs_n,
      spi_do      => spi_do,
      spi_di      => spi_di,
      spi_busy    => spi_busy
      );
end architecture rtl;
