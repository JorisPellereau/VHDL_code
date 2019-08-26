-------------------------------------------------------------------------------
-- Title      : TX uart
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tx_uart.vhd
-- Author     :  
-- Company    : 
-- Created    : 2019-04-24
-- Last update: 2019-06-06
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This module send RS232 transaction
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-04-24  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

entity tx_uart is

  generic (
    stop_bit_number : integer range 1 to 2 := 1;  -- Number of stop bit
    parity          : t_parity             := even;       -- Type of the parity
    baudrate        : t_baudrate           := b115200;    -- Baudrate
    data_size       : integer range 5 to 9 := 8;  -- Size of the data to transmit
    polarity        : std_logic            := '1';  -- Polarity in idle state
    first_bit       : t_first_bit          := lsb_first;  -- LSB or MSB first
    clock_frequency : integer              := 20000000);  -- Clock frequency [Hz]

  port (
    reset_n  : in  std_logic;           -- Asynchronous reset
    clock    : in  std_logic;           -- Clock
    start_tx : in  std_logic;           -- start a TX transaction
    tx_data  : in  std_logic_vector(data_size - 1 downto 0);  -- Data to transmit
    tx       : out std_logic;           -- Serial output transmission
    tx_done  : out std_logic);          -- Transaction done

end entity tx_uart;

architecture arch of tx_uart is
  -- CONSTANTS
  constant bit_duration   : integer := compute_bit_duration(clock_frequency, baudrate);  -- Duration of a bit according to the clock frequency and the baudrate
  constant number_of_bits : integer := number_of_bit_computation(stop_bit_number, parity, data_size);  -- Number of bit in the transaction

  -- SIGNALS
  signal tx_fsm       : t_rs232_tx_fsm;  -- Signal for TX FSM
  signal latch_done_s : std_logic;       -- Flag for a latch terminated

  signal start_tx_s      : std_logic;   -- Latch start_tx
  signal start_tx_r_edge : std_logic;   -- R edge Of start tx
  signal tx_data_s       : std_logic_vector(data_size - 1 downto 0);  -- Latch input data

  signal tx_s             : std_logic;  -- To TX output
  signal cnt_bit_duration : integer range 0 to bit_duration - 1;  -- Bit duration counter

  signal tick_data : std_logic;         -- Tick in order to generate data
  signal cnt_data  : integer range 0 to data_size;  -- Data counter

  signal cnt_bit      : integer range 0 to number_of_bits;   -- Counter of bit
  signal cnt_stop_bit : integer range 0 to stop_bit_number;  -- Counter of STOP BIT

  signal tx_done_s    : std_logic;      -- Signal of done transaction
  signal parity_value : std_logic;      -- Parity result

begin  -- architecture arch



  -- purpose: This process manages the FSM of the TX RS232 transaction
  p_tx_fsm_mng : process (clock, reset_n) is
  begin  -- process p_tx_fsm_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      tx_fsm <= idle;
    elsif clock'event and clock = '1' then  -- rising clock edge
      case tx_fsm is
        when IDLE =>
          if(start_tx_r_edge = '1') then    --start_tx_s = '1') then
            tx_fsm <= LATCH_INPUTS;
          end if;
        when LATCH_INPUTS =>

          if(latch_done_s = '1') then
            tx_fsm <= START_BIT_GEN;
          end if;

        when START_BIT_GEN =>
          if(tick_data = '1') then
            tx_fsm <= DATA_GEN;
          end if;
        when DATA_GEN =>
          if(tick_data = '1' and cnt_data = data_size - 1) then
            if(parity /= none) then
              tx_fsm <= PARITY_GEN;
            else                        -- none case
              tx_fsm <= STOP_BIT_GEN;
            end if;
          end if;
        when PARITY_GEN =>
          if(tick_data = '1') then
            tx_fsm <= STOP_BIT_GEN;
          end if;
        when STOP_BIT_GEN =>
          if(tick_data = '1' and cnt_stop_bit = stop_bit_number - 1) then
            tx_fsm <= stop;
          end if;
        when stop =>
          tx_fsm <= idle;
        when others => null;
      end case;

    end if;
  end process p_tx_fsm_mng;


  -- purpose: This process detect the rising edge of start_tx
  p_start_tx_re_gen : process (clock, reset_n) is
  begin  -- process p_start_tx_re_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      start_tx_s      <= '0';               -- INIT to '0'
      start_tx_r_edge <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge

      -- if(start_tx = '1' and tx_fsm = IDLE) then
      --   start_tx_s <= '1';
      -- else
      --   start_tx_s <= '0';
      -- end if;

      start_tx_s      <= start_tx;
      start_tx_r_edge <= start_tx and not start_tx_s;
    end if;
  end process p_start_tx_re_gen;



  -- purpose: This process latches the input data when the rising_edge of start_tx input occurs
  p_latch_data : process (clock, reset_n) is
  begin  -- process p_latch_data
    if reset_n = '0' then                   -- asynchronous reset (active low)
      tx_data_s    <= (others => '0');
      latch_done_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(tx_fsm = LATCH_INPUTS) then
        tx_data_s    <= tx_data;
        latch_done_s <= '1';
      else
        latch_done_s <= '0';
      end if;
    end if;
  end process p_latch_data;


  -- purpose: This process generates ticks in order to generate bits
  p_tick_gen_bit : process (clock, reset_n) is
  begin  -- process p_tick_gen_bit
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_bit_duration <= 0;
      tick_data        <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if (tx_fsm /= idle and tx_fsm /= LATCH_INPUTS and tx_fsm /= stop) then
        if(cnt_bit_duration < bit_duration - 1) then
          cnt_bit_duration <= cnt_bit_duration + 1;
          tick_data        <= '0';
        else
          cnt_bit_duration <= 0;
          tick_data        <= '1';
        end if;
      else
        cnt_bit_duration <= 0;
        tick_data        <= '0';
      end if;
    end if;
  end process p_tick_gen_bit;


  -- purpose: This process count the number of bit to transmit 
  p_bit_cnt : process (clock, reset_n) is
  begin  -- process p_bit_cnt
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_bit <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(tx_fsm /= idle and tx_fsm /= stop) then
        if(tick_data = '1') then
          if(cnt_bit < number_of_bits) then
            cnt_bit <= cnt_bit + 1;
          else
            cnt_bit <= 0;
          end if;
        end if;
      else
        cnt_bit <= 0;
      end if;
    end if;
  end process p_bit_cnt;



  -- purpose: This process generates the TX output
  p_tx_gen : process (clock, reset_n) is
  begin  -- process p_tx_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      tx_s         <= polarity;
      cnt_data     <= 0;
      cnt_stop_bit <= 0;
      parity_value <= '0';
      tx_done_s    <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(tx_fsm = idle) then
        tx_s      <= polarity;
        tx_done_s <= '1';
      elsif(tx_fsm = LATCH_INPUTS) then
        tx_done_s <= '0';
      elsif(tx_fsm = START_BIT_GEN) then
        tx_s <= '0';
      elsif(tx_fsm = DATA_GEN) then
        if(cnt_data < data_size) then
          if(first_bit = lsb_first) then
            tx_s <= tx_data_s(cnt_data);
          elsif(first_bit = msb_first) then
            tx_s <= tx_data_s(7 - cnt_data);
          end if;
          if(tick_data = '1') then
            cnt_data     <= cnt_data + 1;
            parity_value <= parity_value xor tx_data_s(cnt_data);
          end if;
        else
          cnt_data <= 0;
        end if;
      elsif(tx_fsm = PARITY_GEN) then

        if(parity = even) then
          tx_s <= parity_value;
        elsif(parity = odd) then
          tx_s <= not parity_value;
        end if;
      elsif(tx_fsm = STOP_BIT_GEN) then
        tx_s <= '1';
        if (tick_data = '1') then
          if(cnt_stop_bit < stop_bit_number) then
            cnt_stop_bit <= cnt_stop_bit + 1;
          else
            cnt_stop_bit <= 0;
          end if;
        end if;
      elsif(tx_fsm = STOP) then
        tx_done_s    <= '1';
        cnt_data     <= 0;
        cnt_stop_bit <= 0;
        parity_value <= '0';
      end if;
    end if;
  end process p_tx_gen;


  tx      <= tx_s;                      -- Output affectation
  tx_done <= tx_done_s;
end architecture arch;
