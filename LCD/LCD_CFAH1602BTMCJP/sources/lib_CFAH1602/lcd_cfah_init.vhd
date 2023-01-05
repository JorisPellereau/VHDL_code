-------------------------------------------------------------------------------
-- Title      : LCD CFAH Initialization
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lch_cfah_init.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-12-02
-- Last update: 2023-01-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: LCD CFAH Initialization Block
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-12-02  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah_types_and_func.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah.all;

entity lcd_cfah_init is

  generic (
    G_CLK_PERIOD : integer := 20        -- Period of Input clock in [ns]
    );

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    i_lcd_on     : in std_logic;        -- LCD ON
    i_start_init : in std_logic;        -- Start Initialization

    i_cmd_done         : in  std_logic;  -- Command done
    o_function_set_cmd : out std_logic;  -- Function Set command
    o_display_ctrl     : out std_logic;  -- Display Control Command
    o_entry_mode_set   : out std_logic;  -- Entry Mode set command
    o_clear_display    : out std_logic;  -- Clear Display

    o_init_ongoing          : out std_logic;  -- Init. ongoing
    o_power_on_init_ongoing : out std_logic;  -- Power On init ongoing
    o_init_done             : out std_logic   -- Initialization Done
    );

end entity lcd_cfah_init;


architecture rtl of lcd_cfah_init is

  -- Internal SIGNALS
  signal s_init_ongoing  : std_logic;   -- First Initialization ongoing
  signal s_power_on_init : std_logic;  -- Initialization after a power_on ongoing

  signal s_duration_cnt              : std_logic_vector(log2(C_LCD_WAIT_POWER_ON) - 1 downto 0);  -- Duration for initialization sequence counter
  signal s_duration_max              : std_logic_vector(log2(C_LCD_WAIT_POWER_ON) - 1 downto 0);  -- Max duration
  signal s_duration_cnt_reach        : std_logic;
  signal s_duration_cnt_reach_p      : std_logic;
  signal s_duration_cnt_reach_r_edge : std_logic;
  signal s_start_cnt                 : std_logic;  -- Start Counter

  signal s_cnt_cmd       : std_logic_vector(3 downto 0);  -- Command Counter
  signal s_cnt_cmd_max   : std_logic_vector(3 downto 0);  -- Max Command counter
  signal s_cnt_cmd_up    : std_logic;   -- Counter inc
  signal s_lcd_on        : std_logic;   -- LCD On pipe one time
  signal s_lcd_on_r_edge : std_logic;   -- LCD On Rising Edge detection
  signal s_init_done     : std_logic;   -- Init. Done
  signal s_start_init    : std_logic;   -- Start init pipe

begin  -- architecture rtl

  -- purpose: Pipe inputs
  p_pipe_inputs : process (clk, rst_n) is
  begin  -- process p_pipe_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start_init <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_start_init <= i_start_init;
    end if;
  end process p_pipe_inputs;

  -- purpose: Pipe Signals
  p_pipe_signals : process (clk, rst_n) is
  begin  -- process p_pipe_signals
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_lcd_on               <= '0';
      s_duration_cnt_reach_p <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_lcd_on               <= i_lcd_on;
      s_duration_cnt_reach_p <= s_duration_cnt_reach;
    end if;
  end process p_pipe_signals;

  -- Rising Edge detection
  s_lcd_on_r_edge             <= i_lcd_on and not s_lcd_on;
  s_duration_cnt_reach_r_edge <= s_duration_cnt_reach and not s_duration_cnt_reach_p;

  -- purpose: First Init Ongoing mngt
  p_init_ongoing : process (clk, rst_n) is
  begin  -- process p_first_init_ongoing
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_init_ongoing <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_lcd_on_r_edge = '1' or i_start_init = '1') then
        s_init_ongoing <= '1';

      -- When done reset ongoing flag
      elsif(s_init_done = '1') then
        s_init_ongoing <= '0';
      end if;

    end if;
  end process p_init_ongoing;

-- purpose: Power on Init ongoing management

  p_power_on_init_ongoing_mngt : process (clk, rst_n) is
  begin  -- process p_power_on_init_ongoing_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_power_on_init <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Set to one only when a lcd_on command is ongoing
      if(s_lcd_on_r_edge = '1') then
        s_power_on_init <= '1';

      -- When done reset ongoing flag
      elsif(s_init_done = '1') then
        s_power_on_init <= '0';
      end if;

    end if;
  end process p_power_on_init_ongoing_mngt;


  -- purpose: MAX Counter of command management 
  p_cnt_cmd_max_mngt : process (clk, rst_n) is
  begin  -- process p_cnt_cmd_max_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_cmd_max <= x"6";            -- By Default 6 Command max (7-1)
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Set Max Command for an initialization after an LCD ON Request
      if(s_lcd_on_r_edge = '1') then
        s_cnt_cmd_max <= x"6";          -- By Default 6 Command max (7-1)

      -- If start init do only 4 commands : Function_set - Display_off -
      -- Display_clear - Entry_mode_set
      elsif(i_start_init = '1') then
        s_cnt_cmd_max <= x"3"; -- 4 command -1
      end if;

    end if;
  end process p_cnt_cmd_max_mngt;

  -- purpose: Function Set counter Management
  p_cmd_cnt_mngt : process (clk, rst_n) is
  begin  -- process p_cmd_cnt_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_cmd    <= (others => '0');
      s_cnt_cmd_up <= '0';
      s_init_done  <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_cmd_done = '1' and s_init_ongoing = '1') then
        if(unsigned(s_cnt_cmd) < unsigned(s_cnt_cmd_max)) then
          s_cnt_cmd    <= unsigned(s_cnt_cmd) + 1;
          s_cnt_cmd_up <= '1';
        else
          s_init_done <= '1';
          s_cnt_cmd   <= (others => '0');
        end if;

      else
        s_cnt_cmd_up <= '0';
      end if;

      -- Reset Done flag when lcd is on again and if not ongoing process
      if(s_lcd_on_r_edge = '1' and s_init_ongoing = '0') then
        s_init_done <= '0';
      end if;

    end if;
  end process p_cmd_cnt_mngt;

  -- purpose: Command generation management
  p_cmd_mngt : process (clk, rst_n) is
  begin  -- process p_cmd_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_function_set_cmd <= '0';
      o_display_ctrl     <= '0';
      o_entry_mode_set   <= '0';
      o_clear_display    <= '0';

    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Generation of function after end of counter 
      if(s_duration_cnt_reach_r_edge = '1' and s_init_ongoing = '1' and s_power_on_init = '1') then

        case unsigned(s_cnt_cmd) is
          when conv_unsigned(0, s_cnt_cmd'length) =>
            o_function_set_cmd <= '1';

          when conv_unsigned(1, s_cnt_cmd'length) =>
            o_function_set_cmd <= '1';

          when conv_unsigned(2, s_cnt_cmd'length) =>
            o_function_set_cmd <= '1';

          when others => null;
        end case;

      -- Following command are send only when cnt_cmd in incremented and when
      -- correcponding counter value is reach
      elsif(s_cnt_cmd_up = '1' and s_init_ongoing = '1' and s_power_on_init = '1') then

        case unsigned(s_cnt_cmd) is
          when conv_unsigned(3, s_cnt_cmd'length) =>
            o_function_set_cmd <= '1';

          when conv_unsigned(4, s_cnt_cmd'length) =>
            o_display_ctrl <= '1';

          when conv_unsigned(5, s_cnt_cmd'length) =>
            o_clear_display <= '1';

          when conv_unsigned(6, s_cnt_cmd'length) =>
            o_entry_mode_set <= '1';
          when others => null;
        end case;

      -- On specific init
      elsif((s_start_init = '1' or s_cnt_cmd_up = '1') and s_power_on_init = '0') then
        case unsigned(s_cnt_cmd) is
          when conv_unsigned(0, s_cnt_cmd'length) =>
            o_function_set_cmd <= '1';

          when conv_unsigned(1, s_cnt_cmd'length) =>
            o_display_ctrl <= '1';

          when conv_unsigned(2, s_cnt_cmd'length) =>
            o_clear_display <= '1';

          when conv_unsigned(3, s_cnt_cmd'length) =>
            o_entry_mode_set <= '1';
          when others => null;
        end case;

      else
        o_function_set_cmd <= '0';
        o_display_ctrl     <= '0';
        o_entry_mode_set   <= '0';
        o_clear_display    <= '0';

      end if;

    end if;
  end process p_cmd_mngt;


  -- purpose: Duration Counter Management
  p_cnt_duration_mngt : process (clk, rst_n) is
  begin  -- process p_cnt_duration_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_duration_cnt       <= (others => '0');
      s_duration_cnt_reach <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Reset Counter
      if(s_start_cnt = '1') then
        s_duration_cnt       <= (others => '0');
        s_duration_cnt_reach <= '0';

      -- Inc counter until Max reach
      elsif(unsigned(s_duration_cnt) < unsigned(s_duration_max)) then
        s_duration_cnt       <= unsigned(s_duration_cnt) + 1;
        s_duration_cnt_reach <= '0';

      -- Max reach - Counter stop
      else
        s_duration_cnt_reach <= '1';

      end if;

    end if;
  end process p_cnt_duration_mngt;



  -- purpose: Duration Max management 
  p_duration_max_mngt : process (clk, rst_n) is
  begin  -- process p_duration_max_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_duration_max <= (others => '0');
      s_start_cnt    <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- On rising Edge -> Update MAX for initialization
      if(s_lcd_on_r_edge = '1') then
        s_duration_max <= std_logic_vector(conv_unsigned(clk_period_to_max(G_CLK_PERIOD, C_LCD_WAIT_POWER_ON), s_duration_max'length));
        s_start_cnt    <= '1';

      -- Use only when power on init
      elsif(s_cnt_cmd_up = '1' and s_power_on_init = '1') then

        if(unsigned(s_cnt_cmd) = 1) then
          s_duration_max <= std_logic_vector(conv_unsigned(clk_period_to_max(G_CLK_PERIOD, C_INIT_WAIT_1), s_duration_max'length));
          s_start_cnt    <= '1';

        elsif(unsigned(s_cnt_cmd) = 2) then
          s_duration_max <= std_logic_vector(conv_unsigned(clk_period_to_max(G_CLK_PERIOD, C_INIT_WAIT_2), s_duration_max'length));
          s_start_cnt    <= '1';
        end if;

      else
        s_start_cnt <= '0';             -- Pulse
      end if;

    end if;
  end process p_duration_max_mngt;

  -- Outputs Affectation
  o_init_done <= s_init_done;

  -- Flag generated only during power on init because no polling is necessary
  -- During "regular init" we have to poll busy status between each command
  o_init_ongoing <= s_init_ongoing;-- when s_power_on_init = '1' else '0';

  o_power_on_init_ongoing <= s_power_on_init;
end architecture rtl;
