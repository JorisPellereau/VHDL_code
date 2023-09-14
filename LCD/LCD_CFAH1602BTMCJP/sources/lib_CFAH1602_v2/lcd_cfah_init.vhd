-------------------------------------------------------------------------------
-- Title      : LCD CFAH Initialization block
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_init.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-08
-- Last update: 2023-09-13
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

library lib_CFAH1602_v2;
use lib_CFAH1602_v2.pkg_lcd_cfah_types_and_func.all;
use lib_CFAH1602_v2.pkg_lcd_cfah.all;

entity lcd_cfah_init is

  generic (
    G_CLK_PERIOD : integer := 20;        -- Period of Input clock in [ns]
    G_DL_N_F_INIT : std_logic_vector(2 downto 0) := "111"
    );

  port (
    clk_sys   : in std_logic;           -- Clock
    rst_n_sys : in std_logic;           -- Asynchronous Reset

    i_start_init : in std_logic;        -- Start Initialization

    i_cmd_done : in std_logic;          -- Command done

    o_cmd_req          : out std_logic;  -- Command request
    o_function_set_cmd : out std_logic;  -- Function Set command
    o_dl_n_f           : out std_logic_vector(2 downto 0);  -- DL N F INIT configuration
    o_display_ctrl     : out std_logic;  -- Display Control Command
    o_entry_mode_set   : out std_logic;  -- Entry Mode set command
    o_clear_display    : out std_logic;  -- Clear Display

    o_init_done : out std_logic         -- Initialization Done
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

  signal init_done             : std_logic;  -- Initialization done
  signal wait_duration_ongoing : std_logic;  -- WAIT Duration Ongoing
  signal func_set_init_ongoing : std_logic;  -- FUNCTION SET INIT Ongoing
  signal func_set_ongoing      : std_logic;  -- Function SET command ongoing
  signal func_set_ongoing_p    : std_logic;  -- Function SET command ongoing
  signal display_clear_ongoing : std_logic;  -- DISPLAY CLEAR Ongoing
  signal display_ctrl_ongoing  : std_logic;  -- DISPLAY CTRL Ongoing

begin  -- architecture rtl

  -- purpose: Duration MAX selection
  p_duration_max_sel : process (clk_sys, rst_n_sys) is
  begin  -- process p_duration_max_sel
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      s_duration_max <= to_unsigned(clk_period_to_max(G_CLK_PERIOD, C_LCD_WAIT_POWER_ON), s_duration_max'length);
    elsif rising_edge(clk_sys) then     -- rising clock edge

      case s_duration_sel is
        when "000" =>
          s_duration_max <= to_unsigned(clk_period_to_max(G_CLK_PERIOD, C_LCD_WAIT_POWER_ON), s_duration_max'length);

        when "001" =>
          s_duration_max <= to_unsigned(clk_period_to_max(G_CLK_PERIOD, C_INIT_WAIT_1), s_duration_max'length);

        when "011" =>
          s_duration_max <= to_unsigned(clk_period_to_max(G_CLK_PERIOD, C_INIT_WAIT_2), s_duration_max'length);

        when others =>
          s_duration_max <= to_unsigned(clk_period_to_max(G_CLK_PERIOD, C_LCD_WAIT_POWER_ON), s_duration_max'length);

      end case;

    end if;
  end process p_duration_max_sel;


  -- purpose: Set the signal en_cnt on lcd_on and stop the counter when it
  -- reaches the max.
  p_cnt_en_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_en_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      en_cnt <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Condition for the activation of the counter
      -- Enable the first counter
      if(i_start_init = '1' or ((func_set_init_ongoing = '1' and i_cmd_done = '1') and s_duration_sel /= "111")) then
        en_cnt <= '1';

      elsif(s_duration_done = '1') then
        en_cnt <= '0';
      end if;

    end if;
  end process p_cnt_en_mngt;
  -- purpose: Duration Counter
  p_cnt_duration : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_duration
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      s_duration_cnt <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Enable to counts
      if(en_cnt = '1') then
        -- if the max is reach -> reset the counter
        if(s_duration_cnt = s_duration_max) then
          s_duration_cnt <= (others => '0');
        else
          s_duration_cnt <= s_duration_cnt + 1;  -- Inc the counter
        end if;

      -- Reset the count when disable
      else
        s_duration_cnt <= (others => '0');
      end if;

    end if;
  end process p_cnt_duration;

  -- purpose: When the counter reach the max -> set the flag s_duration_done
  p_duration_done : process (clk_sys, rst_n_sys) is
  begin  -- process p_duration_done
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      s_duration_done <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      if(s_duration_cnt = s_duration_max) then
        s_duration_done <= '1';
      else
        s_duration_done <= '0';
      end if;

    end if;
  end process p_duration_done;

  -- purpose: Duration selection
  p_duration_sel : process (clk_sys, rst_n_sys) is
  begin  -- process p_duration_sel
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      s_duration_sel <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Reset the vector on INIT DONE
      if(init_done = '1') then
        s_duration_sel <= (others => '0');
      elsif(s_duration_done = '1') then
        s_duration_sel <= s_duration_sel(1 downto 0) & s_duration_done;
      end if;

    end if;
  end process p_duration_sel;


  -- purpose: FSM Current state update from next state
  p_fsm_cs_update : process (clk_sys, rst_n_sys) is
  begin  -- process p_fsm_cs_update
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fsm_cs <= IDLE;
    elsif rising_edge(clk_sys) then     -- rising clock edge
      fsm_cs <= fsm_ns;
    end if;
  end process p_fsm_cs_update;


  -- purpose: 
  p_fsm_ns_update : process (fsm_cs, i_start_init, s_duration_done, i_cmd_done, s_duration_sel) is
  begin  -- process p_fsm_ns_update

    -- Next state computation from CS and inputs
    case fsm_cs is

      -- Stay in IDLE state until the LCD is turned on (pulse on lcd_on input)
      when IDLE =>

        init_done             <= '0';   -- INIT DONE
        wait_duration_ongoing <= '0';   -- Wait duration flag
        func_set_ongoing      <= '0';   -- FUNC SET Ongoing flag
        display_clear_ongoing <= '0';   -- DISP CLEAR Flag
        display_ctrl_ongoing  <= '0';   -- DISP CTRL Flag
        func_set_init_ongoing <= '0';   -- FUNC SET INIT Ongoing flag

        if(i_start_init = '1') then
          fsm_ns <= WAIT_DURATION;
        else
          fsm_ns <= IDLE;
        end if;

      -- In WAIT_DURATION state : stay in this state until the end of the counter
      when WAIT_DURATION =>

        init_done             <= '0';   -- INIT DONE
        wait_duration_ongoing <= '1';   -- Wait duration flag
        func_set_ongoing      <= '0';   -- FUNC SET Ongoing flag
        display_clear_ongoing <= '0';   -- DISP CLEAR Flag
        display_ctrl_ongoing  <= '0';   -- DISP CTRL Flag
        func_set_init_ongoing <= '0';   -- FUNC SET INIT Ongoing flag

        if(s_duration_done = '1') then
          fsm_ns <= FUNC_SET_INIT;
        else
          fsm_ns <= WAIT_DURATION;
        end if;

      when FUNC_SET_INIT =>

        init_done             <= '0';   -- INIT DONE
        wait_duration_ongoing <= '0';   -- Wait duration flag
        func_set_ongoing      <= '0';   -- FUNC SET Ongoing flag
        display_clear_ongoing <= '0';   -- DISP CLEAR Flag
        display_ctrl_ongoing  <= '0';   -- DISP CTRL Flag
        func_set_init_ongoing <= '1';   -- FUNC SET INIT Ongoing flag

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

        init_done             <= '0';   -- INIT DONE
        wait_duration_ongoing <= '0';   -- Wait duration flag
        func_set_ongoing      <= '1';   -- FUNC SET Ongoing flag
        display_clear_ongoing <= '0';   -- DISP CLEAR Flag
        display_ctrl_ongoing  <= '0';   -- DISP CTRL Flag
        func_set_init_ongoing <= '0';   -- FUNC SET INIT Ongoing flag

        if(i_cmd_done = '1') then
          fsm_ns <= DISP_OFF;
        else
          fsm_ns <= FUNC_SET;
        end if;

      when DISP_OFF =>

        init_done             <= '0';   -- INIT DONE
        wait_duration_ongoing <= '0';   -- Wait duration flag
        func_set_ongoing      <= '0';   -- FUNC SET Ongoing flag
        display_clear_ongoing <= '0';   -- DISP CLEAR Flag
        display_ctrl_ongoing  <= '1';   -- DISP CTRL Flag
        func_set_init_ongoing <= '0';   -- FUNC SET INIT Ongoing flag

        if(i_cmd_done = '1') then
          fsm_ns <= DISP_CLR;
        else
          fsm_ns <= DISP_OFF;
        end if;

      when DISP_CLR =>

        init_done             <= '0';   -- INIT DONE
        wait_duration_ongoing <= '0';   -- Wait duration flag
        func_set_ongoing      <= '0';   -- FUNC SET Ongoing flag
        display_clear_ongoing <= '1';   -- DISP CLEAR Flag
        display_ctrl_ongoing  <= '0';   -- DISP CTRL Flag
        func_set_init_ongoing <= '0';   -- FUNC SET INIT Ongoing flag

        if(i_cmd_done = '1') then
          fsm_ns <= ENTRY_SET;
        else
          fsm_ns <= DISP_CLR;
        end if;

      when ENTRY_SET =>

        init_done             <= '0';   -- INIT DONE
        wait_duration_ongoing <= '0';   -- Wait duration flag
        func_set_ongoing      <= '0';   -- FUNC SET Ongoing flag
        display_clear_ongoing <= '0';   -- DISP CLEAR Flag
        display_ctrl_ongoing  <= '0';   -- DISP CTRL Flag
        func_set_init_ongoing <= '0';   -- FUNC SET INIT Ongoing flag

        if(i_cmd_done = '1') then
          fsm_ns    <= IDLE;
          init_done <= '1';             -- INIT DONE
        else
          fsm_ns <= ENTRY_SET;
        end if;

      when others =>
        fsm_ns                <= IDLE;
        init_done             <= '0';   -- INIT DONE
        wait_duration_ongoing <= '0';   -- Wait duration flag
        func_set_ongoing      <= '0';   -- FUNC SET Ongoing flag
        display_clear_ongoing <= '0';   -- DISP CLEAR Flag
        display_ctrl_ongoing  <= '0';   -- DISP CTRL Flag
        func_set_init_ongoing <= '0';   -- FUNC SET INIT Ongoing flag

    end case;

  end process p_fsm_ns_update;

  -- purpose: Command request generation
  -- Generation of the cmd_req signal when a duration is terminated or a new
  -- command is beeing generated
  p_cmd_req_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_cmd_req_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_cmd_req <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- When a duration is terminated generated the cmd_req
      if(
        (s_duration_done = '1') or
        (func_set_ongoing = '1' and func_set_ongoing_p = '0') or
        (i_cmd_done = '1' and (func_set_ongoing = '1' or display_clear_ongoing = '1' or display_ctrl_ongoing = '1'))
        ) then

        o_cmd_req <= '1';
      -- Cmd Request is a pulse
      -- Reset it in all other way
      else
        o_cmd_req <= '0';
      end if;
    end if;
  end process p_cmd_req_mngt;


  -- purpose: Generation of the function_set command
  -- Generate it after each duration and when entering in FUNC_SET state
  p_function_set_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_function_set_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_function_set_cmd <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- When a duration is terminated generated the function_set_cmd
      -- Or when we entering in function_set state (rising edge detection
      if((wait_duration_ongoing = '1' and s_duration_done = '1') or
         (func_set_ongoing = '1' and func_set_ongoing_p = '0')
         ) then

        o_function_set_cmd <= '1';
      -- Cmd Request is a pulse
      -- Reset it in all other way
      else
        o_function_set_cmd <= '0';
      end if;

    end if;
  end process p_function_set_mngt;

  -- purpose: DISPLAY Control Command management
  --
  p_display_ctrl_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_display_ctrl_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_display_ctrl <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Set the command when the FUNCTION_SET was previously executed
      if(func_set_ongoing = '1' and i_cmd_done = '1') then
        o_display_ctrl <= '1';
      else
        o_display_ctrl <= '0';
      end if;
    end if;
  end process p_display_ctrl_mngt;

  -- purpose: DISPLAY Clear command management
  -- Set this command when the DISPLAY_CTRL command was previously executed
  p_display_clear_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_display_clear_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_clear_display <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Set the command when the DISP_OFF command was previously executed
      if(display_ctrl_ongoing = '1' and i_cmd_done = '1') then
        o_clear_display <= '1';
      else
        o_clear_display <= '0';
      end if;
    end if;
  end process p_display_clear_mngt;

  -- purpose: Entry Mode Set command management
  -- This command is executed when the previous command DISPLAY_CLEAR was executed
  p_entry_mode_set_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_entry_mode_set_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_entry_mode_set <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Set the command when the last command display clear was previously executed
      if(display_clear_ongoing = '1' and i_cmd_done = '1') then
        o_entry_mode_set <= '1';
      else
        o_entry_mode_set <= '0';
      end if;

    end if;
  end process p_entry_mode_set_mngt;

  -- purpose: Piped internal signals
  p_pipe_sig : process (clk_sys, rst_n_sys) is
  begin  -- process p_pipe_sig
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      func_set_ongoing_p <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      func_set_ongoing_p <= func_set_ongoing;
    end if;
  end process p_pipe_sig;

  -- purpose: INIT Done Management
  p_init_done_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_init_done_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_init_done <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      o_init_done <= init_done;
    end if;
  end process p_init_done_mngt;

  -- purpose: DL N F Configuration init value
  p_dl_n_f_mngt: process (clk_sys, rst_n_sys) is
  begin  -- process p_dl_n_f_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_dl_n_f <= G_DL_N_F_INIT;
    elsif rising_edge(clk_sys) then     -- rising clock edge
      o_dl_n_f <= G_DL_N_F_INIT;
    end if;
  end process p_dl_n_f_mngt;

end architecture rtl;
