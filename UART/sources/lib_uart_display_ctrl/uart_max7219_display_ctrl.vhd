-------------------------------------------------------------------------------
-- Title      : UART Display Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : uart_max7219_display_ctrl.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-07
-- Last update: 2021-05-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: A controller that controls MAX7219_DISPLAY_CTRL
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-05-07  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_uart;
use lib_uart.pkg_uart.all;

entity uart_max7219_display_ctrl is

  generic (
    -- UART I/F Config.
    G_STOP_BIT_NUMBER : integer range 1 to 2 := 1;  -- Number of stop bit
    G_PARITY          : t_parity             := even;  -- Type of the parity
    G_BAUDRATE        : t_baudrate           := b115200;   -- Baudrate
    G_UART_DATA_SIZE  : integer range 5 to 9 := 8;  -- Size of the data to transmit
    G_POLARITY        : std_logic            := '1';  -- Polarity in idle state
    G_FIRST_BIT       : t_first_bit          := lsb_first;  -- LSB or MSB first
    G_CLOCK_FREQUENCY : integer              := 20000000;  -- Clock frequency [Hz]

    -- I/F Generics
    G_MATRIX_NB               : integer range 2 to 8 := 8;  -- Matrix Number
    G_RAM_ADDR_WIDTH_STATIC   : integer              := 8;  -- RAM STATIC ADDR WIDTH
    G_RAM_DATA_WIDTH_STATIC   : integer              := 16;  -- RAM STATIC DATA WIDTH
    G_RAM_ADDR_WIDTH_SCROLLER : integer              := 8;  -- RAM SCROLLER ADDR WIDTH
    G_RAM_DATA_WIDTH_SCROLLER : integer              := 8);  -- RAM SCROLLER DATA WIDTH

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous clock

    -- UART I/F
    i_rx : in  std_logic;               -- RX UART IN
    o_tx : out std_logic;               -- TX UART OUT

    -- Display Ctrl commands
    o_static_dyn  : out std_logic;      -- Statuc-Dyn selection
    o_new_display : out std_logic;      -- New Display

    -- Matrix Configuration
    i_config_done    : in  std_logic;
    o_display_test   : out std_logic;
    o_decod_mode     : out std_logic_vector(7 downto 0);
    o_intensity      : out std_logic_vector(7 downto 0);
    o_scan_limit     : out std_logic_vector(7 downto 0);
    o_shutdown       : out std_logic_vector(7 downto 0);
    o_new_config_val : out std_logic;


    -- STATIC I/O
    o_en_static : out std_logic;

    -- RAM STATIC I/F
    i_rdata_static : in  std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM RDATA
    o_me_static    : out std_logic;
    o_we_static    : out std_logic;     -- W/R command
    o_addr_static  : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- RAM ADDR
    o_wdata_static : out std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM DATA


    -- RAM INFO.
    o_start_ptr_static : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- ST PTR
    o_last_ptr_static  : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- LAST ADDR

    i_ptr_equality_static : in std_logic;  -- ADDR = LAST PTR
    i_static_busy         : in std_logic;  -- STATIC BUSY


    -- SCROLLER I/O
    -- RAM Commands
    i_scroller_busy          : in  std_logic;  -- SCROLLER BUSY
    o_ram_start_ptr_scroller : out std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM START PTR
    o_msg_length_scroller    : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- Message Length
    o_max_tempo_cnt_scroller : out std_logic_vector(31 downto 0);  -- Scroller Tempo


    -- RAM SCROLLER I/F
    i_rdata_scroller : in  std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- RAM RDATA
    o_me_scroller    : out std_logic;   -- Memory Enable
    o_we_scroller    : out std_logic;   -- W/R command
    o_addr_scroller  : out std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM ADDR
    o_wdata_scroller : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0)  -- RAM DATA

    );
end entity uart_max7219_display_ctrl;

architecture behv of uart_max7219_display_ctrl is


  -- INTERNAL SIGNALS

  -- RX UART
  signal s_rx          : std_logic;
  signal s_rx_data     : std_logic_vector(G_UART_DATA_SIZE - 1 downto 0);
  signal s_rx_done     : std_logic;
  signal s_parity_rcvd : std_logic;

  -- TX UART
  signal s_start_tx : std_logic;
  signal s_tx_data  : std_logic_vector(G_UART_DATA_SIZE - 1 downto 0);
  signal s_tx       : std_logic;
  signal s_tx_done  : std_logic;

begin  -- architecture behv


  -- UART RX INST
  i_rx_uart_0 : rx_uart
    generic map(
      stop_bit_number => G_STOP_BIT_NUMBER,
      parity          => G_PARITY,
      baudrate        => G_BAUDRATE,
      data_size       => G_UART_DATA_SIZE,
      polarity        => G_POLARITY,
      first_bit       => G_FIRST_BIT,
      clock_frequency => G_CLOCK_FREQUENCY)

    port map (
      reset_n     => rst_n,
      clock       => clk,
      rx          => s_rx,
      rx_data     => s_rx_data,
      rx_done     => s_rx_done,
      parity_rcvd => s_parity_rcvd
      );



  -- UART TX INST
  i_tx_uart_0 : tx_uart
    generic map(
      stop_bit_number => G_STOP_BIT_NUMBER,
      parity          => G_PARITY,
      baudrate        => G_BAUDRATE,
      data_size       => G_UART_DATA_SIZE,
      polarity        => G_POLARITY,
      first_bit       => G_FIRST_BIT,
      clock_frequency => G_CLOCK_FREQUENCY)

    port map (
      reset_n  => rst_n,
      clock    => clk,
      start_tx => s_start_tx,
      tx_data  => s_tx_data,
      tx       => s_tx,
      tx_done  => s_tx_done
      );



end architecture behv;
