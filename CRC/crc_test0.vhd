-------------------------------------------------------------------------------
-- Title      : CRC Test0
-- Project    : 
-------------------------------------------------------------------------------
-- File       : crc_test0.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-08-08
-- Last update: 2020-08-08
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-08-08  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity crc_test0 is

  port (
    clk          : in  std_logic;       -- Clock
    rst_n        : in  std_logic;       -- Asynchronous reset
    i_crc_en     : in  std_logic;       -- CRC enable
    i_crc        : in  std_logic;       -- CRC in
    o_crc_vector : out std_logic_vector(7 downto 0));

end entity crc_test0;

architecture behv of crc_test0 is

  signal s_crc : std_logic_vector(7 downto 0);  -- CRC internal


begin  -- architecture behv


  -- CRC polynome : x^8 + x^2 + x + 1

  p_crc_compute : process (clk, rst_n) is
  begin  -- process p_crc_compute
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_crc <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_crc_en = '1') then
        s_crc(0)          <= i_crc xor s_crc(7);
        s_crc(1)          <= s_crc(0) xor s_crc(7);
        s_crc(2)          <= s_crc(1) xor s_crc(7);
        s_crc(7 downto 3) <= s_crc(6 downto 2);
      else
        s_crc <= (others => '0');
      end if;
    end if;
  end process p_crc_compute;

  o_crc_vector <= s_crc;

end architecture behv;
