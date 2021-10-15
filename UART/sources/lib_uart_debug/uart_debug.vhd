-------------------------------------------------------------------------------
-- Title      : UART DEBUG TOP Block
-- Project    : 
-------------------------------------------------------------------------------
-- File       : uart_debug.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-08-26
-- Last update: 2021-08-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: UART DEBUG TOP Block
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-08-26  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_uart;
use lib_uart.pkg_uart.all;

library lib_uart_debug;
use lib_uart_debug.pkg_uart_debug.all;

library lib_uart_debug_custom;
use lib_uart_debug.pkg_uart_debug_custom.all;

entity uart_debug is

  generic (
    G_RAM_ADDR_WIDTH   : integer              := 9;  -- RAM ADDR Width
    G_RAM_DATA_WIDTH   : integer              := 8;  -- RAM DATA Width
    G_UART_PARITY      : t_parity             := none;       -- UART Parity
    G_UART_BAUDRATE    : t_baudrate           := b115200;    -- UART BANDRATE
    G_UART_STOP_BIT_NB : integer range 1 to 2 := 1;  -- UART STOP BIT NB
    G_UART_FIRST_BIT   : t_first_bit          := msb_first;  -- UART MSB FIRST
    G_CLOCK_FREQUENCY  : integer              := 50000000);  -- CLOCK FREQUENCY

  port (
    clk          : in  std_logic;
    rst_n        : in  std_logic;
    i_rx         : in  std_logic;          -- UART RX
    o_tx         : out std_logic;          -- UART TX
    i_record_bus : in  t_record_bus_in;    -- Bus Out
    o_record_bus : out t_record_bus_out);  -- Bus Out

end entity uart_debug;

architecture behv of uart_debug is

  -- COMPONENT
  component tdpram_sclk is

    generic (
      G_ADDR_WIDTH : integer := 8;      -- ADDR WIDTH
      G_DATA_WIDTH : integer := 8);     -- DATA WIDTH

    port (
      clk       : in  std_logic;        -- Clock
      i_me_a    : in  std_logic;        -- Memory Enable port A
      i_we_a    : in  std_logic;        -- Memory Write/Read access port A
      i_addr_a  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR port A
      i_wdata_a : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA port A
      o_rdata_a : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- RDATA port A

      i_me_b    : in  std_logic;        -- Memory Enable port B
      i_we_b    : in  std_logic;        -- Memory Write/Read access port B
      i_addr_b  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR port B
      i_wdata_b : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA port B
      o_rdata_b : out std_logic_vector(G_DATA_WIDTH - 1 downto 0)  -- RDATA port B
      );

  end component;

  -- INTERNAL SIGNALS
  signal s_rx_data     : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
  signal s_rx_done     : std_logic;
  signal s_parity_rcvd : std_logic;

  signal s_start_tx : std_logic;
  signal s_tx_data  : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
  signal s_tx_done  : std_logic;

begin  -- architecture behv


  -- RX UART INST.
  i_rx_uart_0 : rx_uart
    generic map (
      stop_bit_number => 1,
      parity          => G_UART_PARITY,
      baudrate        => G_UART_BAUDRATE,
      data_size       => G_RAM_DATA_WIDTH,
      polarity        => '1',
      first_bit       => G_UART_FIRST_BIT,
      clock_frequency => G_CLOCK_FREQUENCY)
    port map (
      reset_n     => rst_n,
      clock       => clk,
      rx          => i_rx,
      rx_data     => s_rx_data,
      rx_done     => s_rx_done,
      parity_rcvd => s_parity_rcvd);

  -- TX UART INST.
  i_tx_uart_0 : rx_uart
    generic map (
      stop_bit_number => 1,
      parity          => G_UART_PARITY,
      baudrate        => G_UART_BAUDRATE,
      data_size       => G_RAM_DATA_WIDTH,
      polarity        => '1',
      first_bit       => G_UART_FIRST_BIT,
      clock_frequency => G_CLOCK_FREQUENCY)
    port map(
      reset_n  => rst_n,
      clock    => clk,
      start_tx => s_start_tx,
      tx_data  => s_tx_data,
      tx       => o_tx,
      tx_done  => s_tx_done);


  -- UART RX RAM
  i_rx_uart_ram_0 : tdpram_sclk
    generic map(
      G_ADDR_WIDTH => G_RAM_ADDR_WIDTH,
      G_DATA_WIDTH => G_RAM_DATA_WIDTH
      )
    port map(
      clk => clk,

      i_me_a    => open,
      i_we_a    => open,
      i_addr_a  => open,
      i_wdata_a => open,
      o_rdata_a => open,

      i_me_b    => open,
      i_we_b    => open,
      i_addr_b  => open,
      i_wdata_b => open,
      o_rdata_b => open,

      );


  -- UART TX RAM
  i_tx_uart_ram_0 : tdpram_sclk
    generic map(
      G_ADDR_WIDTH => G_RAM_ADDR_WIDTH,
      G_DATA_WIDTH => G_RAM_DATA_WIDTH
      )
    port map(
      clk => clk,

      i_me_a    => open,
      i_we_a    => open,
      i_addr_a  => open,
      i_wdata_a => open,
      o_rdata_a => open,

      i_me_b    => open,
      i_we_b    => open,
      i_addr_b  => open,
      i_wdata_b => open,
      o_rdata_b => open,

      );


end architecture behv;
