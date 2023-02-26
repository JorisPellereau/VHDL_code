-------------------------------------------------------------------------------
-- Title      : Package for AXI4 Lite
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_axi4_lite.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-02-26
-- Last update: 2023-02-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Package for AXI4 Lite
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-02-26  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pkg_axi4_lite is

  -- == TYPES ==
  type t_axi4_lite_slave_in is record

  end record t_axi4_lite_slave_in;

  type t_axi4_lite_slave_out is record

  end record t_axi4_lite_slave_out;

end package pkg_axi4_lite;
