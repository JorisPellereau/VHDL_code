-------------------------------------------------------------------------------
-- Title      : Testbench Top of MAX7219 - VHD mode (Coverage purpose)
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2021-11-28
-- Last update: 2021-12-05
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
use lib_max7219_interface.pkg_max7219_interface.all;

library lib_code_coverage;
use lib_code_coverage.pkg_code_coverage.all;

entity tb_top is
  generic (
    G_FILE_PATH           : string  := "INPUT_FILE.txt";
    G_INJECTOR_DATA_WIDTH : integer := 10);  -- Output data width

end entity tb_top;


architecture arch_tb_top of tb_top is

  component code_coverage_injector is

    generic (
      G_FILE_PATH           : string  := "INPUT_FILE.txt";
      G_INJECTOR_DATA_WIDTH : integer := 10);  -- Output data width

    port (
      clk    : in  std_logic;
      i_en   : in  std_logic;
      o_data : out std_logic_vector(G_INJECTOR_DATA_WIDTH - 1 downto 0));

  end component;

  -- INTERNAL SIGNALS
  signal clk                  : std_logic := '0';
  signal rst_n                : std_logic;
  signal s_max7219_if_start   : std_logic;
  signal s_max7219_if_en_load : std_logic;
  signal s_max7219_if_data    : std_logic_vector(15 downto 0);
  signal s_max7219_load       : std_logic;
  signal s_max7219_data       : std_logic;
  signal s_max7219_clk        : std_logic;
  signal s_max7219_if_done    : std_logic;

  signal s_en   : std_logic := '0';     -- Code Coverage Enable
  signal s_data : std_logic_vector(G_INJECTOR_DATA_WIDTH - 1 downto 0);

begin  -- architecture arch_tb_top


  -- == Clock Generation ==
  -- purpose: Clock Maagement
  -- type   : combinational
  -- inputs : 
  -- outputs: 
  p_clk_mngt : process is
  begin  -- process p_clk_mngt
    clk <= not clk;
    wait for 10 ns;
  end process p_clk_mngt;
  -- ======================

  p_en_code_injector : process is
  begin  -- process p_en_code_injector
    s_en <= '0';
    wait for 100 ns;    
    s_en <= '1';
    DISPLAY_MESSAGE("Enable Code Coverage Injector");
    DISPLAY_MESSAGE("");
    wait;
  end process p_en_code_injector;


  i_code_coverage_injector_0 : code_coverage_injector
    generic map(
      G_FILE_PATH           => G_FILE_PATH,
      G_INJECTOR_DATA_WIDTH => G_INJECTOR_DATA_WIDTH)  -- Output data width
    port map(
      clk    => clk,
      i_en   => s_en,
      o_data => s_data);


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
