-------------------------------------------------------------------------------
-- Title      : VHDL TOP Testbench
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_top.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-06-07
-- Last update: 2022-03-13
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

library lib_max7219_interface;
use lib_max7219_interface.pkg_max7219_interface.all;

library lib_max7219_scroller;
use lib_max7219_scroller.pkg_max7219_scroller.all;

library lib_code_coverage;
use lib_code_coverage.pkg_code_coverage.all;

library lib_max7219_controller;
use lib_max7219_controller.pkg_max7219_controller.all;

entity tb_top is
  generic (
    G_FILE_PATH           : string  := "/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT";
    G_FILE_NB             : integer := 5;
    G_TESTS_NAME          : string  := "MAX7219_CONTROLLER";
    G_INJECTOR_DATA_WIDTH : integer := 146);  -- Output data width

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

  -- DUT Signals

  signal s_static_dyn             : std_logic := '0';
  signal s_new_display            : std_logic := '0';
  signal s_display_test           : std_logic := '0';
  signal s_decod_mode             : std_logic_vector(7 downto 0) := (others => '0');
  signal s_intensity              : std_logic_vector(7 downto 0) := (others => '0');
  signal s_scan_limit             : std_logic_vector(7 downto 0) := (others => '0');
  signal s_shutdown               : std_logic_vector(7 downto 0) := (others => '0');
  signal s_new_config_val         : std_logic := '0';
  signal s_config_done            : std_logic := '0';
  signal s_en_static              : std_logic := '0';
  signal s_me_static              : std_logic := '0';
  signal s_we_static              : std_logic := '0';
  signal s_addr_static            : std_logic_vector(7 downto 0) := (others => '0');
  signal s_wdata_static           : std_logic_vector(15 downto 0) := (others => '0');
  signal s_rdata_static           : std_logic_vector(15 downto 0) := (others => '0');
  signal s_start_ptr_static       : std_logic_vector(7 downto 0) := (others => '0');
  signal s_last_ptr_static        : std_logic_vector(7 downto 0) := (others => '0');
  signal s_loop_static            : std_logic := '0';
  signal s_ptr_equality_static    : std_logic := '0';
  signal s_static_busy            : std_logic := '0';
  signal s_ram_start_ptr_scroller : std_logic_vector(7 downto 0) := (others => '0');
  signal s_msg_length_scroller    : std_logic_vector(7 downto 0) := (others => '0');
  signal s_max_tempo_cnt_scroller : std_logic_vector(31 downto 0) := (others => '0');
  signal s_scroller_busy          : std_logic := '0';
  signal s_me_scroller            : std_logic := '0';
  signal s_we_scroller            : std_logic := '0';
  signal s_addr_scroller          : std_logic_vector(7 downto 0) := (others => '0');
  signal s_wdata_scroller         : std_logic_vector(7 downto 0) := (others => '0');
  signal s_rdata_scroller         : std_logic_vector(7 downto 0) := (others => '0');
  signal s_max7219_load           : std_logic := '0';
  signal s_max7219_data           : std_logic := '0';
  signal s_max7219_clk            : std_logic := '0';

  -- Code Coverage injector signals
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
      G_CHAR_NB_DATA_1      => 40,      -- Number of Character of DATA1
      G_CHAR_NB_DATA_2      => 8,       -- Number of Character of DATA2
      G_DATA_1_FORMAT       => 1,       -- 0 => INTEGER - 1 => HEXA
      G_INJECTOR_DATA_WIDTH => G_INJECTOR_DATA_WIDTH)  -- Output data width
    port map(
      clk     => clk,
      i_en    => s_en,
      o_rst_n => rst_n,
      o_data  => s_data);


  -- Affectation of signals
  s_static_dyn             <= s_data(145);
  s_new_display            <= s_data(145);
  s_display_test           <= s_data(143);
  s_decod_mode             <= s_data(142 downto 135);
  s_intensity              <= s_data(134 downto 127);
  s_scan_limit             <= s_data(126 downto 119);
  s_shutdown               <= s_data(118 downto 111);
  s_new_config_val         <= s_data(110);
  s_en_static              <= s_data(109);
  s_me_static              <= s_data(108);
  s_we_static              <= s_data(107);
  s_addr_static            <= s_data(106 downto 99);
  s_wdata_static           <= s_data(98 downto 83);
  s_start_ptr_static       <= s_data(82 downto 75);
  s_last_ptr_static        <= s_data(74 downto 67);
  s_loop_static            <= s_data(66);
  s_ram_start_ptr_scroller <= s_data(65 downto 58);
  s_msg_length_scroller    <= s_data(57 downto 50);
  s_max_tempo_cnt_scroller <= s_data(49 downto 18);
  s_me_scroller            <= s_data(17);
  s_we_scroller            <= s_data(16);
  s_addr_scroller          <= s_data(15 downto 8);
  s_wdata_scroller         <= s_data(7 downto 0);


  i_max7219_display_controller_0 : max7219_display_controller
    generic map (
      G_MATRIX_NB => 8,

      -- MAX7219 I/F GENERICS
      G_MAX_HALF_PERIOD => 4,
      G_LOAD_DURATION   => 4,

      -- MAX7219 STATIC CTRL GENERICS
      G_RAM_ADDR_WIDTH_STATIC => 8,
      G_RAM_DATA_WIDTH_STATIC => 16,
      G_DECOD_MAX_CNT_32B     => x"02FAF080",

      -- MAX7219 SCROLLER CTRL GENERICS
      G_RAM_ADDR_WIDTH_SCROLLER => 8,
      G_RAM_DATA_WIDTH_SCROLLER => 8)

    port map (
      clk   => clk,
      rst_n => rst_n,

      -- SELECTION
      i_static_dyn  => s_static_dyn,
      i_new_display => s_new_display,

      -- MATRIX CONFIG.
      i_display_test   => s_display_test,
      i_decod_mode     => s_decod_mode,
      i_intensity      => s_intensity,
      i_scan_limit     => s_scan_limit,
      i_shutdown       => s_shutdown,
      i_new_config_val => s_new_config_val,
      o_config_done    => s_config_done,

      -- STATIC DISPLAY I/O    
      i_en_static => s_en_static,

      -- RAM Statics I/F
      i_me_static    => s_me_static,
      i_we_static    => s_we_static,
      i_addr_static  => s_addr_static,
      i_wdata_static => s_wdata_static,
      o_rdata_static => s_rdata_static,

      -- RAM INFO.
      i_start_ptr_static    => s_start_ptr_static,
      i_last_ptr_static     => s_last_ptr_static,
      i_loop_static         => s_loop_static,
      o_ptr_equality_static => s_ptr_equality_static,
      o_static_busy         => s_static_busy,

      -- SCROLLER I/O
      -- RAM Commands
      i_ram_start_ptr_scroller => s_ram_start_ptr_scroller,
      i_msg_length_scroller    => s_msg_length_scroller,
      i_max_tempo_cnt_scroller => s_max_tempo_cnt_scroller,
      o_scroller_busy          => s_scroller_busy,

      -- RAM SCROLLER I/F
      i_me_scroller    => s_me_scroller,
      i_we_scroller    => s_we_scroller,
      i_addr_scroller  => s_addr_scroller,
      i_wdata_scroller => s_wdata_scroller,
      o_rdata_scroller => s_rdata_scroller,


      -- MAX7219 OUTPUTS
      o_max7219_load => s_max7219_load,
      o_max7219_data => s_max7219_data,
      o_max7219_clk  => s_max7219_clk

      );

end architecture arch_tb_top;
