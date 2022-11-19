-------------------------------------------------------------------------------
-- Title      : VHDL TOP Testbench for GHDL coverage
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_top.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-06-07
-- Last update: 2022-05-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-06-07  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_uart;
use lib_uart.pkg_uart.all;

library lib_uart_display_ctrl;
use lib_uart_display_ctrl.pkg_uart_max7219_display_ctrl.all;

library lib_code_coverage;
use lib_code_coverage.pkg_code_coverage.all;

entity tb_top is
  generic (
    G_FILE_PATH           : string  := "/home/linux-jp/SIMULATION_VHDL/UART_COLLECT";
    G_FILE_NB             : integer := 8;
    G_TESTS_NAME          : string  := "UART_DISPLAY_CTRL";
    G_INJECTOR_DATA_WIDTH : integer := 1);  -- Output data width

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
  signal clk   : std_logic := '0';
  signal rst_n : std_logic;

  -- Code Coverage injector signals
  signal s_en   : std_logic                                            := '0';  -- Code Coverage Enable
  signal s_data : std_logic_vector(G_INJECTOR_DATA_WIDTH - 1 downto 0) := (others => '0');

  -- DUT Signals
  signal s_tx_uart      : std_logic := '0';
  signal s_rx_uart      : std_logic;
  signal s_max7219_load : std_logic;
  signal s_max7219_data : std_logic;
  signal s_max7219_clk  : std_logic;

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

  p_en_code_injector : process
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
      G_FILE_NB             => G_FILE_NB,
      G_FILE_PATH           => G_FILE_PATH,
      G_TESTS_NAME          => G_TESTS_NAME,
      G_NB_CHAR_TESTS_INDEX => 2,
      G_CHAR_NB_DATA_1      => 8,      -- Number of Character of DATA1
      G_CHAR_NB_DATA_2      => 8,       -- Number of Character of DATA2
      G_DATA_1_FORMAT       => 1,       -- 0 => INTEGER - 1 => HEXA
      G_INJECTOR_DATA_WIDTH => G_INJECTOR_DATA_WIDTH)  -- Output data width
    port map(
      clk     => clk,
      i_en    => s_en,
      o_rst_n => rst_n,
      o_data  => s_data);

  -- Signal Affectations

  s_tx_uart <= s_data(0);

  i_dut : uart_max7219_display_ctrl_wrapper
    generic map(
      G_STOP_BIT_NUMBER => 1,
      G_PARITY          => none,
      G_BAUDRATE        => b230400,
      G_UART_DATA_SIZE  => 8,
      G_POLARITY        => '1',
      G_FIRST_BIT       => lsb_first,
      G_CLOCK_FREQUENCY => 50000000,

      G_MATRIX_NB               => 8,
      G_RAM_ADDR_WIDTH_STATIC   => 8,
      G_RAM_DATA_WIDTH_STATIC   => 16,
      G_RAM_ADDR_WIDTH_SCROLLER => 8,
      G_RAM_DATA_WIDTH_SCROLLER => 8,

      G_MAX_HALF_PERIOD => 4,
      G_LOAD_DURATION   => 4,

      G_DECOD_MAX_CNT_32B => x"02FAF080"
      )

    port map(
      clk   => clk,
      rst_n => rst_n,

      i_rx => s_tx_uart,
      o_tx => s_rx_uart,

      o_max7219_load => s_max7219_load,
      o_max7219_data => s_max7219_data,
      o_max7219_clk  => s_max7219_clk
      );

end architecture arch_tb_top;
