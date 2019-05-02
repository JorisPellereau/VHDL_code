-------------------------------------------------------------------------------
-- Title      : Package for I2C
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_i2c.vhd
-- Author     :   Joris Pellereau
-- Company    : 
-- Created    : 2019-04-30
-- Last update: 2019-05-02
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

  -- COMPONENTS
  component master_i2c is
    generic (
      scl_frequency   : t_i2c_frequency;  -- Frequency of SCL clock
      clock_frequency : integer);       -- Input clock frequency
    port (
      reset_n    : in    std_logic;     -- Asynchronous reset
      clock      : in    std_logic;     -- Input clock
      start_i2c  : in    std_logic;     -- Start an I2C transaction
      rw         : in    std_logic;     -- Read/Write command
      chip_addr  : in    std_logic_vector(6 downto 0);  -- Chip addr [0 : 126]<type>
      nb_data    : in    integer;       -- range 1 to max_array
      wdata      : in    t_byte_array;  -- Array of byte to write on the bus
      i2c_done   : out   std_logic;     -- I2C transaction done
      sack_error : out   std_logic;     --Sack fom slave not received
      rdata      : out   t_byte_array;  -- Output data read from an I2C transaction
      scl        : inout std_logic;     -- I2C clock
      sda        : inout std_logic);    -- Data line
  end component master_i2c;


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


