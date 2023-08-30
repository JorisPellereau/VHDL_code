-------------------------------------------------------------------------------
-- Title      : AXI4 Lite 7 Segments Package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_7segs_pkg.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-29
-- Last update: 2023-08-29
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-08-29  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package axi4_lite_7segs_pkg is

  -- == CONSTANTS ==
  constant C_NB_REG : integer := 1;  -- Number of Register

  -- Register Index
  constant C_DIGITS_IDX : integer := 0;  -- Index number of the register DIGITS
  
end package;
