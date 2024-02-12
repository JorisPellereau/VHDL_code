-------------------------------------------------------------------------------
-- Title      : AXI4 Lite GPO Package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_i2c_gpo_pkg.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-02-12
-- Last update: 2024-02-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-02-12  1.0      linux-jp	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package axi4_lite_gpo_pkg is

  -- == CONSTANTS ==
  constant C_NB_REG : integer := 1;     -- Number of Register

  constant C_USEFUL_LSBITS : integer := 4;  -- 5 LSBITS of usefull addr

  constant C_REG0_ADDR : std_logic_vector(C_USEFUL_LSBITS - 1 downto 0) := x"0";  -- REG0 ADDR
  

  -- Register Index (32bits wide)
  constant C_REG0_IDX : integer := 0;   -- Index number of REG 0

  constant C_CTRL0_WIDTH   : integer := 32;  -- Width of the CTRL0 register

end package;
