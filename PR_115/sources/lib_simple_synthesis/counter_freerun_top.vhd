-------------------------------------------------------------------------------
-- Title      : Counter Freerun TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : counter_freerun_top.vhd
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
use ieee.numeric_std.all;

entity counter_freerun_top is

  generic (
    G_COUNTER_WIDTH : integer := 8);    -- Counter width

  port (
    clk_sys   : in  std_logic;                                        -- Clock system
    rst_n_sys : in  std_logic;                                        -- Asynchronous Reset
    cnt_out   : out std_logic_vector(G_COUNTER_WIDTH - 1 downto 0));  -- Counter output

end entity counter_freerun_top;

architecture rtl of counter_freerun_top is

  -- == INTERNAL Signals ==
  signal counter : unsigned(G_COUNTER_WIDTH - 1 downto 0);

begin  -- architecture rtl


  p_counter : process (clk_sys, rst_n_sys) is
  begin  -- process p_counter
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      counter <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge
      counter <= counter + 1;
    end if;
  end process p_counter;

  cnt_out <= std_logic_vector(counter);

end architecture rtl;
