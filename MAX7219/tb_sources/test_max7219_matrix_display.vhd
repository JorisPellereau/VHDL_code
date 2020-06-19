-------------------------------------------------------------------------------
-- Title      : TB Template
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_type.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-18
-- Last update: 2020-06-19
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

entity test_max7219_matrix_display is

end entity test_max7219_matrix_display;

architecture behv of test_max7219_matrix_display is

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

  -- component max7219_display_n_matrix is
  --   generic(
  --     G_NB_MATRIX : integer := 2);
  --   port (
  --     clk              : in std_logic;
  --     rst_n            : in std_logic;
  --     line_val         : in std_logic;
  --     line_char_matrix : in t_matrix_line_array);
  -- end component max7219_display_n_matrix;


  -- TB CONSTANTS
  constant C_CLK_HALF_PERIOD : time := 10 ns;  -- HALF PERIOD of clk

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

  signal s_max7219_dout_m0  : std_logic;
  signal s_line_char_m0     : std_logic_vector(8*8 - 1 downto 0);
  signal s_max7219_dout_m1  : std_logic;
  signal s_line_char_m1     : std_logic_vector(8*8 - 1 downto 0);
  signal s_line_val         : std_logic;
  signal s_line_matrix      : t_matrix_line_array;
  signal s_line_char_val_m0 : std_logic;
  signal s_line_char_val_m1 : std_logic;

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

    wait for 10*C_CLK_HALF_PERIOD;

    -- SIGNALS INIT
    s_decod_mode     <= (others => '0');
    s_intensity      <= (others => '0');
    s_scan_limit     <= (others => '0');
    s_shutdown       <= (others => '0');
    s_new_config_val <= '0';
    s_score          <= (others => '0');
    s_score_val      <= '0';

    rst_n <= '0';
    wait for 10*C_CLK_HALF_PERIOD;
    rst_n <= '1';

    wait for 10*C_CLK_HALF_PERIOD;


    -- SET CONFIG
    s_decod_mode <= x"00";
    s_intensity  <= x"07";
    s_scan_limit <= x"07";
    s_shutdown   <= x"01";

    wait until falling_edge(clk);
    s_new_config_val <= '1';
    wait until falling_edge(clk);
    s_new_config_val <= '0';

    wait for 300 us;

    -- DISPLAY 00 on Matrix
    s_score     <= x"00000000";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 600 us;                    --1000*C_CLK_HALF_PERIOD;

    -- DISPLAY 99 on Matrix
    s_score     <= x"00000063";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 600 us;                    --1000*C_CLK_HALF_PERIOD;

    -- DISPLAY 50 on Matrix
    s_score     <= x"00000032";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 600 us;                    --1000*C_CLK_HALF_PERIOD;

    -- DISPLAY 01 on Matrix
    s_score     <= x"00000001";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 600 us;                    --1000*C_CLK_HALF_PERIOD;


    -- DISPLAY 98 on Matrix
    s_score     <= x"00000062";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 600 us;                    --1000*C_CLK_HALF_PERIOD;

    wait;

    -- OLD TEST
    s_score     <= x"00000099";
    wait until falling_edge(clk);
    s_score_val <= '1';
    wait until falling_edge(clk);
    s_score_val <= '0';

    wait for 1 ms;
    report "end of Simulation !!!";
    wait;
  end process p_stimulis;

  -- MAX7219 MATRIX DISPLAY INST
  max7219_matrix_display_inst_0 : max7219_matrix_display
    generic map(
      G_DIGITS_NB                  => 2,
      G_DATA_WIDTH                 => 32,
      G_RAM_ADDR_WIDTH             => 8,
      G_RAM_DATA_WIDTH             => 16,
      G_DECOD_MAX_CNT_32B          => x"02FAF080",
      G_MAX7219_IF_MAX_HALF_PERIOD => 50,
      G_MAX7219_LOAD_DUR           => 4)
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


  -- MAX7219 MODULE EMUL - Checker
  -- max7219_emul_inst_m0 : max7219_emul
  --   generic map(
  --     G_MATRIX_I => 0
  --     )
  --   port map (
  --     clk               => clk,
  --     rst_n             => rst_n,
  --     i_max7219_clk     => s_max7219_clk,
  --     i_max7219_din     => s_max7219_data,
  --     i_max7219_load    => s_max7219_load,
  --     o_max7219_dout    => s_max7219_dout_m0,
  --     o_matrix_char     => open,
  --     o_matrix_char_val => open
  --     );

  -- MAX7219 MODULE EMUL - Checker
  -- max7219_emul_inst_m1 : max7219_emul
  --   generic map(
  --     G_MATRIX_I => 1
  --     )
  --   port map (
  --     clk               => clk,
  --     rst_n             => rst_n,
  --     i_max7219_clk     => s_max7219_clk,
  --     i_max7219_din     => s_max7219_dout_m0,
  --     i_max7219_load    => s_max7219_load,
  --     o_max7219_dout    => s_max7219_dout_m1,
  --     o_matrix_char     => open,
  --     o_matrix_char_val => open
  --     );



  -- MAX7219 MATRIX DISPLAY EMUL
  max7219_matrix_emul_inst : max7219_matrix_emul
    generic map (
      G_MATRIX_NB => 2,
      G_VERBOSE   => x"03")
    port map (
      clk            => clk,
      rst_n          => rst_n,
      i_max7219_clk  => s_max7219_clk,
      i_max7219_din  => s_max7219_data,
      i_max7219_load => s_max7219_load);



  -- s_line_val       <= s_line_char_val_m0 or s_line_char_val_m1;
  -- s_line_matrix(0) <= s_line_char_m0;
  -- s_line_matrix(1) <= s_line_char_m1;
  -- s_line_matrix(2) <= (others => '0');
  -- s_line_matrix(3) <= (others => '0');
  -- s_line_matrix(4) <= (others => '0');
  -- s_line_matrix(5) <= (others => '0');
  -- s_line_matrix(6) <= (others => '0');
  -- s_line_matrix(7) <= (others => '0');
  -- -- MAX7219 DISPLAY N MATRIX INST
  -- max7219_display_n_matrix_0 : max7219_display_n_matrix
  --   generic map (
  --     G_NB_MATRIX => 2)
  --   port map(
  --     clk              => clk,
  --     rst_n            => rst_n,
  --     line_val         => s_line_val,
  --     line_char_matrix => s_line_matrix);

end architecture behv;
