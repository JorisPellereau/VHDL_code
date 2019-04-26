-------------------------------------------------------------------------------
-- Title      : UART reception
-- Project    : 
-------------------------------------------------------------------------------
-- File       : rx_uart.vhd
-- Author     :   Joris Pellereau
-- Company    : 
-- Created    : 2019-04-26
-- Last update: 2019-04-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-04-26  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

entity rx_uart is

  generic (
    stop_bit_number : integer range 1 to 2 := 1;  -- Stop bit number
    parity          : t_parity             := even;       -- Type of the parity
    baudrate        : t_baudrate           := b9600;      -- Baudrate
    data_size       : integer range 0 to 9 := 8;  -- Size of the data to received
    polarity        : std_logic            := '1';  -- Polarity on idle state
    first_bit       : t_first_bit          := lsb_first;  -- LSB or MSB first
    clock_frequency : integer              := 20000000);  -- Clock frequency [Hz]

  port (
    reset_n     : in  std_logic;        -- Asynchronous reset
    clock       : in  std_logic;        -- Clock
    rx          : in  std_logic;        -- Serial input
    rx_data     : out std_logic_vector(data_size - 1 downto 0);  -- Received data
    rx_done     : out std_logic;        -- Flag for a received data
    parity_rcvd : out std_logic);       -- Parity received

end entity rx_uart;

architecture arch of rx_uart is

begin



end architecture arch;
