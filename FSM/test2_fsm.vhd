-------------------------------------------------------------------------------
-- Title      : Test of different kind of FSM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_fsm.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-27
-- Last update: 2019-06-27
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

entity test2_fsm is

  port (
    clock   : in  std_logic;                      -- System clock 50MHz
    reset_n : in  std_logic;                      -- Asynchronous_reset
    bp1     : in  std_logic;                      -- bp1
    bp2     : in  std_logic;                      -- bp2
    leds    : out std_logic_vector(7 downto 0));  -- leds

end entity test2_fsm;

architecture arch2 of test2_fsm is

  type t_states is (C0, C1, C2);        -- States
  signal state  : t_states;             -- States
  signal leds_s : std_logic_vector(7 downto 0);

begin  -- architecture arch2

  -- purpose: This process manages the states of the FSM
  p_states_mng : process (clock, reset_n) is
  begin  -- process p_states_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      state <= C0;
    elsif clock'event and clock = '1' then  -- rising clock edge

      case state is
        when C0 =>
          if(bp1 = '1') then
            state <= C1;
          end if;
        when C1 =>
          if(bp2 = '1') then
            state <= C2;
          end if;
        when C2 =>
          if(bp1 = '1' and bp2 = '1') then
            state <= C0;
          end if;
        when others => null;
      end case;
    end if;
  end process p_states_mng;

  -- purpose: This process manages the outputs 
  p_out_mng : process (state) is
  begin
    case state is
      when C0 =>
        leds_s <= x"00";

      when C1 =>
        leds_s <= x"BE";

      when C2 =>
        leds_s <= x"81";

      when others => null;
    end case;
  end process p_out_mng;

  leds <= leds_s;

end architecture arch2;
