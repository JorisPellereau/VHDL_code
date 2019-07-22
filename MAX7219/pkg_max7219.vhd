-------------------------------------------------------------------------------
-- Title      : MAX7219 package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_max7219.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-07-19
-- Last update: 2019-07-22
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the package for the Max7219 component
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-19  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package pkg_max7219 is

  -- SYSTEM clock : 50MHz : 20 ns
  -- CLK frequency : 5MHz (10MHz max)

  -- == MAX7219_interface CONSTANTS ==
  constant C_T_CLK    : integer := 10;      -- 50MHz/5MHz = 10
  constant C_T_2_sclk : integer := 10 / 2;  -- Half Period of CLK
  -- =================================

  -- == MAX7219_controller TYPES & CONSTANTS ==
  constant C_CFG_NB           : integer                      := 3;  -- Number of configuration
  constant C_DECODE_MODE_ADDR : std_logic_vector(7 downto 0) := x"09";  -- Decode mode address register
  constant C_INTENSITY_ADDR   : std_logic_vector(7 downto 0) := x"0A";  -- Inensity addr register
  constant C_SCAN_LIMIT_ADDR  : std_logic_vector(7 downto 0) := x"0B";  -- Scan limit addr register
  constant C_SHUTDOWN_ADDR    : std_logic_vector(7 downto 0) := x"0C";  -- Shutdown addr register

  type t_max7219_ctrl_fsm is (IDLE, SET_CFG, DISPLAY_ON);  -- States of the MAX7219 Controller
  -- ==================================

  -- COMPONENTS
  component max7219_interface
    port (
      clock_i       : in  std_logic;    -- System clock
      reset_n_i     : in  std_logic;    -- Asynchronous active low reset
      wdata_i       : in  std_logic_vector(15 downto 0);  -- Data to send te the Max7219
      start_frame_i : in  std_logic;    -- Start the transaction
      load_o        : out std_logic;    -- LOAD command
      data_o        : out std_logic;    -- DATA to send th
      clk_o         : out std_logic;    -- CLK
      frame_done_o  : out std_logic);   -- Frame done
  end component;

  component max7219_controller is
    port (
      clock_i   : in std_logic;         -- System clock
      reset_n_i : in std_logic;         -- Asynchonous Active Low

      -- From MAX7219 interface
      frame_done_i : in std_logic;  -- Frame done from the MAX7219 interface

      -- Config inputs
      start_config_i     : in std_logic;  -- Start the config of the MAX7219
      decode_mode_i      : in std_logic_vector(1 downto 0);  -- Decode mode (0x0 - 0x1 - 0x2 - 0x3)
      intensity_format_i : in std_logic_vector(3 downto 0);  -- Intensity format
      scan_limit_i       : in std_logic_vector(2 downto 0);  -- Scan limit config

      -- Flags
      config_done_o : out std_logic;    -- Config is done
      display_on_o  : out std_logic;    -- State of the display 1 : on 0 : off

      -- To MAX7219 interface
      wdata_o       : out std_logic_vector(15 downto 0);  -- Data bus                                        
      start_frame_o : out std_logic);   -- Start a frame
  end component;

end package pkg_max7219;
