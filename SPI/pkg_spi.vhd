-------------------------------------------------------------------------------
-- Title      : Package for SPI communication
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_spi.vhd
-- Author     :   Joris Pellereau
-- Company    : 
-- Created    : 2019-05-03
-- Last update: 2019-05-03
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

end package pkg_spi;
