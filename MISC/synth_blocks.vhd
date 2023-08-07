-------------------------------------------------------------------------------
-- Title      : Synthe Blocks for Quartus experiences
-- Project    : 
-------------------------------------------------------------------------------
-- File       : synth_blocks.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-07
-- Last update: 2023-08-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-08-07  1.0      linux-jp	Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity synth_blocks is

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    in_a  : in  std_logic;
    in_b  : in  std_logic;
    out_c : out std_logic;

    out_d : out std_logic;

    din  : in  std_logic;               -- Data in
    dout : out std_logic);              -- Data out

end entity synth_blocks;

architecture rtl of synth_blocks is

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


  -- purpose:
  P_MUX : process (clk, rst_n) is
  begin  -- process P_MUX
    if rst_n = '0' then                 -- asynchronous reset (active low)
      out_c <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      if(in_a = '1' and in_b  = '0') then
        out_c <= '1';
      elsif(in_b = '1' and in_a = '0') then
        out_c <= '1';
      else
        out_c <= '0';
      end if;
    end if;
  end process P_MUX;


  -- purpose: 
  P_MUX2: process (clk, rst_n) is
  begin  -- process P_MUX2
    if rst_n = '0' then                 -- asynchronous reset (active low)
      out_d <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      out_d <= in_a or in_b;
    end if;
  end process P_MUX2;

end architecture rtl;
