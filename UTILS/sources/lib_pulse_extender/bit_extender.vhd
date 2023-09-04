-------------------------------------------------------------------------------
-- Title      : Bit Extender
-- Project    : 
-------------------------------------------------------------------------------
-- File       : bit_extender.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-02
-- Last update: 2023-09-02
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Extend a single pulse
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-02  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity bit_extender is
  generic (
    G_PULSE_WIDTH : positive := 10);    -- Extended Pulse Width
  port (
    clk_sys   : in  std_logic;          -- Clock system
    rst_n     : in  std_logic;          -- Asynchronous Reset
    pulse_in  : in  std_logic;          -- Input pulse to extend
    pulse_out : out std_logic);         -- Output Extended Pulse
end entity bit_extender;

architecture rtl of bit_extender is

  -- == INTERNAL Signals ==
  signal counter_pulse : unsigned(log2(G_PULSE_WIDTH) - 1 downto 0);  -- Pulse Counter
  signal en_cnt        : std_logic;     -- Enable the counter

begin  -- architecture rtl

  -- purpose: Enable Counter Management
  -- Enable to count when pulse_in is set to '1'
  -- Reset enable when the counter is reach
  p_en_cnt_mngt : process (clk_sys, rst_n) is
  begin  -- process p_en_cnt_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      en_cnt <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Set the signal when a pulse is detected
      if(pulse_in = '1') then
        en_cnt <= '1';
      elsif(counter_pulse = to_unsigned(G_PULSE_WIDTH - 1, counter_pulse'length)) then
        en_cnt <= '0';
      end if;
    end if;
  end process p_en_cnt_mngt;

  -- purpose: Counter Management
  p_counter_mngt : process (clk_sys, rst_n) is
  begin  -- process p_counter_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      counter_pulse <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      if(en_cnt = '1' or pulse_in = '1') then
        if(counter_pulse = to_unsigned(G_PULSE_WIDTH - 1, counter_pulse'length)) then
          counter_pulse <= (others => '0');
        else
          counter_pulse <= counter_pulse + 1;  -- Inc. Counter
        end if;
      else
        counter_pulse <= (others => '0');
      end if;
      
    end if;
  end process p_counter_mngt;

  -- Output Affectation
  pulse_out <= en_cnt;

end architecture rtl;
