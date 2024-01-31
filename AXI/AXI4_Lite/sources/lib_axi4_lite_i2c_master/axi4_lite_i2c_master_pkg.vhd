-------------------------------------------------------------------------------
-- Title      : I2C Master AXI4 Lite Package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_i2c_master_pkg.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-31
-- Last update: 2024-01-31
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-31  1.0      linux-jp	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package axi4_lite_i2c_master_pkg is

  -- == CONSTANTS ==
  constant C_NB_REG : integer := 4;     -- Number of Register

  constant C_USEFUL_LSBITS : integer := 4;  -- 5 LSBITS of usefull addr

  constant C_REG0_ADDR : std_logic_vector(C_USEFUL_LSBITS - 1 downto 0) :=   x"0";  -- REG0 ADDR
  constant C_REG1_ADDR : std_logic_vector(C_USEFUL_LSBITS - 1 downto 0) :=   x"4";  -- REG1 ADDR
  constant C_REG2_ADDR : std_logic_vector(C_USEFUL_LSBITS - 1 downto 0) :=   x"8";  -- REG2 ADDR
  constant C_REG3_ADDR : std_logic_vector(C_USEFUL_LSBITS - 1 downto 0) :=   x"C";  -- REG3 ADDR

  -- Register Index (32bits wide)
  constant C_REG0_IDX : integer := 0;   -- Index number of REG 0
  constant C_REG1_IDX : integer := 1;   -- Index number of REG 1
  constant C_REG2_IDX : integer := 2;   -- Index number of REG 2
  constant C_REG3_IDX : integer := 3;   -- Index number of REG 3

  constant C_CTRL0_WIDTH   : integer := 32;  -- Width of the CTRL0 register
  constant C_FIFO_TX_WIDTH : integer := 32;  -- Width of the FIFO TX Register
  constant C_FIFO_RX_WIDTH : integer := 32;  -- Width of the FIFO RX Register
  constant C_STATUS_WIDTH  : integer := 18;  -- Width of the Status Register

  -- REgister Initial Values
  constant C_REG1_INIT_VALUE : std_logic_vector(C_CTRL1_WIDTH - 1 downto 0) := x"00010000";  -- One Write initialized by default

end package;
