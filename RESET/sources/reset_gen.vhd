-------------------------------------------------------------------------------
-- Title      : Single Reset Management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : reset_gen.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-02-12
-- Last update: 2023-02-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Generation of an synchronous on a clock domain from an
-- asynchronous inputs reset signal
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-02-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity reset_gen is

  port (
    clk     : in  std_logic;            -- Clock
    arst_n  : in  std_logic;            -- Synchronous Input Reset
    o_rst_n : out std_logic);           -- Output synchronous Reset

end entity reset_gen;


architecture rtl of reset_gen is

  signal s_rst_n_p1 : std_logic;        -- Reset signal pipe one time
  signal s_rst_n_p2 : std_logic;        -- Reset signal pipe two time

begin  -- architecture rtl

  -- purpose: Asynchronous input reset to synchronous reset management
  p_rst_mngt : process (clk, arst_n) is
  begin  -- process p_rst_mngt
    if arst_n = '0' then                -- asynchronous reset (active low)
      o_rst_n    <= '0';
      s_rst_n_p1 <= '0';
      s_rst_n_p2 <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_rst_n_p1 <= '1';
      s_rst_n_p2 <= s_rst_n_p1;
      o_rst_n    <= s_rst_n_p2;
    end if;
  end process p_rst_mngt;

end architecture rtl;
