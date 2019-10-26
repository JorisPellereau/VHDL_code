-------------------------------------------------------------------------------
-- Title      : Unitary Test of the WS2812_leds_mngt
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tu_ws2812_leds_mngt.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2019-10-26
-- Last update: 2019-10-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Unitary test
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-10-26  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity tu_ws2812_leds_mngt is

end entity tu_ws2812_leds_mngt;

architecture arch_tu_ws2812_leds_mngt of tu_ws2812_leds_mngt is

  -- CONSTANTS
  constant C_HALF_CLK : time    := 10 ns;  -- 50 MHz clock
  constant C_LEDS_NB  : integer := 8;      -- Leds numbers
  constant C_CNT_SIZE : integer := 16;

  -- TB SIGNALS
  signal clock   : std_logic := '0';
  signal reset_n : std_logic := '1';

  -- SIGNALS
  signal s_start_frame      : std_logic;
  signal s_led_config       : std_logic_vector(23 downto 0);
  signal s_frame_done       : std_logic;
  signal s_d_out            : std_logic;
  signal s_stat_dyn         : std_logic;
  signal s_leds_config      : t_led_config_array;
  signal s_en               : std_logic;
  signal s_leds_conf_update : std_logic;
  signal s_max_cnt          : std_logic_vector(C_CNT_SIZE - 1 downto 0);
  signal s_stat_conf_done   : std_logic;
  signal s_dyn_ongoing      : std_logic;

begin  -- architecture arch_tu_ws2812_leds_mngt


  -- purpose: This process generates the 50MHz clock
  p_clk_mng : process
  begin  -- process p_clk_mng
    clock <= not clock;
    wait for C_HALF_CLK;
  end process p_clk_mng;

  p_stimuli : process is
  begin  -- process p_stimuli

    -- INIT SIGNALS
    s_stat_dyn         <= '0';
    s_leds_conf_update <= '0';
    s_leds_config      <= (others => (others => '0'));
    s_en               <= '0';
    s_max_cnt          <= (others => '0');

    wait for 10*C_HALF_CLK;

    -- Reset gen
    reset_n <= '1';
    wait for 4*C_HALF_CLK;
    reset_n <= '0';
    wait for 4*C_HALF_CLK;
    reset_n <= '1';

    wait for 10*C_HALF_CLK;

    -- Static test
    wait until falling_edge(clock);
    s_leds_config      <= C_TEST_LEDS_4;
    s_en               <= '1';
    s_leds_conf_update <= '1';
    wait for 10*C_HALF_CLK;
    s_leds_conf_update <= '0';

    wait until rising_edge(s_stat_conf_done);

    wait for 200 us;

    -- Dynamic test
    wait until falling_edge(clock);
    s_leds_config      <= C_TEST_LEDS_4;
    s_stat_dyn         <= '1';
    s_en               <= '1';
    s_leds_conf_update <= '1';
    s_max_cnt          <= x"0FFF";      --(others => '1');  --  refresh
    wait for 10*C_HALF_CLK;
    s_leds_conf_update <= '0';

    wait for 200 ms;

    report "end of Simu. !!";
    wait;


  end process p_stimuli;


  -- WS2812 INST
  ws2812_inst : ws2812
    generic map (
      T0H => T0H,
      T0L => T0L,
      T1H => T1H,
      T1L => T1L)
    port map (
      clock_i      => clock,
      reset_n      => reset_n,
      start_i      => s_start_frame,
      led_config_i => s_led_config,
      frame_done_o => s_frame_done,
      d_out_o      => s_d_out
      );

  -- WS2812 LEDS MNGT INST
  ws2812_leds_mngt_inst : ws2812_leds_mngt
    generic map (
      G_LEDS_NB  => C_LEDS_NB,
      G_CNT_SIZE => C_CNT_SIZE)
    port map (
      clock              => clock,
      rst_n              => reset_n,
      i_stat_dyn         => s_stat_dyn,
      i_leds_conf_update => s_leds_conf_update,
      i_leds_config      => s_leds_config,
      i_en               => s_en,
      i_frame_done       => s_frame_done,
      i_max_cnt          => s_max_cnt,
      o_led_config       => s_led_config,
      o_stat_conf_done   => s_stat_conf_done,
      o_dyn_ongoing      => s_dyn_ongoing,
      o_start_frame      => s_start_frame);





end architecture arch_tu_ws2812_leds_mngt;
