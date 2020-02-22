------------------------------------------------------------------------------- 
-- Title      : TESTBENCH TOP for top_debug.vhd 
-- Project    :  
------------------------------------------------------------------------------- 
-- File       : tb_top_debug.vhd 
-- Author     :   <JorisP@DESKTOP-LO58CMN> 
-- Company    :  
-- Created    : 2020-02-16 
-- Last update: 2020-02-22
-- Platform   :  
-- Standard   : VHDL'93/02 
------------------------------------------------------------------------------- 
-- Description: TB TOP 
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
 
entity tb_top_debug is 
 
end entity tb_top_debug; 
 
architecture behv of tb_top_debug is 
 
  -- COMPONENTS 
  component top_debug is 
    port ( 
      clk       : in  std_logic;        -- System Clock 
      rst_n     : in  std_logic;        -- Asynchronous reset 
      i_rx_uart : in  std_logic;        -- Input RX UART LINK 
      o_tx_uart : out std_logic);       -- Output TX UART LINK 
  end component top_debug; 
 
 
  -- CONSTANTS 
  constant C_TX_DATA_WIDTH : integer := 8;      -- TX DATA WIDTH 
  constant C_HALF_PERIOD   : time    := 10 ns;  -- 10 ns => 50MHz 
 
  -- TYPES 
  type t_array_cmd_7char is array (0 to 6) of std_logic_vector(C_TX_DATA_WIDTH - 1 downto 0); 
  type t_array_tx_data is array (0 to 2**C_TX_DATA_WIDTH - 1) of std_logic_vector(C_TX_DATA_WIDTH - 1 downto 0); 
  signal s_array_tx_data : t_array_tx_data := (others => (others => '0'));  -- Array of data to transmit 
 
 
  -- purpose: SET READ command 
  procedure proc_rd_cmd ( 
    variable v_id       : in  std_logic_vector(C_TX_DATA_WIDTH - 1 downto 0); 
    variable v_addr     : in  std_logic_vector(C_TX_DATA_WIDTH - 1 downto 0); 
    variable v_read_cmd : out t_array_cmd_7char 
    ) is 
  begin  -- procedure proc_rd_cmd 
 
    -- R D 'ID' '@' E N D 
    v_read_cmd(0) := x"52"; 
    v_read_cmd(1) := x"44"; 
    v_read_cmd(2) := v_id; 
    v_read_cmd(3) := v_addr; 
    v_read_cmd(4) := x"45"; 
    v_read_cmd(5) := x"4E"; 
    v_read_cmd(6) := x"44"; 
 
 
  end procedure proc_rd_cmd; 
 
 
  -- purpose: SEND RD CMD 
  procedure proc_send_rd_cmd ( 
    variable v_read_cmd : in  t_array_cmd_7char; 
    variable v_i        : in  integer; 
    signal clk          : in  std_logic; 
    signal s_tx_done    : in  std_logic; 
    signal s_tx_data    : out std_logic_vector(7 downto 0); 
    signal s_start_tx   : out std_logic 
    ) is 
 
  begin  -- procedure proc_send_rd_cmd 
 
    for v_i in 0 to 6 loop 
 
      s_tx_data  <= v_read_cmd(v_i); 
      wait until falling_edge(clk); 
      wait until falling_edge(clk); 
      s_start_tx <= '1', '0' after 6*C_HALF_PERIOD; 
      wait until rising_edge(s_tx_done); 
      wait for 10*C_HALF_PERIOD; 
 
    end loop;  -- i < 2**C_TX_DATA_WIDTH - 1 
 
  end procedure proc_send_rd_cmd; 
 
 
  -- TB SIGNALS 
  signal clk   : std_logic := '1';      -- Clock 
  signal rst_n : std_logic := '1'; 
 
  -- INTERNAL SIGNALS 
  signal s_start_tx : std_logic; 
  signal s_tx_data  : std_logic_vector(C_TX_DATA_WIDTH - 1 downto 0); 
  signal s_tx_uart  : std_logic; 
  signal s_tx_done  : std_logic; 
 
  signal s_rx_uart     : std_logic; 
  signal s_tx_uart_top : std_logic; 
 
begin  -- architecture behv 
 
  -- CLOCK MNGT 
  p_clock_mngt : process is 
  begin  -- process p_clock_mngt 
    clk <= not clk; 
    wait for C_HALF_PERIOD; 
  end process p_clock_mngt; 
 
  p_stimuli : process is 
    variable i               : integer         := 0; 
    variable v_read_cmd      : t_array_cmd_7char; 
    variable v_id            : std_logic_vector(7 downto 0); 
    variable v_addr          : std_logic_vector(7 downto 0); 
    variable v_array_tx_data : t_array_tx_data := (others => (others => '0')); 
    variable v_tx_data       : std_logic_vector(C_TX_DATA_WIDTH - 1 downto 0); 
  begin  -- process p_stimuli 
 
    s_start_tx <= '0'; 
    s_tx_data  <= (others => '0'); 
 
    wait for 10*C_HALF_PERIOD; 
    rst_n <= '0'; 
    wait for 10*C_HALF_PERIOD; 
    rst_n <= '1'; 
 
    v_id   := x"01"; 
    v_addr := x"02"; 
 
    proc_rd_cmd(v_id, v_addr, v_read_cmd); 
    proc_send_rd_cmd(v_read_cmd, i, clk, s_tx_done, s_tx_data, s_start_tx); 
 
    proc_send_rd_cmd(v_read_cmd, i, clk, s_tx_done, s_tx_data, s_start_tx); 
 
 
     
 
 
    wait for 100 us; 
    report "end of simulation !!!!!"; 
 
    wait; 
  end process p_stimuli; 
 
 
  -- TX UART MODULE INST 
  i_tx_uart_tb_0 : tx_uart 
    generic map ( 
      stop_bit_number => 1, 
      parity          => even, 
      baudrate        => b115200, 
      data_size       => C_TX_DATA_WIDTH, 
      polarity        => '1', 
      first_bit       => lsb_first, 
      clock_frequency => 50000000) 
    port map( 
      reset_n  => rst_n, 
      clock    => clk, 
      start_tx => s_start_tx, 
      tx_data  => s_tx_data, 
      tx       => s_tx_uart, 
      tx_done  => s_tx_done 
      ); 
 
  -- top_debug INST 
  i_top_debug_0 : top_debug 
    port map( 
      clk       => clk, 
      rst_n     => rst_n, 
      i_rx_uart => s_rx_uart, 
      o_tx_uart => s_tx_uart_top); 
 
  s_rx_uart <= s_tx_uart; 
 
end architecture behv; 


