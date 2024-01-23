-------------------------------------------------------------------------------
-- Title      : Signed Multiplier and Accumulator TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : signed_mult_accu_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-18
-- Last update: 2024-01-18
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Source from 6- Recommend HDL Coding Styles
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-18  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signed_mult_accu_top is
  port (
    a         : in  signed(7 downto 0);
    b         : in  signed (7 downto 0);
    clk       : in  std_logic;
    aclr      : in  std_logic;
    accum_out : out signed (15 downto 0)
    );
end signed_mult_accu_top;

architecture rtl of signed_mult_accu_top is
  signal a_reg     : signed (7 downto 0);
  signal b_reg     : signed (7 downto 0);
  signal pdt_reg   : signed (15 downto 0);
  signal adder_out : signed (15 downto 0);
begin
  process (clk, aclr)
  begin
    if (aclr = '1') then
      a_reg     <= (others => '0');
      b_reg     <= (others => '0');
      pdt_reg   <= (others => '0');
      adder_out <= (others => '0');
    elsif (clk'event and clk = '1') then
      a_reg     <= (a);
      b_reg     <= (b);
      pdt_reg   <= a_reg * b_reg;
      adder_out <= adder_out + pdt_reg;
    end if;
  end process;
  accum_out <= adder_out;
end rtl;
