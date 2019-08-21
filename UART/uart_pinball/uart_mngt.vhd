-------------------------------------------------------------------------------
-- Title      : Management of the UART communication
-- Project    : 
-------------------------------------------------------------------------------
-- File       : uart_mngt.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-08-21
-- Last update: 2019-08-21
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file manages the comunication of the UART
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-08-21  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

entity uart_mngt is

  generic(
    data_size : integer range 5 to 9 := 8);

  port (
    reset_n : in std_logic;             -- Active low Asynchronous Reset
    clock_i : in std_logic;             -- System Clock

    -- RX uart interface
    rx_data_i     : in std_logic_vector(data_size - 1 downto 0);  -- Data from RX uart
    rx_done_i     : in std_logic;       -- Data received
    parity_rcvd_i : in std_logic;       -- Parity from the RX uart

    -- TX uart interface
    tx_done_i  : in  std_logic;         -- Tx uart done
    start_tx_o : out std_logic;         -- Start a TX uart
    tx_data_o  : out std_logic_vector(data_size - 1 downto 0));  -- Data to transmit

end entity uart_mngt;

architecture arch_uart_mngt of uart_mngt is

  -- CONSTANTS
  constant C_MAX_ARRAY   : integer := 3;  -- Size of the buffer
  constant C_MAX_TX_BYTE : integer := 2;  -- Number of byte to transmit

  -- NEW TYPES
  type t_byte_array is array (0 to C_MAX_ARRAY - 1) of std_logic_vector(data_size - 1 downto 0);  -- Type for the array


  constant C_cmd_inst : t_byte_array := (0 => x"A0", 1 => x"BB", 2 => x"DE", others => x"00");  -- Cmd okai 

  -- INTERNAL SIGNALS
  signal cnt_byte_rx : integer range 0 to C_MAX_ARRAY;  -- Counts the byte received
  signal byte_array  : t_byte_array;    -- Byte array

  signal cnt_byte_tx : integer range 0 to C_MAX_TX_BYTE;  -- Counts the bytes to send

  signal rx_done_i_r_edge : std_logic;  -- R edge of rx_done_i
  signal rx_done_i_s      : std_logic;  -- Old rx_done_i

  signal tx_done_i_r_edge : std_logic;  -- R edge of tx_done_i
  signal tx_done_i_s      : std_logic;  -- Old tx_done_i

  signal uart_cmd_ok_s    : std_logic;  -- Good command received
  signal uart_resp_done_s : std_logic;  -- Resp Send

  signal start_tx_o_s : std_logic;      -- Start tx
  signal tx_data_o_s  : std_logic_vector(data_size - 1 downto 0);  -- Data to transmit

begin  -- architecture arch_uart_mngt


  -- purpose: This process manages the R edge of the inputs 
  p_r_edge_mng : process (clock_i, reset_n) is
  begin  -- process p_r_edge_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      rx_done_i_s <= '0';
      tx_done_i_s <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      rx_done_i_s <= rx_done_i;
      tx_done_i_s <= tx_done_i;
    end if;
  end process p_r_edge_mng;
  rx_done_i_r_edge <= rx_done_i and not rx_done_i_s;
  tx_done_i_r_edge <= tx_done_i and not tx_done_i_s;


  -- purpose: This process store the data from the RX UART and inc. the counter 
  p_rx_data_mng : process (clock_i, reset_n) is
  begin  -- process p_rx_data_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      cnt_byte_rx   <= 0;
      byte_array    <= (others => (others => '0'));
      uart_cmd_ok_s <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge

      -- Store and Inc on RX_done REdge
      if(rx_done_i_r_edge = '1' and uart_cmd_ok_s = '0') then
        if(cnt_byte_rx < C_MAX_ARRAY - 1) then
          byte_array(cnt_byte_rx) <= rx_data_i;        -- Store the data
          cnt_byte_rx             <= cnt_byte_rx + 1;  -- Inc cnt      
        end if;
      end if;

      if(cnt_byte_rx = C_MAX_ARRAY - 1) then
        if(byte_array = C_cmd_inst) then
          uart_cmd_ok_s <= '1';
        else
          -- RAZ buffer
          uart_cmd_ok_s <= '0';
          byte_array    <= (others => (others => '0'));
          cnt_byte_rx   <= 0;
        end if;
      end if;

      if(uart_resp_done_s = '1') then
        cnt_byte_rx   <= 0;
        byte_array    <= (others => (others => '0'));
        uart_cmd_ok_s <= '0';
      end if;

    end if;
  end process p_rx_data_mng;


  -- purpose: This process manages the TX UART responses
  p_tx_mng : process (clock_i, reset_n) is
  begin  -- process p_tx_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      uart_resp_done_s <= '0';
      cnt_byte_tx      <= 0;
      start_tx_o_s     <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge

      if(uart_cmd_ok_s = '1') then
        if(tx_done_i_r_edge = '1') then
          if(cnt_byte_tx < C_MAX_TX_BYTE - 1) then
            cnt_byte_tx <= cnt_byte_tx + 1;
          else
            uart_resp_done_s <= '1';
            cnt_byte_tx      <= 0;      -- RAZ CNT
          end if;
          start_tx_o_s <= '0';          -- Raz Start TX
        else
          start_tx_o_s <= '1'; -- Start a TX resp
        end if;

        case cnt_byte_tx is
          when 0 =>
            tx_data_o_s <= x"AB";
          when 1 =>
            tx_data_o_s <= x"CD";
          when others => null;
        end case;

      else
        uart_resp_done_s <= '0';
        cnt_byte_tx      <= 0;
        start_tx_o_s     <= '0';
      end if;

    end if;
  end process p_tx_mng;

  start_tx_o <= start_tx_o_s;
  tx_data_o  <= tx_data_o_s;
end architecture arch_uart_mngt;
