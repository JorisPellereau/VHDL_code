-------------------------------------------------------------------------------
-- Title      : WATCH FPGA Pulse generator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : watch_pulse_gen.vhd
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
use ieee.numeric_std.all;

entity watch_pulse_gen is
  port (
    rst_n_sys : in std_logic;           -- Reset in clk_sys clock domain
    clk_sys   : in std_logic;           -- Clock System

    -- Output Pulse
    update_watch        : out std_logic;  -- Update the watch display
    compute_next_update : out std_logic   -- Compute the next update
    );
end entity watch_pulse_gen;

architecture rtl of watch_pulse_gen is

  -- == CONSTANTS ==
  constant C_MAX_CNT_1SEC : std_logic_vector(23 downto 0) := x"989680";

  -- == INERNAL Signals ==
  signal cnt_1s : unsigned(23 downto 0);  -- Counter until 1 sec from and input clock of 10MHz

begin  -- architecture rtl

  -- purpose: Counter for 1 second pulse generation
  p_cnt_1sec : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_1sec
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_1s <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge
      if(cnt_1s = unsigned(C_MAX_CNT_1SEC)) then
        cnt_1s <= (others => '0');
      else
        cnt_1s <= cnt_1s + 1;           -- Inc. by one the counter
      end if;
    end if;
  end process p_cnt_1sec;

  -- purpose: Update Watch
  p_update_watch : process (clk_sys, rst_n_sys) is
  begin  -- process p_update_watch
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      update_watch <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      if(cnt_1s = unsigned(C_MAX_CNT_1SEC) - 1) then
        update_watch <= '1';
      else
        update_watch <= '0';
      end if;
    end if;
  end process p_update_watch;


  -- purpose: Compute next update flag generation
  p_compute_next_update : process (clk_sys, rst_n_sys) is
  begin  -- process p_compute_next_update
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      compute_next_update <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      if(cnt_1s = unsigned(C_MAX_CNT_1SEC(23 downto 1)) - 1) then
        compute_next_update <= '1';
      else
        compute_next_update <= '0';
      end if;

    end if;
  end process p_compute_next_update;

end architecture rtl;
