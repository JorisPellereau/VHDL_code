-------------------------------------------------------------------------------
-- Title      : WS2812 LEDS Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ws2812_leds_ctrl.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2019-10-26
-- Last update: 2019-10-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: WS2812 LEDS Controller
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-10-26  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity ws2812_leds_ctrl is

  generic (
    G_LEDS_NB          : integer := 8;    -- Leds numbers
    G_REFRESH_CNT_SIZE : integer := 16);  -- REFRESH CNT Size

  port (
    clock              : in  std_logic;   -- Clock
    rst_n              : in  std_logic;   -- Active low asynchronous reset
    i_en               : in  std_logic;   -- Block enable
    i_stat_dyn         : in  std_logic;   -- Static/Dyn. config
    i_leds_conf_update : in  std_logic;   -- Start/update the conf    
    o_d_out            : out std_logic);  -- WS2812 Output

end entity ws2812_leds_ctrl;

architecture arch_ws2812_leds_ctrl of ws2812_leds_ctrl is

  -- SIGNALS
  signal s_start_frame : std_logic;
  signal s_led_config  : std_logic_vector(23 downto 0);
  signal s_frame_done  : std_logic;

  signal s_stat_dyn         : std_logic;
  signal s_leds_config      : t_led_config_array;
  signal s_en               : std_logic;
  signal s_leds_conf_update : std_logic;
  signal s_max_cnt          : std_logic_vector(G_REFRESH_CNT_SIZE - 1 downto 0);
  signal s_stat_conf_done   : std_logic;
  signal s_dyn_ongoing      : std_logic;
  signal s_rfrsh_dyn_done   : std_logic;

begin  -- architecture arch_ws2812_leds_ctrl

  p_latch_in_mngt : process (clock, rst_n) is
  begin  -- process p_latch_in_mngt
    if rst_n = '0' then                     -- asynchronous reset (active low)
      s_en               <= '0';
      s_stat_dyn         <= '0';
      s_leds_conf_update <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      s_en               <= i_en;
      s_stat_dyn         <= i_stat_dyn;
      s_leds_conf_update <= i_leds_conf_update;
    end if;
  end process p_latch_in_mngt;


  s_leds_config <= C_TEST_LEDS_DYN_2;   -- C_TEST_LEDS_DYN;
  s_max_cnt     <= x"00500000";--x"004C4B40";         --x"02FAF080";

  -- WS2812 INST
  ws2812_inst : ws2812
    generic map (
      T0H => T0H,
      T0L => T0L,
      T1H => T1H,
      T1L => T1L)
    port map (
      clock_i      => clock,
      reset_n      => rst_n,
      start_i      => s_start_frame,
      led_config_i => s_led_config,
      frame_done_o => s_frame_done,
      d_out_o      => o_d_out
      );

  -- WS2812 LEDS MNGT INST
  ws2812_leds_mngt_inst : ws2812_leds_mngt
    generic map (
      G_LEDS_NB  => G_LEDS_NB,
      G_CNT_SIZE => G_REFRESH_CNT_SIZE)
    port map (
      clock              => clock,
      rst_n              => rst_n,
      i_stat_dyn         => s_stat_dyn,
      i_leds_conf_update => s_leds_conf_update,
      i_leds_config      => s_leds_config,
      i_en               => s_en,
      i_frame_done       => s_frame_done,
      i_max_cnt          => s_max_cnt,
      o_led_config       => s_led_config,
      o_stat_conf_done   => s_stat_conf_done,
      o_dyn_ongoing      => s_dyn_ongoing,
      o_rfrsh_dyn_done   => s_rfrsh_dyn_done,
      o_start_frame      => s_start_frame);



end architecture arch_ws2812_leds_ctrl;
