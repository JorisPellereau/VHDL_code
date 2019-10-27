-------------------------------------------------------------------------------
-- Title      : WS2812 Leds Management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ws2812_leds_mngt.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2019-10-26
-- Last update: 2019-10-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file is the leds management for the WS2812
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

entity ws2812_leds_mngt is

  generic (
    G_LEDS_NB  : integer := 8;          -- Leds number;
    G_CNT_SIZE : integer := 16);        -- Refresh cnt size

  port (
    clock              : in  std_logic;   -- Clock
    rst_n              : in  std_logic;   -- Active low asynchronous reset
    i_stat_dyn         : in  std_logic;   -- Static or dynamique config
    i_leds_conf_update : in  std_logic;   -- Update the leds configuration
    i_leds_config      : in  t_led_config_array;             -- Leds Colors
    i_en               : in  std_logic;   -- Block enable
    i_frame_done       : in  std_logic;   -- Frame done from WS2812 block
    i_max_cnt          : in  std_logic_vector(G_CNT_SIZE - 1 downto 0);  -- Max cnt for the refresh
    o_led_config       : out std_logic_vector(23 downto 0);  -- Current leds config
    o_stat_conf_done   : out std_logic;   -- Static conf. done
    o_dyn_ongoing      : out std_logic;   -- Dyn config ongoing
    o_rfrsh_dyn_done   : out std_logic;   -- Refresh Dyn done
    o_start_frame      : out std_logic);  -- Start a WS2812 frame

end entity ws2812_leds_mngt;

architecture arch_ws2812_leds_mngt of ws2812_leds_mngt is

  -- SIGNALS
  signal s_end_static  : std_logic;     -- Config. Static done
  signal s_dyn_ongoing : std_logic;     -- Dyn Conf. ongoing

  signal s_leds_conf_update        : std_logic;  -- Latch leds_conf_udpate
  signal s_leds_conf_update_r_edge : std_logic;  -- REDGE of leds_conf update

  signal s_frame_done        : std_logic;  -- Latch Frame_done
  signal s_frame_done_r_edge : std_logic;  -- REdge of frme done

  signal s_cnt_nb_leds      : integer range 0 to G_LEDS_NB - 1;  -- Leds counter
  signal s_leds_config_stat : t_led_config_array;  -- Latch leds_config
  signal s_leds_config_dyn  : t_led_config_array;  -- Leds config in dynamic mode

  signal s_rfrsh_cnt      : unsigned(G_CNT_SIZE - 1 downto 0);  --integer range 0 to integer'high -1;  --(2**G_CNT_SIZE - 1);  --2**32 - 1;  -- Resfresh counter
  signal s_rfrsh_cnt_done : std_logic;  -- Rresfresh done  
  signal s_max_cnt        : std_logic_vector(G_CNT_SIZE - 1 downto 0);  -- Latch MAX CNT refresh

  signal s_start_frame : std_logic;                      -- Start frame
  signal s_led_config  : std_logic_vector(23 downto 0);  -- Led config



begin  -- architecture arch_ws2812_leds_mngt

  -- purpose: This process manages the static or dyn. mode 
  p_stat_dyn_mngt : process (clock, rst_n) is
  begin  -- process p_stat_dyn_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_end_static       <= '1';        -- End config terminated
      s_cnt_nb_leds      <= 0;
      s_leds_config_stat <= (others => (others => '0'));
      s_leds_config_dyn  <= (others => (others => '0'));
      s_led_config       <= (others => '0');
      s_start_frame      <= '0';
      s_rfrsh_cnt        <= (others => '0');  -- RAZ cnt
      s_max_cnt          <= (others => '0');
      s_rfrsh_cnt_done   <= '1';
      s_dyn_ongoing      <= '0';
    elsif clock'event and clock = '1' then    -- rising clock edge

      if(i_en = '1') then

        -- Static mode
        if(i_stat_dyn = '0' or s_end_static = '0') then
          s_dyn_ongoing <= '0';

          -- We can send a new config when update
          if(s_leds_conf_update_r_edge = '1' and s_end_static = '1') then
            s_end_static       <= '0';
            s_leds_config_stat <= i_leds_config;  -- Latch the config static
            s_start_frame      <= '1';
          end if;

          if(s_end_static = '0') then
            if(s_frame_done_r_edge = '1') then
              if(s_cnt_nb_leds < G_LEDS_NB - 1) then
                s_cnt_nb_leds <= s_cnt_nb_leds + 1;
                s_start_frame <= '1';
                s_led_config  <= s_leds_config_stat(s_cnt_nb_leds);
              else
                s_cnt_nb_leds <= 0;     -- RAZ cnt
                s_end_static  <= '1';   -- CNT done
                s_led_config  <= (others => '0');
              end if;
            else
              s_start_frame <= '0';
            end if;
          end if;

        -- Dynamic mode
        elsif(s_end_static = '1' and i_stat_dyn = '1') then
          --s_dyn_ongoing <= '1';
          if(s_rfrsh_cnt_done = '1') then
            if(s_frame_done_r_edge = '1') then
              if(s_cnt_nb_leds < G_LEDS_NB - 1) then
                s_cnt_nb_leds <= s_cnt_nb_leds + 1;
                s_start_frame <= '1';
                s_led_config  <= s_leds_config_dyn(s_cnt_nb_leds);
              else
                s_cnt_nb_leds                         <= 0;    -- RAZ cnt
                s_leds_config_dyn(1 to G_LEDS_NB - 1) <= s_leds_config_dyn(0 to G_LEDS_NB - 2);
                s_leds_config_dyn(0)                  <= s_leds_config_dyn(G_LEDS_NB - 1);
                s_rfrsh_cnt_done                      <= '0';  -- Start the refreshment
              end if;
            else
              s_start_frame <= '0';
            end if;

          -- Start the refreshment
          else
            if(s_rfrsh_cnt < unsigned(s_max_cnt)) then
              s_rfrsh_cnt <= s_rfrsh_cnt + 1;
            else
              s_rfrsh_cnt      <= (others => '0');
              s_rfrsh_cnt_done <= '1';
              s_start_frame    <= '1';  -- Restart a frame
            end if;
          end if;


          -- Start the Dyn conf for the 1st time
          if(s_leds_conf_update_r_edge = '1' and s_dyn_ongoing = '0') then
            s_leds_config_dyn <= i_leds_config;  -- Latch the config dyna.
            s_max_cnt         <= i_max_cnt;      -- Refresh MAX CNT
            s_start_frame     <= '1';
            s_dyn_ongoing     <= '1';

          -- Update the leds conf and the refreshment during ongoing conf.
          elsif(s_leds_conf_update_r_edge = '1' and s_dyn_ongoing = '1') then
            s_leds_config_dyn <= i_leds_config;  -- Latch the config dyna.
            s_max_cnt         <= i_max_cnt;      -- Refresh MAX CNT
          end if;

        end if;
      -- i_en = '0'
      else
        s_end_static       <= '1';              -- End config terminated
        s_cnt_nb_leds      <= 0;
        s_leds_config_stat <= (others => (others => '0'));
        s_leds_config_dyn  <= (others => (others => '0'));
        s_led_config       <= (others => '0');
        s_start_frame      <= '0';
        s_rfrsh_cnt        <= (others => '0');  -- RAZ cnt
        s_max_cnt          <= (others => '0');
        s_rfrsh_cnt_done   <= '1';
        s_dyn_ongoing      <= '0';
      end if;


    end if;
  end process p_stat_dyn_mngt;


  -- purpose: This process latches the inputs 
  p_latch_in_mngt : process (clock, rst_n) is
  begin  -- process p_latch_in_mngt
    if rst_n = '0' then                     -- asynchronous reset (active low)
      s_frame_done       <= '0';
      s_leds_conf_update <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      s_frame_done       <= i_frame_done;
      s_leds_conf_update <= i_leds_conf_update;
    end if;
  end process p_latch_in_mngt;

  -- R EDGE detect
  s_frame_done_r_edge       <= i_frame_done and not s_frame_done;
  s_leds_conf_update_r_edge <= i_leds_conf_update and not s_leds_conf_update;

  -- Output affectation
  o_stat_conf_done <= s_end_static;
  o_dyn_ongoing    <= s_dyn_ongoing;
  o_rfrsh_dyn_done <= s_rfrsh_cnt_done;
  o_start_frame    <= s_start_frame;
  o_led_config     <= s_led_config;

end architecture arch_ws2812_leds_mngt;
