-------------------------------------------------------------------------------
-- Title      : MAX7219 SCROLLER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_scroller.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-07-25
-- Last update: 2020-07-25
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description : MAX7219 SCROLLER
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-07-25  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_scroller is

  generic (
    G_RAM_ADDR_WIDTH : integer := 8;    -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH : integer := 16;   -- RAM DATA WIDTH
    G_DIGITS_NB      : integer := 8);   -- DIGIT NUMBER

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- COMMANDS
    i_start_scroll : in std_logic;      -- START SCROLL COMMAND

    -- MEMORY I/F
    o_me    : out std_logic;            -- Memory Enable
    o_we    : out std_logic;            -- R/W enable
    o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- MEMORY ADDR
    i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- MEMORY RDATA

    -- MAX7219 I/F
    o_start   : out std_logic;                      -- MAX7219 I/F Start
    o_en_load : out std_logic;                      -- MAX7219 I/F Enable Load
    o_data    : out std_logic_vector(15 downto 0);  -- MAX7219 I/F DATA
    i_done    : in  std_logic);                     -- MAX7219 DONE

end entity max7219_scroller;


architecture behv of max7219_scroller is

  -- INTERNAL SIGNALS
  signal s_msg2scroll_array : t_msg2scroll_array(0 to 2**G_RAM_ADDR_WIDTH - 2);  -- Message to Scroll

  signal s_shift_nb : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- Shift Number
  signal s_start    : std_logic;

begin  -- architecture behv


  -- MAX7219 SCROLLER READ MEMORY INST
  max7219_scroller_rd_mem_inst_0 : max7219_scroller_rd_mem
    generic map (
      G_RAM_ADDR_WIDTH => G_RAM_ADDR_WIDTH,
      G_RAM_DATA_WIDTH => G_RAM_DATA_WIDTH,
      G_DIGITS_NB      => G_DIGITS_NB
      )
    port map(
      clk   => clk,
      rst_n => rst_n,

      i_start_scroll => i_start_scroll,

      o_me    => o_me,
      o_we    => o_we,
      o_addr  => o_addr,
      i_rdata => i_rdata,

      o_msg2scroll_array => s_msg2scroll_array,
      o_shift_nb         => s_shift_nb,
      o_start            => s_start
      );



end architecture behv;
