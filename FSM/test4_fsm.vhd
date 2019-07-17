-------------------------------------------------------------------------------
-- Title      : Test of different kind of FSM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test4_fsm.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-27
-- Last update: 2019-07-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Test of diffrent kind of FSM
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-27  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity test4_fsm is

  port (
    clock   : in  std_logic;                      -- System clock 50MHz
    reset_n : in  std_logic;                      -- Asynchronous_reset
    bp1     : in  std_logic;                      -- bp1
    bp2     : in  std_logic;                      -- bp2
    leds    : out std_logic_vector(7 downto 0));  -- leds

end entity test4_fsm;




architecture arch4 of test4_fsm is

  type t_states is (C0, C1, C2);        -- States
  signal state, next_state : t_states;  -- States & next state
  signal leds_s            : std_logic_vector(7 downto 0);

begin  -- architecture arch3

  p_curr_state_mng : process (clock, reset_n) is
  begin  -- process p_next_state_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      state <= C0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      state <= next_state;

      case state is
        when C0 =>
          leds_s <= x"00";

        when C1 =>
          leds_s <= x"BE";

        when C2 =>
          leds_s <= x"81";
        when others => null;
      end case;

    end if;
  end process p_curr_state_mng;

  leds <= leds_s;


  p_next_state_mng : process (state, bp1, bp2) is
  begin  -- process p_next_state_mng

    case state is
      when C0 =>
        if(bp1 = '1') then
          next_state <= C1;
        end if;

      when C1 =>
        if(bp2 = '1') then
          next_state <= C2;
        end if;

      when C2 =>
        if(bp1 = '1' and bp2 = '1') then
          next_state <= C0;
        end if;
      when others => null;
    end case;

  end process p_next_state_mng;


end architecture arch4;
