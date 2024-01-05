-------------------------------------------------------------------------------
-- Title      : Package for SPI communication
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_spi.vhd
-- Author     :   Joris Pellereau
-- Company    : 
-- Created    : 2019-05-03
-- Last update: 2019-07-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file is the package for SPI modules
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-03  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package pkg_spi is

  -- SPI MODES
  -- MODE 0 : CPOL : 0 - CPHA : 0
  -- MODE 1 : CPOL : 0 - CPHA : 1
  -- MODE 2 : CPOL : 1 - CPHA : 0
  -- MODE 3 : CPOL : 1 - CPHA : 1

  -- CONSTANTS

  -- System constants
  constant clock_frequency : integer := 50000000;  -- Input clock frequency

  -- SPI module constants
  constant max_slave_number : integer := 2;  -- Number of slave on the SPI bus
  constant spi_frequency    : integer := 5000000;     -- SLCK SPI frequency
  constant T_sclk           : integer := clock_frequency / spi_frequency;  -- Period of the SPI clock
  constant T_2_sclk         : integer := T_sclk / 2;  -- Half sclk period


  -- COMPONENTS
  component master_spi is

    generic (
      cpol         : std_logic                           := '0';  -- Clock Polarity
      cpha         : std_logic                           := '0';  -- Clock phase
      data_size    : integer                             := 8;  -- Size of the data
      msb_first    : boolean                             := true;  -- True : MSB 1st - False : LSB 1st
      slave_number : integer range 1 to max_slave_number := max_slave_number);  -- Number of slave

    port (
      reset_n     : in  std_logic;      -- Asynchronous reset
      clock       : in  std_logic;      -- System clock
      ssi         : in  std_logic_vector(slave_number - 1 downto 0);  -- Slave Select input
      start_spi   : in  std_logic;      -- Start SPI transaction
      wdata       : in  std_logic_vector(data_size - 1 downto 0);  -- Data to transmit
      miso        : in  std_logic;      -- Master In Slave Out
      mosi        : out std_logic;      -- Master Out Slave In
      sclk        : out std_logic;      -- Serial Clock
      ssn         : out std_logic_vector(slave_number - 1 downto 0);  -- Slave Select
      rdata       : out std_logic_vector(data_size - 1 downto 0);  -- Read data
      rdata_valid : out std_logic
      );

  end component;
end package pkg_spi;
