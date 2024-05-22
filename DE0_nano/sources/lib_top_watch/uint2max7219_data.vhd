-------------------------------------------------------------------------------
-- Title      : Unsigned integer to Data for MAX7219
-- Project    : 
-------------------------------------------------------------------------------
-- File       : uint2max7219_data.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-05-12
-- Last update: 2024-05-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-- Limitation : Start shall be a pulse of one clk_sys clock period
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-05-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity uint2max7219_data is
  port (
    clk_sys   : in std_logic;           -- Clock System
    rst_n_sys : in std_logic;           -- Clock reset clock System

    -- Input data
    uint_data : in std_logic_vector(3 downto 0);  -- Input unsigned integer data

    -- Output Data character
    char_data_0 : out std_logic_vector(7 downto 0);  -- Output Char 0
    char_data_1 : out std_logic_vector(7 downto 0);  -- Output Char 1
    char_data_2 : out std_logic_vector(7 downto 0);  -- Output Char 2
    char_data_3 : out std_logic_vector(7 downto 0);  -- Output Char 3
    char_data_4 : out std_logic_vector(7 downto 0)   -- Output Char 4
    );
end entity uint2max7219_data;

architecture rtl of uint2max7219_data is

begin  -- architecture rtl


  -- purpose: Char 0 Management 
  p_char_data_0_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_char_data_0_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      char_data_0 <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge


      case uint_data is
        when x"0" =>
          char_data_0 <= x"7C";

        when x"1" =>
          char_data_0 <= x"00";

        when x"2" =>
          char_data_0 <= x"42";

        when x"3" =>
          char_data_0 <= x"44";

        when x"4" =>
          char_data_0 <= x"18";

        when x"5" =>
          char_data_0 <= x"F2";

        when x"6" =>
          char_data_0 <= x"7C";

        when x"7" =>
          char_data_0 <= x"80";

        when x"8" =>
          char_data_0 <= x"6C";

        when x"9" =>
          char_data_0 <= x"64";

        when others =>
          char_data_0 <= x"A0";         -- Wrong display in case of error
      end case;
    end if;
  end process p_char_data_0_mngt;

  -- purpose: Char 1 Management 
  p_char_data_1_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_char_data_1_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      char_data_1 <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge


      case uint_data is
        when x"0" =>
          char_data_1 <= x"A2";

        when x"1" =>
          char_data_1 <= x"42";

        when x"2" =>
          char_data_1 <= x"86";

        when x"3" =>
          char_data_1 <= x"82";

        when x"4" =>
          char_data_1 <= x"28";

        when x"5" =>
          char_data_1 <= x"92";

        when x"6" =>
          char_data_1 <= x"92";

        when x"7" =>
          char_data_1 <= x"80";

        when x"8" =>
          char_data_1 <= x"92";

        when x"9" =>
          char_data_1 <= x"92";

        when others =>
          char_data_1 <= x"A1";         -- Wrong display in case of error
      end case;
    end if;
  end process p_char_data_1_mngt;


  -- purpose: Char 2 Management 
  p_char_data_2_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_char_data_2_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      char_data_2 <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge


      case uint_data is
        when x"0" =>
          char_data_2 <= x"92";

        when x"1" =>
          char_data_2 <= x"FE";

        when x"2" =>
          char_data_2 <= x"8A";

        when x"3" =>
          char_data_2 <= x"92";

        when x"4" =>
          char_data_2 <= x"48";

        when x"5" =>
          char_data_2 <= x"92";

        when x"6" =>
          char_data_2 <= x"92";

        when x"7" =>
          char_data_2 <= x"9E";

        when x"8" =>
          char_data_2 <= x"92";

        when x"9" =>
          char_data_2 <= x"92";

        when others =>
          char_data_2 <= x"A2";         -- Wrong display in case of error
      end case;
    end if;
  end process p_char_data_2_mngt;



  -- purpose: Char 3 Management 
  p_char_data_3_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_char_data_3_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      char_data_3 <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge


      case uint_data is
        when x"0" =>
          char_data_3 <= x"8A";

        when x"1" =>
          char_data_3 <= x"02";

        when x"2" =>
          char_data_3 <= x"92";

        when x"3" =>
          char_data_3 <= x"92";

        when x"4" =>
          char_data_3 <= x"FE";

        when x"5" =>
          char_data_3 <= x"92";

        when x"6" =>
          char_data_3 <= x"92";

        when x"7" =>
          char_data_3 <= x"A0";

        when x"8" =>
          char_data_3 <= x"92";

        when x"9" =>
          char_data_3 <= x"92";

        when others =>
          char_data_3 <= x"A3";         -- Wrong display in case of error
      end case;
    end if;
  end process p_char_data_3_mngt;


  -- purpose: Char 4 Management 
  p_char_data_4_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_char_data_4_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      char_data_4 <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge


      case uint_data is
        when x"0" =>
          char_data_4 <= x"7C";

        when x"1" =>
          char_data_4 <= x"00";

        when x"2" =>
          char_data_4 <= x"62";

        when x"3" =>
          char_data_4 <= x"6C";

        when x"4" =>
          char_data_4 <= x"08";

        when x"5" =>
          char_data_4 <= x"8C";

        when x"6" =>
          char_data_4 <= x"4C";

        when x"7" =>
          char_data_4 <= x"C0";

        when x"8" =>
          char_data_4 <= x"6C";

        when x"9" =>
          char_data_4 <= x"7C";

        when others =>
          char_data_4 <= x"A4";         -- Wrong display in case of error
      end case;
    end if;
  end process p_char_data_4_mngt;



end architecture rtl;
