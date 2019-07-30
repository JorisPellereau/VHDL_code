-------------------------------------------------------------------------------
-- Title      : MAX7219 package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_max7219.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-07-19
-- Last update: 2019-07-30
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
  constant C_CFG_NB   : integer := 3;   -- Number of configuration
  constant C_DIGIT_NB : integer := 8;   -- Number of digits

  constant C_NO_OP_ADDR : std_logic_vector(7 downto 0) := x"00";  -- No operation addr register

  constant C_DIGIT_0_ADDR : std_logic_vector(7 downto 0) := x"01";  -- Digit 0 addr register
  constant C_DIGIT_1_ADDR : std_logic_vector(7 downto 0) := x"02";  -- Digit 1 addr register
  constant C_DIGIT_2_ADDR : std_logic_vector(7 downto 0) := x"03";  -- Digit 2 addr register
  constant C_DIGIT_3_ADDR : std_logic_vector(7 downto 0) := x"04";  -- Digit 3 addr register
  constant C_DIGIT_4_ADDR : std_logic_vector(7 downto 0) := x"05";  -- Digit 4 addr register
  constant C_DIGIT_5_ADDR : std_logic_vector(7 downto 0) := x"06";  -- Digit 5 addr register
  constant C_DIGIT_6_ADDR : std_logic_vector(7 downto 0) := x"07";  -- Digit 6 addr register
  constant C_DIGIT_7_ADDR : std_logic_vector(7 downto 0) := x"08";  -- Digit 7 addr register

  constant C_DECODE_MODE_ADDR  : std_logic_vector(7 downto 0) := x"09";  -- Decode mode address register
  constant C_INTENSITY_ADDR    : std_logic_vector(7 downto 0) := x"0A";  -- Inensity addr register
  constant C_SCAN_LIMIT_ADDR   : std_logic_vector(7 downto 0) := x"0B";  -- Scan limit addr register
  constant C_SHUTDOWN_ADDR     : std_logic_vector(7 downto 0) := x"0C";  -- Shutdown addr register
  constant C_DISPLAY_TEST_ADDR : std_logic_vector(7 downto 0) := x"0F";  -- Display test addr register

  type t_max7219_ctrl_fsm is (IDLE, SET_CFG, DISPLAY_ON, DISPLAY_OFF, TEST_DISPLAY_ON, TEST_DISPLAY_OFF, SET_DISPLAY);  -- States of the MAX7219 Controller
  -- ==================================


  -- == PATTERN_SELECTOR TYPES & CONSTANTS ==
  type t_matrix_8x8 is array (0 to 7) of std_logic_vector(7 downto 0);  -- Array of bytes for the matrix

  constant C_MATRIX_0 : t_matrix_8x8 := (0 => x"00", 1 => x"7E", 2 => x"C3", 3 => x"81", 4 => x"81", 5 => x"81", 6 => x"7E", 7 => x"00");  -- Display 0
  constant C_MATRIX_1 : t_matrix_8x8 := (0 => x"10", 1 => x"20", 2 => x"41", 3 => x"FF", 4 => x"01", 5 => x"01", 6 => x"00", 7 => x"00");  -- Display 1
  constant C_MATRIX_2 : t_matrix_8x8 := (0 => x"00", 1 => x"61", 2 => x"83", 3 => x"85", 4 => x"89", 5 => x"89", 6 => x"01", 7 => x"00");  -- Display 2
  constant C_MATRIX_3 : t_matrix_8x8 := (0 => x"00", 1 => x"42", 2 => x"81", 3 => x"81", 4 => x"89", 5 => x"89", 6 => x"6E", 7 => x"00");  -- Display 3
  constant C_MATRIX_4 : t_matrix_8x8 := (0 => x"00", 1 => x"1C", 2 => x"24", 3 => x"44", 4 => x"8F", 5 => x"8F", 6 => x"00", 7 => x"00");  -- Display 4
  constant C_MATRIX_5 : t_matrix_8x8 := (0 => x"00", 1 => x"F2", 2 => x"91", 3 => x"91", 4 => x"91", 5 => x"91", 6 => x"9E", 7 => x"00");  -- Display 5
  constant C_MATRIX_6 : t_matrix_8x8 := (0 => x"00", 1 => x"3E", 2 => x"51", 3 => x"91", 4 => x"91", 5 => x"91", 6 => x"0E", 7 => x"00");  -- Display 6
  constant C_MATRIX_7 : t_matrix_8x8 := (0 => x"00", 1 => x"80", 2 => x"8F", 3 => x"90", 4 => x"90", 5 => x"90", 6 => x"C0", 7 => x"00");  -- Display 7
  constant C_MATRIX_8 : t_matrix_8x8 := (0 => x"00", 1 => x"6E", 2 => x"91", 3 => x"91", 4 => x"91", 5 => x"91", 6 => x"6E", 7 => x"00");  -- Display 8
  constant C_MATRIX_9 : t_matrix_8x8 := (0 => x"00", 1 => x"62", 2 => x"91", 3 => x"91", 4 => x"91", 5 => x"91", 6 => x"7E", 7 => x"00");  -- Display 9
  -- =======================================



  -- COMPONENTS
  component max7219_interface
    port (
      clock_i       : in  std_logic;    -- System clock
      reset_n_i     : in  std_logic;    -- Asynchronous active low reset
      wdata_i       : in  std_logic_vector(15 downto 0);  -- Data to send te the Max7219
      start_frame_i : in  std_logic;    -- Start the transaction
      en_load_i     : in  std_logic;    -- Enable the generation of load_o
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

      test_display_i      : in std_logic;  -- Test the display
      update_display_i    : in std_logic;  -- Update the display
      pattern_available_i : in std_logic;  -- Pattern available

      -- Config inputs
      start_config_i     : in std_logic;  -- Start the config of the MAX7219
      decode_mode_i      : in std_logic_vector(1 downto 0);  -- Decode mode (0x0 - 0x1 - 0x2 - 0x3)
      intensity_format_i : in std_logic_vector(3 downto 0);  -- Intensity format
      scan_limit_i       : in std_logic_vector(2 downto 0);  -- Scan limit config

      -- Config Digits
      digit_0_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_1_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_2_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_3_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_4_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_5_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_6_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_7_i : in std_logic_vector(7 downto 0);  -- Digit 0 data


      -- Flags
      config_done_o  : out std_logic;   -- Config is done
      display_on_o   : out std_logic;   -- State of the display 1 : on 0 : off
      display_test_o : out std_logic;   -- 1 : Display in test mode
      update_done_o  : out std_logic;   -- Display Update terminated

      -- To MAX7219 interface
      wdata_o       : out std_logic_vector(15 downto 0);  -- Data bus                                        
      start_frame_o : out std_logic;    -- Start a frame
      en_load_o     : out std_logic);   -- Enable the LOAD generation
  end component;

  component pattern_selector is
    port (
      clock_i             : in  std_logic;   -- System clock
      reset_n_i           : in  std_logic;   -- Active low asynchronous reset
      en_i                : in  std_logic;   -- Enable
      sel_i               : in  std_logic_vector(15 downto 0);  -- Selector
      digit_0_o           : out std_logic_vector(7 downto 0);  -- Digit 0 pattern
      digit_1_o           : out std_logic_vector(7 downto 0);  -- Digit 1 pattern
      digit_2_o           : out std_logic_vector(7 downto 0);  -- Digit 2 pattern
      digit_3_o           : out std_logic_vector(7 downto 0);  -- Digit 3 pattern
      digit_4_o           : out std_logic_vector(7 downto 0);  -- Digit 4 pattern
      digit_5_o           : out std_logic_vector(7 downto 0);  -- Digit 5 pattern
      digit_6_o           : out std_logic_vector(7 downto 0);  -- Digit 6 pattern
      digit_7_o           : out std_logic_vector(7 downto 0);  -- Digit 7 pattern
      pattern_available_o : out std_logic);  -- Pattern avaiable
  end component;

end package pkg_max7219;
