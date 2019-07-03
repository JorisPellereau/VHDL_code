-------------------------------------------------------------------------------
-- Title      : This is a simple clock synch module
-- Project    : 
-------------------------------------------------------------------------------
-- File       : clock_synch.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-07-03
-- Last update: 2019-07-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-03  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity clock_synch is

  port (
    reset_n    : in  std_logic;         -- REset
    clock_b    : in  std_logic;         -- clock b
    in_a       : in  std_logic;         -- input clocked on clock a
    synch_in_a : out std_logic);        -- Input clocked on clock b

end entity clock_synch;



architecture arch_clock_synch of clock_synch is

  signal synch_a_clockb : std_logic_vector(1 downto 0);

begin

  p_synch_in_a : process (clock_b, reset_n)
  begin  -- process p_synch_in_a
    if reset_n = '0' then               -- asynchronous reset (active low)
      synch_a_clockb <= (others => '0');
    elsif clock_b'event and clock_b = '1' then  -- rising clock edge
      synch_a_clockb(0) <= in_a;
      synch_a_clockb(1) <= synch_a_clockb(0);
    end if;
  end process p_synch_in_a;

  synch_in_a <= synch_a_clockb(1);

end architecture arch_clock_synch;
