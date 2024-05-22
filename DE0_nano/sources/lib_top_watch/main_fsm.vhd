-------------------------------------------------------------------------------
-- Title      : WATCH FPGA Main FSM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : main_fsm.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-05-12
-- Last update: 2024-05-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-05-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity main_fsm is
  port (
    clk_sys   : in std_logic;           -- Clock System
    rst_n_sys : in std_logic;           -- Reset in clock system clock domain

    init_done    : in  std_logic;       -- Init Done
    init_ongoing : out std_logic;       -- Init Ongoing
    run_ongoing  : out std_logic        -- Run Ongoing
    );
end entity main_fsm;

architecture rtl of main_fsm is

  -- == TYPES ==
  type t_fsm_state is (IDLE, INIT, RUN);  -- FSM state

  -- == INTERNAL Signals ==
  signal fsm_cs : t_fsm_state;          -- FSM Current state
  signal fsm_ns : t_fsm_state;          -- FSM Next State

begin  -- architecture rtl

  -- purpose: FSM Current state management
  p_cs_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_cs_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fsm_cs <= IDLE;
    elsif rising_edge(clk_sys) then     -- rising clock edge
      fsm_cs <= fsm_ns;
    end if;
  end process p_cs_mngt;

  -- purpose: FSM Next State management
  p_fsm_ns : process (fsm_cs, init_done) is
  begin  -- process p_fsm_ns

    case fsm_cs is
      when IDLE =>
        init_ongoing <= '0';
        run_ongoing  <= '0';
        fsm_ns       <= INIT;

      when INIT =>
        init_ongoing <= '1';
        run_ongoing  <= '0';
        if(init_done = '1') then
          fsm_ns <= RUN;
        else
          fsm_ns <= INIT;
        end if;

      when RUN =>
        init_ongoing <= '0';
        run_ongoing  <= '1';
        fsm_ns       <= RUN;

      when others =>
        init_ongoing <= '0';
        run_ongoing  <= '0';
        fsm_ns       <= IDLE;

    end case;

  end process p_fsm_ns;
  
end architecture rtl;
