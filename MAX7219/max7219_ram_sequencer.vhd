-------------------------------------------------------------------------------
-- Title      : MAX7219 RAM SEQUENCER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_ram_sequencer.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-05-09
-- Last update: 2020-05-09
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 RAM SEQUENCER
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-05-09  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_ram_sequencer is

  generic (
    G_RAM_ADDR_WIDTH : integer              := 8;   -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH : integer              := 16;  -- RAM DATA WIDTH
    G_DIGITS_NB      : integer range 2 to 8 := 2  --DIGIR NB on THE MATRIX DISPLAY
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- SCORE I/F
    i_score_cmd        : in t_score_array;  -- Score Command
    i_score_val        : in std_logic;      -- Score Command Valid
    i_score_start_addr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);


    -- RAM I/F
    o_me    : out std_logic;            -- Memory Enable
    o_we    : out std_logic;            -- W/R Memory Command
    o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
    o_wdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM WDATA
    i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0))  -- RAM RDATA
    );

end entity max7219_ram_sequencer;

architecture behv of max7219_ram_sequencer is

  -- CONSTANTS
  constant C_MAX_SCORE_CNT : integer := 8*G_DIGITS_NB - 1;

  -- INTERNAL SIGNALS
  signal s_score_cnt : integer range 0 to 63 := 0;  -- Score Counter index
  signal s_addr      : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);

begin  -- architecture behv


end architecture behv;
