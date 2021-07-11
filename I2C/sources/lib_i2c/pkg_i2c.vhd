-------------------------------------------------------------------------------
-- Title      : Package for lib_i2c
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_i2c.vhd<lib_i2c>
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-06-27
-- Last update: 2021-07-11
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-06-27  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


package pkg_i2c is

  -- == TYPES ==
  type t_i2c_frequency is (f100k, f400k);  -- I2C frequency : 100 kHz or 400 kHz
  type t_i2c_master_fsm is (IDLE, START_GEN, WR_CHIP, SACK_CHIP, WR_DATA, RD_DATA, SACK_WR, MACK, STOP_GEN);  -- States of the I2C FSM


  -- FUNCTIONS
  function compute_scl_period (
    constant i2c_frequency   : t_i2c_frequency;
    constant clock_frequency : integer)
    return integer;

end pkg_i2c;

package body pkg_i2c is

  -- purpose: This function compute the SCL period duration according to the SCL clock config. and the input clock frequency
  function compute_scl_period (
    constant i2c_frequency   : t_i2c_frequency;  -- SCL frequence 100k or 400k
    constant clock_frequency : integer)          -- Input clock frequency
    return integer is

    variable scl_period : integer := 0;  -- SCL period

  begin  -- function compute_scl_duration
    case i2c_frequency is
      when f100k =>
        scl_period := clock_frequency / 100000;
      when f400k =>
        scl_period := clock_frequency / 400000;
      when others => null;
    end case;
    return scl_period;
  end function compute_scl_period;

end package body pkg_i2c;
