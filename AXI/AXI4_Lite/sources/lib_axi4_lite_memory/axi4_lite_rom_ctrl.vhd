-------------------------------------------------------------------------------
-- Title      : AXI4 Lite Rom Controler
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_rom_ctrl.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-28
-- Last update: 2023-09-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Lite ROM Controler
-- A Rom controller interfaced with the axi4_lite_slave_intf and used in order to read data from a ROM
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-28  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity axi4_lite_rom_ctrl is

  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer := 32;  -- Addr Width
    G_AXI4_LITE_DATA_WIDTH : integer := 32;  -- Data Width
    G_ROM_ADDR_WIDTH       : integer := 8    -- ROM ADDR WIDTH
    );
  port (
    clk_sys   : in std_logic;                -- Clock System
    rst_n_sys : in std_logic;                -- Asynchronous Reset

    -- Slave Interface
    slv_start : in  std_logic;                                              -- Slave start access
    slv_rw    : in  std_logic;                                              -- Slave RNW
    slv_addr  : in  std_logic;                                              -- Slave Addr
    done      : out std_logic;                                              -- Access done
    rdata     : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read data from ROM
    status    : out std_logic_vector(1 downto 0);                           -- Status

    -- Rom Interface
    addr_rom  : out std_logic_vector(G_ROM_ADDR_WIDTH - 1 downto 0);       -- ROM ADDR
    rom_rdata : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0)  -- Rom Rdata
    );

end entity axi4_lite_rom_ctrl;

architecture rtl of axi4_lite_rom_ctrl is

  -- == INERNAL Signals ==
  signal slv_start_p1 : std_logic;      -- Slave Start Pipe one time
  signal slv_start_p2 : std_logic;      -- Slave Start Pipe one time

begin  -- architecture rtl

  -- purpose: Addr Rom Management
  p_addr_rom_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_addr_rom_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      addr_rom <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      if(slv_start = '1') then
        addr_rom <= slv_addr(G_AXI4_LITE_ADDR_WIDTH downto log2(G_AXI4_LITE_ADDR_WIDTH/8));
      end if;

    end if;
  end process p_addr_rom_mngt;

  -- purpose: Slave Start Piped
-- Pipe slave start in order to generate the done signal
  p_slv_start_pipes : process (clk_sys, rst_n_sys) is
  begin  -- process p_slv_start_pipes
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      slv_start_p1 <= '0';
      slv_start_p2 <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      slv_start_p1 <= slv_start;
      slv_start_p2 <= slv_start_p1;
    end if;
  end process p_slv_start_pipes;

  -- Outputs Affectation
  done   <= slv_start_p2;
  status <= (others => '0');            -- No Error
  rdata  <= rom_rdata;

end architecture rtl;
