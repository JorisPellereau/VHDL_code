-------------------------------------------------------------------------------
-- Title      : WS2812 I/O management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ws2812_mngt.vhd
-- Author     : root  <pellerj@localhost.localdomain>
-- Company    : 
-- Last update: 2019/09/03
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: This module manages the WS2812 module
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019/09/03  1.0      pellerj Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity ws2812_mngt is

  generic (
    G_LED_NUMBER : integer range 1 to C_MAX_LEDS := C_LED_NB);

  port (
    clock_i             : in  std_logic;  -- System Clock
    reset_n             : in  std_logic;  -- Active low asynchronous Reset
    start_leds_i        : in  std_logic;  -- Start led
    frame_ws2812_done_i : in  std_logic;  -- Frame from WS2812 done
    led_config_array_i  : in  t_led_config_array;  -- Config of the leds
    start_ws2812_o      : out std_logic;  -- Start the frame
    led_config_o        : out std_logic_vector(23 downto 0));  -- Led conf

end ws2812_mngt;



architecture arch_ws2812_mngt of ws2812_mngt is

  -- INTERNAL SIGNALS
  signal cnt_led_s : integer range 0 to G_LED_NUMBER;  -- Counter for the leds

  signal start_leds_i_s           : std_logic;  -- Old start_i
  signal start_leds_r_edge        : std_logic;  -- Rising edge of start_leds_i
  signal frame_ws2812_done_s      : std_logic;  -- Old frame_ws2812_done_i
  signal frame_ws2812_done_r_edge : std_logic;  -- rising edge of frame_done


  signal led_config_array_s : t_led_config_array;  -- Latch array

  -- Indicates when the config is on or off
  signal run_config_s : std_logic;

  signal start_ws2812_o_s : std_logic;  -- Signal for start the WS frame
  signal led_config_o_s   : std_logic_vector(23 downto 0);  -- Led config

  signal setup_config_done_s : std_logic;  -- Setup led config done
  signal config_done_s       : std_logic;  -- Config Done

begin  -- arch_ws2812_mngt


  -- purpose: This process manages the Rising edge of the inputs 
  p_r_edge_mng : process (clock_i, reset_n)
  begin  -- process p_r_edge_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      start_leds_i_s      <= '0';
      frame_ws2812_done_s <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      start_leds_i_s      <= start_leds_i;
      frame_ws2812_done_s <= frame_ws2812_done_i;
    end if;
  end process p_r_edge_mng;

  start_leds_r_edge        <= start_leds_i and not start_leds_i_s;
  frame_ws2812_done_r_edge <= frame_ws2812_done_i and not frame_ws2812_done_s;


  -- purpose: This process manages the inputs latch
  p_intputs_latch : process (clock_i, reset_n)
  begin  -- process p_intputs_latch
    if reset_n = '0' then               -- asynchronous reset (active low)
      led_config_array_s   <= (others => (others => '0'));
      run_config_s         <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(start_leds_r_edge = '1' and run_config_s = '0') then
        led_config_array_s <= led_config_array_i;
        run_config_s       <= '1';
      elsif(config_done_s = '1') then
        run_config_s       <= '0';
        led_config_array_s <= (others => (others => '0'));
      end if;
    end if;
  end process p_intputs_latch;


  -- purpose: this process manages the I/O interface with the WS2812 module
  p_i_o_sw2812_mng : process (clock_i, reset_n)
  begin  -- process p_i_o_sw2812_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      cnt_led_s           <= 0;         -- RAZ cnt
      led_config_o_s      <= (others => '0');
      start_ws2812_o_s    <= '0';
      setup_config_done_s <= '0';
      config_done_s       <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(run_config_s = '1') then

        -- On the REdge of Frame done
        if(frame_ws2812_done_r_edge = '1') then
          if(cnt_led_s < G_LED_NUMBER - 1) then
            cnt_led_s     <= cnt_led_s + 1;
          else
            cnt_led_s     <= 0;
            config_done_s <= '1';
          end if;
        end if;


        if(frame_ws2812_done_s = '1' and setup_config_done_s = '0') then
          led_config_o_s      <= led_config_array_s(cnt_led_s);  -- Set the led config
          setup_config_done_s <= '1';
        elsif(frame_ws2812_done_s = '0') then
          setup_config_done_s <= '0';
        end if;

        if(setup_config_done_s = '1') then
          start_ws2812_o_s <= '1';
        else
          start_ws2812_o_s <= '0';
        end if;

        -- Config terminated
      else
        cnt_led_s           <= 0;       -- RAZ cnt
        led_config_o_s      <= (others => '0');
        start_ws2812_o_s    <= '0';
        setup_config_done_s <= '0';
        config_done_s       <= '0';
      end if;
    end if;
  end process p_i_o_sw2812_mng;


  -- OUTPUTS affectation

  start_ws2812_o <= start_ws2812_o_s;
  led_config_o   <= led_config_o_s;

end arch_ws2812_mngt;
