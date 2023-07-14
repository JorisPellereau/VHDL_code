-------------------------------------------------------------------------------
-- Title      : OSVVM AXI4 Manager Package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_osvvm_axi4_manager.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-03-11
-- Last update: 2023-03-11
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:  OSVVM AXI4 Manager Package & Procedure
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-03-11  1.0      linux-jp	Created
-------------------------------------------------------------------------------


library tb_lib_osvvm_axi4lite;
use tb_lib_osvvm_axi4lite.Axi4OptionsPkg.all;
use tb_lib_osvvm_axi4lite.Axi4ModelPkg.all;
use tb_lib_osvvm_axi4lite.Axi4InterfaceCommonPkg.all;
use tb_lib_osvvm_axi4lite.Axi4LiteInterfacePkg.all;
use tb_lib_osvvm_axi4lite.Axi4CommonPkg.all;


package pkg_osvvm_axi4_manager is

  -- == CONSTANTS ==
  constant C_AXI4_MANAGER_OPTIONS_NB : integer := 13;  -- Number of AXI4 MAnager Options
  type t_axi4_manager_options is array (0 to C_AXI4_MANAGER_OPTIONS_NB - 1) of integer;  -- Array of integer for AXI4 Manager configuration

  -- AXI4 Manager Configuration
  

end package pkg_osvvm_axi4_manager;
