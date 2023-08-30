-------------------------------------------------------------------------------
-- Title      : 8 7 Segments controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : seg7x8.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-29
-- Last update: 2023-08-30
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

--library lib_seg7;

entity seg7x8 is

  port (
    i_digits : in  std_logic_vector(31 downto 0);  -- Digits Commands
    o_seg0   : out std_logic_vector(6 downto 0);   -- SEG 0
    o_seg1   : out std_logic_vector(6 downto 0);   -- SEG 1
    o_seg2   : out std_logic_vector(6 downto 0);   -- SEG 2
    o_seg3   : out std_logic_vector(6 downto 0);   -- SEG 3
    o_seg4   : out std_logic_vector(6 downto 0);   -- SEG 4
    o_seg5   : out std_logic_vector(6 downto 0);   -- SEG 5
    o_seg6   : out std_logic_vector(6 downto 0);   -- SEG 6
    o_seg7   : out std_logic_vector(6 downto 0)    -- SEG 7
    );

end entity seg7x8;

architecture rtl of seg7x8 is

  -- == COMPONENTS ==
  component seg7_lut is

    port (
      i_digit : in  std_logic_vector(3 downto 0);  -- Input Digit
      o_seg   : out std_logic_vector(6 downto 0)   -- Output Segments
      );
  end component;

begin  -- architecture rtl

  i_seg7_lut_0 : seg7_lut
    port map(
      i_digit => i_digits(3 downto 0),
      o_seg   => o_seg0
      );

  i_seg7_lut_1 : seg7_lut
    port map(
      i_digit => i_digits(7 downto 4),
      o_seg   => o_seg1
      );

  i_seg7_lut_2 : seg7_lut
    port map(
      i_digit => i_digits(11 downto 8),
      o_seg   => o_seg2
      );

  i_seg7_lut_3 : seg7_lut
    port map(
      i_digit => i_digits(15 downto 12),
      o_seg   => o_seg3
      );

  i_seg7_lut_4 : seg7_lut
    port map(
      i_digit => i_digits(19 downto 16),
      o_seg   => o_seg4
      );

  i_seg7_lut_5 : seg7_lut
    port map(
      i_digit => i_digits(23 downto 20),
      o_seg   => o_seg5
      );

  i_seg7_lut_6 : seg7_lut
    port map(
      i_digit => i_digits(27 downto 24),
      o_seg   => o_seg6
      );

  i_seg7_lut_7 : seg7_lut
    port map(
      i_digit => i_digits(31 downto 28),
      o_seg   => o_seg7
      );


end architecture rtl;
