-------------------------------------------------------------------------------
-- Title      : MAX7219 DIGITS to SERIAL CONFIG.
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_digit2conf.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-05-03
-- Last update: 2020-05-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 DIGIT[0 => 9] to ADDRESS and DATA conversion
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-05-03  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity max7219_digit2conf is

  port (
    clk     : in  std_logic;                      -- Clock
    rst_n   : in  std_logic;                      -- Asynchronous reset
    i_digit : in  std_logic_vector(3 downto 0);   -- DIGIT to DECOD
    i_val   : in  std_logic;
    o_seg_7 : out std_logic_vector(11 downto 0);  -- Config. Seg N7
    o_seg_6 : out std_logic_vector(11 downto 0);  -- Config. Seg N6
    o_seg_5 : out std_logic_vector(11 downto 0);  -- Config. Seg N5
    o_seg_4 : out std_logic_vector(11 downto 0);  -- Config. Seg N4
    o_seg_3 : out std_logic_vector(11 downto 0);  -- Config. Seg N3
    o_seg_2 : out std_logic_vector(11 downto 0);  -- Config. Seg N2
    o_seg_1 : out std_logic_vector(11 downto 0);  -- Config. Seg N1
    o_seg_0 : out std_logic_vector(11 downto 0);  -- Config. Seg N0
    o_done  : out std_logic                       -- Conf Available
    );
end entity max7219_digit2conf;

architecture behv of max7219_digit2conf is

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
        case i_digit is
          when x"0" =>
            o_seg_7 <= "800";
            o_seg_6 <= "700";
            o_seg_5 <= "600";
            o_seg_4 <= "53E";
            o_seg_3 <= "451";
            o_seg_2 <= "349";
            o_seg_1 <= "245";
            o_seg_0 <= "13E";

          when x"1" =>
            o_seg_7 <= "800";
            o_seg_6 <= "700";
            o_seg_5 <= "600";
            o_seg_4 <= "500";
            o_seg_3 <= "421";
            o_seg_2 <= "37F";
            o_seg_1 <= "201";
            o_seg_0 <= "100";

          when x"2" =>
            o_seg_7 <= "800";
            o_seg_6 <= "700";
            o_seg_5 <= "600";
            o_seg_4 <= "521";
            o_seg_3 <= "443";
            o_seg_2 <= "345";
            o_seg_1 <= "249";
            o_seg_0 <= "131";

          when x"3" =>
            o_seg_7 <= "800";
            o_seg_6 <= "700";
            o_seg_5 <= "600";
            o_seg_4 <= "522";
            o_seg_3 <= "441";
            o_seg_2 <= "349";
            o_seg_1 <= "249";
            o_seg_0 <= "136";


          when x"4" =>
            o_seg_7 <= "800";
            o_seg_6 <= "700";
            o_seg_5 <= "600";
            o_seg_4 <= "50C";
            o_seg_3 <= "414";
            o_seg_2 <= "324";
            o_seg_1 <= "27F";
            o_seg_0 <= "104";

          when x"5" =>
            o_seg_7 <= "800";
            o_seg_6 <= "700";
            o_seg_5 <= "600";
            o_seg_4 <= "579";
            o_seg_3 <= "449";
            o_seg_2 <= "349";
            o_seg_1 <= "249";
            o_seg_0 <= "146";


          when x"6" =>
            o_seg_7 <= "800";
            o_seg_6 <= "700";
            o_seg_5 <= "600";
            o_seg_4 <= "53E";
            o_seg_3 <= "449";
            o_seg_2 <= "349";
            o_seg_1 <= "249";
            o_seg_0 <= "126";

          when x"7" =>
            o_seg_7 <= "800";
            o_seg_6 <= "700";
            o_seg_5 <= "600";
            o_seg_4 <= "540";
            o_seg_3 <= "440";
            o_seg_2 <= "34F";
            o_seg_1 <= "250";
            o_seg_0 <= "160";

          when x"8" =>
            o_seg_7 <= "800";
            o_seg_6 <= "700";
            o_seg_5 <= "600";
            o_seg_4 <= "536";
            o_seg_3 <= "449";
            o_seg_2 <= "349";
            o_seg_1 <= "249";
            o_seg_0 <= "136";

          when x"9" =>
            o_seg_7 <= "800";
            o_seg_6 <= "700";
            o_seg_5 <= "600";
            o_seg_4 <= "532";
            o_seg_3 <= "449";
            o_seg_2 <= "349";
            o_seg_1 <= "249";
            o_seg_0 <= "13E";

          when others =>
            o_seg_7 <= "855";
            o_seg_6 <= "7AA";
            o_seg_5 <= "655";
            o_seg_4 <= "5AA";
            o_seg_3 <= "455";
            o_seg_2 <= "3AA";
            o_seg_1 <= "255";
            o_seg_0 <= "1AA";
        end case;
      else
        o_done <= '0';
      end if;

    end if;
  end process p_decod_mngt;


end architecture behv;
