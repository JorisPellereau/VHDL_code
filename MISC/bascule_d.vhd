-------------------------------------------------------------------------------
-- Title      : Bascule D
-- Project    : 
-------------------------------------------------------------------------------
-- File       : bascule_d.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-07-15
-- Last update: 2023-07-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-07-15  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity bascule_d is

  port (
    clk   : in  std_logic;              -- Clock
    rst_n : in  std_logic;              -- Asynchronous Reset
    din   : in  std_logic;              -- Data in
    dout  : out std_logic);             -- Data out

end entity bascule_d;

architecture rtl of bascule_d is

begin  -- architecture rtl

  -- purpose: Bascule D
  P_BASCULE_D : process (clk, rst_n) is
  begin  -- process P_BASCULE_D
    if rst_n = '0' then                 -- asynchronous reset (active low)
      dout <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      dout <= din;
    end if;
  end process P_BASCULE_D;

end architecture rtl;
