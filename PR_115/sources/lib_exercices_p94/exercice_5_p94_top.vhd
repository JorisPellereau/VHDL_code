-------------------------------------------------------------------------------
-- Title      : Exercice 5 Page 94
-- Project    : 
-------------------------------------------------------------------------------
-- File       : exercice_5_p94_top.vhd
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

library lib_exercices_p94;

entity exercice_5_p94_top is
  port (
    a   : in  std_logic;                     -- Input A
    b   : in  std_logic;                     -- Input B
    c   : in  std_logic;                     -- Input C
    d   : in  std_logic;                     -- Input D
    sel : in  std_logic_vector(1 downto 0);  -- SEL
    s   : out std_logic);                    -- Output
end entity exercice_5_p94_top;

architecture rtl of exercice_5_p94_top is

begin  -- architecture rtl

  i_exercice_5_0 : entity lib_exercices_p94.exercice_5
    generic map (
      G_SEL_EXO => "EXO5_V1"            -- Version selection by default
      )
    port map(
      a   => a,
      b   => b,
      c   => c,
      d   => d,
      sel => sel,
      s   => s
      );

end architecture rtl;
