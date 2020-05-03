-------------------------------------------------------------------------------
-- Title      : MAX7219 COMMAND ORGANIZER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_cmd_organizer.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-05-03
-- Last update: 2020-05-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 COMMAND ORGANIZER
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

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_cmd_organizer is

  generic (
    G_RAM_DATA_WIDTH : integer              := 16;  -- RAM DATA SIZE
    G_DIGITS_NB      : integer range 2 to 8 := 8);  -- DIGITS Number on the DISPLAY

  port (
    clk               : in  std_logic;  -- Clock
    rst_n             : in  std_logic;  -- Asynchronous reset
    i_score_decod     : in  std_logic_vector(G_DIGITS_NB*4 - 1 downto 0);  -- SCORE DECODED
    i_score_decod_val : in  std_logic;  -- SCORE DECOD valid
    o_score_cmd       : out t_score_array;  -- ARRAY of SCORE
    o_score_val       : out std_logic
    );

end entity max7219_cmd_organizer;

architecture behv of max7219_cmd_organizer is

  -- INTERNAL SIGNALS
  signal s_segs_7 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_6 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_5 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_4 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_3 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_2 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_1 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_0 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);

  signal s_digits2conf_done : std_logic_vector(G_DIGITS_NB - 1 downto 0);
begin  -- architecture behv

  g_digits2conf_inst_0 : for i in 0 to G_DIGITS_NB - 1 generate

    i_digits2conf_inst : max7219_digit2conf
      port map (
        clk     => clk,
        rst_n   => rst_n,
        i_digit => i_score_decod(i*4 + 3 downto i*4),
        i_val   => i_score_decod_val,
        o_seg_7 => s_segs_7(i*12 + 11 downto i*12),
        o_seg_6 => s_segs_6(i*12 + 11 downto i*12),
        o_seg_5 => s_segs_5(i*12 + 11 downto i*12),
        o_seg_4 => s_segs_4(i*12 + 11 downto i*12),
        o_seg_3 => s_segs_3(i*12 + 11 downto i*12),
        o_seg_2 => s_segs_2(i*12 + 11 downto i*12),
        o_seg_1 => s_segs_1(i*12 + 11 downto i*12),
        o_seg_0 => s_segs_0(i*12 + 11 downto i*12),
        o_done  => s_digits2conf_done(i)
        );
  end generate g_digits2conf_inst_0;

end architecture behv;
