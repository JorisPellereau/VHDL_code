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
    slave_addr : std_logic_vector(6 downto 0) := "1111110");  -- Slave Address
  port (
    clock_i              : in    std_logic;  -- Input system clock
    reset_n_i            : in    std_logic;  -- Active low asynchronous reset
    data_to_master_i     : in    std_logic_vector(7 downto 0);  -- Data to send to the I2C Master
    set_data_to_master_o : out   std_logic;  -- Request to set the data to send           
    data_valid_o         : out   std_logic;  -- Data ready to be read
    data_from_master_o   : out   std_logic_vector(7 downto 0);  -- Data from master
    scl                  : inout std_logic;  -- I2C Clock
    sda                  : inout std_logic);                  -- I2C SDA

end entity i2c_slave;

architecture arch_i2c_slave of i2c_slave is


  -- SIGNALS
  signal fsm : t_i2c_slave_fsm;         -- Slave FSM state

  signal addr_rw_s : std_logic_vector(7 downto 0);  -- Addr RW send by the master

  -- COUNTERS

  signal cnt_8 : integer range 0 to 8;  -- Counts from 0 to 8

  -- SDA RE and falling_edge detect
  signal sda_old_s : std_logic;         -- Old sda
  signal sda_re_s  : std_logic;         -- Flag for RE detect
  signal sda_fe_s  : std_logic;         -- Flag for the FE of sda

  -- SCL Rising_edge  an Falling edge detect
  signal scl_old_s : std_logic;         -- Old SCL
  signal scl_re_s  : std_logic;         -- Flag for the rising edge of SCL
  signal scl_fe_s  : std_logic;         -- Flag for the falling edge of SCL


  signal data_from_master_o_s : std_logic_vector(7 downto 0);  -- Data from master

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
        when IDLE =>
          if(sda_fe_s = '1') then
            fsm <= RD_ADDR_RW;
          end if;

        when RD_ADDR_RW =>
          if(cnt_8 = 8 and scl_fe_s = '1') then
            if(addr_rw_s(7 downto 1) = slave_addr) then
              fsm <= ACK_ADDR_RW;
            else
              fsm <= idle;
            end if;
          end if;

        when ACK_ADDR_RW =>
          if(scl_fe_s = '1') then
            if(addr_rw_s(0) = '0') then     -- Write order from master
              fsm <= SLV_RD;
            elsif(addr_rw_s(0) = '1') then  -- RD from master
              fsm <= SLV_WR;
            end if;
          end if;

        when SLV_RD =>
          if(cnt_8 = 8 and scl_fe_s = '1') then
            fsm <= ACK;
          end if;

        when ACK =>
          if(scl_fe_s = '1') then
            fsm <= RD_STOP;
          end if;

        when RD_STOP =>
          if(scl_in = '1' and sda_re_s = '1') then
          end if;
        when others => null;
      end case;
    end if;
  end process p_fsm_manage;


  -- purpose: This process detects the start condition
  p_start_detect : process (clock_i, reset_n_i)
  begin  -- process p_start_detect
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      sda_old_s <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(fsm = IDLE) then
        sda_old_s <= sda_in;
      end if;
    end if;
  end process p_start_detect;
  sda_fe_s <= not sda_in and sda_old_s;
  sda_re_s <= sda_in and not sda_old_s;


  -- purpose: This process detect the RE on SCL
  p_scl_re_detect : process (clock_i, reset_n_i)
  begin  -- process p_scl_re_detect
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      scl_old_s <= '1';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      scl_old_s <= scl_in;
    end if;
  end process p_scl_re_detect;
  scl_re_s <= scl_in and not scl_old_s;
  scl_fe_s <= not scl_in and scl_old_s;

  -- purpose: This process manages the SDA line
  p_sda_manage : process (clock_i, reset_n_i)
  begin  -- process p_sda_manage
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      en_sda  <= '0';                   -- Set SDA to 'Z'
      sda_out <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(fsm = IDLE) then
        en_sda  <= '0';
        sda_out <= '0';
      elsif(fsm = RD_ADDR_RW) then
        en_sda  <= '0';
        sda_out <= '0';
      elsif(fsm = ACK_ADDR_RW) then
        en_sda  <= '1';
        sda_out <= '0';                 -- Gen the ACK on the line
      elsif(fsm = SLV_RD) then
        en_sda  <= '0';                 -- Release the bus => 'Z'
        sda_out <= '0';
      elsif(fsm = ACK) then
        en_sda  <= '1';
        sda_out <= '0';
      elsif(fsm = RD_STOP) then
        en_sda  <= '0';                 -- Release the bus => 'Z'
        sda_out <= '0';
      end if;
    end if;
  end process p_sda_manage;


  -- purpose: This process counts the transmitted bits 
  p_bit_count : process (clock_i, reset_n_i) is
  begin  -- process p_bit_count
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      cnt_8                <= 0;
      addr_rw_s            <= (others => '0');
      data_from_master_o_s <= (others => '0');
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(fsm = RD_ADDR_RW) then
        if(scl_re_s = '1') then
          if(cnt_8 < 8) then
            cnt_8                <= cnt_8 + 1;
            addr_rw_s(7 - cnt_8) <= sda_in;
          else
            cnt_8 <= 0;
          end if;
        end if;
      elsif(fsm = SLV_RD) then
        if(scl_re_s = '1') then
          if(cnt_8 < 8) then
            cnt_8                           <= cnt_8 + 1;
            data_from_master_o_s(7 - cnt_8) <= sda_in;
          else
            cnt_8 <= 0;
          end if;
        end if;
      else
        cnt_8 <= 0;
      end if;
    end if;
  end process p_bit_count;

  -- I2C interface
  scl <= scl_out when en_scl = '1' else 'Z';  -- Write on SCL output
  sda <= sda_out when en_sda = '1' else 'Z';  -- Write on SDA output

  scl_in <= scl;
  sda_in <= sda;


end architecture arch_i2c_slave;
