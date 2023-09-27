-------------------------------------------------------------------------------
-- Title      : LCD CFAH MAIN FSM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_main_fsm.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-12
-- Last update: 2023-09-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Main FSM of LCD CFAH.
-- Start in INIT state in order to wait for the initialization and filter command during INIT.
-- Filter commands during command execution
-- Manage the mux selector for the command
-- "00" -> INIT configuration
-- "01" -> SINGLE_CMD
-- "10" -> UPDATE_DISPLAY Commands
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_cfah_main_fsm is
  port (
    clk_sys   : in std_logic;           -- System Clock
    rst_n_sys : in std_logic;           -- Asynchronous reset

    i_lcd_on   : in  std_logic;         -- LCD ON Command
    start_init : out std_logic;         -- Start Init command

    -- External LCD Commands
    i_func_set          : in std_logic;  -- Function Set command
    i_cursor_disp_shift : in std_logic;  -- Cursor Or display shift
    i_disp_on_off_ctrl  : in std_logic;  -- Displau ON/OFF Control command
    i_entry_mode_set    : in std_logic;  -- Entry Mode Set command
    i_return_home       : in std_logic;  -- Return Home Command
    i_clear_disp        : in std_logic;  -- Clear Display Command
    i_update_all_lcd    : in std_logic;  -- Update the entire LCD display command
    i_update_one_char   : in std_logic;  -- Update one character command

    -- LCD Commands to send inside the function
    o_func_set          : out std_logic;                     -- Function Set command
    o_cursor_disp_shift : out std_logic;                     -- Cursor Or display shift
    o_disp_on_off_ctrl  : out std_logic;                     -- Displau ON/OFF Control command
    o_entry_mode_set    : out std_logic;                     -- Entry Mode Set command
    o_return_home       : out std_logic;                     -- Return Home Command
    o_clear_disp        : out std_logic;                     -- Clear Display Command
    o_start_cmd         : out std_logic;                     -- Start Command signal
    o_update_all_lcd    : out std_logic;                     -- Update the entire LCD display command
    o_update_one_char   : out std_logic;                     -- Update one character command
    o_mux_sel           : out std_logic_vector(1 downto 0);  -- Mux selection of command

    polling_done        : in std_logic;  -- Polling Command done
    update_display_done : in std_logic;  -- Update Display Done

    init_ongoing        : out std_logic;  -- Initialization ongoing
    init_done           : in  std_logic;  -- Initialization done
    single_cmd_ongoing  : out std_logic;  -- SINGLE Command ongoing
    update_disp_ongoing : out std_logic   -- UPDATE Display Ongoing
    );
end entity lcd_cfah_main_fsm;

architecture rtl of lcd_cfah_main_fsm is

  -- == TYPES ==
  type t_fsm_state is (IDLE, WAIT_LCD_ON, LCD_INIT, OPE, SINGLE_CMD, UPDATE_DISPLAY);  -- FSM States

  signal fsm_cs : t_fsm_state;          -- Current State
  signal fsm_ns : t_fsm_state;          -- Next state

  signal start_init_int           : std_logic;                     -- Internal Start init
  signal start_init_p             : std_logic;                     -- Internal Start init
  signal single_cmd_detect        : std_logic;                     -- Single Command detection
  signal single_cmd_vector        : std_logic_vector(5 downto 0);  -- Single Command vector Latch
  signal update_all_lcd_int       : std_logic;                     -- Update all lcd command latch
  signal update_one_char_int      : std_logic;                     -- Update one char lcd command latch
  signal single_cmd_ongoing_int   : std_logic;                     -- Single Command ongoing flag
  signal single_cmd_ongoing_int_p : std_logic;                     -- Single Command ongoing flag piped
  signal update_disp_ongoing_int  : std_logic;                     -- Update Display ongoing flag

begin  -- architecture rtl

  -- Single command detection : set when one of this command are set :
  -- i_func_set           
  -- i_cursor_disp_shift   
  -- i_disp_on_off_ctrl    
  -- i_entry_mode_set     
  -- i_return_home        
  -- i_clear_disp         
  single_cmd_detect <= i_func_set or i_cursor_disp_shift or i_disp_on_off_ctrl or i_entry_mode_set or i_return_home or i_clear_disp;

  -- purpose: Single Command latch purpose
  p_latch_single_cmd : process (clk_sys, rst_n_sys) is
  begin  -- process p_latch_single_cmd
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      single_cmd_vector <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge
      single_cmd_vector <= i_func_set & i_cursor_disp_shift & i_disp_on_off_ctrl & i_entry_mode_set & i_return_home & i_clear_disp;
    end if;
  end process p_latch_single_cmd;

  -- purpose: LCD Update all latch
  p_lcd_update_all_latch : process (clk_sys, rst_n_sys) is
  begin  -- process p_lcd_update_all_latch
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      update_all_lcd_int <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      update_all_lcd_int <= i_update_all_lcd;
    end if;
  end process p_lcd_update_all_latch;

  -- purpose: LCD Update one char latch
  p_lcd_update_one_char : process (clk_sys, rst_n_sys) is
  begin  -- process p_lcd_update_one_char
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      update_one_char_int <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      update_one_char_int <= i_update_one_char;
    end if;
  end process p_lcd_update_one_char;

  -- purpose: Piped one time single cmd_onging int
  -- Used in order to detectthe rising edge
  p_piped_single_cmd_ongoing: process (clk_sys, rst_n_sys) is
  begin  -- process p_piped_single_cmd_ongoing
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      single_cmd_ongoing_int_p <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      single_cmd_ongoing_int_p <= single_cmd_ongoing_int;
    end if;
  end process p_piped_single_cmd_ongoing;

  -- purpose: Single Command generation
  -- Generates single command if we are in SINGLE_CMD state
  -- Otherwise no generation of the command (filtering)
  p_single_cmd_generation : process (clk_sys, rst_n_sys) is
  begin  -- process p_single_cmd_generation
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_func_set          <= '0';
      o_cursor_disp_shift <= '0';
      o_disp_on_off_ctrl  <= '0';
      o_entry_mode_set    <= '0';
      o_return_home       <= '0';
      o_clear_disp        <= '0';
      o_start_cmd         <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Single Command generation on the detection of the rising edge of single_cmd_ongoing_int
      if(single_cmd_ongoing_int = '1' and single_cmd_ongoing_int_p = '0') then
        o_func_set          <= single_cmd_vector(5);
        o_cursor_disp_shift <= single_cmd_vector(4);
        o_disp_on_off_ctrl  <= single_cmd_vector(3);
        o_entry_mode_set    <= single_cmd_vector(2);
        o_return_home       <= single_cmd_vector(1);
        o_clear_disp        <= single_cmd_vector(0);
        o_start_cmd         <= '1';
      -- Reset signals
      else
        o_func_set          <= '0';
        o_cursor_disp_shift <= '0';
        o_disp_on_off_ctrl  <= '0';
        o_entry_mode_set    <= '0';
        o_return_home       <= '0';
        o_clear_disp        <= '0';
        o_start_cmd         <= '0';
      end if;

    end if;
  end process p_single_cmd_generation;

  -- purpose: LCD update command generation
  p_lcd_update_cmd_generation : process (clk_sys, rst_n_sys) is
  begin  -- process p_lcd_update_cmd_generation
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_update_one_char <= '0';
      o_update_all_lcd  <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Generates only if state ongoing display
      if(update_disp_ongoing_int = '1') then
        o_update_one_char <= update_one_char_int;
        o_update_all_lcd  <= update_all_lcd_int;
      -- Pulses generation
      else

        o_update_one_char <= '0';
        o_update_all_lcd  <= '0';
      end if;
    end if;
  end process p_lcd_update_cmd_generation;

  -- purpose: Update of the current state
  p_fsm_cs_update : process (clk_sys, rst_n_sys) is
  begin  -- process p_fsm_cs_update
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fsm_cs <= IDLE;
    elsif rising_edge(clk_sys) then     -- rising clock edge
      fsm_cs <= fsm_ns;
    end if;
  end process p_fsm_cs_update;


  -- purpose: Update the fsm_ns signal in function of the current state and inputs
  p_fsm_ns_update : process (fsm_cs, i_lcd_on, init_done, single_cmd_detect, i_update_all_lcd,
                             i_update_one_char, polling_done, update_display_done) is
  begin  -- process p_fsm_ns_update

    case fsm_cs is

      -- In IDLE, when the reset is released, go to WAIT_LCD_ON state
      when IDLE =>

        init_ongoing            <= '0';              -- Init Ongoing flag
        start_init_int          <= '0';              -- Start init internal
        single_cmd_ongoing_int  <= '0';              -- Single Command ongoing
        update_disp_ongoing_int <= '0';              -- Update display ongoing
        fsm_ns                  <= WAIT_LCD_ON;
        o_mux_sel               <= (others => '0');  -- Mux data selection

      -- In WAIT_LCD_ON state, when the LCD_ON signal is set, go to LCD_INIT state
      when WAIT_LCD_ON =>

        init_ongoing            <= '0';              -- Init Ongoing flag
        start_init_int          <= '0';              -- Start init internal
        single_cmd_ongoing_int  <= '0';              -- Single Command ongoing
        update_disp_ongoing_int <= '0';              -- Update display ongoing
        o_mux_sel               <= (others => '0');  -- Mux data selection

        if(i_lcd_on = '1') then
          fsm_ns       <= LCD_INIT;
          init_ongoing <= '1';          -- Init Ongoing flag
        else
          fsm_ns         <= WAIT_LCD_ON;
          start_init_int <= '0';        -- Start init internal
        end if;


      -- In LCD INIT state, when the initialization is done, go to OPE state
      when LCD_INIT =>
        init_ongoing            <= '1';              -- Init Ongoing flag
        start_init_int          <= '1';              -- Start init internal
        single_cmd_ongoing_int  <= '0';              -- Single Command ongoing
        update_disp_ongoing_int <= '0';              -- Update display ongoing
        o_mux_sel               <= (others => '0');  -- Mux data selection

        if(init_done = '1') then
          fsm_ns <= OPE;
        else
          fsm_ns <= LCD_INIT;
        end if;

      -- In OPE state, wait in this state until the LCD_ON is set to '0'
      when OPE =>
        init_ongoing            <= '0';              -- Init Ongoing flag
        start_init_int          <= '0';              -- Start init internal
        single_cmd_ongoing_int  <= '0';              -- Single Command ongoing
        update_disp_ongoing_int <= '0';              -- Update display ongoing
        o_mux_sel               <= (others => '0');  -- Mux data selection

        -- Priority on LCD ON
        if(i_lcd_on = '0') then
          fsm_ns <= IDLE;

        -- A single Command is detected          
        elsif(single_cmd_detect = '1') then
          fsm_ns <= SINGLE_CMD;

        -- Update all LCD command detected
        elsif(i_update_all_lcd = '1' or i_update_one_char = '1') then
          fsm_ns <= UPDATE_DISPLAY;

        else
          fsm_ns <= OPE;
        end if;


      -- Generate Single Command
      -- Stay in this state until the end of the command
      when SINGLE_CMD =>
        single_cmd_ongoing_int  <= '1';   -- Single Command ongoing
        update_disp_ongoing_int <= '0';   -- Update display ongoing
        o_mux_sel               <= "01";  -- Mux data selection

        if(polling_done = '1') then
          fsm_ns <= OPE;
        else
          fsm_ns <= SINGLE_CMD;
        end if;


      -- Stay in this state until the end of the UPDATE of the display
      when UPDATE_DISPLAY =>
        single_cmd_ongoing_int  <= '0';   -- Single Command ongoing
        update_disp_ongoing_int <= '1';   -- Update display ongoing
        o_mux_sel               <= "10";  -- Mux data selection

        if(update_display_done = '1') then
          fsm_ns <= OPE;
        else
          fsm_ns <= UPDATE_DISPLAY;
        end if;

      when others =>
        init_ongoing            <= '0';              -- Init Ongoing flag
        start_init_int          <= '0';              -- Start init internal
        single_cmd_ongoing_int  <= '0';              -- Single Command ongoing
        update_disp_ongoing_int <= '0';              -- Update display ongoing
        fsm_ns                  <= IDLE;
        o_mux_sel               <= (others => '0');  -- Mux data selection

    end case;

  end process p_fsm_ns_update;

  -- purpose: Generation of a pulse of start init
  p_start_init_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_start_init_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      start_init_p <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      start_init_p <= start_init_int;
    end if;
  end process p_start_init_mngt;

  start_init <= start_init_int and not start_init_p;

  single_cmd_ongoing  <= single_cmd_ongoing_int;   -- Single Ongoing Int
  update_disp_ongoing <= update_disp_ongoing_int;  -- Update display ongoing
end architecture rtl;
