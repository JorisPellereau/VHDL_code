-------------------------------------------------------------------------------
-- Title      : Unitary test of the ws2812_mngt module
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_u_ws2812_mngt.vhd
-- Author     : root  <pellerj@localhost.localdomain>
-- Company    : 
-- Last update: 2019/09/03
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: this is the unitary test of the WS2812_mngt module
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019/09/03  1.0      pellerj Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;


entity test_u_ws2812_mngt is

end test_u_ws2812_mngt;


architecture arch_test_u_ws2812_mngt of test_u_ws2812_mngt is


  -- CONSTANTS
  constant C_HALF_CLK : time := 10 ns;  -- 50 MHz clock

  -- TB SIGNALS
  signal clock   : std_logic := '0';
  signal reset_n : std_logic := '1';

  -- WS2812 SIGNALS
  signal d_out_s : std_logic;

  -- WS2812 MNGT SIGNALS
  signal frame_ws2812_done_s : std_logic;
  signal start_leds_s        : std_logic;
  signal start_ws2812_s      : std_logic;
  signal led_config_array_s  : t_led_config_array := (others => (others => '0'));
  signal led_config_s        : std_logic_vector(23 downto 0);
  signal config_done_s       : std_logic;

begin  -- arch_test_u_ws2812_mngt


  -- purpose: This process generates the 50MHz clock
  p_clk_mng : process
  begin  -- process p_clk_mng
    clock <= not clock;
    wait for C_HALF_CLK;
  end process p_clk_mng;


  p_stimuli : process
  begin  -- process p_stimuli

    -- INIT SIGNALS   
    start_leds_s       <= '0';
    led_config_array_s <= (0 => x"F0F0F0", 1 => x"ABCDEF", 2 => x"123456");
    -- Reset gen
    reset_n            <= '1';
    wait for 4*C_HALF_CLK;
    reset_n            <= '0';
    wait for 4*C_HALF_CLK;
    reset_n            <= '1';

    wait for 10*C_HALF_CLK;


    -- Start config leds
    wait until falling_edge(clock);
    start_leds_s <= '1', '0' after 10*C_HALF_CLK;


    report "End of simulation !!!";
    wait;
  end process p_stimuli;

  -- WS2812 inst
  ws2812_inst : ws2812
    generic map (
      T0H          => T0H,
      T0L          => T0L,
      T1H          => T1H,
      T1L          => T1L)
    port map (
      clock_i      => clock,
      reset_n      => reset_n,
      start_i      => start_ws2812_s,
      led_config_i => led_config_s,
      frame_done_o => frame_ws2812_done_s,
      d_out_o      => d_out_s);

  -- WS2812_mngt inst
  ws2812_mngt_inst : ws2812_mngt
    generic map (
      G_LEd_NUMBER        => C_LED_NB)
    port map (
      clock_i             => clock,
      reset_n             => reset_n,
      start_leds_i        => start_leds_s,
      frame_ws2812_done_i => frame_ws2812_done_s,
      led_config_array_i  => led_config_array_s,
      start_ws2812_o      => start_ws2812_s,
      led_config_o        => led_config_s,
      config_done_o       => config_done_s
      );

end arch_test_u_ws2812_mngt;
