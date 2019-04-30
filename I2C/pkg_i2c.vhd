-------------------------------------------------------------------------------
-- Title      : Package for I2C
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_i2c.vhd
-- Author     :   Joris Pellereau
-- Company    : 
-- Created    : 2019-04-30
-- Last update: 2019-04-30
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-04-30  1.0      pellereau       Created
-------------------------------------------------------------------------------



-- LIBRARY 
library ieee;
use ieee.std_logic_1164.all;




package pkg_i2c is

  -- NEW TYPES
  type t_i2c_master_fsm is (IDLE, START_GEN, WR_CHIP, SACK_CHIP, WR_DATA, RD_DATA, SACK_WR, MACK,
                            STOP_GEN);  -- States of the I2C FSM



end pkg_i2c;


