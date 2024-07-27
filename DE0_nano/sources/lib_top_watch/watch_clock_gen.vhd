-------------------------------------------------------------------------------
-- Title      : Watch FPGA Clock Management and generation
-- Project    : 
-------------------------------------------------------------------------------
-- File       : watch_clock_gen.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-05-12
-- Last update: 2024-05-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-05-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_top_watch;

entity watch_clock_gen is
  port (
    clk_50MHz    : in  std_logic;       -- Input External Clock at 50MHz
    rst_n        : in  std_logic;       -- External Asynchronous Reset
    clk_sys      : out std_logic;       -- Output clk_sys
    clk_sys_180d : out std_logic;       -- Output clk_sys with 180 degrees phasis
    pll_locked   : out std_logic        -- PLL Is locked
    );
end entity watch_clock_gen;

architecture rtl of watch_clock_gen is

begin  -- architecture rtl

  -- PLL Instanciation
  i_watch_pll_0 : entity lib_top_watch.watch_pll
    port map (
      areset => rst_n,
      inclk0 => clk_50MHz,
      c0     => clk_sys,
      c1     => clk_sys_180d,
      locked => pll_locked
      );


  -- Clock Buffer

end architecture rtl;
