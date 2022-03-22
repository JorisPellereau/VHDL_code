-------------------------------------------------------------------------------
-- Title      : MAX7219 CONFIGURATION MATRIX
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_config_matrix.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-05-09
-- Last update: 2020-06-13
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 CONFIGURATION MATRIX
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-05-09  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_config_matrix is

  generic (
    G_DIGITS_NB      : integer range 2 to 8 := 8;  -- DIGIT NB on THE MATRIX DISPLAY
    G_RAM_DATA_WIDTH : integer              := 16);         -- RAM DATA WIDTH
  port (
    clk                : in  std_logic;            -- Clock
    rst_n              : in  std_logic;            -- Asynchronous Reset
    i_decod_mode       : in  std_logic_vector(7 downto 0);  -- DECOD MODE
    i_intensity        : in  std_logic_vector(7 downto 0);  -- INTENSITY
    i_scan_limit       : in  std_logic_vector(7 downto 0);  -- SCAN LIMIT
    i_shutdown         : in  std_logic_vector(7 downto 0);  -- SHUTDOWN MODE
    i_config_val       : in  std_logic;            -- Config. Valid
    o_config_array     : out t_config_array;       -- CONFIG. ARRAY CMD
    o_config_array_val : out std_logic);           -- CONFIG ARRAY VAL

end entity max7219_config_matrix;

architecture behv of max7219_config_matrix is

  -- INTERNAL SIGNALS
  signal s_set_done : std_logic;
begin  -- architecture behv


  p_config_cmd_mngt : process (clk, rst_n) is
  begin  -- process p_config_cmd_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_config_array     <= (others => (others => '0'));
      o_config_array_val <= '0';
      s_set_done         <= '0';
      o_config_array_val <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      
      if(i_config_val = '1') then
        for i in 0 to G_DIGITS_NB - 1 loop
          o_config_array(i)                 <= x"09" & i_decod_mode;
          o_config_array(i + 1*G_DIGITS_NB) <= x"0A" & i_intensity;
          o_config_array(i + 2*G_DIGITS_NB) <= x"0B" & i_scan_limit;
          o_config_array(i + 3*G_DIGITS_NB) <= x"0C" & i_shutdown;
        end loop;
        s_set_done <= '1';
      else
        s_set_done <= '0';
      end if;

      if(s_set_done = '1') then
        for j in 0 to 3 loop
          -- SET LOAD
          o_config_array(G_DIGITS_NB*(j + 1) - 1)(12) <= '1';
        end loop;
        o_config_array_val <= '1';
      else
        o_config_array_val <= '0';
      end if;
    end if;
  end process p_config_cmd_mngt;

end architecture behv;
