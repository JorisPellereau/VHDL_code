-------------------------------------------------------------------------------
-- Title      : Controller of the ws2812 module
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ws2812_controller.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-21
-- Last update: 2019-05-22
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

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity ws2812_controller is
  generic(led_number : integer := 1);
  port (
    clock            : in  std_logic;   -- system clock
    reset_n          : in  std_logic;   -- Asynchronous reset active low
    enable_i         : in  std_logic;   -- Enable of the block
    green_i          : in  std_logic_vector(7 downto 0);  -- Green configuration
    red_i            : in  std_logic_vector(7 downto 0);  -- Red configuration
    blue_i           : in  std_logic_vector(7 downto 0);  -- Blue configuration
    load_grb_i       : in  std_logic;   -- Load the new led configuration
    reset_duration_i : in  unsigned(31 downto 0);  -- Duration of the reset between each frames
    modes_i          : in  std_logic_vector(1 downto 0);  -- Mode for the led controller
    d_out            : out std_logic;  -- Serial output for the leds configuration
    busy_o           : out std_logic);  -- 

end entity ws2812_controller;


architecture arch_ws2812_ctrl of ws2812_controller is

  -- SIGNALS
  signal enable_i_s    : std_logic;     -- Old enabe input
  signal enable_i_re_s : std_logic;  -- Flag that inicates the RE of enbale_i

  -- Internal timer counter signals
  signal reset_duration_i_s : unsigned(31 downto 0);  -- Reset_duration signal
  signal cnt_reset_s        : unsigned(31 downto 0);  -- Counter that counts until the reset_duration
  signal timer_done_s       : std_logic;  -- Flag for a terminated timer

  signal frame_done_re_s  : std_logic;  -- Flag for the RE detection
  signal frame_done_old_s : std_logic;  -- Old frame done

  signal en_timer_s : std_logic;  -- This signal enable the internal timer


  -- ws2812 instanciation signals
  signal start_s      : std_logic;      -- Start a frame
  signal led_config_s : std_logic_vector(23 downto 0);  -- Led configuration
  signal frame_done_s : std_logic;      -- A frame has been transmitted
  signal d_out_s      : std_logic;      -- Connected to the output

begin  -- architecture arch_ws2812_ctrl


  -- purpose: This process latches the input in order to detect its rising edge
  -- p_enable_re_detect : process (clock, reset_n)
  -- begin  -- process p_enable_re_detect
  --   if reset_n = '0' then               -- asynchronous reset (active low)
  --     enable_i_s <= '0';
  --   elsif clock'event and clock = '1' then     -- rising clock edge
  --     enable_i_s <= enable_i;
  --   end if;
  -- end process p_enable_re_detect;
  -- enable_i_re <= enable_i and not enable_i_s;  -- RE detect


  -- purpose: This process latches the inputs 
  -- p_latch_inputs : process (clock, reset_n) is
  -- begin  -- process p_latch_inputs
  --   if reset_n = '0' then                   -- asynchronous reset (active low)
  --     led_config_s <= (others => '0');
  --   elsif clock'event and clock = '1' then  -- rising clock edge
  --     if(enable_i_re = '1') then
  --       led_config_s <= green_i & red_i & blue_i;
  --     end if;
  --   end if;
  -- end process p_latch_inputs;


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
    if reset_n = '0' then                   -- asynchronous reset (active low)
      frame_done_old_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      frame_done_old_s <= frame_done_s;
    end if;
  end process p_frame_done_re_detect;
  frame_done_re_s <= frame_done_s and not frame_done_old_s;



  -- purpose: This process runs the timer when a frame has been done
  -- p_timer_gen : process (clock, reset_n)
  -- begin  -- process p_timer_gen
  --   if reset_n = '0' then                   -- asynchronous reset (active low)
  --     en_timer_s   <= '0';
  --     cnt_reset_s  <= (others => '0');
  --     timer_done_s <= '0';
  --   elsif clock'event and clock = '1' then  -- rising clock edge

  --     if(frame_done_re_s = '1') then  -- Enable is set when en frame is terminated
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
