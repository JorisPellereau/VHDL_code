-------------------------------------------------------------------------------
-- Title      : Test of the WS2812
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_WS2812.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-16
-- Last update: 2019-05-24
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the unitary test of the WS2812
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-16  1.0      JorisPC Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity test_WS2812 is
end test_WS2812;

architecture arch_test_WS2812 of test_WS2812 is

  constant T_clk     : time := 20 ns/2.0;  -- 50 MHz
  constant t_reset_n : time := 100 ns;

  signal clock   : std_logic := '0';
  signal reset_n : std_logic := '0';

  -- Instance ws2812
  signal start      : std_logic := '0';
  signal led_config : std_logic_vector(23 downto 0);
  signal frame_done : std_logic;
  signal d_out      : std_logic;

  -- Instance top_cmd_led
  signal d_out_top : std_logic;         -- Output from the top

  -- Instance ws2812_controller
  signal enable_i         : std_logic;
  signal start_leds_i     : std_logic;
  signal leds_config_i    : t_led_config_array;
  signal load_config_i    : std_logic;
  signal reset_duration_i : unsigned(31 downto 0);
  signal d_out_controller : std_logic;
  signal busy_o           : std_logic;

begin



  clock <= not clock after T_clk;       -- Generation de clock

  simu_p : process
  begin

    led_config <= (others => '0');
    reset_n    <= '0', '1' after t_reset_n;  -- Reset_n
    wait for 2*t_reset_n;
    for i in 1000 to 1005 loop
      -- wait for 100*t_reset_n;  -- to_integer(unsigned(reset_duration))*t_reset_n;  --100*t_reset_n;
      led_config <= std_logic_vector(to_unsigned(i, led_config'length));

      start <= '1', '0' after 100 ns;
      wait until rising_edge(frame_done);
    end loop;

    assert false report "end of simu !!!" severity failure;

    wait;
  end process;


  -- purpose: This process manages the inputs of the ws2812_controller 
  p_ws_controller_stim : process
  begin  -- process p_ws_controller_stim


  end process p_ws_controller_stim;



  -- Instance ws2812
  WS2812_1 : WS2812
    generic map(T0H => T0H,
                T0L => T0L,
                T1H => T1H,
                T1L => T1L)
    port map (clock      => clock,
              reset_n    => reset_n,
              start      => start,
              led_config => led_config,
              frame_done => frame_done,
              d_out      => d_out);


  -- Instance top
  top_isnt : top_led_cmd
    port map(clock   => clock,
             reset_n => reset_n,
             d_out   => d_out_top);


  -- ws2812_controller inst
  ws2812_controller_inst : ws2812_controller
    generic map(led_number => led_numer)
    port map(clock            => clock,
             reset_n          => reset_n,
             enable_i         => enable_i,
             start_leds_i     => start_leds_i,
             leds_config_i    => leds_config_i,
             load_config_i    => load_config_i,
             reset_duration_i => reset_duration_i,
             d_out            => d_out_controller,
             busy_o           => busy_o);

end arch_test_WS2812;
