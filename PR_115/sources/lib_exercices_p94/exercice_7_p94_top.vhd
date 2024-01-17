-------------------------------------------------------------------------------
-- Title      : Exercice 7 Page 94 - Adders
-- Project    : 
-------------------------------------------------------------------------------
-- File       : exercice_7_p94_top.vhd
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
use ieee.numeric_std.all;

library lib_exercices_p94;

entity exercice_7_p94_top is
  generic (
    G_DATA_WIDTH : integer := 4                                 -- Data width
    );
  port (
    data_a : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);   -- Data A
    data_b : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);   -- Data B
    sum    : out std_logic_vector(G_DATA_WIDTH - 1 downto 0));  -- Sum
end entity exercice_7_p94_top;

architecture rtl of exercice_7_p94_top is

begin  -- architecture rtl

  i_exercice_7_0 : entity lib_exercices_p94.exercice_7
    generic map (
      G_SEL_EXO    => "EXO7_V1",        -- Exo selection
      G_DATA_WIDTH => G_DATA_WIDTH
      )
    port map (
      data_a => data_a,
      data_b => data_b,
      sum    => sum
      );


end architecture rtl;
