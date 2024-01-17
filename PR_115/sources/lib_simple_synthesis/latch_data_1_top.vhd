-------------------------------------------------------------------------------
-- Title      : LATCH DATA TOP - 1 
-- Project    : 
-------------------------------------------------------------------------------
-- File       : latch_data_1_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-16
-- Last update: 2024-01-16
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-16  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity latch_data_1_top is

  port (
    clk_sys   : in  std_logic;          -- Clock system
    rst_n_sys : in  std_logic;          -- Asynchronous Rest
    a         : in  std_logic;          -- Input A
    b         : in  std_logic;          -- Input B
    output    : out std_logic);         -- Output

end entity latch_data_1_top;

architecture rtl of latch_data_1_top is

begin  -- architecture rtl

  -- purpose: LATCH DATA - 1
  p_latch_data_1 : process (clk_sys, rst_n_sys) is
  begin  -- process p_latch_data_1
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      output <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      if(a = '1') then
        output <= b;
      end if;
    end if;
  end process p_latch_data_1;

end architecture rtl;
