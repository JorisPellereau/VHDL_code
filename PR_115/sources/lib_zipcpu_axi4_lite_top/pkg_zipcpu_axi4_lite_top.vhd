-------------------------------------------------------------------------------
-- Title      : Package of ZIPCPU AXI4 Lite TOP FPGA
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_zipcpu_axi4_lite_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-20
-- Last update: 2023-11-07
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

library lib_rom_intel;
use lib_rom_intel.pkg_sp_rom.all;

package pkg_zipcpu_axi4_lite_top is

  -- == CORE CONFIguration ==
  constant C_LCD_BIDIR_POLARITY    : std_logic := '0';  -- LCD BIDIR Polarity for read access
  constant C_ROM_ADDR_WIDTH        : integer   := 8;    -- ROM ADDR WIDTH
  constant C_EXTERNAL_INTERRUPT_NB : integer   := 1;    -- Number of external Interrupt

  -- == ROM Initialization ==

  -- simuart ROM
--  00000000 <_start>:
--   0: 12017f53        LDI        0xcafedec0,R2  // cafedec0 <LCD_CHAR>
--   4: 1240dec0 
--   8: 14c00000        SW         R2,($0)

  constant C_SIMUART_ROM : t_rom_32bits(0 to 2**C_ROM_ADDR_WIDTH - 1) := (
    0      => x"12017f53",
    1      => x"1240dec0",
    2      => x"14c00000",
    -- 1      => x"1a000000",
    -- 2      => x"1a400150",
    -- 3      => x"25848000",
    -- 4      => x"2443ffff",
    -- 5      => x"78880018",
    -- 6      => x"2c84c00c",
    -- 7      => x"2c400001",
    -- 8      => x"78abfff4",
    -- 9      => x"24c4c00c",
    -- 10     => x"10800001",
    -- 11     => x"7883ffdc",
    -- 12     => x"7f800100",
    -- 13     => x"70c00010",
    -- 14     => x"48656c6c",
    -- 15     => x"6f2c2057",
    -- 16     => x"6f726c64",
    -- 17     => x"210d0a00",
    others => x"77C00000"               -- NOOP
    );

  constant C_ROM_INIT : t_rom_32bits(0 to 2**C_ROM_ADDR_WIDTH - 1) := C_SIMUART_ROM;

end package;
