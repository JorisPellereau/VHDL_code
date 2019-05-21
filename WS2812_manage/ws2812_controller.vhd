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
    reset_duration_i : in  unsigned(31 downto 0);  -- Duration of the reset between each frames
    modes_i          : in  std_logic_vector(1 downto 0);  -- Mode for the led controller
    d_out            : out std_logic);  -- Serial output for the leds configuration

end entity ws2812_controller;


architecture arch_ws2812_ctrl of ws2812_controller is

  -- SIGNALS

  -- ws2812 instanciation signals
  signal start_s      : std_logic;      -- Start a frame
  signal led_config_s : std_logic_vector(23 downto 0);  -- Led configuration
  signal frame_done_s : std_logic;      -- A frame has been transmitted
  signal d_out_s      : std_logic;      -- Connected to the output

begin  -- architecture arch_ws2812_ctrl

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
