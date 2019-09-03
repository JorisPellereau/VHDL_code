-------------------------------------------------------------------------------
-- Title      : Unitary test WS2812
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_unitaire_ws2812.vhd
-- Author     : root  <pellerj@localhost.localdomain>
-- Company    : 
-- Last update: 2019/09/03
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: This is the unitary test of the WS2812
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019/09/03  1.0      pellerj Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity test_unitaire_ws2812 is

end test_unitaire_ws2812;

architecture arch_test_unitaire_ws2812 of test_unitaire_ws2812 is

  -- CONSTANTS
  constant C_HALF_CLK : time := 10 ns;  -- 50 MHz clock

  -- TB SIGNALS
  signal clock   : std_logic := '0';
  signal reset_n : std_logic := '1';

  -- WS2812 SIGNALS
  signal start_ws      : std_logic;
  signal led_config_ws : std_logic_vector(23 downto 0);
  signal frame_done_ws : std_logic;
  signal d_out_ws      : std_logic;

begin  -- arch_test_unitaire_ws2812


  -- purpose: This process generates the 50MHz clock
  p_clk_mng : process
  begin  -- process p_clk_mng
    clock <= not clock;
    wait for C_HALF_CLK;
  end process p_clk_mng;

  p_stimuli : process
  begin  -- process p_stimuli

    -- INIT SIGNALS
    start_ws      <= '0';
    led_config_ws <= (others => '0');

    -- Reset gen
    reset_n <= '1';
    wait for 4*C_HALF_CLK;
    reset_n <= '0';
    wait for 4*C_HALF_CLK;
    reset_n <= '1';

    wait for 10*C_HALF_CLK;

    -- Send a frame
    wait until falling_edge(clock);
    led_config_ws <= x"00000F";
    start_ws      <= '1';

    wait until rising_edge(frame_done_ws) for 10 ms;



    report "End of simulation !!!";
    wait;
  end process p_stimuli;

  -- WS2812 INST
  ws2812_inst : ws2812
    generic map (
      T0H          => T0H,
      T0L          => T0L,
      T1H          => T1H,
      T1L          => T1L)
    port map (
      clock_i      => clock,
      reset_n      => reset_n,
      start_i      => start_ws,
      led_config_i => led_config_ws,
      frame_done_o => frame_done_ws,
      d_out_o      => d_out_ws
      );

end arch_test_unitaire_ws2812;
