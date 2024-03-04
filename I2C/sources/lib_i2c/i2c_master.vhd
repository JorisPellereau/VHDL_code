-------------------------------------------------------------------------------
-- Title      : I2C Master
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2c_master.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-31
-- Last update: 2024-03-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: I2C MASTER
-- /!\ Limitations : FIFO's Flags are not read yet by the i2c_master_itf block.
-- Data are transmitted with MSB first
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-31  1.0      linux-jp        Created
-------------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_fifo_wrapper;

library lib_i2c;
library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity i2c_master is
  generic (
    G_I2C_FREQ        : integer range 100000 to 400000 := 400000;    -- '0' : 100kHz - '1' : 400kHz
    G_CLKSYS_FREQ     : integer                        := 50000000;  -- clk_sys frequency
    G_NB_DATA         : integer                        := 256;       -- Number of MAXIMUM data to transmit
    G_FIFO_DATA_WIDTH : integer                        := 8;         -- FIFO DATA WIDTH
    G_FIFO_DEPTH      : integer                        := 1024       -- FIFO DPETH
    );
  port (
    clk_sys   : in std_logic;                                        -- Clock
    rst_n_sys : in std_logic;                                        -- Asynchronous Reset

    -- Control Signals
    start     : in std_logic;                                   -- Start I2C Transaction
    rw        : in std_logic;                                   -- R/W acces
    chip_addr : in std_logic_vector(6 downto 0);                -- Chip addr to request
    nb_data   : in std_logic_vector(log2(G_NB_DATA) downto 0);  -- Number of Bytes to Read or Write

    -- FIFO TX Control and Status
    wr_en_fifo_tx      : in  std_logic;                     -- Write Enable to the FIFO TX
    wdata_fifo_tx      : in  std_logic_vector(7 downto 0);  -- Write DAta FIFO TX
    fifo_empty_fifo_tx : out std_logic;                     -- FIFO TX EMPTY FLAG
    fifo_full_fifo_tx  : out std_logic;                     -- FIFO TX FULL FLAG

    -- FIFO RX Control and Status
    rd_en_fifo_rx      : in  std_logic;                     -- Read Enable to the FIFO RX
    rdata_fifo_rx      : out std_logic_vector(7 downto 0);  -- Read Data FIFO RX
    fifo_empty_fifo_rx : out std_logic;                     -- FIFO RX EMPTY FLAG
    fifo_full_fifo_rx  : out std_logic;                     -- FIFO RX FULL FLAG

    -- Status and data
    sack_error : out std_logic;         -- Slave ACK Error
    busy       : out std_logic;         -- I2C Master BUSY Flag

    -- I2C Interface    
    sclk    : out std_logic;            -- SCLK
    sclk_en : out std_logic;            -- Enable SCLK
    sda_in  : in  std_logic;            -- Input Data
    sda_out : out std_logic;            -- Output Data
    sda_en  : out std_logic             -- Enable SDA
    );

end entity i2c_master;

architecture behv of i2c_master is

  -- == INTERNAL Signals ==
  signal rd_en_fifo_tx : std_logic;                                         -- Read Enable FIFO TX
  signal wr_en_fifo_rx : std_logic;                                         -- Write Enable FIFO RX
  signal wdata_fifo_rx : std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);  -- Write DATA FIFO RX
  signal rdata_fifo_tx : std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);  -- Read Data FIFO TX

begin  -- architecture behv

  -- Instanciation of the FIFO TX
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

  -- I2C Master Itf instanciation
  i_i2c_master_itf_0 : entity lib_i2c.i2c_master_itf
    generic map(
      G_I2C_FREQ    => G_I2C_FREQ,
      G_CLKSYS_FREQ => G_CLKSYS_FREQ,
      G_NB_DATA     => G_NB_DATA
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

      -- Control Signals
      start     => start,
      rw        => rw,
      chip_addr => chip_addr,
      nb_data   => nb_data,

      -- I2C Status
      sack_error => sack_error,
      busy       => busy,

      -- I2C Interface    
      sclk    => sclk,
      sclk_en => sclk_en,
      sda_in  => sda_in,
      sda_out => sda_out,
      sda_en  => sda_en
      );

end architecture behv;
