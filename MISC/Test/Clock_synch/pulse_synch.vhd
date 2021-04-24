-------------------------------------------------------------------------------
-- Title      : This is a pulse synchronizer
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pulse_synch.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-07-03
-- Last update: 2019-07-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This a pulse synchronizer
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-03  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity pulse_synch is

  port (
    reset_n : in  std_logic;            -- Reset
    clock_a : in  std_logic;            -- Clock A
    clock_b : in  std_logic;            -- Clock B
    in_a    : in  std_logic;            -- Pulse from clock A
    out_b   : out std_logic);           -- Pulse from A clocked on clock A

end entity pulse_synch;

architecture arch_pulse_synch of pulse_synch is

  signal in_a_s           : std_logic;
  signal synchA_clock_b_s : std_logic_vector(2 downto 0);

begin  -- architecture arch_pulse_synch

  p_flag_a : process (clock_a, reset_n) is
  begin  -- process p_flag_a
    if reset_n = '0' then               -- asynchronous reset (active low)
      in_a_s <= '0';
    elsif clock_a'event and clock_a = '1' then  -- rising clock edge
      in_a_s <= in_a_s xor in_a;        -- Toggle on each pulse of in_a
    end if;
  end process p_flag_a;

  p_synch_on_clock_b : process (clock_b, reset_n) is
  begin  -- process p_synch_on_clock_b
    if reset_n = '0' then               -- asynchronous reset (active low)
      synchA_clock_b_s <= (others => '0');
    elsif clock_b'event and clock_b = '1' then  -- rising clock edge
      synchA_clock_b_s <= synchA_clock_b_s(1 downto 0) & in_a_s;
    end if;
  end process p_synch_on_clock_b;


  out_b <= synchA_clock_b_s(2) xor synchA_clock_b_s(1);

end architecture arch_pulse_synch;
