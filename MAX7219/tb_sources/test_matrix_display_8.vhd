-------------------------------------------------------------------------------
-- Title      : Test of MATRIX DISPLAY 8 Matrix
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_type.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-18
-- Last update: 2020-07-18
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-18  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity test_matrix_display_8 is

end entity test_matrix_display_8;

architecture behv of test_matrix_display_8 is

  -- TYPE
  type t_matrix_line_array is array (0 to 7) of std_logic_vector(8*8 - 1 downto 0);
  -- COMPONENTS
  component max7219_emul is
    generic(
      G_MATRIX_I : integer := 0
      );
    port (
      clk               : in  std_logic;
      rst_n             : in  std_logic;
      i_max7219_clk     : in  std_logic;
      i_max7219_din     : in  std_logic;
      i_max7219_load    : in  std_logic;
      o_max7219_dout    : out std_logic;
      o_matrix_char     : out t_matrix_line_array;
      o_matrix_char_val : out std_logic);

  end component max7219_emul;

  component max7219_matrix_emul is
    generic (
      G_MATRIX_NB : integer                      := 2;
      G_VERBOSE   : std_logic_vector(7 downto 0) := x"FF");
    port (
      clk            : in std_logic;
      rst_n          : in std_logic;
      i_max7219_clk  : in std_logic;
      i_max7219_din  : in std_logic;
      i_max7219_load : in std_logic);

  end component max7219_matrix_emul;

  -- COMPONENT
  component top_max7219_matrix_display is
    generic (
      G_MAX_CNT                    : std_logic_vector(31 downto 0) := x"02FAF080";
      G_DIGITS_NB                  : integer range 2 to 8          := 8;  -- DIGIT NB on THE MATRIX DISPLAY
      G_DATA_WIDTH                 : integer                       := 32;  -- INPUTS SCORE WIDTH
      G_RAM_ADDR_WIDTH             : integer                       := 8;  -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH             : integer                       := 16;  -- RAM DATA WIDTH
      G_DECOD_MAX_CNT_32B          : std_logic_vector(31 downto 0) := x"02FAF080";
      G_MAX7219_IF_MAX_HALF_PERIOD : integer                       := 50;  -- MAX HALF PERIOD for MAX729 CLK generation
      G_MAX7219_LOAD_DUR           : integer                       := 4);  -- MAX7219 LOAD duration in period of clk
    port (
      clk            : in  std_logic;   -- Clock
      rst_n          : in  std_logic;   -- Asynchronous Reset
      o_max7219_load : out std_logic;   -- LOAD
      o_max7219_data : out std_logic;   -- DATA
      o_max7219_clk  : out std_logic);  -- CLK

  end component top_max7219_matrix_display;


  -- TB CONSTANTS
  constant C_CLK_HALF_PERIOD : time := 10 ns;  -- HALF PERIOD of clk

  constant C_DIGITS_NB                  : integer range 2 to 8          := 8;
  constant C_DATA_WIDTH                 : integer                       := 32;
  constant C_RAM_ADDR_WIDTH             : integer                       := 8;
  constant C_RAM_DATA_WIDTH             : integer                       := 16;
  constant C_DECOD_MAX_CNT_32B          : std_logic_vector(31 downto 0) := x"02FAF080";
  constant C_MAX7219_IF_MAX_HALF_PERIOD : integer                       := 50;
  constant C_MAX7219_LOAD_DUR           : integer                       := 4;


  -- TB INTERNAL SIGNALS
  signal clk   : std_logic := '0';      -- Clock
  signal rst_n : std_logic := '1';      -- Asynchronous reset

  -- INTERNAL SIGNALS
  signal s_decod_mode     : std_logic_vector(7 downto 0);
  signal s_intensity      : std_logic_vector(7 downto 0);
  signal s_scan_limit     : std_logic_vector(7 downto 0);
  signal s_shutdown       : std_logic_vector(7 downto 0);
  signal s_new_config_val : std_logic;
  signal s_score          : std_logic_vector(31 downto 0);
  signal s_score_val      : std_logic;
  signal s_max7219_load   : std_logic;
  signal s_max7219_data   : std_logic;
  signal s_max7219_clk    : std_logic;


begin  -- architecture behv

  -- purpose: this process generate the input clock
  p_clk_gen : process is
  begin  -- process p_clk_gen
    clk <= not clk;
    wait for C_CLK_HALF_PERIOD;
  end process p_clk_gen;

  -- STIMULIS
  p_stimulis : process is
  begin  -- process p_stimuli

    -- SIGNALS INIT
    s_new_config_val <= '0';
    s_score_val      <= '0';
    s_score          <= (others => '0');

    rst_n <= '1';
    wait for 10*C_CLK_HALF_PERIOD;
    rst_n <= '0';
    wait for 10*C_CLK_HALF_PERIOD;
    rst_n <= '1';
    wait for 20*C_CLK_HALF_PERIOD;

    -- INIT MATRIX
    wait until falling_edge(clk);
    s_new_config_val <= '1';
    wait until falling_edge(clk);
    s_new_config_val <= '0';

    wait for 2 ms;

    -- DISPLAY SCORE : 99 999 999
    s_score     <= x"05F5E0FF";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 3 ms;

    -- DISPLAY SCORE : 10 456 321
    s_score     <= x"009F8D01";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 3 ms;

    -- DISPLAY SCORE : 00 000 001
    s_score     <= x"00000001";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 3 ms;

    -- DISPLAY SCORE : 00 000 012
    s_score     <= x"0000000C";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 3 ms;


    -- DISPLAY SCORE : 00 000 000
    s_score     <= x"00000000";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 3 ms;

    -- DISPLAY SCORE : 77 777 777
    s_score     <= x"04A2CB71";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 3 ms;

    assert FALSE Report "End of simulation !!!" severity FAILURE;    
    wait;
  end process p_stimulis;

  -- SET CONFIG
  s_decod_mode <= x"00";
  s_intensity  <= x"00";
  s_scan_limit <= x"07";
  s_shutdown   <= x"01";

  -- INST
  -- MAX7219 MATRIX DISPLAY INST
  max7219_matrix_display_inst_0 : max7219_matrix_display
    generic map(
      G_DIGITS_NB                  => C_DIGITS_NB,
      G_DATA_WIDTH                 => C_DATA_WIDTH,
      G_RAM_ADDR_WIDTH             => C_RAM_ADDR_WIDTH,
      G_RAM_DATA_WIDTH             => C_RAM_DATA_WIDTH,
      G_DECOD_MAX_CNT_32B          => C_DECOD_MAX_CNT_32B,
      G_MAX7219_IF_MAX_HALF_PERIOD => C_MAX7219_IF_MAX_HALF_PERIOD,
      G_MAX7219_LOAD_DUR           => C_MAX7219_LOAD_DUR)
    port map(
      clk              => clk,
      rst_n            => rst_n,
      i_decod_mode     => s_decod_mode,
      i_intensity      => s_intensity,
      i_scan_limit     => s_scan_limit,
      i_shutdown       => s_shutdown,
      i_new_config_val => s_new_config_val,
      i_score          => s_score,
      i_score_val      => s_score_val,
      o_max7219_load   => s_max7219_load,
      o_max7219_data   => s_max7219_data,
      o_max7219_clk    => s_max7219_clk
      );


  -- MAX7219 MATRIX DISPLAY EMUL
  max7219_matrix_emul_inst : max7219_matrix_emul
    generic map (
      G_MATRIX_NB => 8,
      G_VERBOSE   => x"FF")
    port map (
      clk            => clk,
      rst_n          => rst_n,
      i_max7219_clk  => s_max7219_clk,
      i_max7219_din  => s_max7219_data,
      i_max7219_load => s_max7219_load);

end architecture behv;
