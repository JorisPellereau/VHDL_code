------------------------------------------------------------------------------- 
-- Title      : TOP DEBUG 
-- Project    :  
------------------------------------------------------------------------------- 
-- File       : top_debug.vhd 
-- Author     :   <JorisP@DESKTOP-LO58CMN> 
-- Company    :  
-- Created    : 2020-02-16 
-- Last update: 2020-02-22
-- Platform   :  
-- Standard   : VHDL'93/02 
------------------------------------------------------------------------------- 
-- Description: TOP DEBUG FILE for TERASIC DE0 NANO board 
------------------------------------------------------------------------------- 
-- Copyright (c) 2020  
------------------------------------------------------------------------------- 
-- Revisions  : 
-- Date        Version  Author  Description 
-- 2020-02-16  1.0      JorisP  Created 
------------------------------------------------------------------------------- 
 
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
 
library lib_uart; 
use lib_uart.pkg_uart.all; 
 
entity top_debug is 
 
  port ( 
    clk       : in  std_logic;          -- System Clock 
    rst_n     : in  std_logic;          -- Asynchronous reset 
    i_rx_uart : in  std_logic;          -- Input RX UART LINK 
    o_tx_uart : out std_logic);         -- Output TX UART LINK 
 
end entity top_debug; 
 
architecture behv of top_debug is 
 
  -- COMPONENTS 
  component w_ram_manager is 
    generic ( 
      G_ADDR_WIDTH : integer := 8;      -- ADDR RAM WIDTH 
      G_DATA_WIDTH : integer := 8);     -- DATA RAM WIDTH 
 
    port ( 
      clk          : in  std_logic;     -- Clock 
      rst_n        : in  std_logic;     -- Asynchronous reset 
      i_data_valid : in  std_logic;     -- DATA valid 
      i_data       : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Input data 
      o_addr       : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR to write on the RAM 
      o_data       : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data to write 
      o_me         : out std_logic;     -- Memory Enable 
      o_we         : out std_logic);    -- Write command 
  end component w_ram_manager; 
 
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
      o_rdata_a : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- RDATA port A 
 
      i_me_b    : in  std_logic;        -- Memory Enable port B 
      i_we_b    : in  std_logic;        -- Memory Write/Read access port B 
      i_addr_b  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR port B 
      i_wdata_b : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA port B 
      o_rdata_b : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0)  -- RDATA port B 
      ); 
  end component tdpram_sclk; 
 
  component pattern_detector is 
    generic ( 
      G_DATA_WIDTH   : integer              := 8;   -- INPUT DATA WIDTH 
      G_PATTERN_SIZE : integer range 2 to 3 := 3);  -- Number of Symbol in the pattern     
    port ( 
      clk                : in  std_logic;           -- Clock 
      rst_n              : in  std_logic;           -- Asynchronous Reset 
      i_data             : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Input Data 
      i_data_valid       : in  std_logic;           -- Data Valid 
      o_pattern_detected : out std_logic);          -- Pattern Detected flag 
  end component; 
 
  component tx_uart_ram_if is 
    generic ( 
      G_ADDR_WIDTH : integer := 8;      -- RAM ADDR WITH7 
      G_DATA_WIDTH : integer := 8);     -- DATA WIDTH 
 
    port ( 
      clk            : in  std_logic;   -- Clock 
      rst_n          : in  std_logic;   -- Asynchronous reset 
      o_me           : out std_logic;   -- Memory Enable 
      o_we           : out std_logic;   -- Write Enable 
      o_addr         : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR WIDTH 
      i_rdata        : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- RDATA 
      i_start_ptr    : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Start Addr to read 
      i_stop_ptr     : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Last ADDR to read 
      i_en_transfert : in  std_logic;   -- Enable the transfert 
      o_start_tx     : out std_logic;   -- Start TX transaction 
      o_tx_data      : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- TX DATA to send 
      i_tx_done      : in  std_logic);  -- TX Transfert Done 
  end component tx_uart_ram_if; 
 
  -- CONSTANTS 
  constant C_RX_TX_DATA_WIDTH : integer := 8;  -- RX DATA WIDTH 
  constant C_ADDR_RAM_WIDTH   : integer := 8;  -- RAM ADDR WIDTH 
 
  -- INTERNAL SIGNALS 
 
  signal s_rx_data     : std_logic_vector(C_RX_TX_DATA_WIDTH - 1 downto 0); 
  signal s_rx_done     : std_logic;     -- RX DATA VALID 
  signal s_parity_rcvd : std_logic;     -- Parity Received 
 
  signal s_rx_uart   : std_logic;       -- META RX UART 
  signal s_rx_uart_p : std_logic;       -- STABLE RX UART 
 
  signal s_start_tx : std_logic;        -- START TX 
  signal s_tx_data  : std_logic_vector(C_RX_TX_DATA_WIDTH - 1 downto 0); 
  signal s_tx_uart  : std_logic;        -- TX LINK 
  signal s_tx_done  : std_logic;        -- TX DONE 
 
  signal s_addr_a_rx_ram  : std_logic_vector(C_ADDR_RAM_WIDTH - 1 downto 0); 
  signal s_data_a_rx_ram  : std_logic_vector(C_RX_TX_DATA_WIDTH - 1 downto 0); 
  signal s_me_a_rx_ram    : std_logic;  -- ME RX RAM PORT A 
  signal s_we_a_rx_ram    : std_logic;  -- WE RX RAM PORT A 
  signal s_rdata_a_rx_ram : std_logic_vector(C_RX_TX_DATA_WIDTH - 1 downto 0); 
 
  signal s_addr_b_rx_ram  : std_logic_vector(C_ADDR_RAM_WIDTH - 1 downto 0); 
  signal s_data_b_rx_ram  : std_logic_vector(C_RX_TX_DATA_WIDTH - 1 downto 0); 
  signal s_me_b_rx_ram    : std_logic;  -- ME RX RAM PORT A 
  signal s_we_b_rx_ram    : std_logic;  -- WE RX RAM PORT A 
  signal s_rdata_b_rx_ram : std_logic_vector(C_RX_TX_DATA_WIDTH - 1 downto 0); 
 
 
  signal s_addr_a_tx_ram  : std_logic_vector(C_ADDR_RAM_WIDTH - 1 downto 0); 
  signal s_data_a_tx_ram  : std_logic_vector(C_RX_TX_DATA_WIDTH - 1 downto 0); 
  signal s_me_a_tx_ram    : std_logic;  -- ME RX RAM PORT A 
  signal s_we_a_tx_ram    : std_logic;  -- WE RX RAM PORT A 
  signal s_rdata_a_tx_ram : std_logic_vector(C_RX_TX_DATA_WIDTH - 1 downto 0); 
 
  signal s_addr_b_tx_ram  : std_logic_vector(C_ADDR_RAM_WIDTH - 1 downto 0); 
  signal s_data_b_tx_ram  : std_logic_vector(C_RX_TX_DATA_WIDTH - 1 downto 0); 
  signal s_me_b_tx_ram    : std_logic;  -- ME RX RAM PORT A 
  signal s_we_b_tx_ram    : std_logic;  -- WE RX RAM PORT A 
  signal s_rdata_b_tx_ram : std_logic_vector(C_RX_TX_DATA_WIDTH - 1 downto 0); 
 
  signal s_pattern_detected : std_logic; 
 
  signal s_start_ptr    : std_logic_vector(C_ADDR_RAM_WIDTH - 1 downto 0); 
  signal s_stop_ptr     : std_logic_vector(C_ADDR_RAM_WIDTH - 1 downto 0); 
  signal s_en_transfert : std_logic; 
 
begin  -- architecture behv 
 
  -- purpose: This precess resynchronize RX UART LINK 
  p_meta_stable_rx_uart : process (clk, rst_n) is 
  begin  -- process p_meta_stable_rx_uart 
    if rst_n = '0' then                 -- asynchronous reset (active low) 
      s_rx_uart   <= '0'; 
      s_rx_uart_p <= '0'; 
    elsif clk'event and clk = '1' then  -- rising clock edge 
      s_rx_uart   <= i_rx_uart; 
      s_rx_uart_p <= s_rx_uart; 
    end if; 
  end process p_meta_stable_rx_uart; 
 
  -- RX UART INST 
  i_rx_uart_inst_0 : rx_uart 
    generic map ( 
      stop_bit_number => 1, 
      parity          => even, 
      baudrate        => b115200, 
      data_size       => C_RX_TX_DATA_WIDTH, 
      polarity        => '1', 
      first_bit       => lsb_first, 
      clock_frequency => 50000000) 
    port map ( 
      reset_n     => rst_n, 
      clock       => clk, 
      rx          => s_rx_uart_p, 
      rx_data     => s_rx_data, 
      rx_done     => s_rx_done, 
      parity_rcvd => s_parity_rcvd); 
 
 
  -- WRITE RAM - RX UART MANAGER INST 
  i_w_ram_manager_rx_uart_0 : w_ram_manager 
    generic map ( 
      G_ADDR_WIDTH => C_ADDR_RAM_WIDTH, 
      G_DATA_WIDTH => C_RX_TX_DATA_WIDTH) 
    port map ( 
      clk          => clk, 
      rst_n        => rst_n, 
      i_data_valid => s_rx_done, 
      i_data       => s_rx_data, 
      o_addr       => s_addr_a_rx_ram, 
      o_data       => s_data_a_rx_ram, 
      o_me         => s_me_a_rx_ram, 
      o_we         => s_we_a_rx_ram); 
 
  -- TDPRAM RX INST 
  i_tdpram_sclk_0 : tdpram_sclk 
    generic map( 
      G_ADDR_WIDTH => C_ADDR_RAM_WIDTH, 
      G_DATA_WIDTH => C_RX_TX_DATA_WIDTH) 
    port map( 
      clk       => clk, 
      i_me_a    => s_me_a_rx_ram, 
      i_we_a    => s_we_a_rx_ram, 
      i_addr_a  => s_addr_a_rx_ram, 
      i_wdata_a => s_data_a_rx_ram, 
      o_rdata_a => s_rdata_a_rx_ram, 
      i_me_b    => s_me_b_rx_ram, 
      i_we_b    => s_we_b_rx_ram, 
      i_addr_b  => s_addr_b_rx_ram, 
      i_wdata_b => s_data_b_rx_ram, 
      o_rdata_b => s_rdata_b_rx_ram); 
 
  -- PATTERN DETECTOR INST 
  i_pattern_detector_0 : pattern_detector 
    generic map ( 
      G_DATA_WIDTH   => 8, 
      G_PATTERN_SIZE => 3) 
    port map( 
      clk                => clk, 
      rst_n              => rst_n, 
      i_data             => s_rx_data, 
      i_data_valid       => s_me_a_rx_ram, 
      o_pattern_detected => s_pattern_detected); 
 
  -- TX UART INST 
  i_tx_uart_0 : tx_uart 
    generic map ( 
      stop_bit_number => 1, 
      parity          => even, 
      baudrate        => b115200, 
      data_size       => C_RX_TX_DATA_WIDTH, 
      polarity        => '1', 
      first_bit       => lsb_first, 
      clock_frequency => 50000000) 
    port map ( 
      reset_n  => rst_n, 
      clock    => clk, 
      start_tx => s_start_tx, 
      tx_data  => s_tx_data, 
      tx       => s_tx_uart, 
      tx_done  => s_tx_done);           -- Transaction done 
 
  o_tx_uart <= s_tx_uart; 
 
  -- TDPRAM TX INST 
  i_tdpram_sclk_1 : tdpram_sclk 
    generic map( 
      G_ADDR_WIDTH => C_ADDR_RAM_WIDTH, 
      G_DATA_WIDTH => C_RX_TX_DATA_WIDTH) 
    port map( 
      clk       => clk, 
      i_me_a    => s_me_a_tx_ram, 
      i_we_a    => s_we_a_tx_ram, 
      i_addr_a  => s_addr_a_tx_ram, 
      i_wdata_a => s_data_a_tx_ram, 
      o_rdata_a => s_rdata_a_tx_ram, 
      i_me_b    => s_me_b_tx_ram, 
      i_we_b    => s_we_b_tx_ram, 
      i_addr_b  => s_addr_b_tx_ram, 
      i_wdata_b => s_data_b_tx_ram, 
      o_rdata_b => s_rdata_b_tx_ram); 
 
 
  -- TX_UART_RAM_IF INST 
  i_tx_uart_ram_if_0 : tx_uart_ram_if 
    generic map( 
      G_ADDR_WIDTH => C_ADDR_RAM_WIDTH, 
      G_DATA_WIDTH => C_RX_TX_DATA_WIDTH) 
    port map ( 
      clk            => clk, 
      rst_n          => rst_n, 
      o_me           => s_me_a_tx_ram, 
      o_we           => s_we_a_tx_ram, 
      o_addr         => s_addr_a_tx_ram, 
      i_rdata        => s_rdata_a_tx_ram, 
      i_start_ptr    => s_start_ptr, 
      i_stop_ptr     => s_stop_ptr, 
      i_en_transfert => s_en_transfert, 
      o_start_tx     => s_start_tx, 
      i_tx_done      => s_tx_done); 
 
  --debug 
  s_start_ptr    <= x"03"; 
  s_stop_ptr     <= x"05"; 
  s_en_transfert <= '0'; 
 
 
end architecture behv; 
