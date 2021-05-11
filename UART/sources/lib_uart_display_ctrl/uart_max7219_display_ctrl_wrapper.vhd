-------------------------------------------------------------------------------
-- Title      : UART Display Controller Wrapper
-- Project    : 
-------------------------------------------------------------------------------
-- File       : uart_max7219_display_ctrl_wrapper.vhd
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

library lib_max7219_controller;
use lib_max7219_controller.pkg_max7219_controller.all;

entity uart_max7219_display_ctrl_wrapper is

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
    G_MAX_HALF_PERIOD : integer := 4;   -- 4 => 6.25MHz with 50MHz input
    G_LOAD_DURATION   : integer := 4;   -- LOAD DURATION in clk_in period

    -- MAX7219 STATIC CTRL GENERICS
    G_DECOD_MAX_CNT_32B : std_logic_vector(31 downto 0) := x"02FAF080"

    );
  port (

    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous clock

    -- UART I/F
    i_rx : in  std_logic;               -- RX UART IN
    o_tx : out std_logic;               -- TX UART OUT

    -- MAX7219 I/F
    o_max7219_load : out std_logic;     -- MAX7219 Load
    o_max7219_data : out std_logic;     -- MAX7219 Data
    o_max7219_clk  : out std_logic      -- MAX7219 Clock

    );
end entity uart_max7219_display_ctrl_wrapper;


architecture behv of uart_max7219_display_ctrl_wrapper is

  -- INTERNAL SIGNALS
  signal s_static_dyn             : std_logic;
  signal s_new_display            : std_logic;
  signal s_config_done            : std_logic;
  signal s_display_test           : std_logic;
  signal s_decod_mode             : std_logic_vector(7 downto 0);
  signal s_intensity              : std_logic_vector(7 downto 0);
  signal s_scan_limit             : std_logic_vector(7 downto 0);
  signal s_shutdown               : std_logic_vector(7 downto 0);
  signal s_new_config_val         : std_logic;
  signal s_en_static              : std_logic;
  signal s_rdata_static           : std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);
  signal s_me_static              : std_logic;
  signal s_we_static              : std_logic;
  signal s_addr_static            : std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
  signal s_wdata_static           : std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);
  signal s_start_ptr_static       : std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
  signal s_last_ptr_static        : std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
  signal s_ptr_equality_static    : std_logic;
  signal s_static_busy            : std_logic;
  signal s_scroller_busy          : std_logic;
  signal s_ram_start_ptr_scroller : std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);
  signal s_msg_length_scroller    : std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);
  signal s_max_tempo_cnt_scroller : std_logic_vector(31 downto 0);
  signal s_rdata_scroller         : std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);
  signal s_me_scroller            : std_logic;
  signal s_we_scroller            : std_logic;
  signal s_addr_scroller          : std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);
  signal s_wdata_scroller         : std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);

begin  -- architecture behv

  -- UART MAX7219 DISPLAY CTRL INST
  i_uart_max7219_display_ctrl_0 : uart_max7219_display_ctrl

    generic map(
      -- UART I/F Config.
      G_STOP_BIT_NUMBER => G_STOP_BIT_NUMBER,
      G_PARITY          => G_PARITY,
      G_BAUDRATE        => G_BAUDRATE,
      G_UART_DATA_SIZE  => G_UART_DATA_SIZE,
      G_POLARITY        => G_POLARITY,
      G_FIRST_BIT       => G_FIRST_BIT,
      G_CLOCK_FREQUENCY => G_CLOCK_FREQUENCY,

      -- I/F Generics
      G_MATRIX_NB               => G_MATRIX_NB,
      G_RAM_ADDR_WIDTH_STATIC   => G_RAM_ADDR_WIDTH_STATIC,
      G_RAM_DATA_WIDTH_STATIC   => G_RAM_DATA_WIDTH_STATIC,
      G_RAM_ADDR_WIDTH_SCROLLER => G_RAM_ADDR_WIDTH_SCROLLER,
      G_RAM_DATA_WIDTH_SCROLLER => G_RAM_DATA_WIDTH_SCROLLER)

    port map(
      clk   => clk,
      rst_n => rst_n,

      -- UART I/F
      i_rx => i_rx,
      o_tx => o_tx,

      o_static_dyn  => s_static_dyn,
      o_new_display => s_new_display,

      i_config_done    => s_config_done,
      o_display_test   => s_display_test,
      o_decod_mode     => s_decod_mode,
      o_intensity      => s_intensity,
      o_scan_limit     => s_scan_limit,
      o_shutdown       => s_shutdown,
      o_new_config_val => s_new_config_val,

      o_en_static => s_en_static,

      i_rdata_static => s_rdata_static,
      o_me_static    => s_me_static,
      o_we_static    => s_we_static,
      o_addr_static  => s_addr_static,
      o_wdata_static => s_wdata_static,

      o_start_ptr_static => s_start_ptr_static,
      o_last_ptr_static  => s_last_ptr_static,

      i_ptr_equality_static => s_ptr_equality_static,
      i_static_busy         => s_static_busy,

      i_scroller_busy          => s_scroller_busy,
      o_ram_start_ptr_scroller => s_ram_start_ptr_scroller,
      o_msg_length_scroller    => s_msg_length_scroller,
      o_max_tempo_cnt_scroller => s_max_tempo_cnt_scroller,

      i_rdata_scroller => s_rdata_scroller,
      o_me_scroller    => s_me_scroller,
      o_we_scroller    => s_we_scroller,
      o_addr_scroller  => s_addr_scroller,
      o_wdata_scroller => s_wdata_scroller

      );


  -- MAX7219 DISPLAY CONTROLLER INST
  i_max7219_display_controller_0 : max7219_display_controller
    generic map (
      G_MATRIX_NB => G_MATRIX_NB,

      -- MAX7219 I/F GENERICS
      G_MAX_HALF_PERIOD => G_MAX_HALF_PERIOD,
      G_LOAD_DURATION   => G_LOAD_DURATION,

      -- MAX7219 STATIC CTRL GENERICS
      G_RAM_ADDR_WIDTH_STATIC => G_RAM_ADDR_WIDTH_STATIC,
      G_RAM_DATA_WIDTH_STATIC => G_RAM_DATA_WIDTH_STATIC,
      G_DECOD_MAX_CNT_32B     => G_DECOD_MAX_CNT_32B,

      -- MAX7219 SCROLLER CTRL GENERICS
      G_RAM_ADDR_WIDTH_SCROLLER => G_RAM_ADDR_WIDTH_SCROLLER,
      G_RAM_DATA_WIDTH_SCROLLER => G_RAM_DATA_WIDTH_SCROLLER
      )
    port map(
      clk   => clk,
      rst_n => rst_n,

      i_static_dyn  => s_static_dyn,
      i_new_display => s_new_display,

      i_display_test   => s_display_test,
      i_decod_mode     => s_decod_mode,
      i_intensity      => s_intensity,
      i_scan_limit     => s_scan_limit,
      i_shutdown       => s_shutdown,
      i_new_config_val => s_new_config_val,
      o_config_done    => s_config_done,

      i_en_static => s_en_static,

      i_me_static    => s_me_static,
      i_we_static    => s_we_static,
      i_addr_static  => s_addr_static,
      i_wdata_static => s_wdata_static,
      o_rdata_static => s_rdata_static,

      i_start_ptr_static => s_start_ptr_static,
      i_last_ptr_static  => s_last_ptr_static,

      i_loop_static         => '0',     -- TBD Not used
      o_ptr_equality_static => s_ptr_equality_static,
      o_static_busy         => s_static_busy,

      i_ram_start_ptr_scroller => s_ram_start_ptr_scroller,
      i_msg_length_scroller    => s_msg_length_scroller,

      i_max_tempo_cnt_scroller => s_max_tempo_cnt_scroller,
      o_scroller_busy          => s_scroller_busy,

      i_me_scroller    => s_me_scroller,
      i_we_scroller    => s_we_scroller,
      i_addr_scroller  => s_addr_scroller,
      i_wdata_scroller => s_wdata_scroller,
      o_rdata_scroller => s_rdata_scroller,

      o_max7219_load => o_max7219_load,
      o_max7219_data => o_max7219_data,
      o_max7219_clk  => o_max7219_clk
      );

end architecture behv;
