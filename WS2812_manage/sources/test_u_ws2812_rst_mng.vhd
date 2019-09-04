-------------------------------------------------------------------------------
-- Title      : Unitary test of the ws2812_rst_mng module
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_u_ws2812_rst_mng.vhd
-- Author     : root  <pellerj@localhost.localdomain>
-- Company    : 
-- Last update: 2019/09/04
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: This is the unitary test of the ws2812 rst module
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019/09/04  1.0      pellerj Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity test_u_ws2812_rst_mng is

end test_u_ws2812_rst_mng;

architecture arch_test_u_ws2812_rst_mng of test_u_ws2812_rst_mng is

  -- CONSTANTS
  constant C_HALF_CLK : time := 10 ns;  -- 50 MHz clock

  -- TB SIGNALS
  signal clock   : std_logic := '0';
  signal reset_n : std_logic := '1';


  -- WS2812_rst_mng signals
  signal en_start_i    : std_logic;
  signal reset_gen_i   : std_logic;
  signal config_done_i : std_logic;
  signal start_leds_o  : std_logic;

begin  -- arch_test_u_ws2812_rst_mng


  -- purpose: This process generates the 50MHz clock
  p_clk_mng : process
  begin  -- process p_clk_mng
    clock <= not clock;
    wait for C_HALF_CLK;
  end process p_clk_mng;


  p_stimuli : process
  begin  -- process p_stimuli

    -- INIT SIGNALS
    en_start_i    <= '0';
    reset_gen_i   <= '0';
    config_done_i <= '0';

    -- Reset gen
    reset_n <= '1';
    wait for 4*C_HALF_CLK;
    reset_n <= '0';
    wait for 4*C_HALF_CLK;
    reset_n <= '1';

    wait for 10*C_HALF_CLK;




    -- Start config
    report "Start the config";
    en_start_i <= '1';

    wait for 10*C_HALF_CLK;
    wait until falling_edge(CLOCK);
    config_done_i <= '1', '0' after 5*C_HALF_CLK;

    wait for 10*C_HALF_CLK;
    wait until falling_edge(CLOCK);
    config_done_i <= '1', '0' after 5*C_HALF_CLK;


    report "Stop the config";
    en_start_i <= '0';
    wait for 10*C_HALF_CLK;


    -- Start config
    report "Start the config + reset";
    en_start_i    <= '1';
    reset_gen_i   <= '1';
    wait for 20*C_HALF_CLK;
    wait until falling_edge(CLOCK);
    config_done_i <= '1', '0' after 5*C_HALF_CLK;

    wait for 15*C_HALF_CLK;

    en_start_i    <= '0';
    wait for 10*C_HALF_CLK;
    wait until falling_edge(CLOCK);
    config_done_i <= '1', '0' after 5*C_HALF_CLK;


    report "End of simulation !!!";
    wait;
  end process p_stimuli;


  -- WS2812_rst_mng_inst
  ws2812_rst_mng_inst : ws2812_rst_mng
    port map (
      clock_i       => clock,
      reset_n       => reset_n,
      en_start_i    => en_start_i,
      reset_gen_i   => reset_gen_i,
      config_done_i => config_done_i,
      start_leds_o  => start_leds_o);




end arch_test_u_ws2812_rst_mng;
