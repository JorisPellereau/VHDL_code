-------------------------------------------------------------------------------
-- Title      : MAX7219 RAM to SCROLLER I/F
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_ram2scroller_if.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2020-08-28
-- Last update: 2020-09-20
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


architecture behv of max7219_ram2scroller_if is

  -- INTERNAL SIGNALS
  signal s_busy             : std_logic;  -- Busy
  signal s_start            : std_logic;  -- Start Pipe
  signal s_scroller_if_busy : std_logic;  -- S_scroller if busy pipe

begin  -- architecture behv

  p_pipe_in : process (clk, rst_n) is
  begin  -- process p_pipe_in
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start            <= '0';
      s_scroller_if_busy <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_start            <= i_start;
      s_scroller_if_busy <= i_scroller_if_busy;
    end if;
  end process p_pipe_in;


  p_busy_mngt : process (clk, rst_n) is
  begin  -- process p_busy_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_busy <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- On start Rising Edge
      if(i_start = '1' and s_start = '0') then
        if(i_scroller_if_busy = '0') then
          s_busy <= '1';
        else
          s_busy <= '0';
        end if;
      end if;

      -- On falling Edge of Scroller IF
      if(i_scroller_if_busy = '0' and s_scroller_if_busy = '1') then
        s_busy <= '0';
      end if;

    end if;
  end process p_busy_mngt;


  -- Outputs Affectations
  o_busy <= s_busy;
end architecture behv;
