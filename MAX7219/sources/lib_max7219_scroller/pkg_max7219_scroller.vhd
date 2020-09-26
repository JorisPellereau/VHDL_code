-------------------------------------------------------------------------------
-- Title      : MAX7219 Scroller Package Library
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_max7219_scroller.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-09-26
-- Last update: 2020-09-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Package of MAX7219 Sroller Library
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-09-26  1.0      jorisp  Created
-------------------------------------------------------------------------------

package pkg_max7219_scroller is

  -- MAX7219 SCROLLER INTERFACE
  -- Interface to MAX7219 Interface
  -- Scroll message on the left
  component max7219_scroller_if is
    generic (
      G_MATRIX_NB : integer range 2 to 8 := 8);  -- MATRIX_NB
    port (
      --# {{clocks|Clock and Reset}}
      clk   : in std_logic;                      -- Clock
      rst_n : in std_logic;                      -- Asynchronous Reset

      --#{{Control signals}}
      i_seg_data       : in  std_logic_vector(7 downto 0);   -- Segment Data
      i_seg_data_valid : in  std_logic;
      i_max_tempo_cnt  : in  std_logic_vector(31 downto 0);  -- Max Tempo Counter
      o_busy           : out std_logic;  -- Scroller I/F Busy

      -- MAX7219 I/F
      --#{{MAX7219_if Interface}}
      i_max7219_if_done    : in  std_logic;  -- MAX7219 I/F Done
      o_max7219_if_start   : out std_logic;  -- MAX7219 I/F Start
      o_max7219_if_en_load : out std_logic;  -- MAX7219 Enable Load
      o_max7219_if_data    : out std_logic_vector(15 downto 0));  -- MAX7219 I/F Data
  end component;


  -- MAX7219 RAM to Scroller Interface
  -- Interface with MAX7219 SCROLLER IF
  -- Manage RAM Access
  component max7219_ram2scroller_if is
    generic (
      G_MATRIX_NB      : integer range 2 to 8 := 8;   -- MATRIX NUMBER
      G_RAM_ADDR_WIDTH : integer              := 8;   -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH : integer              := 8);  -- RAM DATA WIDTH
    port (
      --# {{clocks|Clock and Reset}}
      clk   : in std_logic;                           -- Clock
      rst_n : in std_logic;                           -- Asynchronous Reset

      --#{{Controls Inputs}}
      i_start         : in std_logic;   -- START SCROLL
      i_msg_length    : in std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
      i_ram_start_ptr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);

      --#{{RAM Interface}}
      i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA
      o_me    : out std_logic;          -- Memory Enable
      o_we    : out std_logic;          -- W/R command
      o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR

      --#{{Scroller Interface}}
      o_seg_data         : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- SEG DATA
      o_seg_data_valid   : out std_logic;  -- SEG DATA VAL
      i_scroller_if_busy : in  std_logic;

      --#{{Busy signal}}
      o_busy : out std_logic);          -- Scroller Controller Busy
  end component;



  component max7219_scroller_ctrl is
    generic (
      G_MATRIX_NB      : integer range 2 to 8 := 8;   -- MATRIX NUMBER
      G_RAM_ADDR_WIDTH : integer              := 8;   -- RAM ADDR WITH
      G_RAM_DATA_WIDTH : integer              := 8);  -- RAM DATA WIDTH
    port (
      --# {{clocks|Clock and Reset}}
      clk   : in std_logic;                           -- Clock
      rst_n : in std_logic;                           -- Asynchronous Reset

      --#{{RAM Interface}}
      i_me    : in  std_logic;          -- Memory Enable
      i_we    : in  std_logic;          -- W/R command
      i_addr  : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
      i_wdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM DATA
      o_rdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

      --#{{Control Signals}}
      i_ram_start_ptr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM START PTR
      i_msg_length    : in std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- Message Length
      i_start_scroll  : in std_logic;   -- Valid - Start Scroller
      i_max_tempo_cnt : in std_logic_vector(31 downto 0);  -- Scroller Tempo

      --#{{MAX7219_if Interface}}
      i_max7219_if_done    : in  std_logic;  -- MAX7219 I/F Done
      o_max7219_if_start   : out std_logic;  -- MAX7219 I/F Start
      o_max7219_if_en_load : out std_logic;  -- MAX7219 Enable Load
      o_max7219_if_data    : out std_logic_vector(15 downto 0);  -- MAX7219 I/F Data

      --#{{Busy Signal}}
      o_busy : out std_logic);          -- Scroller Controller Busy
  end component;

end package pkg_max7219_scroller;
