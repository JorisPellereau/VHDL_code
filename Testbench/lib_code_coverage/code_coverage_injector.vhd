-------------------------------------------------------------------------------
-- Title      : Data Injector for Code Coverage
-- Project    : 
-------------------------------------------------------------------------------
-- File       : code_coverage_injector.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2021-11-28
-- Last update: 2021-12-10
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
    G_FILE_PATH           : string  := "INPUT_FILE.txt";
    G_CHAR_NB_DATA_1      : integer := 5;    -- Number of Character of DATA1
    G_CHAR_NB_DATA_2      : integer := 4;    -- Number of Character of DATA2
    G_DATA_1_FORMAT       : integer := 1;    -- 0 => INTEGER - 1 => HEXA
    G_INJECTOR_DATA_WIDTH : integer := 10);  -- Output data width

  port (
    clk    : in  std_logic;
    i_en   : in  std_logic;
    o_data : out std_logic_vector(G_INJECTOR_DATA_WIDTH - 1 downto 0));

end entity code_coverage_injector;

architecture arch_code_coverage_injector of code_coverage_injector is

  -- INTERNAL SIGNALS
  signal s_data : std_logic_vector(G_INJECTOR_DATA_WIDTH - 1 downto 0);

begin  -- architecture arch_code_coverage_injector


  p_data_mngt : process is

    -- VARIABLES
    variable v_row      : line;
    variable v_line     : line;
    variable v_data_out : integer;
    variable v_data_nb  : integer;
    file v_FILE         : text;         --is in G_FILE_PATH;

  begin  -- process p_data_mngt


--    if(i_en = '1') then
    wait until rising_edge(i_en);
    DISPLAY_MESSAGE("");
    DISPLAY_MESSAGE("Beginning of Data Mngt Process");
    DISPLAY_MESSAGE("Input file : " & G_FILE_PATH);

    -- Open File in read mode
    file_open(v_FILE, G_FILE_PATH, read_mode);

    while not endfile(v_FILE) loop

      -- Read a line
      readline(v_FILE, v_row);
      DECODE_LINE(v_row, G_CHAR_NB_DATA_1, G_CHAR_NB_DATA_2, G_DATA_1_FORMAT, v_data_out, v_data_nb);


      -- Loop and generate Data s_data_nb time every clk period
      for i in 0 to v_data_nb - 1 loop
        wait until rising_edge(clk);
        s_data <= conv_std_logic_vector(v_data_out, s_data'length);

      -- if(s_data /= x"0000" & "00") then
      --   write(v_line, s_data);
      --   writeline(output, v_line);
      -- end if;
      end loop;
    end loop;


    -- Close File
    file_close(v_FILE);

    DISPLAY_MESSAGE("End of injection for Code Coverage");
    DISPLAY_MESSAGE("");

    --assert false severity error;
    --finish;
    wait;

  end process p_data_mngt;

  -- Output Affectations
  o_data <= s_data;


  -- p_test : process is
  --   variable v_line : line;
  --   variable v_data : integer;
  -- begin  -- process p_test

  --   v_data := char_2_int('A');
  --   write(v_line, v_data);
  --   writeline(output, v_line);

  --   v_data := char_2_int('B');
  --   write(v_line, v_data);
  --   writeline(output, v_line);

  --   v_data := char_2_int('C');
  --   write(v_line, v_data);
  --   writeline(output, v_line);

  --   v_data := char_2_int('D');
  --   write(v_line, v_data);
  --   writeline(output, v_line);

  --   v_data := char_2_int('E');
  --   write(v_line, v_data);
  --   writeline(output, v_line);

  --   v_data := char_2_int('F');
  --   write(v_line, v_data);
  --   writeline(output, v_line);

  --   v_data := str_2_int("AA", 1);
  --   write(v_line, v_data);
  --   writeline(output, v_line);


  --   wait;
  -- end process p_test;


end architecture arch_code_coverage_injector;
