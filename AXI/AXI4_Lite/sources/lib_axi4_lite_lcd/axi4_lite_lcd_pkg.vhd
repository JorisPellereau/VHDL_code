-------------------------------------------------------------------------------
-- Title      : Package of the LCD AXI4 Lite
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_lcd_pkg.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-17
-- Last update: 2023-09-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-17  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package axi4_lite_lcd_pkg is

  -- == CONSTANTS ==
  constant C_NB_REG : integer := 3;     -- Number of Register

  constant C_USEFUL_LSBITS : integer := 4;  -- 4 LSBITS of usefull addr

  constant C_REG0_ADDR : std_logic_vector(C_USEFUL_LSBITS - 1 downto 0) := x"0";  -- REG0 ADDR
  constant C_REG1_ADDR : std_logic_vector(C_USEFUL_LSBITS - 1 downto 0) := x"4";  -- REG1 ADDR
  constant C_REG2_ADDR : std_logic_vector(C_USEFUL_LSBITS - 1 downto 0) := x"8";  -- REG2 ADDR

  -- Register Index (32bits wide)
  constant C_REG0_IDX : integer := 0;   -- Index number of REG 0
  constant C_REG1_IDX : integer := 1;   -- Index number of REG 1
  constant C_REG2_IDX : integer := 2;   -- Index number of REG 2

  constant C_CTRL_WIDTH                  : integer := 1;  -- Width of the CTRL register
  constant C_ENTRY_MODE_SET_CONFIG_WIDTH : integer := 2;  -- Width of the ENTRY_MODE_SET_CONFIG REG
  constant C_DISP_ON_OFF_CONFIG_WIDTH    : integer := 3;  -- Width of the Register
  constant C_CURSOR_DISP_CONFIG_WIDTH    : integer := 2;  -- Width of the CURSOR_DISP_CONFIG register
  constant C_FUNC_SET_CONFIG_WIDTH       : integer := 3;  -- Width of the FUNC SET Config register
  constant C_WDATA_DISPLAY_WIDTH         : integer := 8;  -- Width of the WDATA DISPLAY Register
  constant C_CHAR_POSITION_WIDTH         : integer := 5;  -- Width of the char position register
  constant C_LCD_CMDS_0_WIDTH            : integer := 8;  -- Width of the LCD CMD 0 Register
  constant C_LCD_STATUS_WIDTH            : integer := 5;  -- Width of the LCD STATUS Register


end package;
