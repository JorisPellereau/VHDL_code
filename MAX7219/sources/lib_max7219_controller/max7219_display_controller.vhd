-------------------------------------------------------------------------------
-- Title      : MAX7219 DISPLAY CONTROLLER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_display_controller.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-09-26
-- Last update: 2021-04-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 DISPLAY CONTROLLER
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-09-26  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219_interface;
use lib_max7219_interface.pkg_max7219_interface.all;

library lib_max7219_static;
use lib_max7219_static.pkg_max7219_static.all;

library lib_max7219_scroller;
use lib_max7219_scroller.pkg_max7219_scroller.all;

library lib_max7219_controller;
use lib_max7219_controller.pkg_max7219_controller.all;

entity max7219_display_controller is
  generic (
    G_MATRIX_NB : integer range 2 to 8 := 8;  -- MATRIX NUMBER

    -- MAX7219 I/F GENERICS
    G_MAX_HALF_PERIOD : integer := 4;   -- 4 => 6.25MHz with 50MHz input
    G_LOAD_DURATION   : integer := 4;   -- LOAD DURATION in clk_in period    

    -- MAX7219 STATIC CTRL GENERICS
    G_RAM_ADDR_WIDTH_STATIC : integer                       := 8;  -- RAM ADDR WITH
    G_RAM_DATA_WIDTH_STATIC : integer                       := 16;  -- RAM DATA WIDTH
    G_DECOD_MAX_CNT_32B     : std_logic_vector(31 downto 0) := x"02FAF080";

    -- MAX7219 SCROLLER CTRL GENERICS
    G_RAM_ADDR_WIDTH_SCROLLER : integer := 8;   -- RAM ADDR WITH
    G_RAM_DATA_WIDTH_SCROLLER : integer := 8);  -- RAM DATA WIDTH
  port (
    clk   : in std_logic;                       -- Clock
    rst_n : in std_logic;                       -- Asynchronous clock

    -- SELECTION
    i_static_dyn  : in std_logic;       -- STATIC or DYNNAMIC Display sel
    i_new_display : in std_logic;       -- New display

    -- MATRIX CONFIG.
    i_display_test   : in  std_logic;   -- DISPLAY TEST Config
    i_decod_mode     : in  std_logic_vector(7 downto 0);  -- DECOD MODE
    i_intensity      : in  std_logic_vector(7 downto 0);  -- INTENSITY
    i_scan_limit     : in  std_logic_vector(7 downto 0);  -- SCAN LIMIT
    i_shutdown       : in  std_logic_vector(7 downto 0);  -- SHUTDOWN MODE
    i_new_config_val : in  std_logic;   -- CONFIG. VALID
    o_config_done    : out std_logic;   -- CONFIG. DONE

    -- STATIC DISPLAY I/O    
    i_en_static : in std_logic;

    -- RAM Statics I/F
    i_me_static    : in  std_logic;     -- Memory Enable
    i_we_static    : in  std_logic;     -- W/R command
    i_addr_static  : in  std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- RAM ADDR
    i_wdata_static : in  std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM DATA
    o_rdata_static : out std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM RDATA

    -- RAM INFO.
    i_start_ptr_static    : in  std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- ST PTR
    i_last_ptr_static     : in  std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- LAST ADDR
    --i_ptr_val_static      : in  std_logic;  -- PTRS VALIDS
    i_loop_static         : in  std_logic;  -- LOOP CONFIG.
    o_ptr_equality_static : out std_logic;  -- ADDR = LAST PTR
    o_static_busy         : out std_logic;  -- STATIC BUSY

    -- SCROLLER I/O
    -- RAM Commands
    i_ram_start_ptr_scroller : in  std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM START PTR
    i_msg_length_scroller    : in  std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- Message Length
    --i_start_scroll           : in  std_logic;  -- Valid - Start Scroller
    i_max_tempo_cnt_scroller : in  std_logic_vector(31 downto 0);  -- Scroller Tempo
    o_scroller_busy          : out std_logic;  -- SCROLLER BUSY

    -- RAM SCROLLER I/F
    i_me_scroller    : in  std_logic;   -- Memory Enable
    i_we_scroller    : in  std_logic;   -- W/R command
    i_addr_scroller  : in  std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM ADDR
    i_wdata_scroller : in  std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- RAM DATA
    o_rdata_scroller : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- RAM RDATA


    -- MAX7219 OUTPUTS
    o_max7219_load : out std_logic;     -- LOAD command
    o_max7219_data : out std_logic;     -- DATA to send
    o_max7219_clk  : out std_logic      -- CLK

    );
end entity max7219_display_controller;

architecture behv of max7219_display_controller is

  -- INTERNAL SIGNALS
  signal s_start_ptr_static : std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
  signal s_last_ptr_static  : std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
  signal s_ptr_val_static   : std_logic;
  signal s_loop_static      : std_logic;

  signal s_ram_start_ptr_scroller : std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);
  signal s_msg_length_scroller    : std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);
  signal s_start_scroll           : std_logic;

  -- MAX7219 CONFIG signals
  signal s_max7219_if_done_config    : std_logic;
  signal s_max7219_if_start_config   : std_logic;
  signal s_max7219_if_en_load_config : std_logic;
  signal s_max7219_if_data_config    : std_logic_vector(15 downto 0);
  signal s_config_done               : std_logic;

  -- MAX7219 STATIC CTRL signals
  signal s_max7219_if_done_static    : std_logic;
  signal s_max7219_if_start_static   : std_logic;
  signal s_max7219_if_en_load_static : std_logic;
  signal s_max7219_if_data_static    : std_logic_vector(15 downto 0);

  -- MAX7219 STATIC Status signals
  signal s_ptr_equality_static : std_logic;
  signal s_discard_static      : std_logic;
  signal s_status_static       : std_logic;

  -- MAX7219 SCROLLER CTRL signals
  signal s_busy_scroller               : std_logic;
  signal s_max7219_if_done_scroller    : std_logic;
  signal s_max7219_if_start_scroller   : std_logic;
  signal s_max7219_if_en_load_scroller : std_logic;
  signal s_max7219_if_data_scroller    : std_logic_vector(15 downto 0);

  -- MAX7219 I/F signals
  signal s_max7219_if_start   : std_logic;
  signal s_max7219_if_en_load : std_logic;
  signal s_max7219_if_data    : std_logic_vector(15 downto 0);
  signal s_max7219_load       : std_logic;
  signal s_max7219_data       : std_logic;
  signal s_max7219_clk        : std_logic;
  signal s_max7219_if_done    : std_logic;

  signal s_mux_sel : std_logic_vector(1 downto 0);

  signal s_new_config_val : std_logic;

begin  -- architecture behv


  -- MAX7219 DISPLAY SEQUENCER
  max7219_display_sequencer_inst_0 : max7219_display_sequencer
    generic map (
      G_FIFO_DEPTH              => 10,
      G_RAM_ADDR_WIDTH_STATIC   => 8,
      G_RAM_DATA_WIDTH_STATIC   => 16,
      G_RAM_ADDR_WIDTH_SCROLLER => 8,
      G_RAM_DATA_WIDTH_SCROLLER => 8)
    port map (
      clk   => clk,
      rst_n => rst_n,

      i_static_dyn  => i_static_dyn,
      i_new_display => i_new_display,


      -- Config I/F
      i_new_config_val => i_new_config_val,  -- TBD shall be connected to SEQUENCER
      i_config_done    => s_config_done,
      o_new_config_val => s_new_config_val,

      -- Static I/F
      i_start_ptr => i_start_ptr_static,
      i_last_ptr  => i_last_ptr_static,

      i_ptr_equality => s_ptr_equality_static,  -- TBD a remplacer par s_status_static
      o_start_ptr    => s_start_ptr_static,
      o_last_ptr     => s_last_ptr_static,
      o_static_val   => s_ptr_val_static,

      -- Scroller I/F
      i_ram_start_ptr => i_ram_start_ptr_scroller,
      i_msg_length    => i_msg_length_scroller,

      i_busy_scroller => s_busy_scroller,

      o_ram_start_ptr => s_ram_start_ptr_scroller,
      o_msg_length    => s_msg_length_scroller,
      o_start_scroll  => s_start_scroll,

      o_mux_sel => s_mux_sel

      );

  s_status_static <= s_ptr_equality_static or s_discard_static;  -- TBD -
                                                                 -- Detection Pulse

  -- MAX7219 CONFIG INST
  max7219_config_if_inst_0 : max7219_config_if
    generic map(
      G_MATRIX_NB => G_MATRIX_NB
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      -- MATRIX CONFIG.
      i_decod_mode     => i_decod_mode,
      i_intensity      => i_intensity,
      i_scan_limit     => i_scan_limit,
      i_shutdown       => i_shutdown,
      i_display_test   => i_display_test,
      i_new_config_val => s_new_config_val,
      o_config_done    => s_config_done,

      -- MAX7219 I/F
      i_max7219_if_done    => s_max7219_if_done_config,
      o_max7219_if_start   => s_max7219_if_start_config,
      o_max7219_if_en_load => s_max7219_if_en_load_config,
      o_max7219_if_data    => s_max7219_if_data_config);


  -- MAX7219 STATIC DISPLAY CONTROLLER INST
  max7219_cmd_decod_inst_0 : max7219_cmd_decod
    generic map (
      G_RAM_ADDR_WIDTH    => G_RAM_ADDR_WIDTH_STATIC,
      G_RAM_DATA_WIDTH    => G_RAM_DATA_WIDTH_STATIC,
      G_DECOD_MAX_CNT_32B => G_DECOD_MAX_CNT_32B)

    port map(
      clk   => clk,
      rst_n => rst_n,
      i_en  => i_en_static,

      -- RAM I/F
      i_me    => i_me_static,
      i_we    => i_we_static,
      i_addr  => i_addr_static,
      i_wdata => i_wdata_static,
      o_rdata => o_rdata_static,

      -- RAM INFO.
      i_start_ptr    => s_start_ptr_static,
      i_last_ptr     => s_last_ptr_static,
      i_ptr_val      => s_ptr_val_static,
      i_loop         => s_loop_static,
      o_ptr_equality => s_ptr_equality_static,
      o_discard      => s_discard_static,

      -- MAX7219 I/F
      i_max7219_if_done    => s_max7219_if_done_static,
      o_max7219_if_start   => s_max7219_if_start_static,
      o_max7219_if_en_load => s_max7219_if_en_load_static,
      o_max7219_if_data    => s_max7219_if_data_static);

  s_loop_static <= '0';                 -- Not used here

  -- MAX7219 SCROLLER CONTROLLER INST
  max7219_scroller_ctrl_inst_0 : max7219_scroller_ctrl
    generic map (
      G_MATRIX_NB      => G_MATRIX_NB,
      G_RAM_ADDR_WIDTH => G_RAM_ADDR_WIDTH_SCROLLER,
      G_RAM_DATA_WIDTH => G_RAM_DATA_WIDTH_SCROLLER)
    port map(
      clk   => clk,
      rst_n => rst_n,

      -- RAM I/F
      i_me    => i_me_scroller,
      i_we    => i_we_scroller,
      i_addr  => i_addr_scroller,
      i_wdata => i_wdata_scroller,
      o_rdata => o_rdata_scroller,

      -- RAM Commands
      i_ram_start_ptr => s_ram_start_ptr_scroller,
      i_msg_length    => s_msg_length_scroller,
      i_start_scroll  => s_start_scroll,
      i_max_tempo_cnt => i_max_tempo_cnt_scroller,

      -- MAX7219 I/F
      i_max7219_if_done    => s_max7219_if_done_scroller,
      o_max7219_if_start   => s_max7219_if_start_scroller,
      o_max7219_if_en_load => s_max7219_if_en_load_scroller,
      o_max7219_if_data    => s_max7219_if_data_scroller,

      o_busy => s_busy_scroller);



  -- MUX SELECTION
  max7219_mux_sel_inst_0 : max7219_mux_sel
    port map(
      clk   => clk,
      rst_n => rst_n,

      -- MAX selector
      i_mux_sel => s_mux_sel,

      -- Config
      i_max7219_if_start_config   => s_max7219_if_start_config,
      i_max7219_if_en_load_config => s_max7219_if_en_load_config,
      i_max7219_if_data_config    => s_max7219_if_data_config,
      o_max7219_if_done_config    => s_max7219_if_done_config,

      -- Static
      i_max7219_if_start_static   => s_max7219_if_start_static,
      i_max7219_if_en_load_static => s_max7219_if_en_load_static,
      i_max7219_if_data_static    => s_max7219_if_data_static,
      o_max7219_if_done_static    => s_max7219_if_done_static,

      -- Scroller
      i_max7219_if_start_Scroller   => s_max7219_if_start_scroller,
      i_max7219_if_en_load_Scroller => s_max7219_if_en_load_scroller,
      i_max7219_if_data_Scroller    => s_max7219_if_data_scroller,
      o_max7219_if_done_Scroller    => s_max7219_if_done_scroller,

      -- MAX7219 I/F
      i_max7219_if_done    => s_max7219_if_done,
      o_max7219_if_start   => s_max7219_if_start,
      o_max7219_if_en_load => s_max7219_if_en_load,
      o_max7219_if_data    => s_max7219_if_data

      );



  -- MAX7219 I/F INST
  max7219_if_inst_0 : max7219_if
    generic map (
      G_MAX_HALF_PERIOD => G_MAX_HALF_PERIOD,
      G_LOAD_DURATION   => G_LOAD_DURATION
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      -- Input commands
      i_start   => s_max7219_if_start,
      i_en_load => s_max7219_if_en_load,
      i_data    => s_max7219_if_data,

      o_max7219_load => s_max7219_load,
      o_max7219_data => s_max7219_data,
      o_max7219_clk  => s_max7219_clk,

      -- Transaction Done
      o_done => s_max7219_if_done);


  -- OUTPUTS AFFECTATIONS
  o_max7219_load <= s_max7219_load;
  o_max7219_data <= s_max7219_data;
  o_max7219_clk  <= s_max7219_clk;

  o_static_busy         <= not s_ptr_equality_static;
  o_scroller_busy       <= s_busy_scroller;
  o_config_done         <= s_config_done;
  o_ptr_equality_static <= s_ptr_equality_static;

end architecture behv;
