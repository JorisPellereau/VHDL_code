-------------------------------------------------------------------------------
-- Title      : TOP Block of an FPGA with JTAG and AXI4 Lite Slaves
-- Project    : 
-------------------------------------------------------------------------------
-- File       : jtag_axi4_lite_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-18
-- Last update: 2023-09-20
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

library lib_jtag_axi4_lite_top;

entity jtag_7seg_top is
  generic (
    SEL_ALTERA_VJTAG : boolean := false  -- Selection of the VJTAG component
    );
  port (
    clk   : in std_logic;                -- Clock System
    rst_n : in std_logic;                -- Asynchronous Reset

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

end entity jtag_7seg_top;

architecture rtl of jtag_7seg_top is

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
  
  -- Instanciation of the CORE
  i_jtag_axi4_lite_core_0 : entity lib_jtag_axi4_lite_top.jtag_axi4_lite_core
    generic map (
      G_AXI_DATA_WIDTH => 32,
      G_AXI_ADDR_WIDTH => 16,
      G_SLAVE_NB       => 2
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
