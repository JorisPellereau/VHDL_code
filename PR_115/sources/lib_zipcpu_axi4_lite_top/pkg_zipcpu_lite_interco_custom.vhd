-------------------------------------------------------------------------------
-- Title      : Custom Package of the Interconnect
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_axi4_lite_interco_custom.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-19
-- Last update: 2023-09-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Custom Package of the Interconnect.
-- THIS FILE MUST BE EDITED 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-19  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pkg_axi4_lite_interco_cutom is

  -- == CONSTANTS ==
  constant C_AXI_ADDR_WIDTH : integer := 16;  -- AXI ADDR WIDTH
  constant C_AXI_DATA_WIDTH : integer := 32;  -- AXI DATA WIDTH

  constant C_SLAVE_NB : integer := 2;   -- Number of Slave

  -- == TYPES ==
  type t_slv_addr is array (0 to C_SLAVE_NB - 1) of std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0);  -- Array of Slave Addr



  constant C_BASE_ADDR_SLAVE_0 : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"0000";  -- SLAVE 0 Base Addr
  constant C_BASE_ADDR_SLAVE_1 : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"1000";  -- SLAVE 1 Base Addr
  constant C_SLAVE_ADDR_RANGE  : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"0FFF";  -- ADDR Range

  -- Slave Addr MIN
  constant C_SLV_ADDR_MIN_ARRAY : t_slv_addr := (0 => C_BASE_ADDR_SLAVE_0,
                                                 1 => C_BASE_ADDR_SLAVE_1
                                                 );

  -- Slave Addr MAX
  constant C_SLV_ADDR_MAX_ARRAY : t_slv_addr := (0 => std_logic_vector(unsigned(C_BASE_ADDR_SLAVE_0) + unsigned(C_SLAVE_ADDR_RANGE)),
                                                 1 => std_logic_vector(unsigned(C_BASE_ADDR_SLAVE_1) + unsigned(C_SLAVE_ADDR_RANGE))
                                                 );

end package;

