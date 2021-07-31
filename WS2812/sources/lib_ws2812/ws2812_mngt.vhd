-------------------------------------------------------------------------------
-- Title      : WS2812 Management block
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ws2812_mngt.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-07-31
-- Last update: 2021-07-31
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-07-31  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity ws2812_mngt is

  generic (
    G_NB_LEDS    : integer   := 2;          -- Leds Number
    G_CLOCK_FREQ : integer   := 100000000;  -- Input Clock Frequency
    G_ADDR_WIDTH : integer   := 8;          -- Addr bus Width
    G_DATA_WIDTH : integer   := 24;         -- Data but Width
    G_WS2812B    : std_logic := '0');       -- WS2812 component selection

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Command
    i_start     : in std_logic;         -- Start Command
    i_loop      : in std_logic;         -- Loop selection
    i_start_ptr : in std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Start Pointer
    i_last_ptr  : in std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Stop Pointer
    i_period    : in std_logic_vector(31 downto 0);  -- Period Value
    i_raz       : in std_logic;         -- Raz Command

    -- RAM I/F
    i_rdata : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Memory RDATA
    o_me    : out std_logic;            -- Memory Enable
    o_we    : out std_logic;            -- Memory Command    
    o_addr  : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Memory Addr

    -- Outputs and Status
    o_ws2812_data      : out std_logic;   -- WS2812 Output
    o_busy             : out std_logic;   -- Busy Status
    o_ptr_error        : out std_logic;   -- Ptr Error
    o_ws2812_data_done : out std_logic);  -- WS2812 Data done

end entity ws2812_mngt;

architecture behv of ws2812_mngt is

begin  -- architecture behv



end architecture behv;
