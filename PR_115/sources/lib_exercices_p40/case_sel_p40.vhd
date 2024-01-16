-------------------------------------------------------------------------------
-- Title      : Case sel p40
-- Project    : 
-------------------------------------------------------------------------------
-- File       : case_sel_p40.vhd
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
use ieee.numeric_std.all;

entity case_sel_p40 is
  generic (
    G_SEL_VERSION : integer range 0 to 1 := 0      -- Version Selection - 0 == version 1 - 1 == version 2
    );
  port (
    clk_sys   : in  std_logic;                     -- Clock system
    rst_n_sys : in  std_logic;                     -- Asynchronous reset
    s         : in  std_logic_vector(2 downto 0);  -- Input selection
    a         : out std_logic_vector(1 downto 0)   -- Output
    );
end entity case_sel_p40;

architecture rtl of case_sel_p40 is

begin  -- architecture rtl

  g_version_1 : if(G_SEL_VERSION = 0) generate

    p_version1 : process (clk_sys, rst_n_sys) is
    begin  -- process p_version1
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        a <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge

        case s is
          when "000" =>
            a <= "01";

          when "001" | "010" | "011" =>
            a <= "10";

          when "100" | "101" | "110" =>
            a <= "00";

          when others =>
            a <= "11";
        end case;

      end if;
    end process p_version1;
  end generate;


  g_version_2 : if(G_SEL_VERSION = 1) generate

    p_version2 : process (clk_sys, rst_n_sys) is
    begin  -- process p_version2
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        a <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge

        case s is
          when "000" =>
            a <= "01";

          when "001" | "010" | "011" =>
            a <= "10";

          when "100" | "101" | "110" =>
            a <= "00";

          when "111" =>
            a <= "11";
        end case;

      end if;
    end process p_version2;
  end generate;




end architecture rtl;
