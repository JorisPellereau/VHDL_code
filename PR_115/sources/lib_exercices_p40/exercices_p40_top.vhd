-------------------------------------------------------------------------------
-- Title      : Exercices Page 40
-- Project    : 
-------------------------------------------------------------------------------
-- File       : exercices_p40_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-16
-- Last update: 2024-01-16
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Test of synthesis of exercice p40
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

entity exercices_p40_top is
  port (
    clk_sys   : in  std_logic;                     -- Clock system
    rst_n_sys : in  std_logic;                     -- Asynchronous reset
    s         : in  std_logic_vector(2 downto 0);  -- Input selection
    a         : out std_logic_vector(1 downto 0)   -- Output
    );
end entity exercices_p40_top;

architecture rtl of exercices_p40_top is

  -- == COMPONENTS ==
  component case_sel_p40 is
    generic (
      G_SEL_VERSION : integer range 0 to 1 := 0      -- Version Selection - 0 == version 1 - 1 == version 2
      );
    port (
      clk_sys   : in  std_logic;                     -- Clock system
      rst_n_sys : in  std_logic;                     -- Asynchronous reset
      s         : in  std_logic_vector(2 downto 0);  -- Input selection
      a         : out std_logic_vector(1 downto 0)   -- Output
      );
  end component case_sel_p40;

begin  -- architecture rtl


  i_case_sel_p40_0 : case_sel_p40
    generic map (
      G_SEL_VERSION => 0                -- Version 1 by default
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,
      s         => s,
      a         => a
      );

end architecture rtl;
