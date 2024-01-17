-------------------------------------------------------------------------------
-- Title      : Exercice 6
-- Project    : 
-------------------------------------------------------------------------------
-- File       : exercice_6.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-16
-- Last update: 2024-01-16
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-16  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity exercice_6 is
  generic(
    G_SEL_EXO : string := "EXO6_V1"     -- Exercice selection
    );
  port (
    clk_sys   : in  std_logic;          -- Clock system
    rst_n_sys : in  std_logic;          -- Asynchronous reset
    a         : in  std_logic;          -- Input A
    b         : in  std_logic;          -- Input B
    x         : in  std_logic;          -- Input X
    y         : in  std_logic;          -- Input Y
    output    : out std_logic;         -- Output
    sel_exo : out std_logic); -- Sel exo check

end entity exercice_6;

architecture rtl of exercice_6 is

begin  -- architecture rtl

  g_exo6_v1 : if(G_SEL_EXO = "EXO6_V1") generate
    -- purpose: Version 1
    p_version1 : process (clk_sys, rst_n_sys) is
    begin  -- process p_version1
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        output <= '0';
      elsif rising_edge(clk_sys) then   -- rising clock edge
        if(a = '0') then
          output <= x;
        elsif(b = '1') then
          output <= y;
        end if;
      end if;
    end process p_version1;

    sel_exo <= '0';
  end generate;

  g_exo6_v2 : if(G_SEL_EXO = "EXO6_V2") generate
    -- purpose: Version 2
    p_version2 : process (clk_sys, rst_n_sys) is
    begin  -- process p_version2
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        output <= '0';
      elsif rising_edge(clk_sys) then   -- rising clock edge
        if(a = '0') then
          output <= x;
        else
          if(b = '1') then
            output <= y;
          end if;
        end if;
      end if;
    end process p_version2;
    sel_exo <= '1';
  end generate;



end architecture rtl;
