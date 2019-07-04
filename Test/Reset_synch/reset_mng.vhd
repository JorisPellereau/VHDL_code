-------------------------------------------------------------------------------
-- Title      : Reset manage example
-- Project    : 
-------------------------------------------------------------------------------
-- File       : reset_mng.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-07-04
-- Last update: 2019-07-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-04  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity reset_mng is

  port (
    clock         : in  std_logic;      -- System clock
    rst_n_i       : in  std_logic;      -- Input reset
    rst_n_synch_o : out std_logic);     -- Synch reset

end entity reset_mng;

architecture arch_reset_mng of reset_mng is

  signal reset_n_s       : std_logic;   -- Latch input reset
  signal reset_n_synch_s : std_logic;   -- Synch reset

begin  -- architecture arch_reset_mng

  -- purpose: This process manages the reset 
  p_reset_n_mng : process (clock, reset_n) is
  begin  -- process p_reset_n_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      reset_n_s       <= '0';
      reset_n_synch_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      reset_n_s       <= '1';
      reset_n_synch_s <= reset_n_s;
    end if;
  end process p_reset_n_mng;

  rst_n_synch_o <= reset_n_synch_s;     -- Output affectation

end architecture arch_reset_mng;
