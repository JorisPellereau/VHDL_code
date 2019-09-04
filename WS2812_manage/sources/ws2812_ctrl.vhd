-------------------------------------------------------------------------------
-- Title      : WS2812 Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ws2812_ctrl.vhd
-- Author     : root  <pellerj@localhost.localdomain>
-- Company    : 
-- Last update: 2019/09/04
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: WS2812 controller
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019/09/04  1.0      pellerj Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity ws2812_ctrl is

  generic (
    G_LED_NUMBER : integer range 1 to C_MAX_LEDS := C_LED_NB);

  port (
    clock_i           : in  std_logic;  -- System Clock
    reset_n           : in  std_logic;  -- Active Low asynchronous reset
    sel_config_i      : in  std_logic_vector(7 downto 0);  -- Sel config leds
    ws2812_leds_cmd_i : in  std_logic_vector(7 downto 0);  -- reg command
    ws2812_data_o     : out std_logic);  -- PWM data to the WS2812 component

end ws2812_ctrl;


architecture arch_ws2812_ctrl of ws2812_ctrl is


  -- INTERNAL SIGNALS
  signal config_led_s   : t_led_config_array;
  signal led_config_s   : std_logic_vector(23 downto 0);
  signal config_valid_s : std_logic;

  signal start_leds_s        : std_logic;
  signal frame_ws2812_done_s : std_logic;

  signal start_ws2812_s : std_logic;

  signal config_done_s : std_logic;

  signal en_start_s  : std_logic;
  signal reset_gen_s : std_logic;


begin  -- arch_ws2812_ctrl

  en_start_s  <= ws2812_leds_cmd_i(0);
  reset_gen_s <= ws2812_leds_cmd_i(1);

  -- CONFIG_LEDS inst
  config_leds_inst : config_leds
    generic map (
      G_LED_NUMBER   => C_LED_NB)
    port map (
      clock_i        => clock_i,
      reset_n        => reset_n,
      sel_config_i   => sel_config_i,
      config_led_o   => config_led_s,
      config_valid_o => config_valid_s);

  -- WS2812_rst_mng_inst
  ws2812_rst_mng_inst : ws2812_rst_mng
    port map (
      clock_i       => clock_i,
      reset_n       => reset_n,
      en_start_i    => en_start_s,
      reset_gen_i   => reset_gen_s,
      config_done_i => config_done_s,
      start_leds_o  => start_leds_s);   -- To ws2812_mng

  -- WS2812_mngt inst
  ws2812_mngt_inst : ws2812_mngt
    generic map (
      G_LEd_NUMBER        => C_LED_NB)
    port map (
      clock_i             => clock_i,
      reset_n             => reset_n,
      start_leds_i        => start_leds_s,         -- From Reset_mng
      frame_ws2812_done_i => frame_ws2812_done_s,  -- From WS2812
      led_config_array_i  => config_led_s,         -- From config_leds
      start_ws2812_o      => start_ws2812_s,       -- To WS2812
      led_config_o        => led_config_s,         -- To WS2812
      config_done_o       => config_done_s         -- To Reset_mng
      );

  -- WS2812 inst
  ws2812_inst : ws2812
    generic map (
      T0H          => T0H,
      T0L          => T0L,
      T1H          => T1H,
      T1L          => T1L)
    port map (
      clock_i      => clock_i,
      reset_n      => reset_n,
      start_i      => start_ws2812_s,
      led_config_i => led_config_s,
      frame_done_o => frame_ws2812_done_s,
      d_out_o      => ws2812_data_o);


end arch_ws2812_ctrl;
