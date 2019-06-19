-------------------------------------------------------------------------------
-- Title      : Package for PWM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_pwm.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-19
-- Last update: 2019-06-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This if the package for PWM
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-19  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package pkg_pwm is

  -- System clock frequency : 50MHz
  -- PWM frequency : 10kHz

  -- 50MHz * (1/10kHz) = 5000
  constant C_MAX_DUTY_CYCLE : integer               := 5000;  -- MAX DUTY cycle
  constant C_N_BITS         : integer range 0 to 32 := 13;  -- Size of the std_logic_vector

-- COMPONENTS

  component pwm is
    port (
      clock_i      : in  std_logic;     -- Input system clock
      reset_n_i    : in  std_logic;     -- Active low asynchronous reset
      duty_cycle_i : in  integer range 0 to C_MAX_DUTY_CYCLE;  -- Duty cycle
      en_pwm_i     : in  std_logic;     -- Enable pwm
      pwm_o        : out std_logic);    -- PWM output
  end component;

end package pkg_pwm;
