-------------------------------------------------------------------------------
-- Title      : Top DE nano board LCD12232 controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_lcd12232_ctrl.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-12
-- Last update: 2019-06-13
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the top level file of the LCd12232 controller
-- Board :DE NANO
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-12  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_lcd12232;
use lib_lcd12232.pkg_lcd12232.all;

entity top_lcd12232_ctrl is

  port (
    clock   : in    std_logic;          -- Sys tem clock 50MHz
    reset_n : in    std_logic;          -- Active low asynchronous reset
    A0      : out   std_logic;          -- Register sel
    en1     : out   std_logic;          -- IC1 enable
    en2     : out   std_logic;          -- IC2 enable
    rw      : out   std_logic;          -- RW
    rst_lcd : out   std_logic;          -- Reset LCD
    data_io : inout std_logic_vector(7 downto 0));  -- Data bus line

end entity top_lcd12232_ctrl;

architecture arch_top_lcd12232_ctrl of top_lcd12232_ctrl is

begin

  -- LCD12232_ctrl Inst
  inst_lcd12232_ctrl : lcd12232_ctrl
    port map(clock_i   => clock,
             reset_n_i => reset_n,
             reg_sel_o => A0,
             en1_o     => en1,
             en2_o     => en2,
             rw_o      => rw,
             rst_o     => rst_lcd,
             data_io   => data_io);



end architecture arch_top_lcd12232_ctrl;
