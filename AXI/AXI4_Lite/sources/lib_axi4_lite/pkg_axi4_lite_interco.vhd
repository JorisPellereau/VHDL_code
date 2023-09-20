-------------------------------------------------------------------------------
-- Title      : Package AXI4 Lite Interconnect
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_axi4_lite_interco.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-19
-- Last update: 2023-09-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Package for AXI4 Lite Interconnect
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

library lib_axi4_lite;
use lib_axi4_lite.pkg_axi4_lite_interco_cutom.all;

package pkg_axi4_lite_interco is

  -- == TYPES ==
  type t_addr_array is array (natural range <>) of std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0);  -- AR/AWADDR Array

  type t_data_array is array(natural range <>) of std_logic_vector(C_AXI_DATA_WIDTH - 1 downto 0);  -- DATA Array

  type t_wstrb_array is array(natural range <>) of std_logic_vector((C_AXI_DATA_WIDTH/8) - 1 downto 0);  -- WSTRB Array

  type t_prot_array is array(natural range <>) of std_logic_vector(2 downto 0);  -- PROT ARRAY

  type t_resp_array is array(natural range <>) of std_logic_vector(1 downto 0);  -- REST Array

end package;
