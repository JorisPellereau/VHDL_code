-------------------------------------------------------------------------------
-- Title      : Functions for WS2812
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ws2812_function.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-16
-- Last update: 2019-05-16
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is a packge with functions for the WS2318 module
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-16  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


package ws2812_function is

  -- FUNCTIONS
  -- This function converts a time in us into an integer
  -- result = clock_frequency*10e6/(t_us)
  function compute_time_duration (
    constant T               : integer;  -- Duration to compute in us
    constant clock_frequency : integer)  -- Input clock frequency [Hz]
    return integer;

end package ws2812_function;

package body ws2812_function is

  -- purpose: This function converts a time in us into an integer
  -- result = clock_frequency/(time * 10^6)
  function compute_time_duration (
    constant T               : integer;  -- Duration to compute in us
    constant clock_frequency : integer)  -- Input clock frequency [Hz]

    return integer is
    variable result : integer := 0;     -- Result
  begin  -- function compute_time_duration


    -- result := (clock_frequency*T)/(10e9);
    return result;
  end function compute_time_duration;

end package body ws2812_function;
