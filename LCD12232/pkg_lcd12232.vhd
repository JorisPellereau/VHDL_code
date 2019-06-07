-------------------------------------------------------------------------------
-- Title      : Package of the LCD12232_ctrl
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_lcd12232.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-07
-- Last update: 2019-06-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This package contains the constants fir the LCD12232
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-07  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package pkg_lcd12232 is

  -- Inputs clock : 50MHz : Tclk = 20 ns

  -- CONSTANTS
  constant C_DISPLAY_ON       : std_logic_vector(7 downto 0) := x"AF";  -- Display on
  constant C_DISPLAY_OFF      : std_logic_vector(7 downto 0) := x"AE";  -- Display off
  constant C_SET_PAGE_0       : std_logic_vector(7 downto 0) := x"B8";  -- Page address set 0
  constant C_SET_PAGE_1       : std_logic_vector(7 downto 0) := x"B9";  -- Page address set 1
  constant C_SET_PAGE_2       : std_logic_vector(7 downto 0) := x"BA";  -- Page address set 2
  constant C_SET_PAGE_3       : std_logic_vector(7 downto 0) := x"BB";  -- Page address set 3
  constant C_RIGHTWARD        : std_logic_vector(7 downto 0) := x"A0";  -- Rightward output
  constant C_LEFTWARD         : std_logic_vector(7 downto 0) := x"A1";  -- Leftward output
  constant C_STATIC_DRIVE_ON  : std_logic_vector(7 downto 0) := x"A4";  -- Normal display operation
  constant C_STATIC_DRIVE_OFF : std_logic_vector(7 downto 0) := x"A5";  --Power save
  constant C_DUTY_1_16        : std_logic_vector(7 downto 0) := x"A8";  -- 1/16 duty factor LCD
  constant C_DUTY_1_32        : std_logic_vector(7 downto 0) := x"A9";  -- 1/32 duty factor LCD
  constant C_RD_MODIFY_WR     : std_logic_vector(7 downto 0) := x"E0";  -- +1 column addr
  constant C_END              : std_logic_vector(7 downto 0) := x"EE";  -- Cancels RD_modif mode
  constant C_RST_DISPLAY      : std_logic_vector(7 downto 0) := x"E2";  -- Reset display


  constant C_MAX_CNT_1US : unsigned(5 downto 0) := x"32";  -- Max coutner for 1 us


end package pkg_lcd12232;
