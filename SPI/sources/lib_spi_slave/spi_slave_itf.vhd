-------------------------------------------------------------------------------
-- Title      : SPI Slave Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : spi_slave_itf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-09
-- Last update: 2024-01-09
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: SPI Slave Interface
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-09  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity spi_slave_itf is

  generic (
    G_SPI_SIZE        : integer range 1 to 4  := 4;    -- SPI Size
    G_DATA_WIDTH      : integer               := 8;    -- Data Width
    G_FIFO_DATA_WIDTH : integer range 8 to 32 := 8;    -- FIFO DATA WIDTH
    G_FIFO_DEPTH      : integer               := 1024  -- FIFO DEPTH
    );
  port (
    clk_sys   : in std_logic;                          -- Clock System
    rst_n_sys : in std_logic;                          -- Asynchronous Reset

    -- FIFO TX Interface
    fifo_tx_rd_en : out std_logic;                                    -- FIFO TX Read Enable
    fifo_tx_data  : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- FIFO TX DATA

    -- FIFO RX Interface
    fifo_rx_wr_en : out std_logic;                                    -- FIFO RX Write Enable
    fifo_rx_data  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- FIFO RX DATA

    -- SPI Control
    full_duplex : in std_logic;         -- Full Duplex configuration
    cpha        : in std_logic;         -- SPI SPHA Configuration
    cpol        : in std_logic;         -- SPI CPOL Configuration

    spi_clk  : in  std_logic;                                  -- MASTER SPI Clock
    spi_cs_n : in  std_logic;                                  -- MASTER SPI Chip Select - Actif at '0'
    spi_do   : out std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- SPI Data Out
    spi_di   : in  std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- SPI Data In
    spi_busy : out std_logic                                   -- SPI Is busy
    );

end entity spi_slave_itf;

architecture rtl of spi_master_itf is

begin  -- architecture rtl



end architecture rtl;
