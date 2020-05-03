-------------------------------------------------------------------------------
-- Title      : MAX7219 MATRIX DISPLAY TOP BLOCK
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_matrix_display.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-05-03
-- Last update: 2020-05-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 MATRIX DISPLAY TOP BLOCK
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-05-03  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_matrix_display is
  generic (
    G_DATA_WIDTH                 : integer                       := 32;  -- INPUTS SCORE WIDTH
    G_RAM_ADDR_WIDTH             : integer                       := 8;  -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH             : integer                       := 16;  -- RAM DATA WIDTH
    G_DECOD_MAX_CNT_32B          : std_logic_vector(31 downto 0) := x"02FAF080";
    G_MAX7219_IF_MAX_HALF_PERIOD : integer                       := 50;  -- MAX HALF PERIOD for MAX729 CLK generation
    G_MAX7219_LOAD_DUR           : integer                       := 4);  -- MAX7219 LOAD duration in period of clk
  port (
    clk            : in  std_logic;     -- Clock
    rst_n          : in  std_logic;     -- Asynchronous Reset
    i_score        : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Score to Display
    i_score_val    : in  std_logic;     -- Scare Valid
    o_max7219_load : out std_logic;     -- MAX7219 LOAD
    o_max7219_data : out std_logic;     -- MAX7219 DATA
    o_max7219_clk  : out std_logic      -- MAX729 CLK
    );

end entity max7219_matrix_display;

architecture behv of max7219_matrix_display is

begin  -- architecture behv

  

end architecture behv;
