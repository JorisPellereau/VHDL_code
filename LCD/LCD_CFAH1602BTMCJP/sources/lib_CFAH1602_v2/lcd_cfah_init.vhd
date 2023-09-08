-------------------------------------------------------------------------------
-- Title      : LCD CFAH Initialization block
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_init.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-08
-- Last update: 2023-09-08
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This block performs the initialization of the LCD when the
-- reset is released. This block used the 8-bit interface of the LCD
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-08  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah_types_and_func.all;
use lib_CFAH1602.pkg_lcd_cfah.all;

entity lcd_cfah_init is

  generic (
    G_CLK_PERIOD : integer := 20        -- Period of Input clock in [ns]
    );

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    i_lcd_on     : in std_logic;        -- LCD ON pulse
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

  -- == TYPES ==
  type t_fsm_state is (IDLE, WAIT_DURATION, FUNC_SET_INIT, FUNC_SET, DISP_OFF, DISP_CLR, ENTRY_SET);  -- FSM States

  -- == Inernal Signals ==
  signal fsm_cs : t_fsm_state;          -- FSM Current State
  signal fsm_ns : t_fsm_state;          -- FSM Next State

  signal en_cnt : std_logic;            -- Enable the counter

  signal s_duration_cnt : unsigned(log2(C_LCD_WAIT_POWER_ON) - 1 downto 0);  -- Duration for initialization sequence counter
  signal s_duration_max : unsigned(log2(C_LCD_WAIT_POWER_ON) - 1 downto 0);  -- Max duration

  signal s_duration_done : std_logic;   -- Duration done flag
  signal s_duration_sel  : std_logic_vector(2 downto 0);  -- A bit that correspond to a done of the counter

  signal init_done    : std_logic;      -- Initialization done
  signal init_ongoing : std_logic;      -- Init Ongoing

begin  -- architecture rtl

  -- purpose: Duration MAX selection
  p_duration_max_sel : process (clk, rst_n) is
  begin  -- process p_duration_max_sel
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_duration_max <= clk_period_to_max(G_CLK_PERIOD, C_LCD_WAIT_POWER_ON);
    elsif rising_edge(clk) then         -- rising clock edge

      case s_duration_sel is
        when "000" =>
          s_duration_max <= clk_period_to_max(G_CLK_PERIOD, C_LCD_WAIT_POWER_ON);

        when "001" =>
          s_duration_max <= clk_period_to_max(G_CLK_PERIOD, C_INIT_WAIT_1);

        when "011" =>
          s_duration_max <= clk_period_to_max(G_CLK_PERIOD, C_INIT_WAIT_2);

        when others =>
          s_duration_max <= clk_period_to_max(G_CLK_PERIOD, C_LCD_WAIT_POWER_ON);

      end case;

    end if;
  end process p_duration_max_sel;


  -- purpose: Set the signal en_cnt on lcd_on and stop the counter when it
  -- reaches the max.
  p_cnt_en_mngt : process (clk, rst_n) is
  begin  -- process p_cnt_en_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      en_cnt <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Condition for the activation of the counter
      if(lcd_on = '1') then
        en_cnt <= '1';

      elsif(s_duration_done = '1') then
        en_cnt <= '0';
      end if;

    end if;
  end process p_cnt_en_mngt;
  -- purpose: Duration Counter
  p_cnt_duration : process (clk, rst_n) is
  begin  -- process p_cnt_duration
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_duration_cnt <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- if the max is reach -> reset the counter
      if(s_duration_cnt = s_duration_max) then
        s_duration_cnt <= (others => '0');
      else
        s_duration_cnt <= s_duration_cnt + 1;  -- Inc the counter
      end if;

    end if;
  end process p_cnt_duration;

  -- purpose: When the counter reach the max -> set the flag s_duration_done
  p_duration_done : process (clk, rst_n) is
  begin  -- process p_duration_done
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_duration_done <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      if(s_duration_cnt = s_duration_max) then
        s_duration_done <= '1';
      else
        s_duration_done <= '0';
      end if;

    end if;
  end process p_duration_done;

  -- purpose: Duration selection
  p_duration_sel : process (clk, rst_n) is
  begin  -- process p_duration_sel
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_duration_sel <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Reset the vector on INIT DONE
      if(init_done = '1') then
        s_duration_sel <= (others => '0');
      elsif(s_duration_done = '1') then
        s_duration_sel <= s_duration_sel(1 downto 0) & s_duration_done;
      end if;

    end if;
  end process p_duration_sel;


  -- purpose: FSM Current state update from next state
  p_fsm_cs_update : process (clk, rst_n) is
  begin  -- process p_fsm_cs_update
    if rst_n = '0' then                 -- asynchronous reset (active low)
      fsm_cs <= IDLE;
    elsif rising_edge(clk) then         -- rising clock edge
      fsm_cs <= fsm_ns;
    end if;
  end process p_fsm_cs_update;


  -- purpose: 
  p_fsm_ns_update : process (fsm_cs) is
  begin  -- process p_fsm_ns_update

    -- Next state computation from CS and inputs
    case fsm_cs is

      -- Stay in IDLE state until the LCD is turned on (pulse on lcd_on input)
      when IDLE =>

        init_done    <= '0';            -- INIT DONE
        init_ongoing <= '0';            -- Init Ongoing flag

        if(i_lcd_on = '1') then
          fsm_ns <= WAIT_DURATION;
        else
          fsm_ns <= IDLE;
        end if;

      -- In WAIT_DURATION state : stay in this state until the end of the counter
      when WAIT_DURATION =>

        init_done    <= '0';            -- INIT DONE
        init_ongoing <= '1';            -- Init Ongoing flag
        if(s_duration_done = '1') then
          fsm_ns <= FUNC_SET_INIT;
        else
          fsm_ns <= WAIT_DURATION;
        end if;

      when FUNC_SET_INIT =>

        init_done    <= '0';            -- INIT DONE
        init_ongoing <= '1';            -- Init Ongoing flag
        -- When the command is done and until all the duration are not
        -- performed -> return in WAIT state
        if(i_cmd_done = '1' and s_duration_sel /= "111") then
          fsm_ns <= WAIT_DURATION;

        -- When all the duration is performed and the last FUNC_SET_INIT cmd is
        -- done, got to FUNC_SET state 
        elsif(i_cmd_done = '1' and s_duration_sel = "111") then
          fsm_ns <= FUNC_SET;

        -- !when i_cmd_done is not set -> stay in the state
        else
          fsm_ns <= FUNC_SET_INIT;
        end if;

      when FUNC_SET =>

        init_done    <= '0';            -- INIT DONE
        init_ongoing <= '1';            -- Init Ongoing flag
        if(i_cmd_done = '1') then
          fsm_ns <= DISP_OFF;
        else
          fsm_ns <= FUNC_SET;
        end if;

      when DISP_OFF =>

        init_done    <= '0';            -- INIT DONE
        init_ongoing <= '1';            -- Init Ongoing flag
        if(i_cmd_done = '1') then
          fsm_ns <= DISP_CLR;
        else
          fsm_ns <= DISP_OFF;
        end if;

      when DISP_CLR =>

        init_done    <= '0';            -- INIT DONE
        init_ongoing <= '1';            -- Init Ongoing flag
        if(i_cmd_done = '1') then
          fsm_ns <= ENTRY_SET;
        else
          fsm_ns <= DISP_CLR;
        end if;

      when ENTRY_SET =>

        init_done    <= '0';            -- INIT DONE
        init_ongoing <= '1';            -- Init Ongoing flag
        if(i_cmd_done = '1') then
          fsm_ns <= IDLE;

          init_done    <= '1';          -- INIT DONE
          init_ongoing <= '0';          -- Init Ongoing flag
        else
          fsm_ns <= ENTRY_SET;
        end if;

      when others =>
        fsm_ns       <= IDLE;
        init_done    <= '0';            -- INIT DONE
        init_ongoing <= '0';            -- Init Ongoing flag

    end case;

  end process p_fsm_ns_update;

  -- == OUTPUTS affectation ==
  o_init_done    <= init_done;
  o_init_ongoing <= init_ongoing;

end architecture rtl;
