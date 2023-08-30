-------------------------------------------------------------------------------
-- Title      : PR115 7 Segments decoder
-- Project    : 
-------------------------------------------------------------------------------
-- File       : seg7_lut.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-29
-- Last update: 2023-08-29
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-08-29  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity seg7_lut is

  port (
    i_digit : in  std_logic_vector(3 downto 0);  -- Input Digit
    o_seg   : out std_logic_vector(6 downto 0)   -- Output Segments
    );

end entity seg7_lut;

architecture rtl of seg7_lut is

begin  -- architecture rtl


  -- ---t----
  -- |      |
  -- lt    rt
  -- |      |
  -- ---m----
  -- |      |
  -- lb    rb
  -- |      |
  -- ---b----


  -- 7 Segement decoder
  -- A '0' level lights the segment
  o_seg <= "1111001" when i_digit = x"1" else  --
           "0100100" when i_digit = x"2" else  --
           "0110000" when i_digit = x"3" else  --
           "0011001" when i_digit = x"4" else  --
           "0010010" when i_digit = x"5" else  --
           "0000010" when i_digit = x"6" else  --
           "1111000" when i_digit = x"7" else  --
           "0000000" when i_digit = x"8" else  --
           "0011000" when i_digit = x"9" else  --
           "0001000" when i_digit = x"A" else
           "0000011" when i_digit = x"B" else
           "1000110" when i_digit = x"C" else
           "0100001" when i_digit = x"D" else
           "0000110" when i_digit = x"E" else
           "0001110" when i_digit = x"F" else
           "1000000" when i_digit = x"0" else
           "0110110";

end architecture rtl;
