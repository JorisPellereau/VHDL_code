-------------------------------------------------------------------------------
-- Title      : ZIPCPU VHDL Wrapper
-- Project    : 
-------------------------------------------------------------------------------
-- File       : zip_cpu_wrapper.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-06-02
-- Last update: 2023-06-18
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-06-02  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_zipcpu;
library lib_wishbone;

entity zip_cpu_wrapper is

end entity zip_cpu_wrapper;

architecture rtl of zip_cpu_wrapper is

  -- == INERNAL Signals ==
  signal clk : std_logic;               -- Clock
  signal rst : std_logic;               -- Reset
    signal rst_n : std_logic;               -- Reset

  signal s_wb_cyc      : std_logic;
  signal s_wb_stb      : std_logic;
  signal s_wb_stall    : std_logic;
  signal s_wb_ack      : std_logic;
  signal s_wb_we       : std_logic;
  signal uart_rx       : std_logic;
  signal uart_tx       : std_logic;
  signal cts_n         : std_logic;
  signal s_uart_rx_int : std_logic;
  signal s_uart_tx_int : std_logic;
  signal s_wb_addr     : std_logic_vector(32-3 downto 0);
  signal s_wb_data     : std_logic_vector(31 downto 0);
  signal s_wb_sel      : std_logic_vector(32/8-1 downto 0);
  signal s_i_wb_data   : std_logic_vector(31 downto 0);
  signal s_i_ext_int   : std_logic_vector(1 -1 downto 0);

  signal s_prof_addr : std_logic_vector(31 downto 0);

begin  -- architecture rtl


  rst_n <= not rst;
  
  -- Instanciation of ZIPSYSTEM
  i_zip_system_0 : entity lib_zipcpu.zipsystem
    generic map (

      RESET_ADDRESS => x"00000000",
      ADDRESS_WIDTH => 32,
      BUS_WIDTH     => 32,
      --DBG_WIDTH     => 32,

      OPT_PIPELINED       => "0",
      OPT_EARLY_BRANCHING => "0",       --OPT_PIPELINED,

      OPT_LGICACHE => 1,--10,

      OPT_LGDCACHE => 1,--10,

      START_HALTED         => "0", -- Wait for a specific debug cmd before
                                   -- starting if set
      OPT_DISTRIBUTED_REGS => "1",
      EXTERNAL_INTERRUPTS  => 1,

      OPT_MPY => 3,

      OPT_DIV => "1",

      OPT_SHIFTS => "1",

      OPT_FPU => "0",

      OPT_CIS        => "0",-- Compressed Instr Set not used (INSTR on 32 Bits)
      OPT_LOCK       => "1",
      OPT_USERMODE   => "1",
      OPT_DBGPORT    => "1",            --START_HALTED,
      OPT_TRACE_PORT => "1",
      OPT_PROFILER   => "0",
      OPT_LOWPOWER   => "0",

      OPT_DMA   => "1",
      DMA_LGMEM => 10,

      OPT_ACCOUNTING => "1",

      DELAY_DBG_BUS => "1",

      DELAY_EXT_BUS => "0",


      OPT_SIM     => "1",--Enable SIM
      OPT_CLKGATE => "0",


      RESET_DURATION => 0


      -- PAW => 32-2--$clog2(BUS_WIDTH/8)

      )
    port map (

      i_clk => clk,

      i_reset => rst,

      o_wb_cyc  => s_wb_cyc,
      o_wb_stb  => s_wb_stb,
      o_wb_we   => s_wb_we,
      o_wb_addr => s_wb_addr,
      o_wb_data => s_wb_data,
      o_wb_sel  => s_wb_sel,

      i_wb_stall => s_wb_stall,
      i_wb_ack   => s_wb_ack,

      i_wb_data => s_i_wb_data,
      i_wb_err  => '0',


      i_ext_int => s_i_ext_int,

      o_ext_int => open,


      i_dbg_cyc   => '0',
      i_dbg_stb   => '0',
      i_dbg_we    => '0',
      i_dbg_addr  => (others => '0'),
      i_dbg_data  => (others => '0'),
      i_dbg_sel   => (others => '0'),
      o_dbg_stall => open,
      o_dbg_ack   => open,
      o_dbg_data  => open,

      o_cpu_debug => open,

      o_prof_stb   => open,
      o_prof_addr  => s_prof_addr,
      o_prof_ticks => open

      );


  i_wb_slv_memory_0 : entity lib_wishbone.wb_slv_memory
    generic map (G_ADDR_WIDTH => 8,
                 G_DATA_WIDH  => 32,
                 G_RAM_DEPTH  => 256
                 )
    port map (
      clk_sys       => clk,
      rst_n_clk_sys => rst_n,

      -- Wishbone ITF
      i_wb_cyc   => s_wb_cyc,
      i_wb_stb   => s_wb_stb,
      i_wb_we    => s_wb_we,
      i_wb_addr  => s_wb_addr(7 downto 0),
      i_wb_data  => s_wb_data,
      i_wb_sel   => s_wb_sel,
      o_wb_stall => s_wb_stall,
      o_wb_ack   => s_wb_ack,
      o_wb_data  => s_i_wb_data
      );

  -- -- Connexion of wbuart of wishbone bus
  -- i_wbuart_0 : entity lib_zipcpu.wbuart
  --   generic map (

  --     INITIAL_SETUP                 => "000" & x"00000" &x"19",  -- 31'd25,
  --     LGFLEN                        => 4,
  --     HARDWARE_FLOW_CONTROL_PRESENT => "1"                       -- 1'b1,

  --     )
  --   port map (

  --     i_clk   => clk,
  --     i_reset => rst,

  --     i_wb_cyc   => s_wb_cyc,
  --     i_wb_stb   => s_wb_stb,
  --     i_wb_we    => s_wb_we,
  --     i_wb_addr  => s_wb_addr(1 downto 0),
  --     i_wb_data  => s_wb_data,
  --     i_wb_sel   => s_wb_sel,
  --     o_wb_stall => s_wb_stall,
  --     o_wb_ack   => s_wb_ack,
  --     o_wb_data  => s_i_wb_data,

  --     i_uart_rx         => uart_rx,
  --     o_uart_tx         => uart_tx,
  --     i_cts_n           => cts_n,
  --     o_rts_n           => open,
  --     o_uart_rx_int     => s_uart_rx_int,
  --     o_uart_tx_int     => s_uart_tx_int,
  --     o_uart_rxfifo_int => open,
  --     o_uart_txfifo_int => open

  --     );


end architecture rtl;
