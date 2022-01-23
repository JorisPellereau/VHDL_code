-------------------------------------------------------------------------------
-- Title      : Package for Code Coverage Tool
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_code_coverage.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2021-12-04
-- Last update: 2022-01-23
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
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

package pkg_code_coverage is

  -- Constaants
  constant C_NB_ARRAY_OF_INT : integer := 10;
  -- New Type
  type t_array_of_int is array (0 to C_NB_ARRAY_OF_INT) of integer;  -- Array of int type

  -- Display a simple message pass as a string
  procedure DISPLAY_MESSAGE (
    constant i_msg : in string);        -- Input Message

  -- Decode Line - Get Data and number of Data
  procedure DECODE_LINE (
    variable v_line                : inout line;
    constant i_char_nb_data1       : in    integer;
    constant i_char_nb_data2       : in    integer;
    constant i_data1_format        : in    integer;
    constant i_injector_data_width : in    integer;
    variable o_data_out            : out   t_array_of_int;
    variable o_data_nb             : out   integer);

  -- A single Char to Int
  function char_2_int(i_char : character)
    return integer;

  -- A str to int
  function str_2_int(i_str    : string;
                     i_format : integer)
    return integer;

  -- A int to a str on N character
  function int_2_str(i_int     : integer;
                     i_nb_char : integer)
    return string;

  -- int_2_str_32
  function int_2_str_32(i_int                : integer;
                        i_nb_char_to_display : integer)
    return string;

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
    variable v_line                : inout line;
    constant i_char_nb_data1       : in    integer;
    constant i_char_nb_data2       : in    integer;
    constant i_data1_format        : in    integer;
    constant i_injector_data_width : in    integer;
    variable o_data_out            : out   t_array_of_int;
    variable o_data_nb             : out   integer) is

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
    variable v_32b_packet_nb  : integer := 0;
    variable v_remain_bit_nb  : integer := 0;

    variable v_str : string(1 to 500);  -- Max Line : 500 Characters

  begin
    -- INIT Output
    for i in 0 to C_NB_ARRAY_OF_INT - 1 loop
      o_data_out(i) := 0;
    end loop;

    v_line_tmp    := v_line;
    v_line_length := v_line'length;

    -- Line to v_str
    read(v_line, v_str_data);           -- Read 1st Data
    read(v_line, v_space);              -- Read space
    read(v_line, v_str_cnt);            -- Read 2nd Data

    DISPLAY_MESSAGE("v_str_data : " & v_str_data);
    DISPLAY_MESSAGE("v_str_cnt : " & v_str_cnt);

    -- Test if the length of v_str_data can be store in an integer (32bits)
    if(v_str_data'length > 8) then
      DISPLAY_MESSAGE("Warning: v_str_data greater than 32bits");
    end if;

    -- Get the number of 32bits packet
    v_32b_packet_nb := i_injector_data_width / 32; -- Packet Entier of 32 bits
    v_remain_bit_nb := i_injector_data_width - 32*v_32b_packet_nb; -- Remain bits

    -- Case No 32bits packet 
    if(v_32b_packet_nb = 0) then
      v_int_data := str_2_int(v_str_data, ); -- TBD
    end if;
    v_int_data := str_2_int(v_str_data, i_data1_format);
    v_int_cnt  := str_2_int(v_str_cnt, 0);

    o_data_out(0) := v_int_data;        -- TBD
    o_data_nb     := v_int_cnt;
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


  -- A int to a str on N character
  function int_2_str(i_int     : integer;
                     i_nb_char : integer)
    return string is

    -- Variables
    variable v_str_tmp        : string(1 to i_nb_char);
    variable v_str_tmp_length : integer;
    variable v_str            : string(1 to 32);  -- := integer'image(i_int);  --string(1 to i_nb_char);
  begin
    v_str := integer'image(i_int);
--    v_str_tmp(1 to i_nb_char) := integer'image(i_int);
    --v_str_tmp := to_string(i_int);
    --v_str_tmp_length := v_str_tmp'length;

    return v_str;
  end function int_2_str;


  -- int_2_str_32
  function int_2_str_32(i_int                : integer;
                        i_nb_char_to_display : integer)
    return string is

    -- Variable
    variable v_line : line;

    -- Init with space
    variable v_str           : string(1 to 32) := "                                ";
    variable v_str_tmp       : string(1 to 32);
    variable v_str_return    : string(1 to i_nb_char_to_display);
    variable v_char_nb       : integer         := 0;  -- Number of character for the current integer converts in string
    variable v_nb_0_to_add   : integer         := 0;
    variable v_conversion_ok : boolean         := false;
  begin

    -- Fill v_str with value of integer - other digit set to ' ' (space)
    std.TextIO.write(v_line, i_int);
    v_str(v_line.all'range) := v_line.all;
    deallocate(v_line);

    -- Get the size of integer convert in string
    for i in 1 to 32 loop
      if(v_str(i) /= ' ') then
        v_char_nb := v_char_nb + 1;     -- Inc
      end if;
    end loop;

    -- Computes number of 0 to add
    if(i_nb_char_to_display > v_char_nb) then
      v_nb_0_to_add   := i_nb_char_to_display - v_char_nb;
      v_conversion_ok := true;
    elsif(i_nb_char_to_display < v_char_nb) then
      DISPLAY_MESSAGE("Error: i_nb_char_to_display < v_char_nb");
      DISPLAY_MESSAGE("v_char_nb : " & integer'image(v_char_nb));
      DISPLAY_MESSAGE("i_nb_char_to_display : " & integer'image(i_nb_char_to_display));
      v_conversion_ok := false;
    else
      v_nb_0_to_add   := 0;
      v_conversion_ok := true;
    end if;

    --DISPLAY_MESSAGE("v_char_nb : " & integer'image(v_char_nb));
    --DISPLAY_MESSAGE("v_nb_0_to_add : " & integer'image(v_nb_0_to_add));

    v_str_tmp := v_str;                 -- Temporary save before roll shift

    if(v_conversion_ok = true) then

      -- Shift integer only if i_nb_char_to_display is greater than v_char_nb
      for i in 1 to v_char_nb loop      --i_nb_char_to_display loop
        v_str(i + v_nb_0_to_add) := v_str_tmp(i);
      end loop;

      -- Add 0
      for i in 1 to v_nb_0_to_add loop
        v_str(i) := '0';
      end loop;
    end if;

    -- Update v_str_return
    v_str_return := v_str(1 to i_nb_char_to_display);
    return v_str_return;                --(1 to i_nb_char_to_display);
  end function int_2_str_32;

end package body pkg_code_coverage;
