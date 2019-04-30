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



library ieee;
use ieee.std_logic_1164.all;


package pkg_i2c is

  -- CONSTANTS
  constant max_array : integer := 5;    -- Number max. of byte in the array

  -- NEW TYPES
  type t_byte_array is array (0 to max_array) of std_logic_vector(7 downto 0);  -- Array of bytes
  type t_i2c_master_fsm is (IDLE, START_GEN, WR_CHIP, SACK_CHIP, WR_DATA, RD_DATA, SACK_WR, MACK,
                            STOP_GEN);  -- States of the I2C FSM

  type t_i2c_frequency is (f100k, f400k);  -- I2C frequency : 100 kHz or 400 kHz


end pkg_i2c;


