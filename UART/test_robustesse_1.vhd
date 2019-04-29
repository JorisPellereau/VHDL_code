-------------------------------------------------------------------------------
-- Title      : Test de robustesse Emmision-Reception
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_robustesse_1.vhd
-- Author     :  
-- Company    : 
-- Created    : 2019-04-29
-- Last update: 2019-04-29
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is a robustness test.
-- Configuration : 1 stop bit - 8 data
--                 No Parity - 9600 bauds - lsb_first - polarity : '1'
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-04-29  1.0      tesson  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

entity test_robustesse is

end entity test_robustesse;

architecture behv of test_robustesse is

  -- Constants
  constant clock_frequency : integer              := 48000000;  -- Clock [Hz]
  constant T_clock         : time                 := 20.8333333 ns;  -- 1/48MHz = 20.8333333ns
  constant data_size       : integer range 5 to 9 := 8;  -- Size of the data to transmit


  -- TB Signals
  signal reset_n : std_logic              := '1';  -- Reset
  signal clock   : std_logic              := '0';  -- Clock
  signal KO_cnt  : integer range 0 to 256 := 0;    -- KO test counter
  signal OK_cnt  : integer range 0 to 256 := 0;    -- Ok test counter



  -- TX Signals
  signal tx_data  : std_logic_vector(data_size - 1 downto 0) := (others => '0');  -- Data to transmit
  signal start_tx : std_logic;          -- Start a TX transaction
  signal tx_done  : std_logic;          -- TX transaction done
  signal tx       : std_logic;          -- Tx output

  -- RX Signals
  signal rx          : std_logic;       -- Rx input
  signal rx_data     : std_logic_vector(data_size - 1 downto 0);  -- Received data
  signal rx_done     : std_logic;       -- Flag data received
  signal parity_rcvd : std_logic;       -- Parity received
  
begin


  -- Clock generation
  p_clock_gen : process
  begin
    clock <= not clock;
    wait for T_clock/2.0;
  end process p_clock_gen;


  -- TX inst
  tx_inst : tx_rs232
    generic map (
      stop_bit_number => 1,
      parity          => even,
      baudrate        => b921600,
      data_size       => data_size,
      polarity        => '1',
      first_bit       => lsb_first,
      clock_frequency => clock_frequency)
    port map (
      reset_n  => reset_n,
      clock    => clock,
      start_tx => start_tx,
      tx_data  => tx_data,
      tx       => tx,
      tx_done  => tx_done);

  -- RX inst
  rx_inst : rx_uart
    generic map (
      stop_bit_number => 1,
      parity          => even,
      baudrate        => b921600,
      data_size       => data_size,
      polarity        => '1',
      first_bit       => lsb_first,
      clock_frequency => clock_frequency)
    port map(
      reset_n     => reset_n,
      clock       => clock,
      rx          => rx,
      rx_data     => rx_data,
      rx_done     => rx_done,
      parity_rcvd => parity_rcvd);

  rx <= transport tx after 10 us;


  p_test : process
  begin

    -- TB signals init
    KO_cnt   <= 0;
    OK_cnt   <= 0;
    -- Input Initialization
    start_tx <= '0';
    tx_data  <= (others => '0');

    -- Reset generation
    reset_n <= '1';
    wait for 25*T_clock;
    reset_n <= '0';
    wait for 25*T_clock;
    reset_n <= '1';
    -- reset_n <= '1', '0' after 25*T_clock, '1' after 25*T_clock;


    wait for 50*T_clock;

    for i in 0 to 255 loop
      tx_data  <= std_logic_vector(to_unsigned(i, tx_data'length));
      start_tx <= '1', '0' after 50*T_clock;
      wait until (rx_done = '1' and tx_done = '1') for 500 ms;
      if(rx_done = '0' or tx_done = '0') then  -- Detect if a transaction is received
        assert false report "Pas de trame recu !!!" severity failure;
      end if;

      if(rx_data = tx_data) then
        report "Test " & integer'image(i) & " : OK - Rx : " & integer'image(to_integer(unsigned(rx_data))) & " Tx : " & integer'image(to_integer(unsigned(tx_data)));
        OK_cnt <= OK_cnt + 1;
      else
        report "Test " & integer'image(i) & " : KO - Rx : " & integer'image(to_integer(unsigned(rx_data))) & " Tx : " & integer'image(to_integer(unsigned(tx_data)));
        KO_cnt <= KO_cnt + 1;
      end if;
      wait for 500*T_clock;
    end loop;

    report "Nombre de OK : " & integer'image(OK_cnt);
    report "Nombre de KO : " & integer'image(KO_cnt);

    assert false report "end of Test !!" severity failure;
    wait;
  end process;

end architecture behv;
