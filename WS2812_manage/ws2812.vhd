-------------------------------------------------------------------------------
-- Title      : WS2812 frame generation
-- Project    : 
-------------------------------------------------------------------------------
-- File       : WS2812.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-21
-- Last update: 2019-05-21
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This module generates a 24 bits frame in order to configure a
-- WS2812 led
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-21  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;


entity WS2812 is
  generic(T0H : integer := T0H;
          T0L : integer := T0L;
          T1H : integer := T1H;
          T1L : integer := T1L
          );
  port(clock      : in  std_logic;      -- Input clock
       reset_n    : in  std_logic;      -- Asynchronous reset
       start      : in  std_logic;      -- Start a frame
       led_config : in  std_logic_vector(23 downto 0);  -- Led configuration      
       frame_done : out std_logic;      -- Frame terminated
       d_out      : out std_logic       -- Serial output
       );
end WS2812;

architecture arch_WS2812 of WS2812 is

  -- SIGNALS
  signal cnt_pwm : integer range 0 to max_T;  -- Counter for the PWM period
  signal TH_s    : integer range 0 to max_T;  -- Time on

  signal pwm_done : std_logic;  -- Flag that indicates when a period of PWM is over
  signal cnt_24   : integer range 0 to 23;  -- Counter 23 until 0

  signal start_init_s : std_logic;      -- This signal Init the TH duty cycle
  signal frame_done_s : std_logic;      -- Frame done signal

  signal frame_gen : std_logic;         -- Gen frame when = '1'
  signal start_s   : std_logic;         -- Old start input

  signal start_re     : std_logic;      -- Flag that indicates the RE of start
  signal led_config_s : std_logic_vector(23 downto 0);  -- Latch config

  signal d_out_s : std_logic;           -- To output


begin


  -- purpose: This process detect the rising edge of the start input 
  p_start_re_manage : process (clock, reset_n)
  begin  -- process p_start_re_manage
    if reset_n = '0' then                   -- asynchronous reset (active low)
      start_s <= '0';                       -- Init to '0'
    elsif clock'event and clock = '1' then  -- rising clock edge
      start_s <= start;
    end if;
  end process p_start_re_manage;
  start_re <= start and not start_s;        -- RE detect


  -- purpose: This process latch the inputs during the RE of start
  p_inputs_latch : process (clock, reset_n)
  begin  -- process p_inputs_latch
    if reset_n = '0' then                   -- asynchronous reset (active low)
      led_config_s <= (others => '0');
      start_init_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(start_re = '1' and frame_gen = '0') then
        led_config_s <= led_config;
        start_init_s <= '1';
      else
        start_init_s <= '0';                -- RAZ
      end if;
    end if;
  end process p_inputs_latch;


  -- purpose: This process manages the duty cycle for the PWM module
  p_set_duty_cycle : process (clock, reset_n)
  begin  -- process p_set_duty_cycle
    if reset_n = '0' then                   -- asynchronous reset (active low)
      TH_s         <= 0;
      frame_gen    <= '0';
      frame_done_s <= '1';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(start_init_s = '1') then
        frame_done_s <= '0';
        if(led_config_s(23) = '1') then     -- Init the first bit to send
          TH_s <= T1H;
        elsif(led_config_s(23) = '0') then
          TH_s <= T0H;
        end if;
        frame_gen <= '1';
      elsif(pwm_done = '0') then
        if(led_config_s(cnt_24) = '1') then
          TH_s <= T1H;
        elsif(led_config_s(cnt_24) = '0') then
          TH_s <= T0H;
        end if;
      elsif(cnt_24 = 0 and pwm_done = '1') then
        frame_gen    <= '0';
        frame_done_s <= '1';
      end if;
    end if;
  end process p_set_duty_cycle;


  -- purpose: This process counts the transmitted bits 
  p_bit_counter : process (clock, reset_n)
  begin  -- process p_bit_counter
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_24 <= 23;                         -- Init the counter to 23
    elsif clock'event and clock = '1' then  -- rising clock edge

      if(frame_gen = '1') then   -- Count only when frame_gen is set to '1'
        if(pwm_done = '1') then         -- Count at the end of a PWM cycle
          if(cnt_24 > 0) then
            cnt_24 <= cnt_24 - 1;
          else
            cnt_24 <= 23;
          end if;
        end if;
      else
        cnt_24 <= 23;                   -- Init the counter to 23
      end if;

    end if;
  end process p_bit_counter;


  -- This process counts until Max_T and generates the PWM output
  p_pwm_cnt : process (clock, reset_n)
  begin  -- process p_pwm_cnt
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_pwm  <= 0;
      d_out_s  <= '0';
      pwm_done <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(frame_gen = '1') then

        if(cnt_pwm = max_T) then
          cnt_pwm  <= 0;                -- RAZ
          pwm_done <= '1';              -- Set flag
        else
          cnt_pwm  <= cnt_pwm + 1;      -- Inc cnt
          pwm_done <= '0';              -- RAZ flag
        end if;

        if(cnt_pwm >= TH_s) then
          d_out_s <= '0';               -- Low level
        else
          d_out_s <= '1';               -- High level
        end if;

      else
        d_out_s <= '0';
        cnt_pwm <= 0;
      end if;
    end if;
  end process p_pwm_cnt;

  -- Outputs affectation
  d_out      <= d_out_s and not frame_done_s;  -- Generate d_out
  frame_done <= frame_done_s;

end arch_WS2812;
