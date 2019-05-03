-------------------------------------------------------------------------------
-- Title      : Test master SPI
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_master_spi.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-05-03
-- Last update: 2019-05-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is a unitary test
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-03  1.0      pellereau       Created
-------------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;

library lib_spi;
use lib_spi.pkg_spi.all;

entity test_master_spi is

end entity test_master_spi;


architecture arch_test_master_spi of test_master_spi is

  signal clock : std_logic := '0';      -- Clock

begin  -- architecture arch_test_master_spi

  p_clock_gen : process
  begin  -- process p_clock_gen
    clock <= not clock;
    wait for 10 us;
  end process p_clock_gen;

end architecture arch_test_master_spi;
