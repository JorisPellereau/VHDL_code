-------------------------------------------------------------------------------
-- Title      : Top level module for the DE0 nano board
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_de0_nano.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-20
-- Last update: 2019-06-20
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


entity top_de0_nano is
  port (
    clock   : in std_logic;             -- System clock : 50MHz
    reset_n : in std_logic;             -- Active low asynchronous reset

    -- ADC 128 interface    
    adc_sdat  : in  std_logic;          -- From ADC   
    adc_cs_n  : out std_logic;          -- ADC chip select
    adc_sclk  : out std_logic;          -- ADC Clock
    adc_saddr : out std_logic;          -- ADC addr

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
      clk_clk                                    : in  std_logic                     := 'X';  -- clk
      reset_reset_n                              : in  std_logic                     := 'X';  -- reset_n
      pio_adc_cmd_external_connection_export     : out std_logic_vector(3 downto 0);  -- export
      pio_uart_data_external_connection_export   : in  std_logic_vector(7 downto 0)  := (others => 'X');  -- export
      pio_adc_data_external_connection_export    : in  std_logic_vector(11 downto 0) := (others => 'X');  -- export
      pio_adc_channel_external_connection_export : in  std_logic_vector(2 downto 0)  := (others => 'X')  -- export
      );
  end component NIOS_II_debug;


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

  -- LEDS SIGNALS
  signal leds_o : std_logic_vector(7 downto 0);

  -- NIOS SIGNALS
  signal pio_adc_cmd_external_connection_export_s : std_logic_vector(3 downto 0);

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


  leds_o <= x"AA";
  leds   <= leds_o;

  -- ADC inst
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


  -- NIOS DEBUG
  u0 : component NIOS_II_debug
    port map (
      clk_clk                                    => clock,
      reset_reset_n                              => reset_n_synch_s,
      pio_adc_cmd_external_connection_export     => pio_adc_cmd_external_connection_export_s,
      pio_uart_data_external_connection_export   => open,
      pio_adc_data_external_connection_export    => b"111111111111",
      pio_adc_channel_external_connection_export => adc_channel_s
      );

  pio_adc_cmd_external_connection_export_s <= en_s & channel_sel_s;
end architecture arch_top_de0_nano;

