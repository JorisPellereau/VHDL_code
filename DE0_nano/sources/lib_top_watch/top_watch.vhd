-------------------------------------------------------------------------------
-- Title      : TOP WATCH on DE0 Nano Board
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_watch.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-05-12
-- Last update: 2024-05-12
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


entity top_watch is

  port (
    -- Clock and Reset
    clk_50MHz : in std_logic;           -- Clock 50 MHz
    rst_n     : in std_logic;           -- External Reset

    -- UART I/F
    uart_rx : in  std_logic;            -- UART RX input
    uart_tx : out std_logic;            -- UART TX output

    -- MAX7219 I/F
    max7219_load : out std_logic;       -- LOAD command
    max7219_data : out std_logic;       -- DATA to send
    max7219_clk  : out std_logic        -- CLK
    );

end entity top_watch;

architecture rtl of top_watch is

  -- == INTERNAL Signals ==
  signal clk_sys        : std_logic;    -- Clock System
  signal clk_sys_180d   : std_logic;    -- Clock System dephase by 180 degrees
  signal pll_locked     : std_logic;    -- PLL Locked signal
  signal rst_n_sys      : std_logic;    -- Reset of clk_sys clock domain
  signal rst_n_sys_180d : std_logic;    -- Reset of clk_sys_180d clock domain

  signal uart_rx_clk_sys : std_logic;   -- UART RX in clock system clock domain

begin  -- architecture rtl


  -- Clock Management
  i_watch_clock_gen_0 : entity lib_top_watch.watch_clock_gen
    port map (
      clk_50MHz    => clk_50MHz,
      rst_n        => rst_n,
      clk_sys      => clk_sys,
      clk_sys_180d => clk_sys_180d,
      pll_locked   => pll_locked
      );

  -- Reset Management
  i_reset_gen_0 : entity lib_top_watch.reset_gen
    port map(
      rst_n      => rst_n,
      pll_locked => pll_locked,

      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      clk_sys_180d   => clk_sys_180d,
      rst_n_sys_180d => rst_n_sys_180d
      );

  -- Resynchronization Block
  i_resynchro_0 : entity lib_top_watch.resynchro
    port map (
      clk_sys    => clk_sys,
      rst_n_sys  => rst_n_sys,
      rx         => uart_rx,
      rx_clk_sys => uart_rx_clk_sys
      );


  -- WATCH CORE


end architecture rtl;
