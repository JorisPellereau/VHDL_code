-------------------------------------------------------------------------------
-- Title      : Package for registers
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_reg.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-05-19
-- Last update: 2023-05-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Package registers
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-05-19  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pkg_reg is

  -- == TYPES ==
  type t_reg_access_type is (RW, RO, WO);  -- Registers Access type

  -- Type for the configuration of a register
  -- reg_wr_en reg_rd_en external
  -- '0'       '0'       '0'     => Not Possible
  -- '0'       '0'       '1'     => Not Possible
  -- '0'       '1'       '0'     => Not connected to external - Write not authorized - Read Only
  -- '0'       '1'       '1'     => Connected to external input port - Write not authorized - Read Only
  -- '1'       '0'       '0'     => Not Possible
  -- '1'       '0'       '1'     => Write only and connected to output port
  -- '1'       '1'       '0'     => Internal Read/Write
  -- '1'       '1'       '1'     => Write and Read possible - connected to output port 
  type t_reg_config_rec is record       -- 
    reg_init_value : integer;           -- Register Initial value
    reg_wr_en      : std_logic;    -- Register is writable ('1') or not ('0')
    reg_rd_en      : std_logic;    -- Register is readable ('1') or not ('0')
    external       : std_logic;         -- Register is connected to in/out port
    position       : integer;  -- Position of the register on the external in/out port
  end record t_reg_config_rec;

  type t_reg_config_array is array (natural range <>) of t_reg_config_rec;  -- Array of register configuration  

end package;
