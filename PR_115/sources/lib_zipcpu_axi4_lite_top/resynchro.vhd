-------------------------------------------------------------------------------
-- Title      : Resynchro
-- Project    : 
-------------------------------------------------------------------------------
-- File       : resynchro.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-04
-- Last update: 2024-01-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Resynchronization of asynchronous signal to clk_sys clock domain
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-04  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity resynchro is
  port (
    rst_n_clk_sys : in std_logic;       -- Reset synchronized in clk_sys clock domain
    clk_sys       : in std_logic;       -- clk_sys clock

    i_rts_n_a       : in  std_logic;    -- RTS asynchronous input
    o_rts_n_clk_sys : out std_logic     -- RTS resynchronized in clk_sys clock domain
    );
end entity resynchro;

architecture rtl of resynchro is

  -- == INTERNAL Signals ==
  signal rts_n_p1 : std_logic;          -- RTS N P1
  signal rts_n_p2 : std_logic;          -- RTS N P2

begin  -- architecture rtl

  p_resynch_rts_n : process (clk_sys, rst_n_clk_sys) is
  begin  -- process p_resynch_rts_n
    if rst_n_clk_sys = '0' then         -- asynchronous reset (active low)
      rts_n_p1 <= '0';
      rts_n_p2 <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      rts_n_p1 <= i_rts_n_a;
      rts_n_p2 <= rts_n_p1;
    end if;
  end process p_resynch_rts_n;

  o_rts_n_clk_sys <= rts_n_p2;          -- Connect the output

end architecture rtl;
