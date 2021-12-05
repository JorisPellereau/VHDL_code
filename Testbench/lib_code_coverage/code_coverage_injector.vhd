-------------------------------------------------------------------------------
-- Title      : Data Injector for Code Coverage
-- Project    : 
-------------------------------------------------------------------------------
-- File       : code_coverage_injector.vhd
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
use std.textio.all;
use ieee.std_logic_textio.all;

library lib_code_coverage;
use lib_code_coverage.pkg_code_coverage.all;

entity code_coverage_injector is

  generic (
    G_FILE_PATH           : string  := "INPUT_FILE.txt";
    G_INJECTOR_DATA_WIDTH : integer := 10);  -- Output data width

  port (
    clk    : in  std_logic;
    i_en   : in  std_logic;
    o_data : out std_logic_vector(G_INJECTOR_DATA_WIDTH - 1 downto 0));

end entity code_coverage_injector;

architecture arch_code_coverage_injector of code_coverage_injector is

  -- INTERNAL SIGNALS
  file input_file : text;

  signal s_data_out : integer;
  signal s_data_nb  : integer;

begin  -- architecture arch_code_coverage_injector


  p_data_mngt : process is

    -- VARIABLES
    variable v_row      : line;
    variable v_data     : std_logic_vector(G_INJECTOR_DATA_WIDTH - 1 downto 0);
    variable v_data_int : integer;
    variable v_data_cnt : integer;
    variable v_line     : line;
    variable v_line_tmp : line;

    variable v_one_char : character;
    --variable v_data_str : string;
    file v_FILE         : text;         --is in G_FILE_PATH;
  --variable v_
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
      DECODE_LINE(v_row, s_data_out, s_data_nb);

      --while(v_one_char /= '2') loop
      --  read(v_row, v_one_char);        -- read Only 1 char
      --end loop;

      write(v_line_tmp, v_row'length);
      writeline(output, v_line_tmp);

    --hread(v_row, v_data);
    --wait until rising_edge(clk);
    --DISPLAY_MESSAGE(string'(v_row(1 downto 0)));
    --DISPLAY_MESSAGE("file not ended");
    end loop;


    -- Close File
    file_close(input_file);

    DISPLAY_MESSAGE("End of p_data_mngt");
    DISPLAY_MESSAGE("");
    --end if;



    wait;

  end process p_data_mngt;



end architecture arch_code_coverage_injector;
