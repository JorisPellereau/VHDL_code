-------------------------------------------------------------------------------
-- Title      : Exercices Page 94 TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : exercice_6_p94_top.vhd
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

entity exercice_6_p94_top is
  port (
    clk_sys   : in  std_logic;          -- Clock system
    rst_n_sys : in  std_logic;          -- Asynchronous reset
    a         : in  std_logic;          -- Input A
    b         : in  std_logic;          -- Input B
    x         : in  std_logic;          -- Input X
    y         : in  std_logic;          -- Input Y
    output    : out std_logic;          -- Output
    sel_exo   : out std_logic);         -- Selection fof exo flag
end entity exercice_6_p94_top;


architecture rtl of exercice_6_p94_top is

  -- == COMPONENT ==
  -- component exercice_6 is
  --   generic(
  --     G_SEL_EXO : string := "EXO6_V1"   -- Exercice selection
  --     );
  --   port (
  --     clk_sys   : in  std_logic;        -- Clock system
  --     rst_n_sys : in  std_logic;        -- Asynchronous reset
  --     a         : in  std_logic;        -- Input A
  --     b         : in  std_logic;        -- Input B
  --     x         : in  std_logic;        -- Input X
  --     y         : in  std_logic;        -- Input Y
  --     output    : out std_logic);       -- Output

  -- end component exercice_6;

begin  -- architecture rtl

  i_exercice_6 : entity lib_exercices_p94.exercice_6
    generic map (
      G_SEL_EXO => "EXO6_V2"            -- Exercice selection by default
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,
      a         => a,
      b         => b,
      x         => x,
      y         => y,
      output    => output,
      sel_exo   => sel_exo
      );

end architecture rtl;
