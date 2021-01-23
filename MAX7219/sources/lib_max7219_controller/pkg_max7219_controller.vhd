-------------------------------------------------------------------------------
-- Title      : Package of Library MAX7219 Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_max7219_controller.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-10-03
-- Last update: 2021-01-23
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Package of Library MAX7219 Controller
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-10-03  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

package pkg_max7219_controller is

  -- MAX7219 Config Interface
  -- Set Config for MAX7219
  -- 1st Step : Config right after reset release
  -- 2nd step : Wait for a new config from external
  component max7219_config_if is
    generic(
      G_MATRIX_NB : integer := 8
      );
    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous clock

      -- MATRIX CONFIG.
      i_decod_mode     : in  std_logic_vector(7 downto 0);  -- DECOD MODE
      i_intensity      : in  std_logic_vector(7 downto 0);  -- INTENSITY
      i_scan_limit     : in  std_logic_vector(7 downto 0);  -- SCAN LIMIT
      i_shutdown       : in  std_logic_vector(7 downto 0);  -- SHUTDOWN MODE
      i_display_test   : in  std_logic;  -- DISPLAY TEST Config
      i_new_config_val : in  std_logic;  -- CONFIG. VALID
      o_config_done    : out std_logic;  -- CONFIG. DONE

      -- MAX7219 I/F
      i_max7219_if_done    : in  std_logic;  -- MAX7219 I/F Done
      o_max7219_if_start   : out std_logic;  -- MAX7219 I/F Start
      o_max7219_if_en_load : out std_logic;  -- MAX7219 Enable Load
      o_max7219_if_data    : out std_logic_vector(15 downto 0));  -- MAX7219 I/F Data
  end component;



  -- DISPLAY CONTROLLER FOR MAX7219
  -- Config Block
  -- Static Block
  -- Scrolelr block
  component max7219_display_controller is
    generic (
      G_MATRIX_NB : integer range 2 to 8 := 8;  -- MATRIX NUMBER

      -- MAX7219 I/F GENERICS
      G_MAX_HALF_PERIOD : integer := 4;  -- 4 => 6.25MHz with 50MHz input
      G_LOAD_DURATION   : integer := 4;  -- LOAD DURATION in clk_in period    

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
      i_static_dyn : in std_logic;      -- STATIC or DYNNAMIC Display sel

      -- MATRIX CONFIG.
      i_decod_mode     : in  std_logic_vector(7 downto 0);  -- DECOD MODE
      i_intensity      : in  std_logic_vector(7 downto 0);  -- INTENSITY
      i_scan_limit     : in  std_logic_vector(7 downto 0);  -- SCAN LIMIT
      i_shutdown       : in  std_logic_vector(7 downto 0);  -- SHUTDOWN MODE
      i_new_config_val : in  std_logic;                     -- CONFIG. VALID
      o_config_done    : out std_logic;                     -- CONFIG. DONE

      -- STATIC DISPLAY I/O    
      i_en_static : in std_logic;

      -- RAM Statics I/F
      i_me_static    : in  std_logic;   -- Memory Enable
      i_we_static    : in  std_logic;   -- W/R command
      i_addr_static  : in  std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- RAM ADDR
      i_wdata_static : in  std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM DATA
      o_rdata_static : out std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM RDATA

      -- RAM INFO.
      i_start_ptr_static    : in  std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- ST PTR
      i_last_ptr_static     : in  std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- LAST ADDR
      i_ptr_val_static      : in  std_logic;  -- PTRS VALIDS
      i_loop_static         : in  std_logic;  -- LOOP CONFIG.
      o_ptr_equality_static : out std_logic;  -- ADDR = LAST PTR
      o_static_busy         : out std_logic;  -- STATIC BUSY

      -- SCROLLER I/O
      -- RAM Commands
      i_ram_start_ptr_scroller : in  std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM START PTR
      i_msg_length_scroller    : in  std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- Message Length
      i_start_scroll           : in  std_logic;  -- Valid - Start Scroller
      i_max_tempo_cnt_scroller : in  std_logic_vector(31 downto 0);  -- Scroller Tempo
      o_scroller_busy          : out std_logic;  -- SCROLLER BUSY

      -- RAM SCROLLER I/F
      i_me_scroller    : in  std_logic;  -- Memory Enable
      i_we_scroller    : in  std_logic;  -- W/R command
      i_addr_scroller  : in  std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM ADDR
      i_wdata_scroller : in  std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- RAM DATA
      o_rdata_scroller : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- RAM RDATA


      -- MAX7219 OUTPUTS
      o_max7219_load : out std_logic;   -- LOAD command
      o_max7219_data : out std_logic;   -- DATA to send
      o_max7219_clk  : out std_logic    -- CLK

      );
  end component;


  -- DISPLAY SEQUENCER
  component max7219_display_sequencer is

    generic (
      G_FIFO_DEPTH              : integer := 10;  -- Fifo DEPTH
      G_RAM_ADDR_WIDTH_STATIC   : integer := 8;   -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH_STATIC   : integer := 16;  -- RAM DATA WIDTH
      G_RAM_ADDR_WIDTH_SCROLLER : integer := 8;   -- RAM ADDR WITH
      G_RAM_DATA_WIDTH_SCROLLER : integer := 8);  -- RAM DATA WIDTH
    port (
      clk   : in std_logic;                       -- Clock
      rst_n : in std_logic;                       -- Asynchronos reset

      i_static_dyn  : in std_logic;     -- Static or Dynamic selection
      i_new_display : in std_logic;     -- Display Static or Dyn Valid


      -- Config I/F
      i_new_config_val : in std_logic;  -- CONFIG. VALID
      i_config_done    : in std_logic;  -- CONFIG. DONE


      -- Static I/F
      i_start_ptr : in std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
      i_last_ptr  : in std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);

      i_ptr_equality : in  std_logic;
      o_start_ptr    : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
      o_last_ptr     : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
      o_static_val   : out std_logic;

      -- Scroller I/F
      i_ram_start_ptr : in std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);
      i_msg_length    : in std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);

      i_busy_scroller : in std_logic;

      o_ram_start_ptr : out std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);
      o_msg_length    : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);
      o_start_scroll  : out std_logic

      );

  end component;

end package pkg_max7219_controller;
