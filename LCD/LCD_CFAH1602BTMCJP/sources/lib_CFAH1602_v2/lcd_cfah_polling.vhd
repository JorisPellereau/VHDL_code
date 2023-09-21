-------------------------------------------------------------------------------
-- Title      : LCD CFAH Command polling
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_polling.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-12
-- Last update: 2023-09-21
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: LCD CFAH Commands polling
-- Commands list :
-- CLEAR_DISPLAY           : i_cmds(0)
-- RETURN_HOME             : i_cmds(1)
-- ENTRY_MODE_SET          : i_cmds(2)
-- DISPLAY_ON_IFF_CTRL     : i_cmds(3)
-- CURSOR_OR_DISPlay_SHIFT : i_cmds(4)
-- FUNCTION_SET            : i_cmds(5)
-- SET_CGRAM_ADDR          : i_cmds(6)
-- SET_DDRAM_ADDR          : i_cmds(7)
-- READ_BUSY_FLAG          : i_cmds(8)
-- WRITE_DATA_TO_RAM       : i_cmds(9)
-- READ_DATA_FROM_RAM      : i_cmds(10)
--
-- Only One command is processed at a time
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

library lib_CFAH1602_v2;
use lib_CFAH1602_v2.pkg_lcd_cfah.all;

entity lcd_cfah_polling is

  port (
    clk_sys   : in  std_logic;                      -- Clock System
    rst_n_sys : in  std_logic;                      -- Asynchronous Reset
    i_start   : in  std_logic;                      -- Start Commands
    i_cmds    : in  std_logic_vector(10 downto 0);  -- Commands in
    o_done    : out std_logic;                      -- Polling function is ready

    -- Command generator ITF
    o_cmd_req   : out std_logic;
    o_cmds      : out std_logic_vector(10 downto 0);
    i_lcd_rdata : in  std_logic_vector(7 downto 0);
    i_done      : in  std_logic         -- Done received
    );

end entity lcd_cfah_polling;

architecture rtl of lcd_cfah_polling is



  -- == TYPES ==
  type t_fsm_state is (IDLE, POLL_BUSY, RUN_CMD);  -- FSM States

  -- == Internal Signals ==
  signal fsm_cs : t_fsm_state;          -- Current State
  signal fsm_ns : t_fsm_state;          -- Next State

  signal cmds            : std_logic_vector(10 downto 0);  -- Latch commands
  signal poll_ongoing    : std_logic;                      -- Polling ongoing
  signal run_cmd_ongoing : std_logic;                      -- Command Ongoing

begin  -- architecture rtl

  -- purpose: FSM Current State update
  p_fsm_cs_update : process (clk_sys, rst_n_sys) is
  begin  -- process p_fsm_cs_update
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fsm_cs <= IDLE;
    elsif rising_edge(clk_sys) then     -- rising clock edge
      fsm_cs <= fsm_ns;
    end if;
  end process p_fsm_cs_update;

  -- purpose: Latch and perform shift on commands
  p_latch_shift_cmds : process (clk_sys, rst_n_sys) is
  begin  -- process p_latch_shift_cmds
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cmds <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On start pulse, latch i_cmds
      if(i_start = '1') then
        cmds <= i_cmds;
      end if;

    end if;
  end process p_latch_shift_cmds;


  -- purpose: Update the fsm_ns in function of the current state dans the inputs
  p_fsm_ns_update : process (fsm_cs, i_start, i_done, i_lcd_rdata) is
  begin  -- process p_fsm_ns_update

    case fsm_cs is

      -- On IDLE stat wait for the start command
      when IDLE =>

        poll_ongoing    <= '0';         -- Polling state
        run_cmd_ongoing <= '0';         -- RUN Command ongoing
        if(i_start = '1') then
          fsm_ns <= POLL_BUSY;
        else
          fsm_ns <= IDLE;
        end if;

      when POLL_BUSY =>

        poll_ongoing    <= '1';         -- Polling state
        run_cmd_ongoing <= '0';         -- RUN Command ongoing

        -- When a command is terminated and when the busy bit is unset
        -- Go to Run Command state
        if(i_done = '1' and i_lcd_rdata(7) = '0') then
          fsm_ns <= RUN_CMD;
        else
          fsm_ns <= POLL_BUSY;
        end if;


      when RUN_CMD =>

        poll_ongoing    <= '0';         -- Polling state
        run_cmd_ongoing <= '1';         -- RUN Command ongoing

        -- When a command is terminated
        -- -> Go to IDLE state
        if(i_done = '1') then
          fsm_ns <= IDLE;

        -- Stay in RUN_CMD (i_done = '0')
        else
          fsm_ns <= RUN_CMD;
        end if;

      when others =>
        fsm_ns          <= IDLE;
        poll_ongoing    <= '0';         -- Polling state
        run_cmd_ongoing <= '0';         -- RUN Command ongoing

    end case;

  end process p_fsm_ns_update;


  -- purpose: Commands req Management
  -- Generate a new command when go to POLL_BUSY state or when go in RUN_CMD state
  p_cmd_req_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_cmd_req_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_cmd_req <= '0';
      o_cmds    <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Generates the Busy command on start pulse or during the polling state
      -- if the busy flag is not equals to '0'
      if(i_start = '1' or (poll_ongoing = '1' and i_done = '1' and i_lcd_rdata(7) = '1')) then
        o_cmds    <= (C_READ_BUSY_FLAG => '1', others => '0');
        o_cmd_req <= '1';

      -- Generates the selected command
      -- Wait for the End of Polling and if the command
      elsif(poll_ongoing = '1' and i_done = '1' and i_lcd_rdata(7) = '0') then
        o_cmds    <= cmds;
        o_cmd_req <= '1';

      -- Resets Commands and requests
      else
        o_cmds    <= (others => '0');
        o_cmd_req <= '0';
      end if;
    end if;
  end process p_cmd_req_mngt;

  -- purpose: Done Signal management
  -- Generate a pulse on done signal when the i_done input is set during the
  -- run_cmd state
  p_done_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_done_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_done <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      o_done <= run_cmd_ongoing and i_done;

    end if;
  end process p_done_mngt;

end architecture rtl;
