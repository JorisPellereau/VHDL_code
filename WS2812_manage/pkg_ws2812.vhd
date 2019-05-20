-------------------------------------------------------------------------------
-- Title      : WS manage package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_ws2812.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-15
-- Last update: 2019-05-20
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

library lib_ws2812;
use lib_ws2812.ws2812_function.all;

package pkg_ws2812 is


  -- FUNCTIONS
  -- This function converts a time in us into an integer
  -- result = clock_frequency/(time * 10^6)
  -- function compute_time_duration (
  --   constant T               : time;     -- Duration to compute in us
  --   constant clock_frequency : integer)  -- Input clock frequency [Hz]
  --   return integer;

  -- CONSTANTS

  -- WS2812
  -- TH + TL = 1.25 us +- 600 us
  -- T0H : 0.35 us
  -- T0L : 0.8 us
  -- T1H : 0.7 us
  -- T1L : 0.6 us
  -- constant T0H_time : time := 0.35 us;  -- High level duration for 0
  -- constant T0L_time : time := 0.8 us;   -- Low level duration for 0
  -- constant T1H_time : time := 0.7 us;   -- High level duration for 1
  -- constant T1L_time : time := 0.6 us;   -- Low level duration for 1

  constant T0H_time : integer := 350;   -- High level duration for 0
  constant T0L_time : integer := 800;   -- Low level duration for 0
  constant T1H_time : integer := 700;   -- High level duration for 1
  constant T1L_time : integer := 600;   -- Low level duration for 1

  -- WS2812b
  -- TH + TL = 1.25 us +- 600 us
  -- T0H : 0.4 us
  -- T0L : 0.85 us
  -- T1H : 0.8 us
  -- T1L : 0.45 us
  -- constant T0Hb_time : time := 0.4 us;   -- High level duration for 0
  -- constant T0Lb_time : time := 0.85 us;  -- Low level duration for 0
  -- constant T1Hb_time : time := 0.8 us;   -- High level duration for 1
  -- constant T1Lb_time : time := 0.45 us;  -- Low level duration for 1

  constant T0Hb_time : integer := 400;  -- High level duration for 0
  constant T0Lb_time : integer := 850;  -- Low level duration for 0
  constant T1Hb_time : integer := 800;  -- High level duration for 1
  constant T1Lb_time : integer := 450;  -- Low level duration for 1

  constant clock_frequency : integer := 50000000;  -- Input clock frequency



  -- WS2812 integer constants
  constant T0H : integer := 18;  --compute_time_duration(T0H_time, clock_frequency);  -- Duration converts into integer
  constant T0L : integer := 40;  --compute_time_duration(T0L_time, clock_frequency);  -- Duration converts into integer
  constant T1H : integer := 35;  --compute_time_duration(T1H_time, clock_frequency);  -- Duration converts into integer
  constant T1L : integer := 30;  --compute_time_duration(T1L_time, clock_frequency);  -- Duration converts into integer

  -- WS2812b integer constants
  constant T0Hb : integer := 20;  --compute_time_duration(T0Hb_time, clock_frequency);  -- Duration converts into integer
  constant T0Lb : integer := 43;  --compute_time_duration(T0Lb_time, clock_frequency);  -- Duration converts into integer
  constant T1Hb : integer := 40;  --compute_time_duration(T1Hb_time, clock_frequency);  -- Duration converts into integer
  constant T1Lb : integer := 23;  --compute_time_duration(T1Lb_time, clock_frequency);  -- Duration converts into integer

  constant T_reset : integer := 2500;   -- Time to reset

  -- NEW TYPES
  type fsm_t is (idle, gen_frame, gen_reset, stop);


  -- COMPONENTS
  component WS2812_mng is
    generic(T0H : integer := T0H;
            T0L : integer := T0L;
            T1H : integer := T1H;
            T1L : integer := T1L
            );
    port(clock      : in  std_logic;                      -- Input clock
         reset_n    : in  std_logic;                      -- Asynchronous reset
         start      : in  std_logic;                      -- Start a frame
         led_config : in  std_logic_vector(23 downto 0);  -- Led configuration
         frame_done : out std_logic;                      -- Frame terminated
         d_out      : out std_logic                       -- Serial output
         );
  end component;

  component WS2812_mng_2 is
    generic(T0H : integer := T0H;
            T0L : integer := T0L;
            T1H : integer := T1H;
            T1L : integer := T1L
            );
    port(clock          : in  std_logic;  -- Input clock
         reset_n        : in  std_logic;  -- Asynchronous reset
         start          : in  std_logic;  -- Start a frame
         led_config     : in  std_logic_vector(23 downto 0);  -- Led configuration
         reset_duration : in  std_logic_vector(31 downto 0);  -- Reset duration
         frame_done     : out std_logic;  -- Frame terminated
         d_out          : out std_logic   -- Serial output
         );
  end component;


end package pkg_ws2812;


package body pkg_ws2812 is

  -- purpose: This function converts a time in us into an integer
  -- result = clock_frequency/(time * 10^6)
  -- function compute_time_duration (
  --   constant T               : time;     -- Duration to compute in us
  --   constant clock_frequency : integer)  -- Input clock frequency [Hz]

  --   return integer is
  --   variable result : integer := 0;     -- Result
  -- begin  -- function compute_time_duration

  --   result := (clock_frequency)/(T*10e6);
  --   return result;
  -- end function compute_time_duration;


end package body;
