-------------------------------------------------------------------------------
-- Title      : Package of UART Command decod
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_uart_cmd_decod.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-04-16
-- Last update: 2021-04-16
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-04-16  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package pkg_uart_cmd_decod is

  -- == CONSTANTS ==
  constant C_NB_CMD     : integer              := 4;   -- Command Number
  constant C_CMD_LENGTH : integer              := 10;  -- Command Length
  constant C_DATA_WIDTH : integer range 5 to 9 := 8;   -- Data Width

  -- == Types ==
  type t_cmd_array is array (0 to C_CMD_LENGTH - 1) of std_logic_vector(C_DATA_WIDTH - 1 downto 0);
  type t_cmd_list_array is array (0 to C_NB_CMD - 1) of t_cmd_array;

  -- == CONSTANTS COMMANDS ==
  constant C_CMD_00 : t_cmd_array := (0 => x"AA", 1 => x"BB", 2 => x"CC", 3 => x"DD", 4 => x"EE", 5 => x"FF", 6 => x"00", 7 => x"11", 8 => x"22", 9 => x"33");  -- Command 0
  constant C_CMD_01 : t_cmd_array := (0 => x"AA", 1 => x"BB", 2 => x"CC", 3 => x"DD", 4 => x"EE", 5 => x"FF", 6 => x"00", 7 => x"11", 8 => x"22", 9 => x"34");  -- Command 1
  constant C_CMD_02 : t_cmd_array := (0 => x"AA", 1 => x"BB", 2 => x"CC", 3 => x"DD", 4 => x"EE", 5 => x"FF", 6 => x"00", 7 => x"11", 8 => x"22", 9 => x"35");  -- Command 2
  constant C_CMD_03 : t_cmd_array := (0 => x"AA", 1 => x"BB", 2 => x"CC", 3 => x"DD", 4 => x"EE", 5 => x"FF", 6 => x"00", 7 => x"11", 8 => x"22", 9 => x"36");  -- Command 3

  -- == CONSTANTS COMMANDS LIST ==
  constant C_CMD_LIST : t_cmd_list_array := (
    0 => C_CMD_00,
    1 => C_CMD_01,
    2 => C_CMD_02,
    3 => C_CMD_03
    );



end package pkg_uart_cmd_decod;
