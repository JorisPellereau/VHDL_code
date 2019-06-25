-------------------------------------------------------------------------------
-- Title      : Top level module for the DE0 nano board
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_de0_nano.vhd
-- Author     :  jojo de la compta  <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-20
-- Last update: 2019-06-25
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the top level file for the DE0 nano board
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-20  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

library lib_i2c;
use lib_i2c.pkg_i2c.all;

entity top_de0_nano is
  port (
    clock   : in std_logic;             -- System clock : 50MHz
    reset_n : in std_logic;             -- Active low asynchronous reset

    -- ADC 128 interface    
    adc_sdat  : in  std_logic;          -- From ADC   
    adc_cs_n  : out std_logic;          -- ADC chip select
    adc_sclk  : out std_logic;          -- ADC Clock
    adc_saddr : out std_logic;          -- ADC addr

    -- EEPROM I2C interface
    i2c_sclk : inout std_logic;
    i2c_sda  : inout std_logic;

    -- I2C DEBUG
    i2c_sclk_o : out std_logic;
    i2c_sda_o  : out std_logic;


    -- ADC DEBUG : connected to the GPIO pins
    adc_sdat_o  : out std_logic;
    adc_cn_n_o  : out std_logic;
    adc_sclk_o  : out std_logic;
    adc_saddr_o : out std_logic;

    -- RX - TX UART interface
    -- rx_uart_i : in  std_logic;
    tx_uart_o : out std_logic;


    -- Leds interface
    leds : out std_logic_vector(7 downto 0));
end entity top_de0_nano;

architecture arch_top_de0_nano of top_de0_nano is

  -- COMPONENTS
  component adc128s022_ctrl is
    port (
      clock       : in  std_logic;      -- Input system clock
      reset_n     : in  std_logic;      -- Active low asynchronous reset
      adc_sdat    : in  std_logic;      -- ADC serial data
      channel_sel : in  std_logic_vector(2 downto 0);   -- ADC channel selector
      en          : in  std_logic;      -- Enable - Start conversion
      adc_cs_n    : out std_logic;      -- ADC Chip select
      adc_sclk    : out std_logic;      -- ADC Serial Clock
      adc_saddr   : out std_logic;      -- ADC d_in controller
      adc_data    : out std_logic_vector(11 downto 0);  -- ADC data
      adc_channel : out std_logic_vector(2 downto 0);   -- Current ADC channel
      data_valid  : out std_logic);     -- Data and Current channel available
  end component;


  component NIOS_II_debug is
    port (
      clk_clk                                              : in  std_logic                     := 'X';  -- clk
      pi_adc_channel_data_valid_external_connection_export : in  std_logic_vector(3 downto 0)  := (others => 'X');  -- export
      pi_adc_data_external_connection_export               : in  std_logic_vector(11 downto 0) := (others => 'X');  -- export
      po_adc_cmd_external_connection_export                : out std_logic_vector(3 downto 0);  -- export
      uart_mng_nios_external_connection_in_port            : in  std_logic_vector(7 downto 0)  := (others => 'X');  -- in_port
      uart_mng_nios_external_connection_out_port           : out std_logic_vector(7 downto 0);  -- out_port
      uart_nios_external_connection_rxd                    : in  std_logic                     := 'X';  -- rxd
      uart_nios_external_connection_txd                    : out std_logic;  -- txd
      uart_tx_rx_cmd_external_connection_in_port           : in  std_logic_vector(2 downto 0)  := (others => 'X');  -- in_port
      uart_tx_rx_cmd_external_connection_out_port          : out std_logic_vector(2 downto 0);  -- out_port
      reset_reset_n                                        : in  std_logic                     := 'X';  -- reset_n
      pio_eeprom_ctrl_external_connection_in_port          : in  std_logic_vector(10 downto 0) := (others => 'X');  -- in_port
      pio_eeprom_ctrl_external_connection_out_port         : out std_logic_vector(10 downto 0)  -- out_port
      );
  end component NIOS_II_debug;

  -- component NIOS_II_debug is
  --   port (
  --     clk_clk                                              : in  std_logic                     := 'X';  -- clk
  --     pi_adc_channel_data_valid_external_connection_export : in  std_logic_vector(3 downto 0)  := (others => 'X');  -- export
  --     pi_adc_data_external_connection_export               : in  std_logic_vector(11 downto 0) := (others => 'X');  -- export
  --     po_adc_cmd_external_connection_export                : out std_logic_vector(3 downto 0);  -- export
  --     reset_reset_n                                        : in  std_logic                     := 'X';  -- reset_n
  --     uart_mng_nios_external_connection_in_port            : in  std_logic_vector(7 downto 0)  := (others => 'X');  -- in_port
  --     uart_mng_nios_external_connection_out_port           : out std_logic_vector(7 downto 0);  -- out_port
  --     uart_nios_external_connection_rxd                    : in  std_logic                     := 'X';  -- rxd
  --     uart_nios_external_connection_txd                    : out std_logic;  -- txd
  --     uart_tx_rx_cmd_external_connection_in_port           : in  std_logic_vector(2 downto 0)  := (others => 'X');  -- in_port
  --     uart_tx_rx_cmd_external_connection_out_port          : out std_logic_vector(2 downto 0)  -- out_port
  --     );
  -- end component NIOS_II_debug;

  component master_i2c_24lc02b is
    generic (
      scl_frequency   : t_i2c_frequency := f100k;  -- Frequency of SCL clock
      clock_frequency : integer         := 20000000);  -- Input clock frequency
    port (
      reset_n    : in    std_logic;     -- Asynchronous reset
      clock      : in    std_logic;     -- Input clock
      start_i2c  : in    std_logic;     -- Start an I2C transaction
      rw         : in    std_logic;     -- Read/Write command
      rd_mode    : in    std_logic_vector(1 downto 0);  -- Read mode selection
      chip_addr  : in    std_logic_vector(6 downto 0);  -- Chip address [0:127]
      nb_data    : in    integer range 1 to max_array;  -- Number of byte to Read or Write
      wdata      : in    t_byte_array;  -- Array of data to transmit
      i2c_done   : out   std_logic;     -- I2C transaction done
      sack_error : out   std_logic;     -- Sack from slave not received
      rdata      : out   t_byte_array;  -- Output data read from an I2C transaction
      scl        : inout std_logic;     -- I2C clock
      sda        : inout std_logic);    -- Data line

  end component;


  -- SIGNALS

  -- Resets signals
  signal reset_n_s       : std_logic;   -- Reset s
  signal reset_n_synch_s : std_logic;   -- Reset ss

  -- ADC SIGNALS
  signal channel_sel_s : std_logic_vector(2 downto 0);
  signal en_s          : std_logic;
  signal adc_sdat_s    : std_logic;
  signal adc_cs_n_s    : std_logic;
  signal adc_sclk_s    : std_logic;
  signal adc_saddr_s   : std_logic;
  signal adc_data_s    : std_logic_vector(11 downto 0);
  signal adc_channel_s : std_logic_vector(2 downto 0);
  signal data_valid_s  : std_logic;


  -- TX UART SIGNALS
  signal tx_uart_s  : std_logic;
  signal tx_data_s  : std_logic_vector(7 downto 0);
  signal tx_done_s  : std_logic;
  signal start_tx_s : std_logic;

  -- RX UART SIGNALS
  signal rx_uart_s     : std_logic;
  signal rx_data_s     : std_logic_vector(7 downto 0);
  signal rx_done_s     : std_logic;
  signal parity_rcvd_s : std_logic;

  -- I2C EEPROM CTRL SIGNALS
  signal start_i2c  : std_logic;
  signal rw         : std_logic;
  signal rd_mode    : std_logic_vector(1 downto 0);
  signal chip_addr  : std_logic_vector(6 downto 0);
  signal nb_data    : integer range 1 to max_array;
  signal wdata      : t_byte_array;
  signal i2c_done   : std_logic;
  signal sack_error : std_logic;
  signal rdata      : t_byte_array;
  signal scl        : std_logic;
  signal sda        : std_logic;


  -- LEDS SIGNALS
  signal leds_o : std_logic_vector(7 downto 0);

  -- NIOS SIGNALS
  signal po_adc_cmd_s                                   : std_logic_vector(3 downto 0);
  signal uart_tx_rx_cmd_external_connection_out_port_s  : std_logic_vector(2 downto 0);
  signal pio_eeprom_ctrl_external_connection_out_port_s : std_logic_vector(10 downto 0);
begin

  -- purpose: This process manages the reset input
  p_resetn_mng : process (clock, reset_n) is
  begin  -- process p_resetn_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      reset_n_s       <= '0';
      reset_n_synch_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      reset_n_s       <= '1';
      reset_n_synch_s <= reset_n_s;
    end if;
  end process p_resetn_mng;

  -- LEDS interface
  leds_o <= x"AA";
  leds   <= leds_o;
  --


  --  ===== ADC inst =====
  adc_ctrl_inst : adc128s022_ctrl
    port map(clock       => clock,
             reset_n     => reset_n_synch_s,
             adc_sdat    => adc_sdat_s,
             channel_sel => channel_sel_s,
             en          => en_s,
             adc_cs_n    => adc_cs_n_s,
             adc_sclk    => adc_sclk_s,
             adc_saddr   => adc_saddr_s,
             adc_data    => adc_data_s,
             adc_channel => adc_channel_s,
             data_valid  => data_valid_s);

  -- From ADC
  adc_sdat_s <= adc_sdat;

  -- To ADC  
  adc_cs_n  <= adc_cs_n_s;
  adc_sclk  <= adc_sclk_s;
  adc_saddr <= adc_saddr_s;
  -- ====================

  -- ===== TX UART inst =====
  tx_uart_inst : tx_rs232
    generic map (
      stop_bit_number => 1,
      parity          => none,
      baudrate        => b9600,
      data_size       => 8,
      polarity        => '1',
      first_bit       => lsb_first,
      clock_frequency => 50000000)

    port map (
      reset_n  => reset_n_synch_s,
      clock    => clock,
      start_tx => start_tx_s,
      tx_data  => tx_data_s,
      tx       => tx_uart_s,
      tx_done  => tx_done_s);


  tx_uart_o <= tx_uart_s;
  -- ========================


  -- ===== RX UART inst =====
  rx_uart_inst : rx_uart
    generic map (
      stop_bit_number => 1,
      parity          => none,
      baudrate        => b9600,
      data_size       => 8,
      polarity        => '1',
      first_bit       => lsb_first,
      clock_frequency => 50000000)
    port map (
      reset_n     => reset_n_synch_s,
      clock       => clock,
      rx          => rx_uart_s,
      rx_data     => rx_data_s,
      rx_done     => rx_done_s,
      parity_rcvd => parity_rcvd_s);

  -- ========================

  -- ===== EEPROM I2C inst =====

  eeprom_ctrl_inst : master_i2c_24lc02b
    generic map (
      scl_frequency   => f400k,
      clock_frequency => 50000000)
    port map (
      reset_n    => reset_n_synch_s,
      clock      => clock,
      start_i2c  => start_i2c,
      rw         => rw,
      rd_mode    => rd_mode,
      chip_addr  => chip_addr,
      nb_data    => nb_data,
      wdata      => wdata,
      i2c_done   => i2c_done,
      sack_error => sack_error,
      rdata      => rdata,
      scl        => scl,
      sda        => sda);



  wdata <= (0 => x"AA",
            1 => x"BB",
            2 => x"CC",
            3 => x"DD",
            4 => x"EE",
            5 => x"FF");
  nb_data <= 2;

  i2c_sclk <= scl;
  i2c_sda  <= sda;

  i2c_sclk_o <= i2c_sclk;
  i2c_sda_o  <= i2c_sda;
  -- ===========================


  u0 : component NIOS_II_debug
    port map (
      clk_clk                                              => clock,
      pi_adc_channel_data_valid_external_connection_export => (data_valid_s & adc_channel_s),
      pi_adc_data_external_connection_export               => adc_data_s,
      po_adc_cmd_external_connection_export                => po_adc_cmd_s,
      uart_mng_nios_external_connection_in_port            => rx_data_s,
      uart_mng_nios_external_connection_out_port           => tx_data_s,
      uart_nios_external_connection_rxd                    => tx_uart_s,
      uart_nios_external_connection_txd                    => rx_uart_s,
      uart_tx_rx_cmd_external_connection_in_port           => tx_done_s & rx_done_s & parity_rcvd_s,
      uart_tx_rx_cmd_external_connection_out_port          => uart_tx_rx_cmd_external_connection_out_port_s,
      reset_reset_n                                        => reset_n_synch_s,
      pio_eeprom_ctrl_external_connection_in_port          => "000000000" & sack_error & i2c_done,
      pio_eeprom_ctrl_external_connection_out_port         => pio_eeprom_ctrl_external_connection_out_port_s
      );

  start_i2c <= pio_eeprom_ctrl_external_connection_out_port_s(0);
  rw        <= pio_eeprom_ctrl_external_connection_out_port_s(1);
  chip_addr <= pio_eeprom_ctrl_external_connection_out_port_s(8 downto 2);
  rd_mode   <= pio_eeprom_ctrl_external_connection_out_port_s(10 downto 9);

  -- NIOS DEBUG
  -- u0 : component NIOS_II_debug
  --   port map (
  --     clk_clk                                              => clock,
  --     pi_adc_channel_data_valid_external_connection_export => (data_valid_s & adc_channel_s),
  --     pi_adc_data_external_connection_export               => adc_data_s,
  --     po_adc_cmd_external_connection_export                => po_adc_cmd_s,
  --     reset_reset_n                                        => reset_n_synch_s,
  --     uart_mng_nios_external_connection_in_port            => rx_data_s,
  --     uart_mng_nios_external_connection_out_port           => tx_data_s,
  --     uart_nios_external_connection_rxd                    => tx_uart_s,
  --     uart_nios_external_connection_txd                    => rx_uart_s,
  --     uart_tx_rx_cmd_external_connection_in_port           => tx_done_s & rx_done_s & parity_rcvd_s,
  --     uart_tx_rx_cmd_external_connection_out_port          => uart_tx_rx_cmd_external_connection_out_port_s
  --     );


  -- TX UART cmd
  start_tx_s <= uart_tx_rx_cmd_external_connection_out_port_s(0);



  -- To ADC controller
  en_s          <= po_adc_cmd_s(3);
  channel_sel_s <= po_adc_cmd_s(2 downto 0);

  -- ADC DEBUG
  adc_sdat_o  <= adc_sdat_s;
  adc_cn_n_o  <= adc_cs_n_s;
  adc_sclk_o  <= adc_sclk_s;
  adc_saddr_o <= adc_saddr_s;

end architecture arch_top_de0_nano;

