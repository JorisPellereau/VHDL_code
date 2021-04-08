-------------------------------------------------------------------------------
-- Title      : MAX7219 Scroller Controler
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_scroller_ctrl.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2020-08-28
-- Last update: 2021-04-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 Scroller Controler
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

library lib_max7219_scroller;
use lib_max7219_scroller.pkg_max7219_scroller.all;

entity max7219_scroller_ctrl is

  generic (
    G_MATRIX_NB      : integer range 2 to 8 := 8;   -- MATRIX NUMBER
    G_RAM_ADDR_WIDTH : integer              := 8;   -- RAM ADDR WITH
    G_RAM_DATA_WIDTH : integer              := 8);  -- RAM DATA WIDTH

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- RAM I/F
    i_me    : in  std_logic;            -- Memory Enable
    i_we    : in  std_logic;            -- W/R command
    i_addr  : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
    i_wdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM DATA
    o_rdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

    -- RAM Commands
    i_ram_start_ptr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM START PTR
    i_msg_length    : in std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- Message Length
    i_start_scroll  : in std_logic;     -- Valid - Start Scroller
    i_max_tempo_cnt : in std_logic_vector(31 downto 0);  -- Scroller Tempo

    -- MAX7219 I/F
    i_max7219_if_done    : in  std_logic;  -- MAX7219 I/F Done
    o_max7219_if_start   : out std_logic;  -- MAX7219 I/F Start
    o_max7219_if_en_load : out std_logic;  -- MAX7219 Enable Load
    o_max7219_if_data    : out std_logic_vector(15 downto 0);  -- MAX7219 I/F Data

    o_busy : out std_logic);            -- Scroller Controller Busy

end entity max7219_scroller_ctrl;

architecture behv of max7219_scroller_ctrl is

  -- TDPRAM single CLOCK
  component tdpram_sclk is

    generic (
      G_ADDR_WIDTH : integer := 8;      -- ADDR WIDTH
      G_DATA_WIDTH : integer := 8);     -- DATA WIDTH

    port (
      clk       : in  std_logic;        -- Clock
      i_me_a    : in  std_logic;        -- Memory Enable port A
      i_we_a    : in  std_logic;        -- Memory Write/Read access port A
      i_addr_a  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR port A
      i_wdata_a : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA port A
      o_rdata_a : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- RDATA port A

      i_me_b    : in  std_logic;        -- Memory Enable port B
      i_we_b    : in  std_logic;        -- Memory Write/Read access port B
      i_addr_b  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR port B
      i_wdata_b : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA port B
      o_rdata_b : out std_logic_vector(G_DATA_WIDTH - 1 downto 0)  -- RDATA port B
      );

  end component tdpram_sclk;

  -- INTERNAL SIGNALS
  signal s_me_b    : std_logic;
  signal s_we_b    : std_logic;
  signal s_addr_b  : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_wdata_b : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
  signal s_rdata_b : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);

  signal s_seg_data         : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
  signal s_seg_data_valid   : std_logic;
  signal s_scroller_if_busy : std_logic;

  signal s_done    : std_logic;
  signal s_start   : std_logic;
  signal s_en_load : std_logic;
  signal s_data    : std_logic_vector(15 downto 0);

begin  -- architecture behv

  -- MAX7219 RAM2SCROLLER IF INST
  max7219_ram2scroller_if_inst_0 : max7219_ram2scroller_if
    generic map (
      G_MATRIX_NB      => G_MATRIX_NB,
      G_RAM_ADDR_WIDTH => G_RAM_ADDR_WIDTH,
      G_RAM_DATA_WIDTH => G_RAM_DATA_WIDTH)
    port map(
      clk   => clk,
      rst_n => rst_n,

      i_start         => i_start_scroll,
      i_msg_length    => i_msg_length,
      i_ram_start_ptr => i_ram_start_ptr,

      i_rdata => s_rdata_b,
      o_me    => s_me_b,
      o_we    => s_we_b,
      o_addr  => s_addr_b,

      o_seg_data       => s_seg_data,
      o_seg_data_valid => s_seg_data_valid,

      i_scroller_if_busy => s_scroller_if_busy,
      o_busy             => o_busy

      );

  -- Max7219 SCROLLER INST
  max7219_scroller_if_inst_0 : max7219_scroller_if
    generic map (
      G_MATRIX_NB => G_MATRIX_NB)
    port map(
      clk   => clk,
      rst_n => rst_n,

      i_seg_data       => s_seg_data,
      i_seg_data_valid => s_seg_data_valid,
      i_max_tempo_cnt  => i_max_tempo_cnt,
      o_busy           => s_scroller_if_busy,

      -- MAX7219 I/F
      i_max7219_if_done    => s_done,
      o_max7219_if_start   => s_start,
      o_max7219_if_en_load => s_en_load,
      o_max7219_if_data    => s_data);

  -- TDPRAM INST
  tdpram_inst_0 : tdpram_sclk
    generic map (
      G_ADDR_WIDTH => G_RAM_ADDR_WIDTH,
      G_DATA_WIDTH => G_RAM_DATA_WIDTH
      )
    port map(
      clk       => clk,
      i_me_a    => i_me,
      i_we_a    => i_we,
      i_addr_a  => i_addr,
      i_wdata_a => i_wdata,
      o_rdata_a => o_rdata,

      i_me_b    => s_me_b,
      i_we_b    => s_we_b,
      i_addr_b  => s_addr_b,
      i_wdata_b => s_wdata_b,
      o_rdata_b => s_rdata_b
      );


  -- OUTPUTS AFFECTATION
  o_max7219_if_start   <= s_start;
  o_max7219_if_en_load <= s_en_load;
  o_max7219_if_data    <= s_data;

  -- INPUTS CONNECTION
  s_done <= i_max7219_if_done;

end architecture behv;

