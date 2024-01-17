-------------------------------------------------------------------------------
-- Title      : Exercice 5 Page 94
-- Project    : 
-------------------------------------------------------------------------------
-- File       : exercice_5.vhd
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


entity exercice_5 is

  generic (
    G_SEL_EXO : string := "EXO5_V1");   -- Version selection

  port (
    a   : in  std_logic;                     -- Input A
    b   : in  std_logic;                     -- Input B
    c   : in  std_logic;                     -- Input C
    d   : in  std_logic;                     -- Input D
    sel : in  std_logic_vector(1 downto 0);  -- SEL
    s   : out std_logic);                    -- Output

end entity exercice_5;

architecture rtl of exercice_5 is

  signal x : std_logic;
  signal y : std_logic;

begin  -- architecture rtl

  g_version1 : if(G_SEL_EXO = "EXO5_V1") generate
    x <= b when sel(0) = '1' else a;
    y <= d when sel(0) = '1' else c;
    s <= y when sel(1) = '1' else x;
  end generate;

  g_version2 : if(G_SEL_EXO = "EXO5_V2") generate
    s <= a when sel = "00" else
         b when sel = "01" else
         c when sel = "10" else
         d;
  end generate;

end architecture rtl;
