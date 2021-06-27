-------------------------------------------------------------------------------
-- Title      : Package for lib_i2c
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_i2c.vhd<lib_i2c>
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-06-27
-- Last update: 2021-06-27
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

end pkg_i2c;
