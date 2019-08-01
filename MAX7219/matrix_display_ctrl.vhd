-------------------------------------------------------------------------------
-- Title      : Matrix Display Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : matrix_display_ctrl.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-08-01
-- Last update: 2019-08-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the matrix display controller for 8 8x8 matrix
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-08-01  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity matrix_display_ctrl is

  port (
    clock_i        : in std_logic;      -- System clock
    reset_n_i      : in std_logic;      -- Active low Asynchronous reset
    display_test_i : in std_logic;      -- Test the matrix
    score_i        : in std_logic_vector(31 downto 0);  -- Current score to display

    -- MAX7219 Interface
    load_o : out std_logic;             -- Load MAX7219
    data_o : out std_logic;             -- Data MAX7219
    clk_o  : out std_logic);            -- CLK MAX7219

end entity matrix_display_ctrl;


architecture arch_matrix_display_ctrl of matrix_display_ctrl is

begin  -- architecture arch_matrix_display_ctrl



end architecture arch_matrix_display_ctrl;
