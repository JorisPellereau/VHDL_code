-------------------------------------------------------------------------------
-- Title      : Single Port ROM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : sp_rom.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-28
-- Last update: 2023-10-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Single Port ROM for Intel FPGA description
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-28  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_rom_intel;
use lib_rom_intel.pkg_sp_rom.all;

entity sp_rom is
  generic(
    G_ADDR_WIDTH : integer                := 16;               -- ROM Addr width
    G_DATA_WIDTH : integer range 32 to 32 := 32;               -- ROM Data width
    G_ROM_INIT   : t_rom_32bits                                -- ROM Initialization
    );
  port (
    clk    : in  std_logic;                                    -- Clock ROM
    addr_a : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Addr port A
    q_a    : out std_logic_vector(G_DATA_WIDTH - 1 downto 0)   -- Data out port A
    );

end entity sp_rom;

architecture rtl of sp_rom is

  -- == INTERNAL Signals ==
  signal rom : t_rom_32bits(0 to 2**G_ADDR_WIDTH - 1) := G_ROM_INIT;  -- ROM

begin  -- architecture rtl

  p_rom_access : process (clk)

  begin
    if(rising_edge(clk)) then
      q_a <= rom(to_integer(unsigned(addr_a)));
    end if;
  end process;


end architecture rtl;
