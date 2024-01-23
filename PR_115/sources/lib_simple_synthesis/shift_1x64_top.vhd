-------------------------------------------------------------------------------
-- Title      : Shift register from HDL recommendatio, altera
-- Project    : 
-------------------------------------------------------------------------------
-- File       : shift_1x64_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-18
-- Last update: 2024-01-18
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-18  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity shift_1x64_top is
  port (
    clk    : in  std_logic;
    shift  : in  std_logic;
    sr_in  : in  std_logic;
    sr_out : out std_logic
    );
end shift_1x64_top;

architecture arch of shift_1x64_top is
  type sr_length is array (63 downto 0) of std_logic;
  signal sr : sr_length;
begin
  process (clk)
  begin
    if (clk'event and clk = '1') then
      if (shift = '1') then
        sr(63 downto 1) <= sr(62 downto 0);
        sr(0)           <= sr_in;
      end if;
    end if;
  end process;
  sr_out <= sr(63);
end arch;
