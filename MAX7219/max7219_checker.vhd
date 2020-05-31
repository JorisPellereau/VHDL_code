-------------------------------------------------------------------------------
-- Title      : MAX7219 Checker
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_checker.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-05-31
-- Last update: 2020-05-31
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 Frame Checker
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-05-31  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use IEEE.std_logic_textio.all;

entity max7219_checker is

  generic (
    G_DIGITS_NB : integer range 2 to 8 := 2);
  port (
    clk            : in std_logic;      -- Clock
    rst_n          : in std_logic;      -- Reset
    i_max7219_clk  : in std_logic;      -- MAX7219 CLK
    i_max7219_data : in std_logic;      -- MAX7219 DATA
    i_max7219_load : in std_logic);     -- MAX7219 LOAd

end entity max7219_checker;

architecture behv of max7219_checker is

  -- TYPE
  type t_max7219_data_array is array (0 to G_DIGITS_NB - 1) of std_logic_vector(15 downto 0);

  -- INTERNAL SIGNAL
  signal s_max7219_data : std_logic_vector(15 downto 0);
  signal s_cnt_15       : std_logic_vector(3 downto 0);  -- Counter 15

  signal s_max7219_clk    : std_logic;
  signal s_max7219_r_edge : std_logic;  -- R EDGE of CLK
  signal s_cnt_15_done    : std_logic;

begin  -- architecture behv

  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_max7219_clk <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_max7219_clk <= i_max7219_clk;
    end if;
  end process p_latch_inputs;

  -- R EDGE detection
  s_max7219_r_edge <= i_max7219_clk and not s_max7219_clk;


  p_data_latch : process (clk, rst_n) is
  begin  -- process p_data_latch
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_max7219_data <= (others => '0');
      s_cnt_15       <= (others => '0');
      s_cnt_15_done  <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_cnt_15_done <= '0';
      -- MSB FIRST
      if(s_max7219_r_edge = '1') then
        s_max7219_data(0)           <= i_max7219_data;
        s_max7219_data(15 downto 1) <= s_max7219_data(14 downto 0);

        if(s_cnt_15 < x"F") then
          s_cnt_15      <= unsigned(s_cnt_15) + 1;  -- INC
          s_cnt_15_done <= '0';
        else
          s_cnt_15      <= (others => '0');
          s_cnt_15_done <= '1';
        end if;
      end if;


    end if;
  end process p_data_latch;

  p_display_data : process (clk, rst_n) is
  begin  -- process p_display_data
    if rst_n = '0' then                 -- asynchronous reset (active low)

    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_cnt_15_done = '1') then

        report "MAX7219 FRAME Transmitted";

        report "register @ : " & integer'image(conv_integer(unsigned(s_max7219_data(11 downto 8)))));

      end if;
    end if;
  end process p_display_data;

end architecture behv;
