-------------------------------------------------------------------------------
-- Title      : SPI Slave
-- Project    : 
-------------------------------------------------------------------------------
-- File       : spi_slave.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-09
-- Last update: 2024-01-21
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-09  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_spi_slave;
library lib_fifo_wrapper;

entity spi_slave is
  generic (
    G_SPI_SIZE        : integer range 1 to 4  := 4;     -- SPI Size
    G_DATA_WIDTH      : integer               := 8;     -- Data Width
    G_FIFO_DATA_WIDTH : integer range 8 to 32 := 8;     -- FIFO DATA WIDTH
    G_FIFO_DEPTH      : integer               := 1024;  -- FIFO DEPTH
    G_CPHA            : std_logic             := '0';   -- CPHA HARD Configuration
    G_CPOL            : std_logic             := '0'    -- CPOL HARD Configuration
    );
  port (
    clk_sys   : in std_logic;                           -- Clock system
    rst_n_sys : in std_logic;                           -- Asynchronous Reset

    -- FIFO RX
    spi_rd_en     : in  std_logic;                                         -- FIFO RX Read Rnable
    spi_rdata     : out std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);  -- SPI Read Dzta from FIFO
    spi_rdata_val : out std_logic;                                         -- SPI Read Data from FIFO Valid
    fifo_rx_empty : out std_logic;                                         -- FIFO RX Empty Flag
    fifo_rx_full  : out std_logic;                                         -- FIFO RX Full Flag

    -- SPI Control
    spi_clk      : in  std_logic;                                  -- MASTER SPI Clock
    spi_cs_n     : in  std_logic;                                  -- MASTER SPI Chip Select - Actif at '0'
    spi_do       : out std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- SPI Data Out
    spi_di       : in  std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- SPI Data In
    spi_busy     : out std_logic;                                  -- SPI Is busy
    spi_slave_it : out std_logic                                   -- SPI DONE
    );
end entity spi_slave;


architecture rtl of spi_slave is

  -- == INTERNAL Signals ==
  signal wr_rx_en          : std_logic;                                        -- FIFO Write RX enable
  signal wdata_rx          : std_logic_vector(G_FIFO_DATA_WIDTH -1 downto 0);  -- Write DATA FIFO RX
  signal fifo_rx_empty_int : std_logic;                                        -- FIFO RX EMPTY FLAG
  signal fifo_rx_full_int  : std_logic;                                        -- FIFO RX FULL FLAG

begin  -- architecture rtl

  -- FIFO RX Management-- Instanciation of the FIFO Wrapper
  i_fifo_rx_sp_ram_wrapper_0 : entity lib_fifo_wrapper.fifo_sp_ram_wrapper
    generic map (
      G_DATA_WIDTH => G_FIFO_DATA_WIDTH,
      G_ADDR_WIDTH => 10                -- 2^10
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- FIFO CTRL
      wr_en     => wr_rx_en,
      rd_en     => spi_rd_en,
      wdata     => wdata_rx,
      rdata     => spi_rdata,
      rdata_val => spi_rdata_val,

      -- FIFO Status
      fifo_empty => fifo_rx_empty_int,
      fifo_full  => fifo_rx_full_int
      );

  -- SPI Interface instanciation
  i_spi_slave_itf_0 : entity lib_spi_slave.spi_slave_itf
    generic map (
      G_SPI_SIZE        => G_SPI_SIZE,
      G_DATA_WIDTH      => G_DATA_WIDTH,
      G_FIFO_DATA_WIDTH => G_FIFO_DATA_WIDTH,
      G_FIFO_DEPTH      => G_FIFO_DEPTH,
      G_CPHA            => G_CPHA,
      G_CPOL            => G_CPOL
      )
    port map (
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- FIFO TX Interface
      fifo_tx_rd_en => open,             -- NOT USED for the moment
      fifo_tx_data  => (others => '0'),  -- NOT USED for the moment

      -- FIFO RX Interface
      fifo_rx_wr_en => wr_rx_en,
      fifo_rx_data  => wdata_rx,

      -- SPI Control
      spi_clk      => spi_clk,
      spi_cs_n     => spi_cs_n,
      spi_do       => spi_do,
      spi_di       => spi_di,
      spi_busy     => spi_busy,
      spi_slave_it => spi_slave_it
      );

  -- == OUTPUTS Affectation ==
  fifo_rx_empty <= fifo_rx_empty_int;
  fifo_rx_full  <= fifo_rx_full_int;

end architecture rtl;
