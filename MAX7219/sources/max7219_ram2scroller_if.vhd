-------------------------------------------------------------------------------
-- Title      : MAX7219 RAM to SCROLLER I/F
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_ram2scroller_if.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2020-08-28
-- Last update: 2020-08-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 RAM to SCROLLER I/F
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-08-28  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_ram2scroller_if is

  generic (
    G_MATRIX_NB      : integer range 2 to 8 := 8;   -- MATRIX NUMBER
    G_RAM_ADDR_WIDTH : integer              := 8;   -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH : integer              := 8);  -- RAM DATA WIDTH

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- EXTERNAL I/F
    i_start : in std_logic;             -- START SCROLL

    -- RAM I/F
    i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA
    o_me    : out std_logic;            -- Memory Enable
    o_we    : out std_logic;            -- W/R command
    o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR


    -- RAM SCROLLER I/F
    o_seg_data       : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- SEG DATA
    o_seg_data_valid : out std_logic;   -- SEG DATA VAL

    i_scroller_if_busy : in std_logic;



    o_busy : out std_logic);            -- Scroller Controller Busy
end entity max7219_ram2scroller_if;
