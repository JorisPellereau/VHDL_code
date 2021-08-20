-------------------------------------------------------------------------------
-- Title      : Package for lib_uart_debug
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_uart_debug.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-08-19
-- Last update: 2021-08-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-08-19  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package pkg_uart_debug is

  -- NEW TYPES
  type t_out_type is (W, WC);  -- Possible Output Type - WC : Clear on Write -
  -- W : Write

  type t_in_type is (R, RC); -- Possible Input Type - R : Read - RC : Clear on
                             -- Read
  

  -- Record : Outputs
  type t_record_out is record
    out_type   : t_out_type;            -- Output Type
    out_length : integer;               -- Output Length
  end record t_record_out;

  -- Record : Inputs
  type t_record_in is record
    in_type   : t_in_type;              -- Input Type
    in_length : integer;                -- Input Length
  end record t_record_in;
  
end package pkg_uart_debug;
