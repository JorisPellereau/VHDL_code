-------------------------------------------------------------------------------
-- Title      : Master SPI - 4 Wire mode
-- Project    : 
-------------------------------------------------------------------------------
-- File       : master_spi.vhd
-- Author     :   Joris Pellereau
-- Company    : 
-- Created    : 2019-05-03
-- Last update: 2019-05-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file is le master SPI module - 4 Wire mode
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-03  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use lib_spi;
use lib_spi.pkg_spi.all;

entity master_spi is

  generic (
    cpol         : bit     := '0';                        -- Clock Polarity
    cpha         : bit     := '0';                        -- Clock phase
    data_size    : integer := 8;                          -- Size of the data
    slave_number : integer range 1 to max_slave_number);  -- Number of slave

  port (
    reset_n   : in  std_logic;          -- Asynchronous reset
    clock     : in  std_logic;          -- System clock
    ssi       : in  std_logic_vector(slave_number - 1 downto 0);  -- Slave Select input
    start_spi : in  std_logic;          -- Start SPI transaction
    wdata     : in  std_logic_vector(data_size - 1 downto 0);  -- Data to transmit
    miso      : in  std_logic;          -- Master In Slave Out
    mosi      : out std_logic;          -- Master Out Slave In
    sclk      : out std_logic;          -- Serial Clock
    ssn       : out std_logic_vector(slave_number - 1 downto 0);  -- Slave Select
    rdata     : out std_logic_vector(data_size - 1 downto 0));

end entity master_spi;



architecture arch_master_spi of master_spi is

  -- SIGNALS

  -- Rising edge detect (start_spi)
  signal start_spi_s  : std_logic;      -- Latch start_spi input
  signal start_spi_re : std_logic;  -- Pulse that indicate a start_spi Rising edge

  -- Input to latch
  signal ssi_s   : std_logic_vector(slave_number - 1 downto 0);  -- Latch slave select input
  signal wdata_s : std_logic_vector(data_size - 1 downto 0);     -- Latch wdata

begin  -- architecture arch_master_spi


  -- purpose: This process detect the start SPI input 
  p_start_detect : process (clock, reset_n) is
  begin  -- process p_start_detect
    if reset_n = '0' then                   -- asynchronous reset (active low)
      start_spi_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      start_spi_s <= start_spi;
    end if;
  end process p_start_detect;
  start_spi_re <= start_spi and not start_spi_s;


  -- purpose: This process latch the input when a rising edge of start_spi occurs
  p_latch_inputs : process (clock, reset_n) is
  begin  -- process p_latch_inputs
    if reset_n = '0' then                   -- asynchronous reset (active low)
      ssi_s   <= (others => '0');
      wdata_s <= (others => '0');
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(start_spi_re = '1') then
        ssi_s   <= ssi;
        wdata_s <= wdata;
      end if;
    end if;
  end process p_latch_inputs;

end architecture arch_master_spi;
