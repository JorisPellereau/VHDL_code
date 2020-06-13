-------------------------------------------------------------------------------
-- Title      : TB Template
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_type.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-18
-- Last update: 2020-06-13
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

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity test_max7219_matrix_display is

end entity test_max7219_matrix_display;

architecture behv of test_max7219_matrix_display is
  -- COMPONENTS
  component max7219_emul is
    generic(
          G_MATRIX_I : integer := 0);
    port (
      clk            : in  std_logic;
      rst_n          : in  std_logic;
      i_max7219_clk  : in  std_logic;
      i_max7219_din  : in  std_logic;
      i_max7219_load : in  std_logic;
      o_max7219_dout : out std_logic);

  end component max7219_emul;
  
  -- TB CONSTANTS
  constant C_CLK_HALF_PERIOD : time := 10 ns;  -- HALF PERIOD of clk

  -- TB INTERNAL SIGNALS
  signal clk   : std_logic := '0';      -- Clock
  signal rst_n : std_logic := '1';      -- Asynchronous reset

  -- INTERNAL SIGNALS
  signal s_decod_mode     : std_logic_vector(7 downto 0);
  signal s_intensity      : std_logic_vector(7 downto 0);
  signal s_scan_limit     : std_logic_vector(7 downto 0);
  signal s_shutdown       : std_logic_vector(7 downto 0);
  signal s_new_config_val : std_logic;
  signal s_score          : std_logic_vector(31 downto 0);
  signal s_score_val      : std_logic;
  signal s_max7219_load   : std_logic;
  signal s_max7219_data   : std_logic;
  signal s_max7219_clk    : std_logic;

  signal s_max7219_dout_m0 : std_logic;
  signal s_max7219_dout_m1 : std_logic;
  
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

    wait for 10*C_CLK_HALF_PERIOD;

    -- SIGNALS INIT
    s_decod_mode     <= (others => '0');
    s_intensity      <= (others => '0');
    s_scan_limit     <= (others => '0');
    s_shutdown       <= (others => '0');
    s_new_config_val <= '0';
    s_score          <= (others => '0');
    s_score_val      <= '0';

    rst_n <= '0';
    wait for 10*C_CLK_HALF_PERIOD;
    rst_n <= '1';

    wait for 10*C_CLK_HALF_PERIOD;


    -- SET CONFIG
    s_decod_mode <= x"00";
    s_intensity  <= x"07";
    s_scan_limit <= x"07";
    s_shutdown   <= x"01";

    wait until falling_edge(clk);
    s_new_config_val <= '1';
    wait until falling_edge(clk);
    s_new_config_val <= '0';

    wait for 300 us;

    s_score     <= x"00000051";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 600 us; --1000*C_CLK_HALF_PERIOD;

    wait;

    -- OLD TEST
    s_score     <= x"00000099";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 1 ms;
    report "end of Simulation !!!";
    wait;
  end process p_stimulis;

  -- MAX7219 MATRIX DISPLAY INST
  max7219_matrix_display_inst_0 : max7219_matrix_display
    generic map(
      G_DIGITS_NB                  => 2,
      G_DATA_WIDTH                 => 32,
      G_RAM_ADDR_WIDTH             => 8,
      G_RAM_DATA_WIDTH             => 16,
      G_DECOD_MAX_CNT_32B          => x"02FAF080",
      G_MAX7219_IF_MAX_HALF_PERIOD => 50,
      G_MAX7219_LOAD_DUR           => 4)
    port map(
      clk              => clk,
      rst_n            => rst_n,
      i_decod_mode     => s_decod_mode,
      i_intensity      => s_intensity,
      i_scan_limit     => s_scan_limit,
      i_shutdown       => s_shutdown,
      i_new_config_val => s_new_config_val,
      i_score          => s_score,
      i_score_val      => s_score_val,
      o_max7219_load   => s_max7219_load,
      o_max7219_data   => s_max7219_data,
      o_max7219_clk    => s_max7219_clk
      );


  -- MAX7219 MODULE EMUL - Checker
  max7219_emul_inst_m0 : max7219_emul
    generic map(
      G_MATRIX_I => 0
    )
    port map (
      clk            => clk,
      rst_n          => rst_n,
      i_max7219_clk  => s_max7219_clk,
      i_max7219_din  => s_max7219_data,
      i_max7219_load => s_max7219_load,
      o_max7219_dout => s_max7219_dout_m0
      );

  -- MAX7219 MODULE EMUL - Checker
  max7219_emul_inst_m1 : max7219_emul
    generic map(
      G_MATRIX_I => 1
    )
    port map (
      clk            => clk,
      rst_n          => rst_n,
      i_max7219_clk  => s_max7219_clk,
      i_max7219_din  => s_max7219_dout_m0,
      i_max7219_load => s_max7219_load,
      o_max7219_dout => s_max7219_dout_m1
      );
  
end architecture behv;
