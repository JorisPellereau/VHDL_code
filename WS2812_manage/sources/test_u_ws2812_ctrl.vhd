-------------------------------------------------------------------------------
-- Title      : Unitary test of the WS2812 controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_u_ws2812_ctrl.vhd
-- Author     : root  <pellerj@localhost.localdomain>
-- Company    : 
-- Last update: 2019/09/05
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: This is the unitary test of the WS2812 controller
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019/09/05  1.0      pellerj Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity test_u_ws2812_ctrl is

end test_u_ws2812_ctrl;

architecture arch_test_u_ws2812_ctrl of test_u_ws2812_ctrl is


  -- CONSTANTS
  constant C_HALF_CLK : time := 10 ns;  -- 50 MHz clock

  -- TB SIGNALS
  signal clock   : std_logic := '0';
  signal reset_n : std_logic := '1';

  -- WS2812_CTRL SIGNALS
  signal sel_config_i      : std_logic_vector(7 downto 0);
  signal ws2812_leds_cmd_i : std_logic_vector(7 downto 0);
  signal ws2812_data_o     : std_logic;

begin  -- arch_test_u_ws2812_ctrl


  -- purpose: This process generates the 50MHz clock
  p_clk_mng : process
  begin  -- process p_clk_mng
    clock <= not clock;
    wait for C_HALF_CLK;
  end process p_clk_mng;


  p_stimuli : process
  begin  -- process p_stimuli

    -- INIT SIGNALS   
    sel_config_i      <= (others => '0');
    ws2812_leds_cmd_i <= (others => '0');

    -- Reset gen
    reset_n <= '1';
    wait for 4*C_HALF_CLK;
    reset_n <= '0';
    wait for 4*C_HALF_CLK;
    reset_n <= '1';

    wait for 10*C_HALF_CLK;


    -- start config
    wait until falling_edge(clock);
    ws2812_leds_cmd_i(0) <= '1';


    wait for 5000*C_HALF_CLK;

    -- stop leds
    wait until falling_edge(clock);
    ws2812_leds_cmd_i(0) <= '0';


    -- start config
    wait until falling_edge(clock);
    ws2812_leds_cmd_i(0) <= '1';        -- EN start
    ws2812_leds_cmd_i(1) <= '1';        -- Reset Gen

    wait for 5000*C_HALF_CLK;

    -- start config
    wait until falling_edge(clock);
    ws2812_leds_cmd_i(0) <= '1';        -- EN start
    ws2812_leds_cmd_i(1) <= '0';        -- Reset Gen

    wait for 5000*C_HALF_CLK;

    -- stop leds
    wait until falling_edge(clock);
    ws2812_leds_cmd_i(0) <= '0';


    report "End of simulation !!!";
    wait;
  end process p_stimuli;



  -- WS2812_CTRL inst
  ws2812_ctrl_inst : ws2812_ctrl
    generic map (
      G_LEd_NUMBER      => C_LED_NB)
    port map (
      clock_i           => clock,
      reset_n           => reset_n,
      sel_config_i      => sel_config_i,
      ws2812_leds_cmd_i => ws2812_leds_cmd_i,
      ws2812_data_o     => ws2812_data_o);



end arch_test_u_ws2812_ctrl;
