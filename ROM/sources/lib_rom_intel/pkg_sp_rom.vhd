-------------------------------------------------------------------------------
-- Title      : Package SP ROM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_sp_rom.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-10-01
-- Last update: 2023-10-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: PAckage for SP ROM
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-10-01  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package pkg_sp_rom is

  -- == TYPES ==
  type t_rom_32bits is array (natural range <>) of std_logic_vector(31 downto 0);  -- Array of 32 bits slv
end package;
