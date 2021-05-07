-------------------------------------------------------------------------------
-- Title      : Sequencer UART Command
-- Project    : 
-------------------------------------------------------------------------------
-- File       : sequencer_uart_cmd.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-07
-- Last update: 2021-05-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-05-07  1.0      jorisp	Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_uart_display_ctrl;
use lib_uart_display_ctrl.pkg_uart_max7219_display_ctrl.all;


entity sequencer_uart_cmd is
  
  generic (
    G_NB_CMD          : integer              := 4;  -- Command Number
    G_UART_DATA_WIDTH : integer range 5 to 9 := 8);

  port (
    clk          : in std_logic;
    rst_n        : in std_logic;
    i_cmd_pulses : in std_logic_vector(G_NB_CMD - 1 downto 0));

end entity sequencer_uart_cmd;


architecture behv of sequencer_uart_cmd is

begin  -- architecture behv

  

end architecture behv;
