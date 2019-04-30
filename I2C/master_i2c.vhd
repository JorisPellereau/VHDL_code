-------------------------------------------------------------------------------
-- Title      : Master I2C 
-- Project    : 
-------------------------------------------------------------------------------
-- File       : master_i2c.vhd
-- Author     :  Joris Pellereau
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

library lib_i2c;
use lib_i2c.pkg_i2c.all;

entity master_i2c is

  generic (
    scl_frequency   : t_i2c_frequency := f100k;      -- Frequency of SCL clock
    clock_frequency : integer         := 20000000);  -- Input clock frequency
  port (
    reset_n   : in    std_logic;        -- Asynchronous reset
    clock     : in    std_logic;        -- Input clock
    start_i2c : in    std_logic;        -- Start an I2C transaction
    rw        : in    std_logic;        -- Read/Write command
    chip_addr : in    std_logic_vector(6 downto 0);  -- Chip address [0:127]
    nb_data   : in    integer range 1 to max_array;  -- Number of byte to Read or Write
    wdata     : in    t_byte_array;     -- Array of data to transmit
    i2c_done  : out   std_logic;        -- I2C transaction done
    rdata     : out   t_byte_array;  -- Output data read from an I2C transaction
    scl       : inout std_logic;        -- I2C clock
    sda       : inout std_logic);       -- Data line

end entity master_i2c;


architecture arch_macter_i2c of master_i2c is

begin  -- architecture arch_macter_i2c



end architecture arch_macter_i2c;
