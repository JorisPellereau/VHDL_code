-------------------------------------------------------------------------------
-- Title      : Testbench Top of MAX7219 - VHD mode (Coverage purpose)
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2021-11-28
-- Last update: 2021-11-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-11-28  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_max7219_interface;
use lib_max729_interface.pkg_max7219_interface.all;

entity tb_top is

end entity tb_top;


architecture arch_tb_top of tb_top is

  -- INTERNAL SIGNALS
  signal clk                  : std_logic;
  signal rst_n                : std_logic;
  signal s_max7219_if_start   : std_logic;
  signal s_max7219_if_en_load : std_logic;
  signal s_max7219_if_data    : std_logic_vector(15 downto 0);
  signal s_max7219_load       : std_logic;
  signal s_max7219_data       : std_logic;
  signal s_max7219_clk        : std_logic;
  signal s_max7219_if_done    : std_logic;

begin  -- architecture arch_tb_top


  -- MAX7219 I/F INST
  max7219_if_inst_0 : max7219_if
    generic map (
      G_MAX_HALF_PERIOD => 4,
      G_LOAD_DURATION   => 4
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      -- Input commands
      i_start   => s_max7219_if_start,
      i_en_load => s_max7219_if_en_load,
      i_data    => s_max7219_if_data,

      o_max7219_load => s_max7219_load,
      o_max7219_data => s_max7219_data,
      o_max7219_clk  => s_max7219_clk,

      -- Transaction Done
      o_done => s_max7219_if_done);



end architecture arch_tb_top;
