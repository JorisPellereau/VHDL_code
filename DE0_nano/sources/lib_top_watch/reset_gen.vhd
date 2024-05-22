-------------------------------------------------------------------------------
-- Title      : Reset Generation Management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : reset_gen.vhd
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


entity reset_gen is

  port(
    rst_n      : in std_logic;          -- External Reset Pin
    pll_locked : in std_logic;          -- PLL Locked

    clk_sys   : in  std_logic;          -- Clock System
    rst_n_sys : out std_logic;          -- Reset of clk_sys clock domain

    clk_sys_180d   : in  std_logic;     -- Clock System 180degrees
    rst_n_sys_180d : out std_logic      -- Reset of clk_sus_180d clock dmain
    );

end entity reset_gen;

architecture rtl of reset_gen is

  -- == INTERNAL Signals ==
  signal asynch_reset : std_logic;      -- Asynchronous reset : Locked anded with rst_n
  signal rst_n_sys_p1 : std_logic;      -- Reset Clock domain piped one time
  signal rst_n_sys_p2 : std_logic;      -- Reset Clock domain piped a second time

  signal rst_n_sys_180d_p1 : std_logic;  -- Reset Clock domain piped one time
  signal rst_n_sys_180d_p2 : std_logic;  -- Reset Clock domain piped a second time

begin  -- architecture rtl

  -- External reset is anded with PLL locked and generate the asynchronous reset
  asynch_reset <= not(rst_n) and pll_locked;

  -- purpose: Reset generation for clk_sys clock domain
  p_reset_gen_clk_sys : process (clk_sys, asynch_reset) is
  begin  -- process p_reset_gen_clk_sys
    if asynch_reset = '0' then          -- asynchronous reset (active low)
      rst_n_sys_p1 <= '0';
      rst_n_sys_p2 <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      rst_n_sys_p1 <= '1';
      rst_n_sys_p2 <= rst_n_sys_p1;
    end if;
  end process p_reset_gen_clk_sys;

  -- Output affectation
  rst_n_sys <= rst_n_sys_p2;


  -- purpose: Reset generation for clk_sys_180d clock domain
  p_reset_gen_clk_sys_180d : process (clk_sys_180d, asynch_reset) is
  begin  -- process p_reset_gen_clk_sys_180d
    if asynch_reset = '0' then            -- asynchronous reset (active low)
      rst_n_sys_180d_p1 <= '0';
      rst_n_sys_180d_p2 <= '0';
    elsif rising_edge(clk_sys_180d) then  -- rising clock edge
      rst_n_sys_180d_p1 <= '1';
      rst_n_sys_180d_p2 <= rst_n_sys_180d_p1;
    end if;
  end process p_reset_gen_clk_sys_180d;

  -- Output affecation
  rst_n_sys_180d <= rst_n_sys_180d_p2;

end architecture rtl;
