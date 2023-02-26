-------------------------------------------------------------------------------
-- Title      : Multiplier
-- Project    : 
-------------------------------------------------------------------------------
-- File       : multiplier.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-02-19
-- Last update: 2023-02-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Multiplier
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-02-19  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is

  generic (
    G_DATA_A_WIDTH : integer range 0 to 32 := 18;   -- Data A in Width
    G_DATA_B_WIDTH : integer range 0 to 32 := 18);  -- DAta B in Width

  port (
    clk       : in  std_logic;          -- Clock
    rst_n     : in  std_logic;          -- Asynchronous Reset
    data_in_a : in  std_logic_vector(G_DATA_A_WIDTH - 1 downto 0);  -- Data in A
    data_in_b : in  std_logic_vector(G_DATA_B_WIDTH - 1 downto 0);  -- Data in B
    data_out  : out std_logic_vector(G_DATA_A_WIDTH + G_DATA_B_WIDTH - 1 downto 0));  -- Data out

end entity multiplier;


architecture rtl of multiplier is

begin  -- architecture rtl

  -- purpose: Multiplier A*B every clock cycle
  p_mult : process (clk, rst_n) is
  begin  -- process p_mult
    if rst_n = '0' then                 -- asynchronous reset (active low)
      data_out <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      data_out <= std_logic_vector(unsigned(data_in_a) * unsigned(data_in_b));
    end if;
  end process p_mult;


end architecture rtl;
