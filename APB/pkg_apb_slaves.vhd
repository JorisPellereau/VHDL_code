-------------------------------------------------------------------------------
-- Title      : Package for APB slaves
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_apb.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-06
-- Last update: 2019-05-06
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the package for APB slaves
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-06  1.0      JorisPC Created
-------------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;

package pkg_apb is


  -- CONSTANTES 
  constant add_width        : integer                          := 32;  -- Address width
  constant base_addr_slave1 : unsigned(add_width - 1 downto 0) := x"50000000";  -- Base address for the slave number 1




end package pkg_apb;
