-------------------------------------------------------------------------------
-- Title      : MAX7219 DIGIT to letter
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_digit2letter.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-07-18
-- Last update: 2020-07-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 Digit to letter
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-07-18  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;


entity max7219_digit2letter is
  port (
    clk      : in  std_logic;                      -- Clock
    rst_n    : in  std_logic;                      -- Asynchronous reset
    i_letter : in  std_logic_vector(7 downto 0);   -- Letter to decod
    i_val    : in  std_logic;
    o_seg_7  : out std_logic_vector(11 downto 0);  -- Config. Seg N7
    o_seg_6  : out std_logic_vector(11 downto 0);  -- Config. Seg N6
    o_seg_5  : out std_logic_vector(11 downto 0);  -- Config. Seg N5
    o_seg_4  : out std_logic_vector(11 downto 0);  -- Config. Seg N4
    o_seg_3  : out std_logic_vector(11 downto 0);  -- Config. Seg N3
    o_seg_2  : out std_logic_vector(11 downto 0);  -- Config. Seg N2
    o_seg_1  : out std_logic_vector(11 downto 0);  -- Config. Seg N1
    o_seg_0  : out std_logic_vector(11 downto 0);  -- Config. Seg N0
    o_done   : out std_logic                       -- Conf Available
    );
end entity max7219_digit2letter;


architecture behv of max7219_digit2letter is

begin  -- architecture behv

  p_decod_mngt : process (clk, rst_n) is
  begin  -- process p_decod_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_seg_7 <= (others => '0');
      o_seg_6 <= (others => '0');
      o_seg_5 <= (others => '0');
      o_seg_4 <= (others => '0');
      o_seg_3 <= (others => '0');
      o_seg_2 <= (others => '0');
      o_seg_1 <= (others => '0');
      o_seg_0 <= (others => '0');
      o_done  <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(i_val = '1') then
        o_done <= '1';

        case i_letter is

          -- A
          when x"00" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"53F";
            o_seg_3 <= x"448";
            o_seg_2 <= x"348";
            o_seg_1 <= x"248";
            o_seg_0 <= x"13F";

          -- B
          when x"01" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57F";
            o_seg_3 <= x"449";
            o_seg_2 <= x"349";
            o_seg_1 <= x"249";
            o_seg_0 <= x"136";

          -- C
          when x"02" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"53E";
            o_seg_3 <= x"441";
            o_seg_2 <= x"341";
            o_seg_1 <= x"241";
            o_seg_0 <= x"122";

          -- D
          when x"03" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57F";
            o_seg_3 <= x"441";
            o_seg_2 <= x"341";
            o_seg_1 <= x"241";
            o_seg_0 <= x"12E";

          -- E
          when x"04" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57F";
            o_seg_3 <= x"449";
            o_seg_2 <= x"349";
            o_seg_1 <= x"249";
            o_seg_0 <= x"141";

          -- F
          when x"05" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"53F";
            o_seg_3 <= x"448";
            o_seg_2 <= x"348";
            o_seg_1 <= x"248";
            o_seg_0 <= x"140";

          -- G
          when x"06" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"53E";
            o_seg_3 <= x"441";
            o_seg_2 <= x"349";
            o_seg_1 <= x"249";
            o_seg_0 <= x"12E";

          -- H
          when x"07" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57F";
            o_seg_3 <= x"408";
            o_seg_2 <= x"308";
            o_seg_1 <= x"208";
            o_seg_0 <= x"17F";

          -- I
          when x"08" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"500";
            o_seg_3 <= x"441";
            o_seg_2 <= x"37F";
            o_seg_1 <= x"241";
            o_seg_0 <= x"100";

          -- J
          when x"09" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"502";
            o_seg_3 <= x"441";
            o_seg_2 <= x"341";
            o_seg_1 <= x"241";
            o_seg_0 <= x"17E";

          -- K
          when x"0A" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57F";
            o_seg_3 <= x"408";
            o_seg_2 <= x"308";
            o_seg_1 <= x"214";
            o_seg_0 <= x"163";

          -- L
          when x"0B" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57F";
            o_seg_3 <= x"401";
            o_seg_2 <= x"301";
            o_seg_1 <= x"201";
            o_seg_0 <= x"101";

          -- M
          when x"0C" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57F";
            o_seg_3 <= x"420";
            o_seg_2 <= x"310";
            o_seg_1 <= x"220";
            o_seg_0 <= x"17F";

          -- N
          when x"0D" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57F";
            o_seg_3 <= x"410";
            o_seg_2 <= x"308";
            o_seg_1 <= x"204";
            o_seg_0 <= x"17F";

          -- O
          when x"0E" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"53E";
            o_seg_3 <= x"441";
            o_seg_2 <= x"341";
            o_seg_1 <= x"241";
            o_seg_0 <= x"13E";

          -- P
          when x"0F" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57F";
            o_seg_3 <= x"448";
            o_seg_2 <= x"348";
            o_seg_1 <= x"248";
            o_seg_0 <= x"130";

          -- Q
          when x"10" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"53E";
            o_seg_3 <= x"441";
            o_seg_2 <= x"345";
            o_seg_1 <= x"243";
            o_seg_0 <= x"13F";

          -- R
          when x"11" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57F";
            o_seg_3 <= x"448";
            o_seg_2 <= x"348";
            o_seg_1 <= x"248";
            o_seg_0 <= x"137";

          -- S
          when x"12" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"532";
            o_seg_3 <= x"449";
            o_seg_2 <= x"349";
            o_seg_1 <= x"249";
            o_seg_0 <= x"126";

          -- T
          when x"13" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"540";
            o_seg_3 <= x"440";
            o_seg_2 <= x"37F";
            o_seg_1 <= x"240";
            o_seg_0 <= x"140";

          -- U
          when x"14" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57E";
            o_seg_3 <= x"401";
            o_seg_2 <= x"301";
            o_seg_1 <= x"201";
            o_seg_0 <= x"17E";

          -- V
          when x"15" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57C";
            o_seg_3 <= x"402";
            o_seg_2 <= x"301";
            o_seg_1 <= x"202";
            o_seg_0 <= x"17C";

          -- W
          when x"16" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"57F";
            o_seg_3 <= x"402";
            o_seg_2 <= x"304";
            o_seg_1 <= x"202";
            o_seg_0 <= x"17F";

          -- X
          when x"17" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"563";
            o_seg_3 <= x"414";
            o_seg_2 <= x"308";
            o_seg_1 <= x"214";
            o_seg_0 <= x"163";

          -- Y
          when x"18" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"560";
            o_seg_3 <= x"410";
            o_seg_2 <= x"30F";
            o_seg_1 <= x"210";
            o_seg_0 <= x"160";

          -- Z
          when x"19" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"543";
            o_seg_3 <= x"445";
            o_seg_2 <= x"349";
            o_seg_1 <= x"251";
            o_seg_0 <= x"161";

          -- SPACE
          when x"1A" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"500";
            o_seg_3 <= x"400";
            o_seg_2 <= x"300";
            o_seg_1 <= x"200";
            o_seg_0 <= x"100";

          -- !
          when x"1B" =>
            o_seg_7 <= x"800";
            o_seg_6 <= x"700";
            o_seg_5 <= x"600";
            o_seg_4 <= x"500";
            o_seg_3 <= x"400";
            o_seg_2 <= x"37D";
            o_seg_1 <= x"200";
            o_seg_0 <= x"100";

            -- >
          when x"1C" =>
            o_seg_7 <= x"8C3";
            o_seg_6 <= x"7E7";
            o_seg_5 <= x"6E7";
            o_seg_4 <= x"5FF";
            o_seg_3 <= x"4FF";
            o_seg_2 <= x"37E";
            o_seg_1 <= x"23C";
            o_seg_0 <= x"118";

          when others => null;
        end case;
      else
        o_done <= '0';
      end if;

    end if;
  end process p_decod_mngt;

end architecture behv;
