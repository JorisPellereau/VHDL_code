-------------------------------------------------------------------------------
-- Title      : Testbench Top of MAX7219 SCROLLER - VHD mode (Coverage purpose)
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2021-11-28
-- Last update: 2022-02-27
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

library lib_max7219_scroller;
use lib_max7219_scroller.pkg_max7219_scroller.all;

library lib_code_coverage;
use lib_code_coverage.pkg_code_coverage.all;

entity tb_top is
  generic (
    G_FILE_PATH           : string  := "/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT";
    G_FILE_NB             : integer := 6;
    G_TESTS_NAME          : string  := "MAX7219_SCROLLER";
    G_INJECTOR_DATA_WIDTH : integer := 67);  -- Output data width

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

  -- component max7219_cmd_decod is
  --   generic (
  --     G_RAM_ADDR_WIDTH    : integer                       := 8;  -- RAM ADDR WIDTH
  --     G_RAM_DATA_WIDTH    : integer                       := 16;  -- RAM DATA WIDTH
  --     G_DECOD_MAX_CNT_32B : std_logic_vector(31 downto 0) := x"02FAF080");
  --   port (
  --     --# {{clocks|Clock and Reset}}    
  --     clk   : in std_logic;             -- Clock
  --     rst_n : in std_logic;             -- Asynchronous reset

  --     --# {{Enable}}
  --     i_en : in std_logic;              -- Enable the Function

  --     --# {{RAM I/F}}
  --     i_me    : in  std_logic;          -- Memory Enable
  --     i_we    : in  std_logic;          -- W/R command
  --     i_addr  : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
  --     i_wdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM WDATA
  --     o_rdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

  --     --# {{Control Signals}}
  --     i_start_ptr    : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- ST PTR
  --     i_last_ptr     : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST ADDR
  --     i_ptr_val      : in  std_logic;   -- PTRS VALIDS
  --     i_loop         : in  std_logic;   -- LOOP CONFIG.
  --     o_ptr_equality : out std_logic;   -- ADDR = LAST PTR
  --     o_discard      : out std_logic;   -- Start of pattern discard

  --     --# {{MAX7219_if I/F}}
  --     i_max7219_if_done    : in  std_logic;  -- MAX7219 IF Done
  --     o_max7219_if_start   : out std_logic;
  --     o_max7219_if_en_load : out std_logic;
  --     o_max7219_if_data    : out std_logic_vector(15 downto 0));
  -- end component;


  -- INTERNAL SIGNALS
  signal clk   : std_logic := '0';
  signal rst_n : std_logic;


  signal s_me_dut    : std_logic;
  signal s_we_dut    : std_logic;
  signal s_addr_dut  : std_logic_vector(7 downto 0);
  signal s_wdata_dut : std_logic_vector(7 downto 0);
  signal s_rdata_dut : std_logic_vector(7 downto 0);

  signal s_ram_start_ptr : std_logic_vector(7 downto 0);
  signal s_msg_length    : std_logic_vector(7 downto 0);
  signal s_start_scroll  : std_logic;
  signal s_max_tempo_cnt : std_logic_vector(31 downto 0);

  signal s_busy : std_logic;


  signal s_max7219_if_done    : std_logic;
  signal s_max7219_start      : std_logic;
  signal s_max7219_if_en_load : std_logic;
  signal s_max7219_if_data    : std_logic_vector(15 downto 0);

  signal s_max7219_clk  : std_logic;
  signal s_max7219_data : std_logic;
  signal s_max7219_load : std_logic;

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
      G_CHAR_NB_DATA_1      => 24,      -- Number of Character of DATA1
      G_CHAR_NB_DATA_2      => 8,       -- Number of Character of DATA2
      G_DATA_1_FORMAT       => 1,       -- 0 => INTEGER - 1 => HEXA
      G_INJECTOR_DATA_WIDTH => G_INJECTOR_DATA_WIDTH)  -- Output data width
    port map(
      clk     => clk,
      i_en    => s_en,
      o_rst_n => rst_n,
      o_data  => s_data);


  -- == DUT INST ==
  i_max7219_scroller_ctrl_0 : max7219_scroller_ctrl

    generic map (
      G_MATRIX_NB      => 8,
      G_RAM_ADDR_WIDTH => 8,
      G_RAM_DATA_WIDTH => 8)

    port map (
      clk   => clk,
      rst_n => rst_n,

      i_me    => s_me_dut,
      i_we    => s_we_dut,
      i_addr  => s_addr_dut,
      i_wdata => s_wdata_dut,
      o_rdata => s_rdata_dut,

      i_ram_start_ptr => s_ram_start_ptr,
      i_msg_length    => s_msg_length,
      i_start_scroll  => s_start_scroll,
      i_max_tempo_cnt => s_max_tempo_cnt,

      i_max7219_if_done    => s_max7219_if_done,
      o_max7219_if_start   => s_max7219_start,
      o_max7219_if_en_load => s_max7219_if_en_load,
      o_max7219_if_data    => s_max7219_if_data,

      o_busy => s_busy
      );




  -- DATA affectation
  s_ram_start_ptr <= s_data(66 downto 59);
  s_msg_length    <= s_data(58 downto 51);
  s_start_scroll  <= s_data(50);
  s_max_tempo_cnt <= s_data(49 downto 18);
  s_me_dut        <= s_data(17);
  s_we_dut        <= s_data(16);
  s_addr_dut      <= s_data(15 downto 8);
  s_wdata_dut     <= s_data(7 downto 0);


  -- == MAX7219 IF INST ==
  i_max7219_if_0 : max7219_if
    generic map (
      G_MAX_HALF_PERIOD => 4,
      G_LOAD_DURATION   => 4
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      i_start   => s_max7219_start,
      i_en_load => s_max7219_if_en_load,
      i_data    => s_max7219_if_data,

      o_max7219_load => s_max7219_load,
      o_max7219_data => s_max7219_data,
      o_max7219_clk  => s_max7219_clk,
      o_done         => s_max7219_if_done
      );

end architecture arch_tb_top;
