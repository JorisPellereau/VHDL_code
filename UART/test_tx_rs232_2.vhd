-------------------------------------------------------------------------------
-- Title      : Test du TX RS232
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_rx_rs232.vhd
-- Author     :   <lore@modelsim-31>
-- Company    : 
-- Created    : 2019-04-24
-- Last update: 2019-05-27
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

entity test_tx_rs232_2 is

end entity test_tx_rs232_2;

architecture arch of test_tx_rs232_2 is

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


  -- TX on DE NANO inst
  signal clock_de : std_logic := '0';
  signal tx_de    : std_logic;

  component top_test_uart is
    port (
      clock   : in  std_logic;          -- Input system clock
      reset_n : in  std_logic;          -- Active low asynchronous reset
      tx      : out std_logic);         -- TX output
  end component;


begin  -- architecture arch


  -- =========================
  -- Transmitter Instanciation
  -- =========================

  -- TX RS232 instanciation 1
  inst_tx_rs232_1 : tx_rs232
    generic map (
      stop_bit_number => 1,
      parity          => none,
      baudrate        => b9600,
      data_size       => 8,
      polarity        => '1',
      first_bit       => lsb_first,
      clock_frequency => 50000000)
    port map (
      reset_n  => reset_n,
      clock    => clock,
      start_tx => start_tx,
      tx_data  => tx_data,
      tx       => tx_1,
      tx_done  => tx_done_1);



  -- Inst top DE NANO
  top_test_uart_inst : top_test_uart
    port map(clock   => clock,
             reset_n => reset_n,
             tx      => tx_de);

  -- Clock gen
  p_gen_clock : process
  begin
    clock <= not clock;
    wait for 10 ns;                     -- 50MHz
  end process;


  -- Stimuli
  p_test : process
    variable bit_duration : integer := 0;
  begin
    -- Init inputs
    reset_n  <= '0', '1' after 10 us;
    start_tx <= '0';
    tx_data  <= (others => '0');

    bit_duration := compute_bit_duration(50000000, b9600);

    report "Calcul duree d'un bit : " & integer'image(bit_duration);



    tx_data  <= x"99";
    wait for 20 us;
    start_tx <= '1';
    wait for 10 us;
    start_tx <= '0';


    wait until rising_edge(tx_done_1);

    tx_data  <= x"98";
    wait for 200 us;
    start_tx <= '1';
    wait for 10 us;
    start_tx <= '0';


    report "end of test !";
    wait;

  end process;

end architecture arch;
