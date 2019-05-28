-------------------------------------------------------------------------------
-- Title      : I2C slave
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2c_slave.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-28
-- Last update: 2019-05-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Simple I2C slave
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-28  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_i2c;
use lib_i2c.pkg_i2c.all;

entity i2c_slave is

  generic (
    slave_addr : std_logic_vector(6 downto 0));  -- Slave Address
  port (
    clock_i              : in    std_logic;  -- Input system clock
    reset_n_i            : in    std_logic;  -- Active low asynchronous reset
    data_to_master_i     : in    std_logic_vector(7 downto 0);  -- Data to send to the I2C Master
    set_data_to_master_o : out   std_logic;  -- Request to set the data to send           
    data_valid_o         : out   std_logic;  -- Data ready to be read
    data_from_master_o   : out   std_logic_vector(7 downto 0);  -- Data from master
    scl                  : inout std_logic;  -- I2C Clock
    sda                  : inout std_logic);     -- I2C SDA

end entity i2c_slave;

architecture arch_i2c_slave of i2c_slave is


  -- SIGNALS
  signal fsm : t_i2c_slave_fsm;         -- Slave FSM state

  -- SDA falling_edge detect
  signal sda_old_s : std_logic;         -- Old sda
  signal sda_fe_s  : std_logic;         -- Flag for the FE of sda


  -- I2C inout signals
  signal scl_in  : std_logic;           -- Read the SCL
  signal sda_in  : std_logic;           -- Read SDA
  signal scl_out : std_logic;           -- Write SCL
  signal sda_out : std_logic;           -- Write SDA
  signal en_scl  : std_logic;           -- Enable scl_out
  signal en_sda  : std_logic;           -- Enable sda_out

begin  -- architecture arch_i2c_slave

  -- purpose: This process manages the FSM of the I2C slave 
  p_fsm_manage : process (clock_i, reset_n_i)
  begin  -- process p_fsm_manage
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      fsm <= IDLE;
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      case fsm is
        when IDLE   =>;
        when others => null;
      end case;
    end if;
  end process p_fsm_manage;


  -- purpose: This process detects the start condition
  p_start_detect : process (clock_i, reset_n_i)
  begin  -- process p_start_detect
    if reset_n_i = '0' then             -- asynchronous reset (active low)

    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(fsm = IDLE) then
        sda_old_s <= sda_in;
      end if;
    end if;
  end process p_start_detect;
  sda_fe_s <= sda_in and not sda_old_s;



  -- I2C interface
  scl <= scl_out when en_scl = '1' else 'Z';  -- Write on SCL output
  sda <= sda_out when en_sda = '1' else 'Z';  -- Write on SDA output

  scl_in <= scl;
  sda_in <= sda;


end architecture arch_i2c_slave;
