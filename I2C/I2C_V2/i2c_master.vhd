-------------------------------------------------------------------------------
-- Title      : Generic I2C Master
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2c_master.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-28
-- Last update: 2019-06-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Generic I2C Master
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-28  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_i2c;
use lib_i2c.pkg_i2c.all;

entity i2c_master is
  generic (
    scl_frequency   : t_i2c_frequency := f400k;  -- Frequency of SCL clock
    clock_frequency : integer         := 20000000);  -- Input clock frequency
  port (
    reset_n      : in    std_logic;     -- Active Low asynchronous reset
    clock        : in    std_logic;     -- Input clock
    start_i2c    : in    std_logic;     -- Start an I2C transaction
    rw           : in    std_logic;     -- Read/Write command
    chip_addr    : in    std_logic_vector(6 downto 0);  -- Chip address [0:127]
    nb_data      : in    integer range 1 to 10;  -- Number of byte to Read or Write
    wdata        : in    std_logic_vector(7 downto 0);  -- Array of data to transmit
    i2c_done     : out   std_logic;     -- I2C transaction done
    sack_error   : out   std_logic;     -- Sack from slave not received
    rdata        : out   std_logic_vector(7 downto 0);  -- Output data read from an I2C transaction
    rdata_valid  : out   std_logic;     -- Rdata valid
    wdata_change : out   std_logic;     -- Ok for a new data
    scl          : inout std_logic;     -- I2C clock
    sda          : inout std_logic);    -- Data line
end entity i2c_master;

