-------------------------------------------------------------------------------
-- Title      : TB Template
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_type.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-18
-- Last update: 2020-04-18
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-18  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity test_top_max7219_matrix_display is

end entity test_top_max7219_matrix_display;

architecture behv of test_top_max7219_matrix_display is

  -- COMPONENT
  component top_max7219_matrix_display is
    generic (
      G_MAX_CNT                    : std_logic_vector(31 downto 0) := x"02FAF080";
      G_DIGITS_NB                  : integer range 2 to 8          := 8;  -- DIGIT NB on THE MATRIX DISPLAY
      G_DATA_WIDTH                 : integer                       := 32;  -- INPUTS SCORE WIDTH
      G_RAM_ADDR_WIDTH             : integer                       := 8;  -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH             : integer                       := 16;  -- RAM DATA WIDTH
      G_DECOD_MAX_CNT_32B          : std_logic_vector(31 downto 0) := x"02FAF080";
      G_MAX7219_IF_MAX_HALF_PERIOD : integer                       := 50;  -- MAX HALF PERIOD for MAX729 CLK generation
      G_MAX7219_LOAD_DUR           : integer                       := 4);  -- MAX7219 LOAD duration in period of clk
    port (
      clk            : in  std_logic;   -- Clock
      rst_n          : in  std_logic;   -- Asynchronous Reset
      o_max7219_load : out std_logic;   -- LOAD
      o_max7219_data : out std_logic;   -- DATA
      o_max7219_clk  : out std_logic);  -- CLK

  end component top_max7219_matrix_display;

  -- TB CONSTANTS
  constant C_CLK_HALF_PERIOD : time := 10 ns;  -- HALF PERIOD of clk

  -- TB INTERNAL SIGNALS
  signal clk   : std_logic := '0';      -- Clock
  signal rst_n : std_logic := '1';      -- Asynchronous reset

  -- INTERNAL SIGNALS
  signal s_max7219_load : std_logic;
  signal s_max7219_data : std_logic;
  signal s_max7219_clk  : std_logic;

begin  -- architecture behv

  -- purpose: this process generate the input clock
  p_clk_gen : process is
  begin  -- process p_clk_gen
    clk <= not clk;
    wait for C_CLK_HALF_PERIOD;
  end process p_clk_gen;

  -- STIMULIS
  p_stimulis : process is
  begin  -- process p_stimuli

    -- SIGNALS INIT
    rst_n <= '1';
    wait for 10*C_CLK_HALF_PERIOD;
    rst_n <= '0';
    wait for 10*C_CLK_HALF_PERIOD;
    rst_n <= '1';

    report "end of Simulation !!!";
    wait;
  end process p_stimulis;

  -- INST
  top_max7219_matrix_display_inst_0 : top_max7219_matrix_display
    generic map (
      G_MAX_CNT                    => x"000061A8",
      G_DIGITS_NB                  => 2,
      G_DATA_WIDTH                 => 32,  -- INPUTS SCORE WIDTH
      G_RAM_ADDR_WIDTH             => 8,  -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH             => 16,  -- RAM DATA WIDTH
      G_DECOD_MAX_CNT_32B          => x"02FAF080",
      G_MAX7219_IF_MAX_HALF_PERIOD => 50,  -- MAX HALF PERIOD for MAX729 CLK generation
      G_MAX7219_LOAD_DUR           => 4)  -- MAX7219 LOAD duration in period of clk
    port map (
      clk            => clk,
      rst_n          => rst_n,
      o_max7219_load => s_max7219_load,
      o_max7219_data => s_max7219_data,
      o_max7219_clk  => s_max7219_clk);
end architecture behv;
