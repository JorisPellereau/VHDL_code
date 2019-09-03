-------------------------------------------------------------------------------
-- Title      : Controller of the ws2812 module
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ws2812_controller.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-21
-- Last update: 2019-05-24
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file is the controller of the ws2812 module
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-21  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity ws2812_controller is
  generic(led_number : integer := led_number);
  port (
    clock            : in  std_logic;   -- system clock
    reset_n          : in  std_logic;   -- Asynchronous reset active low
    enable_i         : in  std_logic;   -- Enable of the block
    start_leds_i     : in  std_logic;   -- Start the leds
    leds_config_i    : in  t_led_config_array;  -- Array of leds configuration
    load_config_i    : in  std_logic;   -- Load the new led configuration
    reset_duration_i : in  unsigned(31 downto 0);  -- Duration of the reset between each frames
    d_out            : out std_logic;  -- serial output for the leds configuration
    busy_o           : out std_logic);  -- Controller is busy 

end entity ws2812_controller;


architecture arch_ws2812_ctrl of ws2812_controller is

  -- SIGNALS
  signal start_leds_i_s    : std_logic;  -- Old start_leds_i_s
  signal start_leds_i_re_s : std_logic;  -- Flag that  indicates the RE of start_leds_i

  signal cnt_leds_s     : integer range 0 to led_number;  -- count until the number of led, in order to generate the frame
  signal inc_cnt_done_s : std_logic;    -- Flag that indicate if a inc is done


  signal leds_config_i_s : t_led_config_array;  -- Array of the led configuration

  -- internal timer counter signals
  signal reset_duration_i_s : unsigned(31 downto 0);  -- reset_duration signal
  signal cnt_reset_s        : unsigned(31 downto 0);  -- counter that counts until the reset_duration
  signal timer_done_s       : std_logic;  -- flag for a terminated timer

  signal frame_done_re_s  : std_logic;  -- flag for the re detection
  signal frame_done_old_s : std_logic;  -- old frame done

  signal en_timer_s : std_logic;  -- this signal enable the internal timer


  -- ws2812 instanciation signals
  signal start_s      : std_logic;      -- start a frame
  signal led_config_s : std_logic_vector(23 downto 0);  -- led configuration
  signal frame_done_s : std_logic;      -- a frame has been transmitted
  signal d_out_s      : std_logic;      -- connected to the output

begin  -- architecture arch_ws2812_ctrl

  -- purpose: This process latch the leds configuration in a array
  p_load_config : process (clock, reset_n)
  begin  -- process p_load_config
    if reset_n = '0' then               -- asynchronous reset (active low)
      leds_config_i_s <= (others => (others => '0'));  -- Init the array to '0'
    elsif clock'event and clock = '1' then             -- rising clock edge
      if(load_config_i = '1' and enable_i = '1') then
        leds_config_i_s <= leds_config_i;
      end if;
    end if;
  end process p_load_config;


  -- purpose: reset_nre of start_leds_i 
  p_start_re_detect : process (clock, reset_n)
  begin  -- process p_start_re_detect
    if reset_n = '0' then                   -- asynchronous reset (active low)
      start_leds_i_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(enable_i = '1') then
        start_leds_i_s <= start_leds_i;
      end if;
    end if;
  end process p_start_re_detect;

  -- Flag for RE detect
  start_leds_i_re_s <= (start_leds_i and not start_leds_i_s) when enable_i = '1' else '0';


  -- purpose: This process manages the start of a frame
  p_start_frame_manage : process (clock, reset_n)
  begin  -- process p_start_frame_manage
    if reset_n = '0' then                   -- asynchronous reset (active low)
      start_s <= '0';                       -- Init the start to '0'
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(enable_i = '1') then

        led_config_s <= leds_config_i_s(cnt_leds_s);  -- Latch the config                
        if(start_leds_i_re_s = '1') then
          start_s <= '1';

        -- Gen a start if the led number is not reach and an inc is done
        elsif(cnt_leds_s < led_number and inc_cnt_done_s = '1') then
          start_s <= '1';
        else
          start_s <= '0';
        end if;
      end if;
    end if;
  end process p_start_frame_manage;



  -- WS2812 Instanciation
  ws2812_inst : ws2812
    generic map(T0H => T0H,
                T0L => T0L,
                T1H => T1H,
                T1L => T1L)
    port map (clock      => clock,
              reset_n    => reset_n,
              start      => start_s,
              led_config => led_config_s,
              frame_done => frame_done_s,
              d_out      => d_out_s);



  -- purpose: This process detect the RE of frame_done_s 
  p_frame_done_re_detect : process (clock, reset_n)
  begin  -- process p_frame_done_re_detect
    if reset_n = '0' then                   -- asynchronous RESET (active low)
      frame_done_old_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(enable_i = '1') then
        frame_done_old_s <= frame_done_s;
      end if;
    end if;
  end process p_frame_done_re_detect;
  frame_done_re_s <= frame_done_s and not frame_done_old_s;


  -- purpose: This process count the number of frame to transmit
  p_led_cnt : process (clock, reset_n)
  begin  -- process p_led_cnt
    if reset_n = '0' then               -- asynchronous reset (active low)
      cnt_leds_s     <= 0;              -- Init to 0
      inc_cnt_done_s <= '0';
    elsif clock'event and clock = '1' then     -- rising clock edge
      if(enable_i = '1') then
        if(frame_done_re_s = '1') then
          if(cnt_leds_s = led_number) then
            cnt_leds_s <= 0;            -- RAZ cnt
          else
            cnt_leds_s     <= cnt_leds_s + 1;  -- Inc cnt
            inc_cnt_done_s <= '1';
          end if;
        else
          inc_cnt_done_s <= '0';
        end if;
      else
        cnt_leds_s     <= 0;            -- Init to 0
        inc_cnt_done_s <= '0';
      end if;
    end if;
  end process p_led_cnt;


  -- purpose: This process runs the timer when a frame has been done
  -- p_timer_gen : process (clock, reset_n)
  -- begin  -- process p_timer_gen
  --   if reset_n = '0' then                   -- asynchronous reset (active low)
  --     en_timer_s   <= '0';
  --     cnt_reset_s  <= (others => '0');
  --     timer_done_s <= '0';
  --   elsif clock'event and clock = '1' then  -- rising clock edge

  --     if(cnt_leds_s = led_number) then  -- 
  --       en_timer_s <= '1';
  --     end if;

  --     if(en_timer_s = '1') then
  --       if(cnt_reset_s = reset_duration_i_s) then
  --         timer_done_s <= '1';
  --         en_timer_s   <= '0';              -- RAZ enable
  --         cnt_reset_s  <= (others => '0');  -- RAZ cnt
  --       else
  --         timer_done_s <= '0';
  --         cnt_reset_s  <= cnt_reset_s + 1;  --Inc cnt
  --       end if;
  --     else

  --     end if;

  --   end if;
  -- end process p_timer_gen;


  d_out <= d_out_s;                     -- Output connection
end architecture arch_ws2812_ctrl;
