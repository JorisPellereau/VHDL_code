-------------------------------------------------------------------------------
-- Title      : Package of the LCD12232_ctrl
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_lcd12232.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-07
-- Last update: 2019-06-12
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
use ieee.numeric_std.all;

package pkg_lcd12232 is

  -- Inputs clock : 50MHz : Tclk = 20 ns

  -- CONSTANTS

  -- LCD12232 Commands
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
  constant C_DISPLAY_LINE_0   : std_logic_vector(7 downto 0) := x"C0";  -- Display start line 0
  constant C_COL_ADDR_0       : std_logic_vector(7 downto 0) := x"00";  -- Set column 0

  -- 50*20ns = 1 us
  constant C_MAX_CNT_1US : unsigned(5 downto 0) := "110010";  -- Max counter for 1 us

  -- Max acces time : 90 ns => 100 ns
  constant C_MAX_TACC_RD : unsigned(2 downto 0) := "101";  -- MAX access time

  -- Number of command sor the LCD init
  constant C_MAX_INIT_CMD : unsigned(7 downto 0) := x"08";  -- Number of command for INIT the LCD


  -- Column positions
  constant C_MAX_HALF_PANEL : unsigned(7 downto 0) := x"3C";  -- Half panel column number
  constant C_MAX_PANEL      : unsigned(7 downto 0) := x"79";  -- Max panel column

  -- TYPES
  type t_fsm_rw is (IDLE, SET_RW_REG, SET_ENi, WR_DATA, RD_DATA, RST_ENi, RST_DATA);  -- FSM states for txhe BUS RW

  type t_fsm_ctrl is (IDLE, RST_LCD, INIT_LCD, READ_STATUS, WAIT_LCD, SET_DISPLAY);  -- FSM states for the LCd controller

  -- COMPONENTS

  component lcd12232_ctrl is
    port (
      clock_i   : in    std_logic;      -- System clock
      reset_n_i : in    std_logic;      -- Active low asynchronous reset
      reg_sel_o : out   std_logic;      -- Register sel (A0)
      en1_o     : out   std_logic;      -- Enable for IC1
      en2_o     : out   std_logic;      -- Enable for IC2
      rw_o      : out   std_logic;      -- Read/Write selection
      rst_o     : out   std_logic;      -- LCD reset
      data_io   : inout std_logic_vector(7 downto 0));  -- Data to LCD
  end component;

end package pkg_lcd12232;
