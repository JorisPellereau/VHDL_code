-------------------------------------------------------------------------------
-- Title      : UART Controller for the pinball project
-- Project    : 
-------------------------------------------------------------------------------
-- File       : uart_ctrl.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-08-22
-- Last update: 2019-08-22
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the UART controller for the Pinball project
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-08-22  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

entity uart_ctrl is

  generic(
    stop_bit_number : integer range 1 to 2 := 1;  -- Stop bit number
    parity          : t_parity             := even;       -- Type of the parity
    baudrate        : t_baudrate           := b9600;      -- Baudrate
    data_size       : integer range 5 to 9 := 8;  -- Size of the data to received
    polarity        : std_logic            := '1';  -- Polarity on idle state
    first_bit       : t_first_bit          := lsb_first;  -- LSB or MSB first
    clock_frequency : integer              := 20000000);  -- Clock frequency [Hz]
  port (
    reset_n   : in  std_logic;          -- Active Low Asynchronous Reset
    clock_i   : in  std_logic;          -- System clock
    rx_uart_i : in  std_logic;          -- RX UART
    tx_uart_o : out std_logic);         -- TX UART

end entity uart_ctrl;

architecture arch_uart_ctrl of uart_ctrl is

  -- UART_MNGT signals
  signal rx_data_s     : std_logic_vector(data_size - 1 downto 0);  -- Data from RX uart
  signal rx_done_s     : std_logic;     -- Data received
  signal parity_rcvd_s : std_logic;     -- Parity from the RX uart
  signal tx_done_s     : std_logic;     -- Tx uart done
  signal start_tx_s    : std_logic;     -- Start a TX uart
  signal tx_data_s     : std_logic_vector(data_size - 1 downto 0);  -- Data to transmit





begin  -- architecture arch_uart_ctrl

  -- UART_MNGT inst
  uart_mngt_inst : uart_mngt
    generic map(
      data_size => data_size)
    port map(
      reset_n       => reset_n,
      clock_i       => clock_i,
      rx_data_i     => rx_data_s,
      rx_done_i     => rx_done_s,
      parity_rcvd_i => parity_rcvd_s,
      tx_done_i     => tx_done_s,
      start_tx_o    => start_tx_s,
      tx_data_o     => tx_data_s);

  -- RX UART inst
  rx_uart_inst : rx_uart
    generic map (
      stop_bit_number => stop_bit_number,
      parity          => parity,
      baudrate        => baudrate,
      data_size       => data_size,
      polarity        => polarity,
      first_bit       => first_bit,
      clock_frequency => clock_frequency)
    port map(
      reset_n     => reset_n,
      clock       => clock_i,
      rx          => rx_uart_i,
      rx_data     => rx_data_s,
      rx_done     => rx_done_s,
      parity_rcvd => parity_rcvd_s);

  -- TX UART inst
  tx_uart_inst : tx_rs232
    generic map (
      stop_bit_number => stop_bit_number,
      parity          => parity,
      baudrate        => baudrate,
      data_size       => data_size,
      polarity        => polarity,
      first_bit       => first_bit,
      clock_frequency => clock_frequency)
    port map (
      reset_n  => reset_n,
      clock    => clock_i,
      start_tx => start_tx_s,
      tx_data  => tx_data_s,
      tx       => tx_uart_o,
      tx_done  => tx_done_s);

end architecture arch_uart_ctrl;
