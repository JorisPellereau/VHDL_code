-------------------------------------------------------------------------------
-- Title      : Custom Package for lib_uart_debug
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_uart_debug_custom.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-08-19
-- Last update: 2021-08-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Custom Package for lib_uart_debug - Can be modified for
-- specific project
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-08-19  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_uart_debug;
use lib_uart_debug.pkg_uart_debug.all;


package pkg_uart_debug_custom is

  -- Constants
  constant C_OUTPUT_NB : integer := 2;  -- Output Number to drive
  constant C_INPUT_NB  : integer := 2;  -- Input Number to Read

  -- NEW TYPES
  type t_array_record_out is array (0 to C_OUTPUT_NB - 1) of t_record_out;
  type t_array_record_in is array (0 to C_INPUT_NB - 1) of t_record_in;


  -- Constant with Infos. for Outputs
  constant C_ARRAY_RECORD_OUT : t_array_record_out := (
    0 => (out_type => WC, out_length => 1),
    1 => (out_type => W, out_length => 32)
    );

  -- Constants with infos. for Inputs
  constant C_ARRAY_RECORD_IN : t_array_record_in := (
    0 => (in_type => R, in_length => 1),
    1 => (in_type => R, in_length => 32)
    );

  -- Type Record Out 0
  type t_record_out_0 is record
    bus : std_logic_vector(C_ARRAY_RECORD_OUT(0).out_length - 1 downto 0);
  end record t_record_out_0;

  -- Type Record Out 1
  type t_record_out_1 is record
    bus : std_logic_vector(C_ARRAY_RECORD_OUT(1).out_length - 1 downto 0);
  end record t_record_out_1;


  -- Record for Bus creation - Output Bus
  type t_record_bus_out is record
    bus_0 : t_record_out_0;
    bus_1 : t_record_out_1;
  end record t_record_bus_out;


end package pkg_uart_debug_custom;
