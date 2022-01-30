-------------------------------------------------------------------------------
-- Title      : Data Injector for Code Coverage
-- Project    : 
-------------------------------------------------------------------------------
-- File       : code_coverage_injector.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2021-11-28
-- Last update: 2022-01-30
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
use ieee.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library lib_code_coverage;
use lib_code_coverage.pkg_code_coverage.all;

entity code_coverage_injector is

  generic (
    G_FILE_NB             : integer := 1;  -- Number of file to inject
    G_FILE_PATH           : string  := "/home/";  --
    G_TESTS_NAME          : string  := "TEST_XXX";
    G_NB_CHAR_TESTS_INDEX : integer := 2;  -- Number of Character of Test index

    G_CHAR_NB_DATA_1      : integer := 5;    -- Number of Character of DATA1
    G_CHAR_NB_DATA_2      : integer := 4;    -- Number of Character of DATA2
    G_DATA_1_FORMAT       : integer := 1;    -- 0 => INTEGER - 1 => HEXA
    G_INJECTOR_DATA_WIDTH : integer := 10);  -- Output data width

  port (
    clk     : in  std_logic;
    i_en    : in  std_logic;
    o_rst_n : out std_logic;
    o_data  : out std_logic_vector(G_INJECTOR_DATA_WIDTH - 1 downto 0));

end entity code_coverage_injector;

architecture arch_code_coverage_injector of code_coverage_injector is

  -- CONSTANTS
  constant C_SUFFIX_NAME : string := "_collect_opti.txt";

  -- INTERNAL SIGNALS
  signal s_data     : std_logic_vector(G_INJECTOR_DATA_WIDTH - 1 downto 0);
  signal s_rst_n    : std_logic;
  signal s_data_out : std_logic_vector(C_NB_ARRAY_OF_INT*32 - 1 downto 0);

begin  -- architecture arch_code_coverage_injector


  p_data_mngt : process is

    -- VARIABLES
    variable v_row             : line;
    variable v_line            : line;
    variable v_data_out        : t_array_of_int;
    variable v_data_nb         : integer;
    file v_FILE                : text;
    variable v_str             : string(1 to 500);  -- Input file
    variable v_str_length      : integer := 0;
    variable v_vector_data_out : std_logic_vector(C_NB_ARRAY_OF_INT*32 - 1 downto 0);

  begin  -- process p_data_mngt

    s_rst_n <= '1';

    wait until rising_edge(i_en);
    DISPLAY_MESSAGE("");
    DISPLAY_MESSAGE("Beginning of Data Mngt Process");

    for nb_file_i in 0 to G_FILE_NB - 1 loop

      DISPLAY_MESSAGE("Input file : " & G_FILE_PATH & "/" & G_TESTS_NAME & "_" & int_2_str_32(nb_file_i, G_NB_CHAR_TESTS_INDEX) & C_SUFFIX_NAME);


      -- Drive Reset
      wait for 50 ns;
      s_rst_n <= '0';
      wait for 50 ns;
      s_rst_n <= '1';
      wait for 50 ns;

      v_str_length             := G_FILE_PATH'length + G_TESTS_NAME'length + 2 + C_SUFFIX_NAME'length + int_2_str_32(nb_file_i, G_NB_CHAR_TESTS_INDEX)'length;
      v_str(1 to v_str_length) := G_FILE_PATH & '/' & G_TESTS_NAME & '_' & int_2_str_32(nb_file_i, G_NB_CHAR_TESTS_INDEX) & C_SUFFIX_NAME;

      -- Open File in read mode
      file_open(v_FILE, v_str(1 to v_str_length), read_mode);

      while not endfile(v_FILE) loop

        -- Read a line
        readline(v_FILE, v_row);
        DECODE_LINE(v_row, G_CHAR_NB_DATA_1, 8, G_DATA_1_FORMAT, G_INJECTOR_DATA_WIDTH, v_data_out, v_data_nb);

        --DISPLAY_MESSAGE("DEBUG v_data_nb : " & integer'image(v_data_nb));
        -- Convert Int Array to std_logic_vector
        for i in 0 to C_NB_ARRAY_OF_INT - 1 loop
          --DISPLAY_MESSAGE("v_data_out(" & integer'image(i) & ") : " & integer'image(v_data_out(i)));
          v_vector_data_out(32*(i+1) - 1 downto i*32) := conv_std_logic_vector(v_data_out(i), 32);
        end loop;

        -- Loop and generate Data s_data_nb time every clk period
        for i in 0 to v_data_nb - 1 loop
          wait until rising_edge(clk);
          s_data     <= v_vector_data_out(G_INJECTOR_DATA_WIDTH - 1 downto 0);
          s_data_out <= v_vector_data_out; -- Debug Purpose
        end loop;
      end loop;

      -- Close File
      file_close(v_FILE);

    end loop;

    DISPLAY_MESSAGE("End of injection for Code Coverage");
    DISPLAY_MESSAGE("");

    wait;

  end process p_data_mngt;

  -- Output Affectations
  o_data  <= s_data;
  o_rst_n <= s_rst_n;

end architecture arch_code_coverage_injector;
