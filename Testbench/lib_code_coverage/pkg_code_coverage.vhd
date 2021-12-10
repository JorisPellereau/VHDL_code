-------------------------------------------------------------------------------
-- Title      : Package for Code Coverage Tool
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_code_coverage.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2021-12-04
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
    variable v_line          : inout line;
    constant i_char_nb_data1 : in    integer;
    constant i_char_nb_data2 : in    integer;
    constant i_data1_format  : in    integer;
    variable o_data_out      : out   integer;
    variable o_data_nb       : out   integer);

  -- A single Char to Int
  function char_2_int(i_char : character)
    return integer;

  -- A str to int
  function str_2_int(i_str    : string;
                     i_format : integer)
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
    variable v_line          : inout line;
    constant i_char_nb_data1 : in    integer;
    constant i_char_nb_data2 : in    integer;
    constant i_data1_format  : in    integer;
    variable o_data_out      : out   integer;
    variable o_data_nb       : out   integer) is

    -- VARIABLES
    variable v_str_data : string(1 to i_char_nb_data1);
    variable v_str_cnt  : string(1 to i_char_nb_data2);
    variable v_space    : character;
    variable v_int_data : integer;
    variable v_int_cnt  : integer;


    variable v_line_length    : integer;
    variable v_space_position : integer;
    variable v_one_char       : character;
    variable v_init_puissance : integer;
    variable v_digit_nb       : integer;
    variable v_line_tmp       : line;
    variable v_data_tmp       : integer;

    variable v_str : string(1 to 500);  -- Max Line : 500 Characters

  begin
    v_line_tmp    := v_line;
    v_line_length := v_line'length;

    -- Line to v_str
    read(v_line, v_str_data);           -- Read 1st Data
    read(v_line, v_space);              -- Read space
    read(v_line, v_str_cnt);            -- Read 2nd Data

    v_int_data := str_2_int(v_str_data, i_data1_format);
    v_int_cnt  := str_2_int(v_str_cnt, 0);

    o_data_out := v_int_data;
    o_data_nb  := v_int_cnt;
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

      when 'a' =>
        v_int := 10;
      when 'b' =>
        v_int := 11;
      when 'c' =>
        v_int := 12;
      when 'd' =>
        v_int := 13;
      when 'e' =>
        v_int := 14;
      when 'f' =>
        v_int := 15;

      when others => null;
    end case;
    return v_int;
  end function char_2_int;


  -- A str to int
  function str_2_int(i_str    : string;
                     i_format : integer)
    return integer is

    -- Internal variables
    variable v_str_length     : integer;
    variable v_init_puissance : integer;
    variable v_data           : integer := 0;
  begin

    v_str_length := i_str'length;       -- Get Length

    -- Init Puissance
    if(i_format = 0) then
      v_init_puissance := 10**(v_str_length - 1);
    elsif(i_format = 1) then
      v_init_puissance := 16**(v_str_length - 1);
    end if;

    -- Compute Value in integer
    for i in 1 to v_str_length loop
      -- Integer format
      if(i_format = 0) then
        v_data           := v_data + char_2_int(i_str(i))*v_init_puissance;
        v_init_puissance := v_init_puissance / 10;
      -- HEX Format
      elsif(i_format = 1) then
        v_data           := v_data + char_2_int(i_str(i))*v_init_puissance;
        v_init_puissance := v_init_puissance / 16;
      end if;
    end loop;

    return v_data;
  end function str_2_int;

end package body pkg_code_coverage;
