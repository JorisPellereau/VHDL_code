-------------------------------------------------------------------------------
-- Title      : Package for Code Coverage Tool
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_code_coverage.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2021-12-04
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
-- 2021-12-04  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

package pkg_code_coverage is

  -- Display a simple message pass as a string
  procedure DISPLAY_MESSAGE (
    constant i_msg : in string);        -- Input Message

  -- Decode Line - Get Data and number of Data
  procedure DECODE_LINE (
    variable v_line   : inout line;
    signal o_data_out : out   integer;
    signal o_data_nb  : out   integer);


  function char_2_int(i_char : character)
    return integer;

end package pkg_code_coverage;

package body pkg_code_coverage is

  -- purpose: Display a Message in console
  procedure DISPLAY_MESSAGE (
    constant i_msg : in string) is

    variable v_line : line;             -- Line
  begin  -- procedure DISPLAY_MESSAGE
    write(v_line, string'(i_msg));
    writeline(output, v_line);
  end procedure DISPLAY_MESSAGE;


  -- Decode Line - Get Data and number of Data
  procedure DECODE_LINE (
    variable v_line   : inout line;
    signal o_data_out : out   integer;
    signal o_data_nb  : out   integer) is

    -- VARIABLES
    variable v_line_length    : integer;
    variable v_space_position : integer;
    variable v_one_char       : character;
    variable v_init_puissance : integer;
    variable v_digit_nb       : integer;
    variable v_line_tmp : line;
    variable s_data_tmp : integer;

  begin
    v_line_tmp := v_line;
    v_line_length := v_line'length;

    -- Get Space Position
    for i in 0 to v_line_length - 1 loop
      read(v_line, v_one_char);
      if(v_one_char = ' ') then
        v_space_position := i;
      end if;
    end loop;  -- i

    v_digit_nb := v_space_position - 1;  -- Number of digit in o_data
    case v_digit_nb is
      when 1 =>
        v_init_puissance := 1;
      when 2 =>
        v_init_puissance := 10;
      when 3 =>
        v_init_puissance := 100;
      when 4 =>
        v_init_puissance := 1000;
      when 5 =>
        v_init_puissance := 10000;
      when 6 =>
        v_init_puissance := 100000;
      when 7 =>
        v_init_puissance := 1000000;
      when 8 =>
        v_init_puissance := 10000000;
      when 9 =>
        v_init_puissance := 100000000;
      when 10 =>
        v_init_puissance := 1000000000;
      when others => DISPLAY_MESSAGE("Error wrong value og v_digit_nb");
    end case;
    
    -- for i in 0 to v_digit_nb loop
    --   read(v_line_tmp, v_one_char);
    --   --s_data_tmp := s_data_tmp + char_2_int(v_one_char)*v_init_puissance;
    --   --v_init_puissance := v_init_puissance / 10;
    -- end loop;

  end procedure DECODE_LINE;


  -- Decod a character and return an int
  function char_2_int(i_char : character)
    return integer is
    variable v_int : integer := 0;
  begin
    case i_char is
      when '0' =>
        v_int := 0;
      when '1' =>
        v_int := 1;
      when '2' =>
        v_int := 2;
      when '3' =>
        v_int := 3;
      when '4' =>
        v_int := 4;
      when '5' =>
        v_int := 5;
      when '6' =>
        v_int := 6;
      when '7' =>
        v_int := 7;
      when '8' =>
        v_int := 8;
      when '9' =>
        v_int := 9;
      when 'A' =>
        v_int := 10;
      when 'B' =>
        v_int := 11;
      when 'C' =>
        v_int := 12;
      when 'D' =>
        v_int := 13;
      when 'E' =>
        v_int := 14;
      when 'F' =>
        v_int := 15;

      when others => null;
    end case;
  end function char_2_int;


end package body pkg_code_coverage;
