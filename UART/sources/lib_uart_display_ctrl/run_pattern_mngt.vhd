-------------------------------------------------------------------------------
-- Title      : Run Pattern Management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : run_pattern_mngt.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-12
-- Last update: 2021-05-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-05-12  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_uart_display_ctrl;
use lib_uart_display_ctrl.pkg_uart_max7219_display_ctrl.all;

entity run_pattern_mngt is

  generic (
    G_RAM_DATA_WIDTH_STATIC   : integer := 16;
    G_RAM_ADDR_WIDTH_STATIC   : integer := 8;
    G_RAM_DATA_WIDTH_SCROLLER : integer := 8;
    G_RAM_ADDR_WIDTH_SCROLLER : integer := 8
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Commands from Sequencer
    i_update_static_pattern      : in  std_logic;
    o_update_static_pattern_done : out std_logic;
    o_update_static_discard      : out std_logic;

    i_update_scroller_pattern      : in  std_logic;
    o_update_scroller_pattern_done : out std_logic;
    o_update_scroller_discard      : out std_logic;



    o_static_dyn  : out std_logic;      -- Static or Dynamic Pattern selection
    o_new_display : out std_logic;      -- Valid

    -- STATIC MNGT
    o_en_static           : out std_logic;  -- Enable Static Block
    i_ptr_equality_static : in  std_logic;  -- Static Ptr equality
    o_start_ptr_static    : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
    o_last_ptr_static     : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
    i_static_busy         : in  std_logic;

    -- SCROLLER MNGT
    i_scroller_busy          : in  std_logic;
    o_ram_start_ptr_scroller : out std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM START PTR
    o_msg_length_scroller    : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- Message Length
    o_max_tempo_cnt_scroller : out std_logic_vector(31 downto 0)  -- Scroller Tempo
    );


end entity run_pattern_mngt;

architecture behv of run_pattern_mngt is

begin  -- architecture behv


  -- Outputs Affectation
  o_en_static <= '1';                   -- enable by default



end architecture behv;
