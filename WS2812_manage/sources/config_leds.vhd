-------------------------------------------------------------------------------
-- Title      : Leds configuration
-- Project    : 
-------------------------------------------------------------------------------
-- File       : config_leds.vhd
-- Author     : root  <pellerj@localhost.localdomain>
-- Company    : 
-- Last update: 2019/09/04
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: This file contains the led configuration
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019/09/04  1.0      pellerj Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;


entity config_leds is

  generic (
    G_LED_NUMBER : integer range 1 to C_MAX_LEDS := C_LED_NB);  -- Numer of leds

  port (
    clock_i        : in  std_logic;     -- System Clock
    reset_n        : in  std_logic;     -- Active low asynchronous reset
    sel_config_i   : in  std_logic_vector(7 downto 0);  -- Config led selection
    config_led_o   : out t_led_config_array;  -- Current leds config
    config_valid_o : out std_logic);    -- Current conf. Valid

end config_leds;



architecture arch_config_leds of config_leds is


  -- INTERNAL SIGNALS
  signal sel_config_i_s  : std_logic_vector(7 downto 0);
  signal sel_config_i_ss : std_logic_vector(7 downto 0);

  signal config_led_o_s   : t_led_config_array;
  signal config_valid_o_s : std_logic;

begin  -- arch_config_leds


  -- purpose: This process latches the inputs
  p_latch_inputs : process (clock_i, reset_n)
  begin  -- process p_latch_inputs
    if reset_n = '0' then               -- asynchronous reset (active low)
      sel_config_i_s  <= (others => '0');
      sel_config_i_ss <= (others => '0');
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      sel_config_i_s  <= sel_config_i;
      sel_config_i_ss <= sel_config_i_s;
    end if;
  end process p_latch_inputs;


  -- purpose: This process manages the selection of the config
  p_sel_mng : process (clock_i, reset_n)
  begin  -- process p_sel_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      config_led_o_s   <= (others => (others => '0'));
      config_valid_o_s <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge

      case sel_config_i_ss is
        when x"00"  =>
          config_led_o_s   <= C_ALL_GREEN_LEDS;
          config_valid_o_s <= '1';
        when x"01"  =>
          config_led_o_s   <= C_ALL_RED_LEDS;
          config_valid_o_s <= '1';
        when x"02"  =>
          config_led_o_s   <= C_ALL_BLUE_LEDS;
          config_valid_o_s <= '1';
        when others =>
          config_led_o_s   <= C_DEFAULT_LEDS;
          config_valid_o_s <= '0';
      end case;

    end if;
  end process p_sel_mng;

  config_led_o   <= config_led_o_s;
  config_valid_o <= config_valid_o_s;

end arch_config_leds;
