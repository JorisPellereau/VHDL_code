-------------------------------------------------------------------------------
-- Title      : WS manage package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_ws2812.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-15
-- Last update: 2019-05-16
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file is the package of the WS28xx component
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-15  1.0      JorisPC Created
-------------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;


package pkg_ws2812 is


  -- CONSTANTS

  -- WS2812
  -- TH + TL = 1.25 us +- 600 us
  -- T0H : 0.35 us
  -- T0L : 0.8 us
  -- T1H : 0.7 us
  -- T1L : 0.6 us
  constant T0H_time : time := 0.35 us;  -- High level duration for 0
  constant T0L_time : time := 0.8 us;   -- Low level duration for 0
  constant T1H_time : time := 0.7 us;   -- High level duration for 1
  constant T1L_time : time := 0.6 us;   -- Low level duration for 1

  -- WS2812b
  -- TH + TL = 1.25 us +- 600 us
  -- T0H : 0.4 us
  -- T0L : 0.85 us
  -- T1H : 0.8 us
  -- T1L : 0.45 us
  constant T0Hb_time : time := 0.4 us;   -- High level duration for 0
  constant T0Lb_time : time := 0.85 us;  -- Low level duration for 0
  constant T1Hb_time : time := 0.8 us;   -- High level duration for 1
  constant T1Lb_time : time := 0.45 us;  -- Low level duration for 1

  constant clock_frequency : integer := 50000000;  -- Input clock frequency


  -- WS2812 integer constants
  constant T0H : integer := compute_time_duration(T0H_time, clock_frequency);  -- Duration converts into integer
  constant T0L : integer := compute_time_duration(T0L_time, clock_frequency);  -- Duration converts into integer
  constant T1H : integer := compute_time_duration(T1H_time, clock_frequency);  -- Duration converts into integer
  constant T1L : integer := compute_time_duration(T1L_time, clock_frequency);  -- Duration converts into integer

  -- WS2812b integer constants
  constant T0Hb : integer := compute_time_duration(T0Hb_time, clock_frequency);  -- Duration converts into integer
  constant T0Lb : integer := compute_time_duration(T0Lb_time, clock_frequency);  -- Duration converts into integer
  constant T1Hb : integer := compute_time_duration(T1Hb_time, clock_frequency);  -- Duration converts into integer
  constant T1Lb : integer := compute_time_duration(T1Lb_time, clock_frequency);  -- Duration converts into integer



  -- NEW TYPES
  type ws2812x is(ws2812, ws2812b);     -- Type of WS2812x device

  -- type mode is (mode_0, mode_1);        -- Modes d'envoie (0 ou 1)
  type fsm_t is (idle, gen_frame, gen_reset, stop);


  -- This function converts a time in us into an integer
  -- result = clock_frequency/(time * 10^6)
  function compute_time_duration (
    constant T               : time;     -- Duration to compute in us
    constant clock_frequency : integer)  -- Input clock frequency [Hz]
    return integer;


  function mode_sel(config_msb : in std_logic)
    return mode;


end package pkg_ws2812;


package body pkg_ws2812 is


  -- purpose: This function converts a time in us into an integer
  -- result = clock_frequency/(time * 10^6)
  function compute_time_duration (
    constant T               : time;     -- Duration to compute in us
    constant clock_frequency : integer)  -- Input clock frequency [Hz]

    return integer is
    variable result : integer := 0;     -- Result
  begin  -- function compute_time_duration

    result := (clock_frequency)/(T*10e6);
    return result;
  end function compute_time_duration;







  function mode_sel(config_msb : in std_logic)
    return mode is

    variable mode_trame : mode;

  begin

    if(config_msb = '1') then
      mode_trame := mode_1;
    else
      mode_trame := mode_0;
    end if;
    return mode_trame;
  end mode_sel;


end package body;
