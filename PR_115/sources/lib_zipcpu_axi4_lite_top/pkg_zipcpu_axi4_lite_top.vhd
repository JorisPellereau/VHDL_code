-------------------------------------------------------------------------------
-- Title      : Package of JTAG AXI4 Lite TOP FPGA
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_jtag_axi4_lite_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-20
-- Last update: 2023-09-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-20  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package pkg_jtag_axi4_lite_top is

  -- == CORE CONFIguration ==
  constant C_LCD_BIDIR_POLARITY : std_logic := '0';  -- LCD BIDIR Polarity for read access
  
end package;
