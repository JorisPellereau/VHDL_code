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
  -- CONSTANTS
  constant bit_duration      : integer := compute_bit_duration(clock_frequency, baudrate);  -- Duration of a bit according to the clock frequency and the baudrate
  constant half_bit_duration : integer := bit_duration / 2;  -- Half bit duration
  constant number_of_bits    : integer := number_of_bit_computation(stop_bit_number, parity, data_size);  -- number of bit in the transaction

  -- SIGNALS
  signal rx_fsm       : t_rx_fsm;       -- RX uart FSM
  signal rx_old       : std_logic;      -- Latch RX input
  signal start_rx_fe  : std_logic;      -- Start bit Falling edge detected
  signal start_rx_re  : std_logic;      -- Start_bit rising edge detected
  signal start_cnt    : std_logic;  -- Start counter in order to generate Tick
  signal tick_data    : std_logic;  -- Tick data in order to read the RX input
  signal rx_data_s    : std_logic_vector(data_size - 1 downto 0);  -- Save the RX data input
  -- COUNTERS
  signal cnt_half_bit : integer range 0 to half_bit_duration;  -- Counter halft bit in order to sample the data
  signal cnt_bit      : integer range 0 to bit_duration;  -- Counter bit duration
  signal cnt_data     : integer range 0 to data_size;  -- Counter of the data

  -- purpose : This process manages the FSM on the RX UART
  p_rx_fsm_mng : process (clock, reset_n) is
  begin  -- process p_rx_fsm_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      rx_fsm <= IDLE;
    elsif clock'event and clock = '1' then  -- rising clock edge
      case rx_fsm is
        when IDLE =>
          rx_fsm <= WAIT_START;
        when WAIT_START =>
          if(polarity = '1') then
            if(start_rx_fe = '1') then
              rx_fsm <= READ_START;
            end if;
          elsif(polarity = '0') then
            if(start_rx_re = '1') then
              rx_fsm <= READ_START;
            end if;
          end if;
        when READ_START =>
          if(tick_data = '1') then
            rx_fsm <= READ_DATA;
          end if;
        when READ_DATA =>
          if(tick_data = '1' and cnt_data = data_size - 1) then
            if(parity /= none) then
              rx_fsm <= READ_PARITY;
            else
              rx_fsm <= READ_STOP_BIT;
            end if;
          end if;
        when READ_PARITY =>
          
        when others => null;
      end case;
    end if;
  end process p_rx_fsm_mng;


  -- purpose: This process detect the start of an UART reception 
  p_start_detect : process (clock, reset_n) is
  begin  -- process p_start_detect
    if reset_n = '0' then                   -- asynchronous reset (active low)
      rx_old <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(rx_fsm = WAIT_START) then
        rx_old <= rx;
      else
        rx_old <= '0';
      end if;
    end if;
  end process p_start_detect;

  -- Detect the start bit
  start_rx_fe <= (not rx) and rx_old when polarity = '1' else '0';
  start_rx_re <= rx and (not rx_old) when polarity = '0' else '0';


  -- purpose: This process generates ticks in order to read the input data 
  p_tick_read_data : process (clock, reset_n) is
  begin  -- process p_tick_read_data
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_half_bit <= 0;
      start_cnt    <= '0';
      tick_data    <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(rx_fsm = WAIT_START) then
        if(start_rx_re = '1' or start_rx_fe = '1') then
          start_cnt <= '1';
        end if;
      elsif(rx_fsm = READ_START) then
        if(cnt_half_bit < half_bit_duration) then
          cnt_half_bit <= cnt_half_bit + 1;
          tick_data    <= '0';
        else
          cnt_half_bit <= 0;
          tick_data    <= '1';
        end if;
      elsif(rx_fsm = READ_DATA) then
        if(cnt_bit < bit_duration) then
          cnt_bit   <= cnt_bit + 1;
          tick_data <= '0';
        else
          cnt_bit   <= 0;
          tick_data <= '1';
        end if;
      end if;
    end if;
  end process p_tick_read_data;

  -- purpose: This process count the data to received 
  p_data_cnt : process (clock, reset_n) is
  begin  -- process p_data_cnt
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_data <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(rx_fsm = READ_DATA) then
        if(tick_data = '1') then
          if(cnt_data < data_size) then
            cnt_data <= cnt_data + 1;       -- INC cnt
          else
            cnt_data <= 0;
          end if;
        end if;
      else
        cnt_data <= 0;
      end if;
    end if;
  end process p_data_cnt;


--   if reset_n = '0' then                 -- asynchronous reset (active low)

--   elsif clock'event and clock = '1' then  -- rising clock edge

--   end if;
-- end process p_read_rx;


end architecture arch;
