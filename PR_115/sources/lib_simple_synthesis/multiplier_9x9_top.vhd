-------------------------------------------------------------------------------
-- Title      : Multiplier 9*9 TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : multiplier_9x9_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-17
-- Last update: 2024-01-17
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-17  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_simple_synthesis;


entity multiplier_9x9_top is

  port (
    clk_sys   : in  std_logic;                       -- Clock system
    rst_n_sys : in  std_logic;                       -- Asynchronous Reset
    data_a    : in  std_logic_vector(8 downto 0);    -- Data A
    data_b    : in  std_logic_vector(8 downto 0);    -- Data B
    data_out  : out std_logic_vector(17 downto 0));  -- Data Out

end entity multiplier_9x9_top;

architecture rtl of multiplier_9x9_top is

begin  -- architecture rtl

  i_multiplier_9x9_0 : entity lib_simple_synthesis.multiplier_9x9
    generic map(
      G_SEL_VERSION => "COMB_UNSIGNED_"  -- Version to selected
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,
      data_a    => data_a,
      data_b    => data_b,
      data_out  => data_out
      );


end architecture rtl;
