-------------------------------------------------------------------------------
-- Title      : Test de robustesse Emmision-Reception
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_robustesse.vhd
-- Author     :  
-- Company    : 
-- Created    : 2019-04-29
-- Last update: 2019-04-30
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is a robustness test.
-- Configuration : According to the config file
--                 Default : 1 stop bit - parity : even - baudrate : b9600
--                           8 bit of data - polarity : '1' - LSB First
--                           clk : 48 MHz
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
use std.textio.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

entity test_robustesse is
  generic (
    -- TX Config
    stop_bit_number_tx : integer range 1 to 2 := 1;    -- Stop bit number
    parity_tx          : t_parity             := even;  -- Parity configuration
    baudrate_tx        : t_baudrate           := b9600;     -- Baudrate
    data_size_tx       : integer range 5 to 9 := 8;    -- Data size
    polarity_tx        : std_logic            := '1';  -- Polarity on idle state
    first_bit_tx       : t_first_bit          := lsb_first;  -- LSB or MSB first
    clock_frequency_tx : integer              := 48000000;  -- Clock frequency [Hz]

    -- RX Config
    stop_bit_number_rx : integer range 1 to 2 := 1;    -- Stop bit number
    parity_rx          : t_parity             := even;  -- Parity configuration
    baudrate_rx        : t_baudrate           := b9600;      -- Baudrate
    data_size_rx       : integer range 5 to 9 := 8;    -- Data size
    polarity_rx        : std_logic            := '1';  -- Polarity on idle state
    first_bit_rx       : t_first_bit          := lsb_first;  -- LSB or MSB first
    clock_frequency_rx : integer              := 48000000);  -- Clock frequency [Hz]

end entity test_robustesse;

architecture arch_test_robustesse of test_robustesse is

  -- Constants
  constant T_clock_tx : time := (1.0/real(clock_frequency_tx))*10.0e12 ps;
  constant T_clock_rx : time := (1.0/real(clock_frequency_rx))*10.0e12 ps;

  -- TB Signals
  signal reset_n : std_logic              := '1';  -- Reset
  signal KO_cnt  : integer range 0 to 256 := 0;    -- KO test counter
  signal OK_cnt  : integer range 0 to 256 := 0;    -- Ok test counter



  -- TX Signals
  signal tx_data  : std_logic_vector(data_size_tx - 1 downto 0) := (others => '0');  -- Data to transmit
  signal start_tx : std_logic;          -- Start a TX transaction
  signal tx_done  : std_logic;          -- TX transaction done
  signal tx       : std_logic;          -- Tx output
  signal clock_tx : std_logic                                   := '0';  -- TX clock

  -- RX Signals
  signal rx          : std_logic;       -- Rx input
  signal rx_data     : std_logic_vector(data_size_rx - 1 downto 0);  -- Received data
  signal rx_done     : std_logic;       -- Flag data received
  signal parity_rcvd : std_logic;       -- Parity received
  signal clock_rx    : std_logic := '0';  -- RX clock
  
begin


  -- Clock TX generation
  p_clock_tx_gen : process
  begin
    clock_tx <= not clock_tx;
    wait for T_clock_tx/2.0;
  end process p_clock_tx_gen;

  -- Clock RX generation
  p_clock_rx_gen : process
  begin
    clock_rx <= not clock_rx;
    wait for T_clock_rx/2.0;
  end process p_clock_rx_gen;

  -- TX inst
  tx_inst : tx_rs232
    generic map (
      stop_bit_number => stop_bit_number_tx,
      parity          => parity_tx,
      baudrate        => baudrate_tx,
      data_size       => data_size_tx,
      polarity        => polarity_tx,
      first_bit       => first_bit_tx,
      clock_frequency => clock_frequency_tx)
    port map (
      reset_n  => reset_n,
      clock    => clock_tx,
      start_tx => start_tx,
      tx_data  => tx_data,
      tx       => tx,
      tx_done  => tx_done);

  -- RX inst
  rx_inst : rx_uart
    generic map (
      stop_bit_number => stop_bit_number_rx,
      parity          => parity_rx,
      baudrate        => baudrate_rx,
      data_size       => data_size_rx,
      polarity        => polarity_rx,
      first_bit       => first_bit_rx,
      clock_frequency => clock_frequency_tx)
    port map(
      reset_n     => reset_n,
      clock       => clock_rx,
      rx          => rx,
      rx_data     => rx_data,
      rx_done     => rx_done,
      parity_rcvd => parity_rcvd);

  rx <= tx;


  p_test : process
    variable parity_result : std_logic := '0';  -- Result of the parity computation
    variable line_v        : line;      -- Line to write

  begin

    -- TB signals init
    KO_cnt   <= 0;
    OK_cnt   <= 0;
    -- Input Initialization
    start_tx <= '0';
    tx_data  <= (others => '0');

    -- Reset generation
    reset_n <= '1';
    wait for 25*T_clock_rx;
    reset_n <= '0';
    wait for 25*T_clock_rx;
    reset_n <= '1';
    -- reset_n <= '1', '0' after 25*T_clock, '1' after 25*T_clock;


    wait for 50*T_clock_rx;

    for i in 0 to 255 loop
      if(parity_tx /= none) then
        parity_result := parity_computation(i, parity_tx);
      end if;
      tx_data  <= std_logic_vector(to_unsigned(i, tx_data'length));
      start_tx <= '1', '0' after 50*T_clock_rx;
      wait until (rx_done = '1' and tx_done = '1') for 20 ms;  -- 20 ms de timeout
      if(rx_done = '0' or tx_done = '0') then  -- Detect if a transaction is received
        assert false report "Pas de trame recu !!!" severity failure;
      end if;

      if(rx_data = tx_data) then
        write(line_v, string'("Test ") & integer'image(i) & string'(" OK"));
        writeline(output, line_v);
        write(line_v, string'("Tx data : ") & integer'image(to_integer(unsigned(tx_data))) & string'(" Rx data : ") & integer'image(to_integer(unsigned(tx_data))));
        --report "Test " & integer'image(i) & " : OK - Rx : " & integer'image(to_integer(unsigned(rx_data))) & " Tx : " & integer'image(to_integer(unsigned(tx_data)));
        if(parity_tx /= none) then
          if(parity_rcvd = parity_result) then
            write(line_v, string'("Parity Received = parity computed"));
            writeline(output, line_v);
          else
            write(line_v, string'("Parity Received != parity computed"));
            writeline(output, line_v);
          end if;
        end if;
        OK_cnt <= OK_cnt + 1;
      else
        report "Test " & integer'image(i) & " : KO - Rx : " & integer'image(to_integer(unsigned(rx_data))) & " Tx : " & integer'image(to_integer(unsigned(tx_data)));
        KO_cnt <= KO_cnt + 1;
      end if;
      wait for 500*T_clock_rx;
    end loop;

    report "Nombre de OK : " & integer'image(OK_cnt);
    report "Nombre de KO : " & integer'image(KO_cnt);

    assert false report "end of Test !!" severity failure;
    wait;
  end process;

end architecture arch_test_robustesse;
