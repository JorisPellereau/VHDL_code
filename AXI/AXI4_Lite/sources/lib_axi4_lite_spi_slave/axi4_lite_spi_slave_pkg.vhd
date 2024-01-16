-------------------------------------------------------------------------------
-- Title      : Package of the SPI MASTER AXI4 Lite
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_spi_master_pkg.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-17
-- Last update: 2024-01-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-17  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package axi4_lite_spi_slave_pkg is

  -- == CONSTANTS ==
  constant C_NB_REG        : integer := 2;  -- Number of Register
  constant C_USEFUL_LSBITS : integer := 4;  -- 4 LSBITS of usefull addr

  constant C_REG0_ADDR : std_logic_vector(C_USEFUL_LSBITS - 1 downto 0) := x"0";  -- REG0 ADDR
  constant C_REG1_ADDR : std_logic_vector(C_USEFUL_LSBITS - 1 downto 0) := x"4";  -- REG1 ADDR

  -- Register Index (32bits wide)
  constant C_REG0_IDX : integer := 0;   -- Index number of REG 0
  constant C_REG1_IDX : integer := 1;   -- Index number of REG 1

  constant C_FIFO_RX_WIDTH : integer := 32;  -- Width of the FIFO RX Register
  constant C_STATUS_WIDTH  : integer := 17;  -- Width of the Status Register

end package;
