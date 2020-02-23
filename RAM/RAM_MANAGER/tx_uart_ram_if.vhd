-------------------------------------------------------------------------------
-- Title      : TX UART - RAM I/F
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tx_uart_ram_if.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2020-02-21
-- Last update: 2020-02-23
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Interface TX UART - RAM - Read RAM Only
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-02-21  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tx_uart_ram_if is

  generic (
    G_ADDR_WIDTH : integer := 8;        -- RAM ADDR WITH7
    G_DATA_WIDTH : integer := 8);       -- DATA WIDTH

  port (
    clk            : in  std_logic;     -- Clock
    rst_n          : in  std_logic;     -- Asynchronous reset
    o_me           : out std_logic;     -- Memory Enable
    o_we           : out std_logic;     -- Write Enable
    o_addr         : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR WIDTH
    i_rdata        : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- RDATA
    i_start_ptr    : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Start Addr to read
    i_stop_ptr     : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Last ADDR to read
    i_en_transfert : in  std_logic;     -- Enable the transfert
    o_start_tx     : out std_logic;     -- Start TX transaction
    o_tx_data      : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- TX DATA to send
    i_tx_done      : in  std_logic;     -- TX Transfert Done
    o_busy         : out std_logic);    -- Block busy

end entity tx_uart_ram_if;

architecture behv of tx_uart_ram_if is

  -- TYPE
  type t_ram_mngt_states is (IDLE, SET_ADDR, RD_RAM, WAIT1, SAVE_RDATA, START_TX, CHECK_ADDR, TX_DONE);  -- States
  signal s_current_state : t_ram_mngt_states;  -- Current State
  signal s_next_state    : t_ram_mngt_states;  -- Next State


  -- INTERNAL SIGNALS
  signal s_start_ptr : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Latch Start Ptr
  signal s_stop_ptr  : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Latch Stop Ptr

  signal s_en_transfert        : std_logic;  -- Latch Enable transfert
  signal s_en_transfert_r_edge : std_logic;  -- R EDGE of i_en_transfert

  signal s_tx_done        : std_logic;  -- Latch TX Done
  signal s_tx_done_r_edge : std_logic;  -- TX Done E Edge

  signal s_me   : std_logic;            -- Memory Enable
  signal s_we   : std_logic;            -- Write/Read Enable
  signal s_addr : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Memory ADDR

  signal s_start_tx : std_logic;        -- Start TX
  signal s_tx_data  : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- TX DATA to send;

  signal s_busy : std_logic;            -- Busy

begin  -- architecture behv


  -- purpose: Latch inputs
  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_en_transfert <= '0';
      s_tx_done      <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_en_transfert <= i_en_transfert;
      s_tx_done      <= i_tx_done;
    end if;
  end process p_latch_inputs;

  -- R EDGE detection
  s_en_transfert_r_edge <= i_en_transfert and not s_en_transfert;
  s_tx_done_r_edge      <= i_tx_done and not s_tx_done;

  -- purpose: Latch inputs on R EDGE of Enable
  p_latch_ptr : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start_ptr <= (others => '0');
      s_stop_ptr  <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_en_transfert_r_edge = '1') then
        s_start_ptr <= i_start_ptr;
        s_stop_ptr  <= i_stop_ptr;
      end if;
    end if;
  end process p_latch_ptr;


  -- purpose: Curr State Mngt
  p_curr_state_mngt : process (clk, rst_n) is
  begin  -- process p_curr_state_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_current_state <= IDLE;
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_current_state <= s_next_state;
    end if;
  end process p_curr_state_mngt;

  p_next_state_mngt : process (s_current_state, s_en_transfert_r_edge, i_tx_done, s_tx_done_r_edge, s_addr) is
  begin  -- process p_next_state_mngt
    case s_current_state is
      when IDLE =>
        if(s_en_transfert_r_edge = '1') then
          s_next_state <= SET_ADDR;
        end if;

      when SET_ADDR =>
        s_next_state <= RD_RAM;

      when RD_RAM =>
        s_next_state <= WAIT1;

      when WAIT1 =>
        s_next_state <= SAVE_RDATA;

      when SAVE_RDATA =>
        if(i_tx_done = '1') then
          s_next_state <= START_TX;
        end if;

      when START_TX =>
        if(s_tx_done_r_edge = '1') then
          s_next_state <= CHECK_ADDR;
        end if;

      when CHECK_ADDR =>
        if(s_addr <= s_stop_ptr) then
          s_next_state <= RD_RAM;
        else
          s_next_state <= TX_DONE;
        end if;

      when TX_DONE =>
        s_next_state <= IDLE;

      when others => null;
    end case;
  end process p_next_state_mngt;



  -- purpose: Outputs mngt 
  p_outputs_mngt : process (clk, rst_n) is
  begin  -- process p_outputs_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_me       <= '0';
      s_we       <= '0';
      s_start_tx <= '0';
      s_tx_data  <= (others => '0');
      s_busy     <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      case s_current_state is
        when IDLE =>
          s_me       <= '0';
          s_we       <= '0';
          s_start_tx <= '0';
          s_tx_data  <= (others => '0');
          s_busy     <= '0';

        when SET_ADDR =>
          s_busy <= '1';

        when RD_RAM =>
          s_me <= '1';
          s_we <= '0';

        when SAVE_RDATA =>
          s_tx_data <= i_rdata;

        when WAIT1 =>
          s_me <= '0';
          s_we <= '0';

        when START_TX =>
          s_start_tx <= '1';

        when CHECK_ADDR =>
          s_start_tx <= '0';

        when others => null;
      end case;
    end if;
  end process p_outputs_mngt;


  -- purpose: Addr mngt
  p_addr_mngt : process (clk, rst_n) is
  begin  -- process p_addr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_addr <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_current_state = SET_ADDR) then
        s_addr <= s_start_ptr;

      elsif(s_current_state = START_TX) then
        if(s_tx_done_r_edge = '1') then
          s_addr <= unsigned(s_addr) + 1;  -- INC
        end if;

      end if;
    end if;
  end process p_addr_mngt;



  -- OUTPUTS AFFECTATIONS
  o_me       <= s_me;
  o_we       <= s_we;
  o_addr     <= s_addr;
  o_start_tx <= s_start_tx;
  o_tx_data  <= s_tx_data;
  o_busy     <= s_busy;
  
end architecture behv;
