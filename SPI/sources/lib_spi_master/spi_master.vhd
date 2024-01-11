-------------------------------------------------------------------------------
-- Title      : SPI Master
-- Project    : 
-------------------------------------------------------------------------------
-- File       : spi_master.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-05
-- Last update: 2024-01-11
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: SPI Master
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-05  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_fifo_wrapper;
library lib_spi_master;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity spi_master is
  generic (
    G_SPI_SIZE        : integer range 1 to 4  := 4;    -- SPI Size
    G_SPI_DATA_WIDTH  : integer               := 8;    -- SPI DATA WIDTH
    G_FIFO_DATA_WIDTH : integer range 8 to 32 := 8;    -- FIFO DATA WIDTH
    G_FIFO_DEPTH      : integer               := 1024  -- FIFO DEPTH
    );
  port (
    clk_sys   : in std_logic;                          -- Clock System
    rst_n_sys : in std_logic;                          -- Asynchronous Reset

    -- FIFO TX Interface
    wr_en_fifo_tx : in  std_logic;                                         -- Write Enable FIFO TX
    wdata_fifo_tx : in  std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);  -- FIFO Write Data
    fifo_tx_empty : out std_logic;                                         -- FIFO TX EMPTY FLAG
    fifo_tx_full  : out std_logic;                                         -- FIFO TX FULL FLAG

    -- FIFO RX Interface
    rd_en_fifo_rx : in  std_logic;                                         -- read Enable FIFO RX
    rdata_fifo_rx : out std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);  -- FIFO Read Data
    fifo_rx_empty : out std_logic;                                         -- FIFO RX EMPTY FLAG
    fifo_rx_full  : out std_logic;                                         -- FIFO RX FULL FLAG

    -- SPI Control
    start       : in  std_logic;                                          -- Start the SPI transaction on pulse
    nb_wr       : in  std_logic_vector(log2(G_FIFO_DEPTH) - 1 downto 0);  -- Number of write to send
    nb_rd       : in  std_logic_vector(log2(G_FIFO_DEPTH) - 1 downto 0);  -- Number of read to perform
    full_duplex : in  std_logic;                                          -- Fulle Duplux configuration
    cpha        : in  std_logic;                                          -- SPI SPHA Configuration
    cpol        : in  std_logic;                                          -- SPI CPOL Configuration
    clk_div     : in  std_logic_vector(7 downto 0);                       -- Clock Division
    spi_clk     : out std_logic;                                          -- MASTER SPI Clock
    spi_cs_n    : out std_logic;                                          -- MASTER SPI Chip Select
    spi_do      : out std_logic_vector(G_SPI_SIZE - 1 downto 0);          -- SPI Data Oute
    spi_di      : in  std_logic_vector(G_SPI_SIZE - 1 downto 0);          -- SPI Data In
    spi_busy    : out std_logic                                           -- SPI Busy Flag
    );
end entity spi_master;

architecture rtl of spi_master is

  -- == INTERNAL Signals ==
  signal rd_en_fifo_tx      : std_logic;                                         -- read Enable FIFO TX
  signal rdata_fifo_tx      : std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);  -- FIFO Read Data
  signal fifo_empty_fifo_tx : std_logic;                                         -- Empty Flag FIFO TX
  signal fifo_full_fifo_tx  : std_logic;                                         -- Full Flag FIFO TX

  signal wr_en_fifo_rx      : std_logic;                                         -- Write Enable FIFO RX 
  signal wdata_fifo_rx      : std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);  -- FIFO Write Data
  signal fifo_empty_fifo_rx : std_logic;                                         -- Empty Flag FIFO RX
  signal fifo_full_fifo_rx  : std_logic;                                         -- Full Flag FIFO RX

begin  -- architecture rtl

  -- FIFO TX Instanciation
  i_fifo_tx_0 : entity lib_fifo_wrapper.fifo_sp_ram_fast_wrapper
    generic map (
      G_DATA_WIDTH => G_FIFO_DATA_WIDTH,
      G_ADDR_WIDTH => log2(G_FIFO_DEPTH)
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- FIFO CTRL
      wr_en => wr_en_fifo_tx,
      rd_en => rd_en_fifo_tx,
      wdata => wdata_fifo_tx,
      rdata => rdata_fifo_tx,

      -- FIFO Status
      fifo_empty => fifo_empty_fifo_tx,
      fifo_full  => fifo_full_fifo_tx
      );

  -- SPI ITF Instancation
  i_spi_master_itf_0 : entity lib_spi_master.spi_master_itf
    generic map (
      G_SPI_SIZE        => G_SPI_SIZE,
      G_DATA_WIDTH      => G_SPI_DATA_WIDTH,
      G_FIFO_DATA_WIDTH => G_FIFO_DATA_WIDTH,
      G_FIFO_DEPTH      => G_FIFO_DEPTH
      )
    port map (
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- FIFO TX Interface
      fifo_tx_rd_en => rd_en_fifo_tx,
      fifo_tx_data  => rdata_fifo_tx,

      -- FIFO RX Interface
      fifo_rx_wr_en => wr_en_fifo_rx,
      fifo_rx_data  => wdata_fifo_rx,

      -- SPI Control
      start       => start,
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

  -- FIFO RX Instanciation
  i_fifo_rx_0 : entity lib_fifo_wrapper.fifo_sp_ram_fast_wrapper
    generic map (
      G_DATA_WIDTH => G_FIFO_DATA_WIDTH,
      G_ADDR_WIDTH => log2(G_FIFO_DEPTH)
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- FIFO CTRL
      wr_en => wr_en_fifo_rx,
      rd_en => rd_en_fifo_rx,
      wdata => wdata_fifo_rx,
      rdata => rdata_fifo_rx,

      -- FIFO Status
      fifo_empty => fifo_empty_fifo_rx,
      fifo_full  => fifo_full_fifo_rx
      );

  -- Outputs affectations
  fifo_tx_empty <= fifo_empty_fifo_tx;
  fifo_tx_full  <= fifo_full_fifo_tx;
  fifo_rx_empty <= fifo_empty_fifo_rx;
  fifo_rx_full  <= fifo_full_fifo_rx;

end architecture rtl;
