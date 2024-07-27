-------------------------------------------------------------------------------
-- Title      : Package for WATCH FPGA
-- Project    : 
-------------------------------------------------------------------------------
-- File       : watch_pkg.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-05-12
-- Last update: 2024-05-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-05-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package watch_pkg is

  -- == CONSTANTS ==
  constant C_NB_UINT2MAX7219_DATA : integer := 4;  -- Number of instance of UINT2MAX7219_DATA block

  -- inst[0] -> hours_tens_digit
  -- inst[1] -> hours_unity_digit
  -- inst[2] -> mins_tens_digit
  -- inst[3] -> mins_unity_digit
  constant C_HOURS_TENS_DIGIT_IDX  : integer := 0;  -- Index of Hours Tens digit
  constant C_HOURS_UNITY_DIGIT_IDX : integer := 1;  -- Index of Hours Unity Digit
  constant C_MINS_TENS_DIGIT_IDX   : integer := 2;  -- Index of Minutes Tens Digit
  constant C_MINS_UNITY_DIGIT_IDX  : integer := 3;  -- Index of Minutes Unity Digit

  -- == TYPES ==
  type t_char_data_array is array (natural range <>) of std_logic_vector(7 downto 0);  -- Array of std_logic_vector(7 downto 0) with a not defined array length
  type t_uint_data_array is array(natural range <>) of std_logic_vector(3 downto 0);  -- Array of std_logic_vector(3 downto 0) with a not defined array length

  type t_framebuffer_array is array(0 to 31) of std_logic_vector(15 downto 0);  -- Array of std_logic_vector(15 downto 0) with a depth of 32


  -- MAX7219 Configuration
  constant C_MAX_HALF_PERIOD : integer := 4;  -- clk_sys / (2*4) => 1.25MHz clock output
  constant C_LOAD_DURATION   : integer := 1;  -- Min 50ns (clk_sys == 10MHz -> 100ns -> OK)

end package watch_pkg;
