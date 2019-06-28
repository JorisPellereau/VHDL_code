-------------------------------------------------------------------------------
-- Title      : 24LC02B I2C EEPROM controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2c_24lc02b_controller.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-27
-- Last update: 2019-06-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the controller for the 24LC02B component
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-27  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_i2c;
use lib_i2c.pkg_i2c.all;


entity i2c_24lc02b_controller is

  port (
    clock      : in    std_logic;       -- System Clock 50MHz
    reset_n    : in    std_logic;       -- Asynchronous active low reset
    en         : in    std_logic;
    byte_wr    : in    std_logic;
    page_wr    : in    std_logic;
    byte_rd    : in    std_logic;
    chip_addr  : in    std_logic_vector(6 downto 0);
    wdata      : in    t_byte_array;
    rdata      : out   t_byte_array;
    sack_error : out   std_logic;
    i2c_busy   : out   std_logic;
    scl        : inout std_logic;       -- Clock line
    sda        : inout std_logic
    );

end entity i2c_24lc02b_controller;


architecture arch_i2c_24lc02b_controller of i2c_24lc02b_controller is

  signal start_i2c_s  : std_logic;
  signal start_i2c_ss : std_logic;
  signal rw           : std_logic;
  signal chip_addr_s  : std_logic_vector(6 downto 0);
  signal nb_data      : integer range 1 to max_array;
  signal wdata_s      : t_byte_array;
  signal i2c_done     : std_logic;
  signal sack_error_s : std_logic;
  signal rdata_s      : t_byte_array;


begin  -- architecture arch_i2c_24lc02b_controller

  -- purpose: This process manages command send to the I2C Master 
  p_cmd_mng : process (clock, reset_n) is
  begin  -- process p_cmd_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      start_i2c_s  <= '0';
      start_i2c_ss <= '0';
      rw           <= '0';
      chip_addr_s  <= (others => '0');
      nb_data      <= 1;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(en = '1') then
        if(i2c_done = '1') then
          if(byte_wr = '1') then
            nb_data <= 2;
            rw      <= '0';
          elsif(page_wr = '1') then
            nb_data <= 9;
            rw      <= '0';
          elsif(byte_rd = '1') then
            nb_data <= 1;
            rw      <= '1';
          end if;
          start_i2c_s  <= '1';
          start_i2c_ss <= start_i2c_s;
        else
          start_i2c_s  <= '0';
          start_i2c_ss <= '0';
        end if;
      end if;
    end if;
  end process p_cmd_mng;

  -- MASTER I2C INST
  master_i2c_inst : master_i2c
    generic map(
      scl_frequency   => f400k,
      clock_frequency => 50000000)
    port map(
      reset_n    => reset_n,
      clock      => clock,
      start_i2c  => start_i2c_ss,
      rw         => rw,
      chip_addr  => chip_addr_s,
      nb_data    => nb_data,
      wdata      => wdata_s,
      i2c_done   => i2c_done,
      sack_error => sack_error_s,
      rdata      => rdata_s,
      scl        => scl,
      sda        => sda);

  sack_error <= sack_error_s;
  rdata      <= rdata_s;
  i2c_busy   <= not i2c_done;
  
end architecture arch_i2c_24lc02b_controller;


