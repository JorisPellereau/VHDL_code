-------------------------------------------------------------------------------
-- Title      : This file is the top module of the led commande for the DE NANO board
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_led_cmd.vhd
-- Author     :   Joris Pellereau
-- Company    : 
-- Created    : 2019-05-23
-- Last update: 2019-05-24
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the top level test module for the led controller on the
-- DE NANO board
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-23  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;


entity top_led_cmd is

  port (
    clock   : in  std_logic;            -- Input clock system
    reset_n : in  std_logic;            -- Asynchronous reset active low
    d_out   : out std_logic);  -- Serial output for the led configuration

end entity top_led_cmd;

architecture arch_top_led_cmd of top_led_cmd is

  -- CONSTANTS
  constant C_led_config : std_logic_vector(23 downto 0) := x"0F0F0F";  -- Led config
  constant C_max_timer  : integer                       := 500;  -- Max timer for 1 second

  -- SIGNALS
  signal cnt_timer : integer range 0 to C_max_timer;  -- Counter for the timer

  -- WS2812 SIGNALS
  signal start_s      : std_logic;      -- Start commande for the WS2812
  signal led_config_s : std_logic_vector(23 downto 0);  -- Led configuration
  signal frame_done_s : std_logic;      -- Flag for a terminated transfert;
  signal d_out_s      : std_logic;      --Connection to the output;


begin  -- architecture arch_top_led_cmd


  led_config_s <= C_led_config;         -- Fixe configuration


  -- purpose: This process manages the start of the frame
  p_start_manage : process (clock, reset_n) is
  begin  -- process p_start_manage
    if reset_n = '0' then                   -- asynchronous reset (active low)
      start_s   <= '0';
      cnt_timer <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(frame_done_s = '1') then
        if(cnt_timer = C_max_timer) then
          cnt_timer <= 0;                   -- RAZ cnt
          start_s   <= '1';                 -- Set to '1'
        else
          cnt_timer <= cnt_timer + 1;       -- Inc cnt
          start_s   <= '0';                 -- Set to '0'
        end if;
      else                                  -- frame_done_s = '0'
        start_s   <= '0';
        cnt_timer <= 0;
      end if;
    end if;
  end process p_start_manage;



  ws2812_inst : ws2812
    generic map(T0H => T0H,
                T0L => T0L,
                T1H => T1H,
                T1L => T1L)
    port map(clock      => clock,
             reset_n    => reset_n,
             start      => start_s,
             led_config => led_config_s,
             frame_done => frame_done_s,
             d_out      => d_out_s);


  d_out <= d_out_s;                     -- Output affectation

end architecture arch_top_led_cmd;
