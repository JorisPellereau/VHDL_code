-------------------------------------------------------------------------------
-- Title      : Package of ZIPCPU AXI4 Lite TOP FPGA
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_zipcpu_axi4_lite_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-20
-- Last update: 2024-02-12
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
  constant C_LCD_BIDIR_POLARITY : std_logic := '0';  -- LCD BIDIR Polarity for read access
  constant C_ROM_ADDR_WIDTH     : integer   := 8;    -- ROM ADDR WIDTH

  -- External Interruption Configuration
  -- (0) : SPI SLAVE
  -- (1) : KEY_1 of PR_115 board
  constant C_EXTERNAL_INTERRUPT_NB : integer := 2;  -- Number of external Interrupt


  -- == ROM Initialization ==

  -- simuart ROM
--  00000000 <_start>:
--   0: 12017f53        LDI        0xcafedec0,R2  // cafedec0 <LCD_CHAR>
--   4: 1240dec0 
--   8: 14c00000        SW         R2,($0)

  constant C_SIMUART_ROM : t_rom_32bits(0 to 2**C_ROM_ADDR_WIDTH - 1) := (
    others => x"77C00000"               -- NOOP
    );

  constant C_ROM_INIT : t_rom_32bits(0 to 2**C_ROM_ADDR_WIDTH - 1) := C_SIMUART_ROM;


  -- ZIPUART Initial setup Value
  -- Initial Setup :
  -- H = 1 == Flow ctrl disable - 0 : enable
  -- N = 00 -> 8 bits
  -- S = 0 -> 1 stop bit
  -- PFT = 000 -> No Parity
  -- CLKS = 50MHz/115200 = 434 = 0x1B2
  constant C_ZIPUART_INIT_SETUP     : std_logic_vector(30 downto 0) := "100" & x"0" & x"0001B2";  -- ZIPUART Initial Value
  constant C_ZIPUART_LGFLEN         : std_logic_vector(3 downto 0)  := x"4";                      -- ZIPUART LGFLEN FIFO SIZE log based 2 -
                                                                                                  -- MAX 10
  constant C_ZIPUART_HW_FLOW_CTRL   : std_logic_vector(0 downto 0)  := "1";  -- HW Flow Hardware enable
  constant C_ZIPUART_OPT_SKIDBUFFER : std_logic_vector(0 downto 0)  := "0";  -- ZIPUART OPT SKIDBUFFER
  constant C_ZIPUART_LOWPOWER       : std_logic_vector(0 downto 0)  := "0";  -- ZIPUART OPT LOW POWER
  constant C_OPT_USERMODE           : std_logic_vector(0 downto 0)  := "1";  -- 1 : Use user regs
  constant C_OPT_EARLY_BRANCHING    : std_logic_vector(0 downto 0)  := "1";  -- 1 : the ZipCPU may branch on an unconditional branch instruction as soon as it is recognized by the instruction decoder
  constant C_RESET_DURATION         : integer                       := 100;  -- RESET DURATION of ZIPCPU

  -- SPI MASTER Configuration
  constant C_SPI_SIZE            : integer := 4;     -- SPI SIZE
  constant C_SPI_DATA_WIDTH      : integer := 8;     -- SPI DATA WIDTH
  constant C_SPI_FIFO_DATA_WIDTH : integer := 8;     -- SPI FIFO DATA WIDTH
  constant C_FIFO_DEPTH          : integer := 1024;  -- FIFO DEPTH

  -- GPO Configuration
  constant C_GPO_WIDTH : integer := 8;  -- GPO Width

end package;
