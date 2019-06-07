-------------------------------------------------------------------------------
-- Title      : LCD12232 controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd12232_ctrl.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-07
-- Last update: 2019-06-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the controller module for the LCD12232
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-07  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_lcd12232;
use lib_lcd12232.pkg_lcd12232.all;

entity lcd12232_ctrl is

  port (
    clock_i   : in    std_logic;        -- System clock
    reset_n_i : in    std_logic;        -- Active low asynchronous reset
    reg_sel_o : out   std_logic;        -- Register sel
    en1_o     : out   std_logic;        -- Enable for IC1
    en2_o     : out   std_logic;        -- Enable for IC2
    rw_o      : out   std_logic;        -- Read/Write selection
    rst_o     : out   std_logic;        -- LCD reset
    db_o      : inout std_logic_vector(7 downto 0));  -- Data to LCD

end entity lcd12232_ctrl;

architecture arch_lcd12232_ctrl of lcd12232_ctrl is

begin  -- architecture arch_lcd12232_ctrl



end architecture arch_lcd12232_ctrl;
