-------------------------------------------------------------------------------
-- Title      : WS2812 LEDS Config selector management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : leds_config_selector.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2019-11-24
-- Last update: 2019-11-24
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file manages the selection of the leds configs
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-11-24  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity leds_config_selector is

  port (
    clock                   : in  std_logic;  -- Clock
    rst_n                   : in  std_logic;  -- Asynchronous reset
    i_default_config_sel    : in  std_logic_vector(7 downto 0);  -- Default config sel
    i_default_config_en     : in  std_logic;  -- Default_config_selection
    i_new_config_sel        : in  std_logic_vector(7 downto 0);
    i_new_config_sel_update : in  std_logic;  -- New config valid
    i_new_leds_config       : in  t_led_config_array;   -- New leds config
    o_leds_config           : out t_led_config_array);  -- Current leds config

end entity leds_config_selector;


architecture arch of leds_config_selector is

  signal s_config_default : t_led_config_array;  -- Current default config
  signal s_new_config     : t_led_config_array;  -- Current new config

begin  -- architecture arch


  -- Default config mngt
  p_default_conf_mngt : process (clock, rst_n) is
  begin  -- process p_default_conf_mngt
    if rst_n = '0' then                     -- asynchronous reset (active low)
      s_config_default <= C_DEFAULT_LEDS;
    elsif clock'event and clock = '1' then  -- rising clock edge
      case i_default_config_sel is
        when x"00" =>
          s_config_default <= C_DEFAULT_LEDS;

        when x"01" =>
          s_config_default <= C_ALL_GREEN_LEDS;

        when others =>
          s_config_default <= C_ALL_RED_LEDS;
      end case;

    end if;
  end process p_default_conf_mngt;

  -- purpose: This process manages the new config leds 
  p_new_conf_mngt : process (clock, rst_n) is
  begin  -- process p_nex_conf_mngt
    if rst_n = '0' then                     -- asynchronous reset (active low)
      s_new_config <= (others => (others => '0'));
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i_new_config_sel_update = '1') then
        s_new_config <= i_new_leds_config;
      end if;
    end if;
  end process p_new_conf_mngt;



  o_leds_config <= s_config_default when i_default_config_sel = '1' else
                   s_new_config when i_new_config_sel /= x"00" else
                   C_DEFAULT_LEDS;

end architecture arch;
