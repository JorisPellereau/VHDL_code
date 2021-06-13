-------------------------------------------------------------------------------
-- Title      : VHDL TOP Testbench
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_top.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-06-07
-- Last update: 2021-06-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-06-07  1.0      jorisp	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_max7219_display_controller;
use lib_max7219_display_controller.pkg_max7219_display_controller.all;

entity tb_top is
  
end entity tb_top;

architecture behv of tb_top is

begin  -- architecture behv


  i_max7219_display_controller_0 : max7219_display_controller
  generic map (
    G_MATRIX_NB => 8,

    -- MAX7219 I/F GENERICS
    G_MAX_HALF_PERIOD => 4,
    G_LOAD_DURATION   => 4,  

    -- MAX7219 STATIC CTRL GENERICS
    G_RAM_ADDR_WIDTH_STATIC => 8,
    G_RAM_DATA_WIDTH_STATIC => 16,
    G_DECOD_MAX_CNT_32B    => x"02FAF080",

    -- MAX7219 SCROLLER CTRL GENERICS
    G_RAM_ADDR_WIDTH_SCROLLER => 8,
    G_RAM_DATA_WIDTH_SCROLLER => 8)
    
  port map (
    clk   => clk,
    rst_n => rst_n,

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

end architecture behv;
