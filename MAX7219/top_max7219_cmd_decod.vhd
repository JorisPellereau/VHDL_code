-------------------------------------------------------------------------------
-- Title      : TOP on DE0 NANO board for MAX7219_cmd_decod
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_max7219_cmd_decod.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-13
-- Last update: 2020-04-14
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: TOP for the test of MAX7219_cmd_decod
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-13  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;


entity top_max7219_cmd_decod is
  generic (
    G_RAM_ADDR_WIDTH             : integer                       := 8;  -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH             : integer                       := 16;  -- RAM DATA WIDTH
    G_DECOD_MAX_CNT_32B          : std_logic_vector(31 downto 0) := x"02FAF080";
    G_MAX7219_IF_MAX_HALF_PERIOD : integer                       := 50;  -- MAX HALF PERIOD for MAX729 CLK generation
    G_MAX7219_LOAD_DUR           : integer                       := 4);  -- MAX7219 LOAD duration in period of clk
  port (
    clk            : in  std_logic;     -- Clock
    rst_n          : in  std_logic;     -- Asynchronous Reset
    o_max7219_load : out std_logic;     -- MAX7219 LOAD
    o_max7219_data : out std_logic;     -- MAX7219 DATA
    o_max7219_clk  : out std_logic);    -- MAX7219 CLK

end entity top_max7219_cmd_decod;

architecture behv of top_max7219_cmd_decod is

  -- INERNAL SIGNALS
  signal s_me       : std_logic;
  signal s_we       : std_logic;
  signal s_en       : std_logic;
  signal s_addr     : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_wdata    : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
  signal s_rdata    : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
  signal s_last_ptr : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);

begin  -- architecture behv


  -- MAX7219 RAM INIT INST
  max7219_init_ram_inst_0 : max7219_init_ram
    generic map (
      G_ADDR_WIDTH => G_RAM_ADDR_WIDTH,
      G_DATA_WIDTH => G_RAM_DATA_WIDTH,
      G_LAST_PTR   => x"00000056")
    port map(
      clk        => clk,
      rst_n      => rst_n,
      o_me       => s_me,
      o_we       => s_we,
      o_addr     => s_addr,
      o_wdata    => s_wdata,
      o_en       => s_en,
      o_last_ptr => s_last_ptr);


  -- MAX7219 CMD DECOD INST
  max7219_cmd_decod_inst : max7219_cmd_decod
    generic map (
      G_RAM_ADDR_WIDTH             => G_RAM_ADDR_WIDTH,    -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH             => G_RAM_DATA_WIDTH,    -- RAM DATA WIDTH
      G_DECOD_MAX_CNT_32B          => G_DECOD_MAX_CNT_32B,  -- MAX CNT by DEFAULT
      G_MAX7219_IF_MAX_HALF_PERIOD => G_MAX7219_IF_MAX_HALF_PERIOD,  -- MAX HALF PERIOD for MAX729 CLK generation
      G_MAX7219_LOAD_DUR           => G_MAX7219_LOAD_DUR)  -- MAX7219 LOAD duration in period of clk

    port map (
      clk     => clk,
      rst_n   => rst_n,
      i_en    => s_en,
      -- RAM I/F
      i_me    => s_me,
      i_we    => s_we,
      i_addr  => s_addr,
      i_wdata => s_wdata,
      o_rdata => s_rdata,

      -- RAM INFO.
      i_last_ptr => s_last_ptr,

      -- MAX7219 I/F
      o_max7219_load => o_max7219_load,
      o_max7219_data => o_max7219_data,
      o_max7219_clk  => o_max7219_clk);  -- MAX7219 CLK

end architecture behv;
