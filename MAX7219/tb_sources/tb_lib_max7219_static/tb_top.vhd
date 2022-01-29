-------------------------------------------------------------------------------
-- Title      : Testbench Top of MAX7219 STATIC - VHD mode (Coverage purpose)
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2021-11-28
-- Last update: 2022-01-29
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

library lib_max7219_static;
use lib_max7219_static.pkg_max7219_static.all;

library lib_code_coverage;
use lib_code_coverage.pkg_code_coverage.all;

entity tb_top is
  generic (
    G_FILE_PATH           : string  := "/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT";
    G_FILE_NB             : integer := 5;
    G_TESTS_NAME          : string  := "MAX7219_STATIC";
    G_INJECTOR_DATA_WIDTH : integer := 45);  -- Output data width

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

  signal s_max7219_cmd_decod_en : std_logic;
  signal s_me                   : std_logic;
  signal s_we                   : std_logic;
  signal s_addr                 : std_logic_vector(7 downto 0);
  signal s_wdata                : std_logic_vector(15 downto 0);
  signal s_rdata                : std_logic_vector(15 downto 0);
  signal s_start_ptr            : std_logic_vector(7 downto 0);
  signal s_last_ptr             : std_logic_vector(7 downto 0);
  signal s_ptr_val              : std_logic;
  signal s_loop                 : std_logic;
  signal s_ptr_equality         : std_logic;
  signal s_discard              : std_logic;

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
      G_CHAR_NB_DATA_1      => 16,      -- Number of Character of DATA1
      G_CHAR_NB_DATA_2      => 4,       -- Number of Character of DATA2
      G_DATA_1_FORMAT       => 1,       -- 0 => INTEGER - 1 => HEXA
      G_INJECTOR_DATA_WIDTH => G_INJECTOR_DATA_WIDTH)  -- Output data width
    port map(
      clk     => clk,
      i_en    => s_en,
      o_rst_n => rst_n,
      o_data  => s_data);





  i_max7219_cmd_decod_0 : max7219_cmd_decod
    generic map(
      G_RAM_ADDR_WIDTH    => 8,
      G_RAM_DATA_WIDTH    => 16,
      G_DECOD_MAX_CNT_32B => x"00000064")
    port map (

      clk   => clk,
      rst_n => rst_n,

      i_en => s_max7219_cmd_decod_en,

      i_me    => s_me,
      i_we    => s_we,
      i_addr  => s_addr,
      i_wdata => s_wdata,
      o_rdata => s_rdata,

      i_start_ptr    => s_start_ptr,
      i_last_ptr     => s_last_ptr,
      i_ptr_val      => s_ptr_val,
      i_loop         => s_loop,
      o_ptr_equality => s_ptr_equality,
      o_discard      => s_discard,

      i_max7219_if_done    => s_max7219_if_done,
      o_max7219_if_start   => s_max7219_start,
      o_max7219_if_en_load => s_max7219_if_en_load,
      o_max7219_if_data    => s_max7219_if_data
      );


  -- DATA affectation
  s_start_ptr            <= s_data(44 downto 37);
  s_last_ptr             <= s_data(36 downto 29);
  s_ptr_val              <= s_data(28);
  s_loop                 <= s_data(27);
  s_me                   <= s_data(26);
  s_we                   <= s_data(25);
  s_addr                 <= s_data(24 downto 17);
  s_wdata                <= s_data(16 downto 1);
  s_max7219_cmd_decod_en <= s_data(0);


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
