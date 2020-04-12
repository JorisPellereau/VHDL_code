-------------------------------------------------------------------------------
-- Title      : DEBUG FSM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : fsm_debug.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2020-03-07
-- Last update: 2020-03-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: FSM for the debug module
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-03-07  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity fsm_debug is

  port (
    clk         : in  std_logic;        -- Clock
    rst_n       : in  std_logic;        -- Asynchronous reset
    i_debug_on  : in  std_logic;        -- Debug On
    i_debug_off : in  std_logic;        -- Debug off
    o_en_debug  : out std_logic);       -- Debug Enable

end entity fsm_debug;

architecture behv of fsm_debug is

  -- TYPE
  type t_debug_states is (DEBUG_LOCK, DEBUG);

  -- INTERNAL SIGNALS
  signal s_current_state : t_debug_states;  -- Current State
  signal s_next_state    : t_debug_states;  -- Next State

  signal s_debug_on         : std_logic;
  signal s_debug_off        : std_logic;
  signal s_debug_on_r_edge  : std_logic;
  signal s_debug_off_r_edge : std_logic;

begin  -- architecture behv

  -- purpose: Latch Inputs 
  p_atch_inputs : process (clk, rst_n) is
  begin  -- process p_atch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_debug_off <= '0';
      s_debug_on  <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_debug_on  <= i_debug_on;
      s_debug_off <= i_debug_off;
    end if;
  end process p_atch_inputs;

  -- R EDGE detection
  s_debug_on_r_edge  <= i_debug_on and not s_debug_on;
  s_debug_off_r_edge <= i_debug_off and not s_debug_off;

  -- purpose: Current State ngt
  p_curr_state_mngt : process (clk, rst_n) is
  begin  -- process p_curr_state_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_current_state <= DEBUG_LOCK;
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_current_state <= s_next_state;
    end if;
  end process p_curr_state_mngt;

  -- purpose: Next state MNGT
  p_next_state_mngt : process (s_current_state, s_debug_on_r_edge, s_debug_off_r_edge) is
  begin  -- process p_next_state_mngt
    case s_current_state is
      when DEBUG_LOCK =>
        if(s_debug_on_r_edge = '1') then
          s_next_state <= DEBUG;
        end if;

      when DEBUG =>
        if(s_debug_off_r_edge = '1') then
          s_next_state <= DEBUG_LOCK;
        end if;

      when others => null;
    end case;

  end process p_next_state_mngt;

  -- purpose: Outputs mngt
  p_outputs_mngt : process (clk, rst_n) is
  begin  -- process p_outputs_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_en_debug <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      case s_current_state is
        when DEBUG_LOCK =>
          o_en_debug <= '0';

        when DEBUG =>
          o_en_debug <= '1';

        when others => null;
      end case;
    end if;
  end process p_outputs_mngt;

end architecture behv;
