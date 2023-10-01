-------------------------------------------------------------------------------
-- Title      : TOP Block of an FPGA with ZIPCPU and AXI4 Lite Slaves
-- Project    : 
-------------------------------------------------------------------------------
-- File       : zipcpu_axi4_lite_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-18
-- Last update: 2023-10-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-18  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_zipcpu_axi4_lite_top;
use lib_zipcpu_axi4_lite_top.pkg_zipcpu_axi4_lite_top.all;

library lib_axi4_lite;
use lib_axi4_lite.pkg_axi4_lite_interco_cutom.all;

library lib_rom_intel;
use lib_rom_intel.pkg_sp_rom.all;

entity zipcpu_axi4_lite_top is
  port (
    clk   : in std_logic;               -- Clock System
    rst_n : in std_logic;               -- Asynchronous Reset

    -- 7 Segments
    o_seg0 : out std_logic_vector(6 downto 0);  -- SEG 0
    o_seg1 : out std_logic_vector(6 downto 0);  -- SEG 1
    o_seg2 : out std_logic_vector(6 downto 0);  -- SEG 2
    o_seg3 : out std_logic_vector(6 downto 0);  -- SEG 3
    o_seg4 : out std_logic_vector(6 downto 0);  -- SEG 4
    o_seg5 : out std_logic_vector(6 downto 0);  -- SEG 5
    o_seg6 : out std_logic_vector(6 downto 0);  -- SEG 6
    o_seg7 : out std_logic_vector(6 downto 0);  -- SEG 7

    -- LCD
    io_lcd_data : inout std_logic_vector(7 downto 0);  -- Data from/to LCD    
    o_lcd_rw    : out   std_logic;                     -- R/W command
    o_lcd_en    : out   std_logic;                     -- LCD Enable
    o_lcd_rs    : out   std_logic;                     -- LCD RS
    o_lcd_on    : out   std_logic;                     -- LCD ON Management

    -- RED LEDS
    ledr : out std_logic_vector(17 downto 0);  -- RED LEDS

    -- GREEN LEDS
    ledg : out std_logic_vector(8 downto 0)  -- GREEN LEDS
    );

end entity zipcpu_axi4_lite_top;

architecture rtl of zipcpu_axi4_lite_top is

  -- == COMPONENTS ==
  component reset_gen is
    port (
      clk     : in  std_logic;          -- Clock
      arst_n  : in  std_logic;          -- Synchronous Input Reset
      o_rst_n : out std_logic);         -- Output synchronous Reset
  end component;

  -- == INTERNAL SIGNALS ==
  signal rst_n_clk_sys : std_logic;                     -- REset in clk_sys clock domain
  signal lcd_rdata     : std_logic_vector(7 downto 0);  -- LCD Read Data
  signal lcd_wdata     : std_logic_vector(7 downto 0);  -- LCD Write Data
  signal lcd_bidir_sel : std_logic;                     -- LCD Bidir Selector

begin  -- architecture rtl

  -- Instanciation of Reset generation
  i_reset_gen_0 : reset_gen
    port map (
      clk     => clk,
      arst_n  => rst_n,
      o_rst_n => rst_n_clk_sys
      );

  -- BIDIR MNGT
  -- BIDIR Management -- Write access when not G_POL
  io_lcd_data <= lcd_wdata when lcd_bidir_sel = not C_LCD_BIDIR_POLARITY else (others => 'Z');
  lcd_rdata   <= io_lcd_data;  -- io LCD DATA not synchronized in clk clock domain (50MHz) because it's dynamic is slewer than the clock

  -- Instanciation of the CORE
  -- Zipcpu CORE doesnt access an ADDR_WIDTh lower than 16 (idecode multiplier concat : AW-15 < 0 -> BUG !
  i_zipcpu_axi4_lite_core_0 : entity lib_zipcpu_axi4_lite_top.zipcpu_axi4_lite_core
    generic map (
      G_AXI_DATA_WIDTH      => C_AXI_DATA_WIDTH,
      G_AXI_ADDR_WIDTH      => C_AXI_ADDR_WIDTH,
      G_SLAVE_NB            => 2,
      G_CLK_PERIOD_NS       => 20,                    -- Clock Period in ns
      G_BIDIR_POLARITY_READ => C_LCD_BIDIR_POLARITY,  -- BIDIR SEL Polarity
      G_FIFO_ADDR_WIDTH     => 10,                    -- FIFO ADDR WIDTH      
      G_ROM_ADDR_WIDTH      => C_ROM_ADDR_WIDTH,      -- ROM Addr Width - Shall have the size : G_AXI4_LITE_ADDR_WIDTH / 4
      G_ROM_INIT            => C_ROM_INIT
      )
    port map (
      clk_sys   => clk,
      rst_n_sys => rst_n_clk_sys,

      -- 7 Segments
      o_seg0 => o_seg0,
      o_seg1 => o_seg1,
      o_seg2 => o_seg2,
      o_seg3 => o_seg3,
      o_seg4 => o_seg4,
      o_seg5 => o_seg5,
      o_seg6 => o_seg6,
      o_seg7 => o_seg7,

      -- LCD I/F
      i_lcd_data  => lcd_rdata,
      o_lcd_wdata => lcd_wdata,
      o_lcd_rw    => o_lcd_rw,
      o_lcd_en    => o_lcd_en,
      o_lcd_rs    => o_lcd_rs,
      o_lcd_on    => o_lcd_on,
      o_bidir_sel => lcd_bidir_sel,

      -- RED LEDS
      ledr => ledr,

      -- GREEN LEDS
      ledg => ledg
      );

end architecture rtl;
