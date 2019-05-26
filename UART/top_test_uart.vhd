-------------------------------------------------------------------------------
-- Title      : Top test file
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_test_uart.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2019-05-26
-- Last update: 2019-05-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the top test file
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-26  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

entity top_test_uart is

  port (
    clock      : in  std_logic;         -- Input system clock
    reset_n    : in  std_logic;         -- Active low asynchronous reset
    start_tx_i : in  std_logic;         -- Button to start a transaction
    tx         : out std_logic);        -- TX output

end entity top_test_uart;

architecture arch_top_test_uart of top_test_uart is

  -- CONSTANTS
  constant C_uart_data : std_logic_vector(7 downto 0) := x"EF";  -- DAta to transmit for test
  constant C_max_cnt   : integer                      := 50000000;  -- Max counter

  -- SIGNALS
  signal cnt_s : integer range 0 to C_max_cnt;  -- Counter Timer

  -- TX uart inst
  signal start_tx_s : std_logic;        -- Start an UART transaction
  signal tx_data_s  : std_logic_vector(7 downto 0);  -- Data to transmit
  signal tx_s       : std_logic;        -- Output
  signal tx_done_s  : std_logic;        -- Flag for a terminated frame

begin  -- architecture arch_top_test_uart


  -- purpose: This process generates the start for uart frame 
  p_start_gen : process (clock, reset_n) is
  begin  -- process p_start_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      start_tx_s <= '0';
      cnt_s      <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge

      if(tx_done_s = '1') then
        start_tx_s <= '1';
      end if;
      -- if(cnt_s = C_max_cnt) then
      --   cnt_s      <= 0;
      --   start_tx_s <= '1';
      -- else
      --   cnt_s <= cnt_s + 1;
      -- end if;

      -- -- if(cnt_s <= C_max_cnt / 2) then
      -- --   start_tx_s <= '0';
      -- -- else
      -- --   start_tx_s <= '1';
      -- end if;
      -- else
      --   start_tx_s <= '0';
      -- end if;


    end if;
  end process p_start_gen;

  -- start_tx_s <= not start_tx_i;

  tx_data_s <= C_uart_data;

  tx_rx232_inst : tx_rs232
    generic map (
      stop_bit_number => 1,
      parity          => none,
      baudrate        => b9600,
      data_size       => 8,
      polarity        => '1',
      first_bit       => lsb_first,
      clock_frequency => 50000000)

    port map(
      reset_n  => reset_n,
      clock    => clock,
      start_tx => start_tx_s,
      tx_data  => tx_data_s,
      tx       => tx_s,
      tx_done  => tx_done_s);


  tx <= tx_s;
end architecture arch_top_test_uart;
