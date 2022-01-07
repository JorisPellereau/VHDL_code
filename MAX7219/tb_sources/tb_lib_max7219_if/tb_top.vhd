-------------------------------------------------------------------------------
-- Title      : Testbench Top of MAX7219 - VHD mode (Coverage purpose)
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2021-11-28
-- Last update: 2022-01-04
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
    G_FILE_PATH           : string  := "/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT";
    G_FILE_NB             : integer := 5;
    G_TESTS_NAME          : string  := "MAX7219_IF";
    G_INJECTOR_DATA_WIDTH : integer := 18);  -- Output data width

end entity tb_top;


architecture arch_tb_top of tb_top is

  component code_coverage_injector is

    generic (
      G_FILE_NB             : integer := 1;  -- Number of file to inject
      G_FILE_PATH           : string  := "/home/";  --
      G_TESTS_NAME          : string  := "TEST_XXX";
      G_NB_CHAR_TESTS_INDEX : integer := 2;  -- Number of Character of Test index
      G_CHAR_NB_DATA_1      : integer := 5;  -- Number of Character of DATA1
      G_CHAR_NB_DATA_2      : integer := 4;  -- Number of Character of DATA2
      G_DATA_1_FORMAT       : integer := 1;  -- 0 => INTEGER - 1 => HEXA
      G_INJECTOR_DATA_WIDTH : integer := 10);       -- Output data width

    port (
      clk     : in  std_logic;
      i_en    : in  std_logic;
      o_rst_n : out std_logic;
      o_data  : out std_logic_vector(G_INJECTOR_DATA_WIDTH - 1 downto 0));

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

  i_code_coverage_injector_0 : code_coverage_injector
    generic map(
      G_FILE_NB             => G_FILE_NB,
      G_FILE_PATH           => G_FILE_PATH,
      G_TESTS_NAME          => G_TESTS_NAME,
      G_NB_CHAR_TESTS_INDEX => 2,
      G_CHAR_NB_DATA_1      => 5,       -- Number of Character of DATA1
      G_CHAR_NB_DATA_2      => 4,       -- Number of Character of DATA2
      G_DATA_1_FORMAT       => 1,       -- 0 => INTEGER - 1 => HEXA
      G_INJECTOR_DATA_WIDTH => G_INJECTOR_DATA_WIDTH)  -- Output data width
    port map(
      clk     => clk,
      i_en    => s_en,
      o_rst_n => rst_n,
      o_data  => s_data);



  -- Limitation : process and combinationnal affectation must be placed after
  -- component instantiation /!\


  -- Connect Code Coverage injector to input of DUT
  --rst_n                <= s_data(18);
  -- s_max7219_if_start   <= s_data(17);
  -- s_max7219_if_en_load <= s_data(16);
  -- s_max7219_if_data    <= s_data(15 downto 0);

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

  s_max7219_if_start   <= s_data(17);
  s_max7219_if_en_load <= s_data(16);
  s_max7219_if_data    <= s_data(15 downto 0);

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


  p_en_code_injector : process
  begin  -- process p_en_code_injector
    s_en <= '0';
    wait for 100 ns;
    s_en <= '1';
    DISPLAY_MESSAGE("Enable Code Coverage Injector");
    DISPLAY_MESSAGE("");
    wait;
  end process p_en_code_injector;

end architecture arch_tb_top;
