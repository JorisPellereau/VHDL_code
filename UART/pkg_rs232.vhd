-------------------------------------------------------------------------------
-- Title      : Package of RS232 communication
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_rs232.vhd
-- Author     :   
-- Company    : 
-- Created    : 2019-04-24
-- Last update: 2019-04-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file is the package of the RS232 communication
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-04-24  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package pkg_rs232 is

  -- NEW TYPES
  type t_rs232_tx_fsm is (IDLE, START_BIT_GEN, DATA_GEN, PARITY_GEN, STOP_BIT_GEN, STOP);  -- State of the TX FSM
  type t_rx_fsm is(IDLE, WAIT_START, READ_START, READ_DATA, READ_PARITY, READ_STOP_BIT, STOP);  -- States of the RX FSM
  type t_baudrate is (
    b110,
    b300,
    b1200,
    b2400,
    b4800,
    b9600,
    b19200,
    b38400,
    b57600,
    b115200,
    b230400,
    b460800,
    b921600,
    b1843200,
    b3686400);                          -- Definition of the possible baudrate

  type t_parity is (even, odd, none);   -- Parity definition
  type t_first_bit is (lsb_first, msb_first);

  -- NEW FUNCTIONS
  function compute_bit_duration (
    constant clock_frequency : integer;     -- Input clock frequency
    constant baudrate        : t_baudrate)  -- Baudrate
    return integer;


  function number_of_bit_computation (
    constant stop_bit_number : integer range 1 to 2;  -- Number of stop bit
    constant parity          : t_parity;  -- Parity of the configuration
    constant data_size       : integer range 5 to 9)  -- Number of data in the RS232 transaction
    return integer;

  -- COMPONENTS
  component tx_rs232 is
    generic (
      stop_bit_number : integer range 1 to 2 := 1;  -- Number of stop bit
      parity          : t_parity             := even;  -- Type of the parity
      baudrate        : t_baudrate           := b115200;    -- Baudrate
      data_size       : integer range 5 to 9 := 8;  -- Size of the data to transmit
      polarity        : std_logic            := '1';  -- Polarity in idle state
      first_bit       : t_first_bit          := lsb_first;  -- LSB or MSB first
      clock_frequency : integer              := 20000000);  -- Clock frequency [Hz]

    port (
      reset_n  : in  std_logic;         -- Asynchronous reset
      clock    : in  std_logic;         -- Clock
      start_tx : in  std_logic;         -- start a TX transaction
      tx_data  : in  std_logic_vector(data_size - 1 downto 0);  -- Data to transmit
      tx       : out std_logic;         -- Serial output transmission
      tx_done  : out std_logic);        -- Transaction done
  end component;

  component rx_uart is
    generic (
      stop_bit_number : integer range 1 to 2 := 1;  -- Number of stop bit
      parity          : t_parity             := even;  -- Type of the parity
      baudrate        : t_baudrate           := b9600;      -- Baudrate
      data_size       : integer range 5 to 9 := 8;  -- Size of the data to transmit
      polarity        : std_logic            := '1';  -- Polarity in idle state
      first_bit       : t_first_bit          := lsb_first;  -- LSB or MSB first
      clock_frequency : integer              := 20000000);  -- Clock frequency [Hz]
    port (
      reset_n     : in  std_logic;      -- Asynchronous reset
      coc         : in  std_logic :     -- Clock
      rx          : in  std_logic;      -- Serial input
      rx_data     : out std_logic_vector(data_size - 1 downto 0);  -- Received data
      rx_done     : out std_logic;      -- Flag for a received data
      parity_rcvd : out std_logic);     -- Parity received
  end component rx_uart;

end package pkg_rs232;

package body pkg_rs232 is

  -- purpose: This function compute the duration of a bit according to the input clock frequency and the baudrate
  function compute_bit_duration (
    constant clock_frequency : integer;     -- Input clock frequency
    constant baudrate        : t_baudrate)  -- Baudrate
    return integer is
    variable bit_duration : integer := 0;   -- Bit duration
  begin  -- function compute_bit_duration

    case baudrate is
      when b110 =>
        bit_duration := clock_frequency/110;
      when b300 =>
        bit_duration := clock_frequency/300;
      when b1200 =>
        bit_duration := clock_frequency/1200;
      when b2400 =>
        bit_duration := clock_frequency/2400;
      when b4800 =>
        bit_duration := clock_frequency/4800;
      when b9600 =>
        bit_duration := clock_frequency/9600;
      when b19200 =>
        bit_duration := clock_frequency/19200;
      when b38400 =>
        bit_duration := clock_frequency/38400;
      when b57600 =>
        bit_duration := clock_frequency/57600;
      when b115200 =>
        bit_duration := clock_frequency/115200;
      when b230400 =>
        bit_duration := clock_frequency/230400;
      when b460800 =>
        bit_duration := clock_frequency/460800;
      when b921600 =>
        bit_duration := clock_frequency/921600;
      when b1843200 =>
        bit_duration := clock_frequency/1843200;
      when b3686400 =>
        bit_duration := clock_frequency/3686400;
      when others => null;
    end case;

    return bit_duration;
  end function compute_bit_duration;

  -- purpose : This function compute the number of bit in the RS232 transaction
  -- according to the generic parameters
  function number_of_bit_computation (
    constant stop_bit_number : integer range 1 to 2;  -- Number of stop bit
    constant parity          : t_parity;  -- Parity of the configuration
    constant data_size       : integer range 5 to 9)  -- Number of data in the RS232 transaction
    return integer is
    variable number_of_bit : integer := 0;            -- Number of bit
  begin

    number_of_bit := stop_bit_number + data_size;

    case parity is
      when none =>
        number_of_bit := number_of_bit + 0;
      when even =>
        number_of_bit := number_of_bit + 1;
      when odd =>
        number_of_bit := number_of_bit + 1;
      when others => null;
    end case;

    return number_of_bit;
  end function number_of_bit_computation;


end package body pkg_rs232;
