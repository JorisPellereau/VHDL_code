-------------------------------------------------------------------------------
-- Title      : Test du TX RS232
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_rx_rs232.vhd
-- Author     :   <lore@modelsim-31>
-- Company    : 
-- Created    : 2019-04-24
-- Last update: 2019-04-29
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Unitary test of the RS232 TX transmission
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-04-24  1.0      lore    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

entity test_tx_rs232 is

end entity test_tx_rs232;

architecture arch of test_tx_rs232 is

  -- Inst Signals
  signal reset_n : std_logic;
  signal clock   : std_logic := '0';

  -- TX common
  signal start_tx : std_logic;
  signal tx_data  : std_logic_vector(7 downto 0);

  -- TX Inst
  -- Inst1
  signal tx_1      : std_logic;
  signal tx_done_1 : std_logic;

  -- Inst2
  signal tx_2      : std_logic;
  signal tx_done_2 : std_logic;

  -- Inst3
  signal tx_3      : std_logic;
  signal tx_done_3 : std_logic;

  -- Inst4
  signal tx_4      : std_logic;
  signal tx_done_4 : std_logic;

  -- Inst5
  signal tx_5      : std_logic;
  signal tx_done_5 : std_logic;

  -- Inst6
  signal tx_6      : std_logic;
  signal tx_done_6 : std_logic;

  -- RX Inst common
  signal rx : std_logic;

  -- RX Inst 1
  signal rx_data_1     : std_logic_vector(7 downto 0);
  signal rx_done_1     : std_logic;
  signal parity_rcvd_1 : std_logic;
  
begin  -- architecture arch

  -- TX RS232 instanciation
  inst_tx_rs232_1 : tx_rs232
    generic map (
      stop_bit_number => 2,
      parity          => even,
      baudrate        => b115200,
      data_size       => 8,
      polarity        => '1',
      first_bit       => lsb_first,
      clock_frequency => 48000000)
    port map (
      reset_n  => reset_n,
      clock    => clock,
      start_tx => start_tx,
      tx_data  => tx_data,
      tx       => tx_1,
      tx_done  => tx_done_1);

  -- TX RS232 instanciation
  inst_tx_rs232_2 : tx_rs232
    generic map (
      stop_bit_number => 2,
      parity          => even,
      baudrate        => b115200,
      data_size       => 8,
      polarity        => '1',
      first_bit       => msb_first,
      clock_frequency => 48000000)
    port map (
      reset_n  => reset_n,
      clock    => clock,
      start_tx => start_tx,
      tx_data  => tx_data,
      tx       => tx_2,
      tx_done  => tx_done_2);


  -- TX RS232 instanciation
  inst_tx_rs232_3 : tx_rs232
    generic map (
      stop_bit_number => 1,
      parity          => even,
      baudrate        => b115200,
      data_size       => 8,
      polarity        => '1',
      first_bit       => lsb_first,
      clock_frequency => 48000000)
    port map (
      reset_n  => reset_n,
      clock    => clock,
      start_tx => start_tx,
      tx_data  => tx_data,
      tx       => tx_3,
      tx_done  => tx_done_3);

  -- TX RS232 instanciation
  inst_tx_rs232_4 : tx_rs232
    generic map (
      stop_bit_number => 1,
      parity          => even,
      baudrate        => b115200,
      data_size       => 8,
      polarity        => '1',
      first_bit       => msb_first,
      clock_frequency => 48000000)
    port map (
      reset_n  => reset_n,
      clock    => clock,
      start_tx => start_tx,
      tx_data  => tx_data,
      tx       => tx_4,
      tx_done  => tx_done_4);


-- TX RS232 instanciation
  inst_tx_rs232_5 : tx_rs232
    generic map (
      stop_bit_number => 1,
      parity          => odd,
      baudrate        => b115200,
      data_size       => 8,
      polarity        => '1',
      first_bit       => msb_first,
      clock_frequency => 48000000)
    port map (
      reset_n  => reset_n,
      clock    => clock,
      start_tx => start_tx,
      tx_data  => tx_data,
      tx       => tx_5,
      tx_done  => tx_done_5);


  -- TX RS232 instanciation
  inst_tx_rs232_6 : tx_rs232
    generic map (
      stop_bit_number => 1,
      parity          => odd,
      baudrate        => b115200,
      data_size       => 8,
      polarity        => '1',
      first_bit       => lsb_first,
      clock_frequency => 48000000)
    port map (
      reset_n  => reset_n,
      clock    => clock,
      start_tx => start_tx,
      tx_data  => tx_data,
      tx       => tx_6,
      tx_done  => tx_done_6);


-- RX UART instanciation 1
  inst_rx_uart_1 : rx_uart
    generic map(
      stop_bit_number => 2,
      parity          => even,
      baudrate        => b115200,
      data_size       => 8,
      first_bit       => lsb_first,
      clock_frequency => 48000000)
    port map(
      reset_n     => reset_n,
      clock       => clock,
      rx          => tx_1,
      rx_data     => rx_data_1,
      rx_done     => rx_done_1,
      parity_rcvd => parity_rcvd_1);

  -- Clock gen
  p_gen_clock : process
  begin
    clock <= not clock;
    wait for 10.416666 ns;
  end process;


  -- Stimuli
  p_test : process
    variable bit_duration : integer := 0;
  begin
    -- Init inputs
    reset_n  <= '0', '1' after 10 us;
    start_tx <= '0';
    tx_data  <= (others => '0');

    bit_duration := compute_bit_duration(48000000, b115200);

    report "Calcul duree d'un bit : " & integer'image(bit_duration);


    wait for 20 us;
    tx_data  <= x"99";
    start_tx <= '1', '0' after 100 ns;


    wait until rising_edge(tx_done_1);

    wait for 200 us;
    tx_data  <= x"98";
    start_tx <= '1', '0' after 100 ns;


    report "end of test !";
    wait;
    
  end process;

end architecture arch;
