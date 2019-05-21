-------------------------------------------------------------------------------
-- Title      : Controller of the ws2812 module
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ws2812_controller.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-21
-- Last update: 2019-05-21
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

  signal enable_i_s  : std_logic;       -- Old enabe input
  signal enable_i_re : std_logic;  -- Flag that inicates the RE of enbale_i

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

  d_out <= d_out_s;                     -- Output connection
end architecture arch_ws2812_ctrl;
