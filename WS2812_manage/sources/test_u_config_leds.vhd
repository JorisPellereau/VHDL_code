-------------------------------------------------------------------------------
-- Title      : Unitary test of the config_led module
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_u_config_leds.vhd
-- Author     : root  <pellerj@localhost.localdomain>
-- Company    : 
-- Last update: 2019/09/04
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: Unitary test of the config_led module
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019/09/04  1.0      pellerj Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity test_u_config_leds is

end test_u_config_leds;

architecture arch_test_u_config_leds of test_u_config_leds is

  -- CONSTANTS
  constant C_HALF_CLK : time := 10 ns;  -- 50 MHz clock

  -- TB SIGNALS
  signal clock   : std_logic := '0';
  signal reset_n : std_logic := '1';

  -- CONFIG LEDS SIGNALS
  signal sel_config_i   : std_logic_vector(7 downto 0);
  signal config_led_o   : t_led_config_array;
  signal config_valid_o : std_logic;

begin  -- arch_test_u_config_leds


  -- purpose: This process generates the 50MHz clock
  p_clk_mng : process
  begin  -- process p_clk_mng
    clock <= not clock;
    wait for C_HALF_CLK;
  end process p_clk_mng;

  p_stimuli : process
  begin  -- process p_stimuli

    -- INIT SIGNALS
    sel_config_i <= (others => '0');

    -- Reset gen
    reset_n <= '1';
    wait for 4*C_HALF_CLK;
    reset_n <= '0';
    wait for 4*C_HALF_CLK;
    reset_n <= '1';

    wait for 10*C_HALF_CLK;

    -- Sel 00
    wait until falling_edge(clock);
    sel_config_i <= (others => '0');

    wait for 10*C_HALF_CLK;

    -- Sel 01
    wait until falling_edge(clock);
    sel_config_i <= x"01";

    wait for 10*C_HALF_CLK;

    -- SEL 02
    wait until falling_edge(clock);
    sel_config_i <= x"02";

    wait for 10*C_HALF_CLK;


    -- SEL 03
    wait until falling_edge(clock);
    sel_config_i <= x"03";

    wait for 10*C_HALF_CLK;


    report "End of simulation !!!";
    wait;
  end process p_stimuli;


  -- CONFIG LEDS Inst
  config_leds_inst : config_leds
    generic map (
      G_LED_NUMBER   => C_LED_NB)
    port map (
      clock_i        => clock,
      reset_n        => reset_n,
      sel_config_i   => sel_config_i,
      config_led_o   => config_led_o,
      config_valid_o => config_valid_o);


end arch_test_u_config_leds;
