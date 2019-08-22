-------------------------------------------------------------------------------
-- Title      : Test of the UART Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_uart_ctrl.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-08-22
-- Last update: 2019-08-22
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Unitary test of the UART Controller for the pinball project
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

entity test_uart_ctrl is

end entity test_uart_ctrl;

architecture arch_test_uart_ctrl of test_uart_ctrl is

  -- TESTBENCH Constants
  constant C_Clock_period : time := 20 ns;  -- CLock Period

  -- UART CTRL Config
  constant C_stop_bit_nb     : integer              := 1;    -- Stop_bit_nb
  constant C_parity          : t_parity             := even;      -- Parity
  constant C_baudrate        : t_baudrate           := b115200;   -- Baudrate
  constant C_data_size       : integer range 5 to 9 := 8;    -- Data zize
  constant C_polarity        : std_logic            := '1';  -- High polarity
  constant C_first_bit       : t_first_bit          := lsb_first;  -- LSB First
  constant C_clock_frequency : integer              := 50000000;  -- Clock freq

  -- Signals
  signal reset_n : std_logic := '1';
  signal clock   : std_logic := '0';

  -- UART CTRL Signals
  signal rx_uart_i : std_logic;         -- RX UART input
  signal tx_uart_o : std_logic;         -- TX UART output


  -- TX UART Injector
  signal start_tx_inj : std_logic                                  := '0';
  signal tx_data_inj  : std_logic_vector(C_data_size - 1 downto 0) := (others => '0');
  signal tx_done_inj  : std_logic                                  := '0';

  -- RX UART CHECKER
  signal rx_data_checker     : std_logic_vector(C_data_size - 1 downto 0);
  signal rx_done_checker     : std_logic;
  signal parity_rcvd_checker : std_logic;

begin  -- architecture arch_test_uart_ctrl

  -- Clock gen
  p_gen_clock : process
  begin
    clock <= not clock;
    wait for 10 ns;                     -- 50MHz
  end process;


  p_stimuli : process is
  begin  -- process p_stimuli

    wait for 5*C_Clock_period;
    reset_n <= '0';
    wait for 5*C_Clock_period;
    reset_n <= '1';

    -- == SEND 3 WRONG BYTES ==
    -- Send a first byte
    tx_data_inj  <= x"66";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;

    -- Send a 2nd byte
    tx_data_inj  <= x"88";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;

    -- Send a 3rd byte
    tx_data_inj  <= x"77";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;
    -- ==============================

    wait for 0.5 ms;

    -- == SEND 3 GOODS BYTES ==
    -- Send a first byte
    tx_data_inj  <= x"A0";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;

    -- Send a 2nd byte
    tx_data_inj  <= x"BB";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;

    -- Send a 3rd byte
    tx_data_inj  <= x"DE";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;
    -- ==============================

    wait for 0.5 ms;

    -- == SEND 3 WRONG BYTES ==
    -- Send a first byte
    tx_data_inj  <= x"11";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;

    -- Send a 2nd byte
    tx_data_inj  <= x"22";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;

    -- Send a 3rd byte
    tx_data_inj  <= x"33";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;


    
    
    -- ==============================

    wait for 0.5 ms;

    -- == SEND 3 GOODS BYTES ==
    -- Send a first byte
    tx_data_inj  <= x"A0";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;

    -- Send a 2nd byte
    tx_data_inj  <= x"BB";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;

    -- Send a 3rd byte
    tx_data_inj  <= x"DE";
    wait for 2*C_Clock_period;
    start_tx_inj <= '1', '0' after 2*C_Clock_period;
    wait until rising_edge(tx_done_inj) for 10 ms;
    -- ==============================


    report "end of simu";
    wait;


  end process p_stimuli;

  -- UART_CTRL inst
  uart_ctrl_inst : uart_ctrl
    generic map (
      stop_bit_number => C_stop_bit_nb,
      parity          => C_parity,
      baudrate        => C_baudrate,
      data_size       => C_data_size,
      polarity        => C_polarity,
      first_bit       => C_first_bit,
      clock_frequency => C_clock_frequency)
    port map (
      reset_n   => reset_n,
      clock_i   => clock,
      rx_uart_i => rx_uart_i,
      tx_uart_o => tx_uart_o);


  -- TX UART injector
  tx_uart_inj_inst : tx_rs232
    generic map (
      stop_bit_number => C_stop_bit_nb,
      parity          => C_parity,
      baudrate        => C_baudrate,
      data_size       => C_data_size,
      polarity        => C_polarity,
      first_bit       => C_first_bit,
      clock_frequency => C_clock_frequency)
    port map(
      reset_n  => reset_n,
      clock    => clock,
      start_tx => start_tx_inj,
      tx_data  => tx_data_inj,
      tx       => rx_uart_i,
      tx_done  => tx_done_inj);

  -- RX UART checker
  rx_uart_checker_inst : rx_uart
    generic map (
      stop_bit_number => C_stop_bit_nb,
      parity          => C_parity,
      baudrate        => C_baudrate,
      data_size       => C_data_size,
      polarity        => C_polarity,
      first_bit       => C_first_bit,
      clock_frequency => C_clock_frequency)
    port map (
      reset_n     => reset_n,
      clock       => clock,
      rx          => tx_uart_o,
      rx_data     => rx_data_checker,
      rx_done     => rx_done_checker,
      parity_rcvd => parity_rcvd_checker);

end architecture arch_test_uart_ctrl;
