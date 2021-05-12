-------------------------------------------------------------------------------
-- Title      : UART MAX7219 Controller TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : uart_max7219_ctrl_top.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-11
-- Last update: 2021-05-11
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-05-11  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_uart;
use lib_uart.pkg_uart.all;

library lib_uart_display_ctrl;
use lib_uart_display_ctrl.pkg_uart_max7219_display_ctrl.all;

entity uart_max7219_ctrl_top is

  port (
    clk   : in std_logic;
    rst_n : in std_logic;

    i_rx : in  std_logic;
    o_tx : out std_logic;

    o_max7219_load : out std_logic;
    o_max7219_data : out std_logic;
    o_max7219_clk  : out std_logic;

    o_leds : out std_logic_vector(7 downto 0)
    );

end entity uart_max7219_ctrl_top;


architecture behv of uart_max7219_ctrl_top is


  component uart_max7219_display_ctrl_wrapper is

    generic (
      -- UART I/F Config.
      G_STOP_BIT_NUMBER : integer range 1 to 2 := 1;  -- Number of stop bit
      G_PARITY          : t_parity             := even;  -- Type of the parity
      G_BAUDRATE        : t_baudrate           := b115200;   -- Baudrate
      G_UART_DATA_SIZE  : integer range 5 to 9 := 8;  -- Size of the data to transmit
      G_POLARITY        : std_logic            := '1';  -- Polarity in idle state
      G_FIRST_BIT       : t_first_bit          := lsb_first;  -- LSB or MSB first
      G_CLOCK_FREQUENCY : integer              := 50000000;  -- Clock frequency [Hz]

      -- I/F Generics
      G_MATRIX_NB               : integer range 2 to 8 := 8;  -- Matrix Number
      G_RAM_ADDR_WIDTH_STATIC   : integer              := 8;  -- RAM STATIC ADDR WIDTH
      G_RAM_DATA_WIDTH_STATIC   : integer              := 16;  -- RAM STATIC DATA WIDTH
      G_RAM_ADDR_WIDTH_SCROLLER : integer              := 8;  -- RAM SCROLLER ADDR WIDTH
      G_RAM_DATA_WIDTH_SCROLLER : integer              := 8;  -- RAM SCROLLER DATA WIDTH

      -- MAX7219 I/F GENERICS
      G_MAX_HALF_PERIOD : integer := 4;  -- 4 => 6.25MHz with 50MHz input
      G_LOAD_DURATION   : integer := 4;  -- LOAD DURATION in clk_in period

      -- MAX7219 STATIC CTRL GENERICS
      G_DECOD_MAX_CNT_32B : std_logic_vector(31 downto 0) := x"02FAF080"

      );
    port (

      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous clock

      -- UART I/F
      i_rx : in  std_logic;             -- RX UART IN
      o_tx : out std_logic;             -- TX UART OUT

      -- MAX7219 I/F
      o_max7219_load : out std_logic;   -- MAX7219 Load
      o_max7219_data : out std_logic;   -- MAX7219 Data
      o_max7219_clk  : out std_logic    -- MAX7219 Clock

      );
  end component;

  -- INTERNAL SIGNALS
  signal s_tx : std_logic;


begin  -- architecture behv



  i_uart_max7219_display_ctrl_wrapper_0 : uart_max7219_display_ctrl_wrapper
    generic map (
      -- UART I/F Config.
      G_STOP_BIT_NUMBER => 1,           -- Number of stop bit
      G_PARITY          => even,        -- Type of the parity
      G_BAUDRATE        => b115200,     -- Baudrate
      G_UART_DATA_SIZE  => 8,           -- Size of the data to transmit
      G_POLARITY        => '1',         -- Polarity in idle state
      G_FIRST_BIT       => lsb_first,   -- LSB or MSB first
      G_CLOCK_FREQUENCY => 50000000,

      -- I/F Generics
      G_MATRIX_NB               => 8,
      G_RAM_ADDR_WIDTH_STATIC   => 8,
      G_RAM_DATA_WIDTH_STATIC   => 16,
      G_RAM_ADDR_WIDTH_SCROLLER => 8,
      G_RAM_DATA_WIDTH_SCROLLER => 8,

      -- MAX7219 I/F GENERICS
      G_MAX_HALF_PERIOD => 4,
      G_LOAD_DURATION   => 4,

      -- MAX7219 STATIC CTRL GENERICS
      G_DECOD_MAX_CNT_32B => x"02FAF080"
      )
    port map (

      clk   => clk,
      rst_n => rst_n,

      -- UART I/F
      i_rx => i_rx,
      o_tx => s_tx,

      -- MAX7219 I/F
      o_max7219_load => o_max7219_load,
      o_max7219_data => o_max7219_data,
      o_max7219_clk  => o_max7219_clk

      );


  -- OUTPUTS Affectations

  o_tx <= s_tx;


  -- Alive RX/TX Leds
  o_leds(0)          <= i_rx;
  o_leds(1)          <= s_tx;
  o_leds(7 downto 2) <= (others => '0');

end architecture behv;
