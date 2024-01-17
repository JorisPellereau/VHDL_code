-------------------------------------------------------------------------------
-- Title      : Exercice 7 Page 94 - Adders
-- Project    : 
-------------------------------------------------------------------------------
-- File       : exercice_7.vhd
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

entity exercice_7 is
  generic (
    G_SEL_EXO    : string  := "EXO7_V1";                        -- Exo selection
    G_DATA_WIDTH : integer := 4                                 -- Data width
    );
  port (
    data_a : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);   -- Data A
    data_b : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);   -- Data B
    sum    : out std_logic_vector(G_DATA_WIDTH - 1 downto 0));  -- Sum
end entity exercice_7;

architecture rtl of exercice_7 is

begin  -- architecture rtl

  -- Unsigned addition
  g_version1 : if(G_SEL_EXO = "EXO7_V1") generate
    sum <= std_logic_vector(unsigned(data_a) + unsigned(data_b));
  end generate;

  -- signed addition
  g_version2 : if(G_SEL_EXO = "EXO7_V2") generate
    sum <= std_logic_vector(signed(data_a) + signed(data_b));
  end generate;

end architecture rtl;
