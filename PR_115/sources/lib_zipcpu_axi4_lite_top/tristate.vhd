-------------------------------------------------------------------------------
-- Title      : Tristate Management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tristate.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-02-02
-- Last update: 2024-02-02
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file contains all tristate buffer for the TOP design
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-02-02  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_zipcpu_axi4_lite_top;
use lib_zipcpu_axi4_lite_top.pkg_zipcpu_axi4_lite_top.all;

entity tristate is
  port(
    -- LCD Tristate
    io_lcd_data   : inout std_logic_vector(7 downto 0);  -- LCD DATA I/O
    lcd_rdata     : out   std_logic_vector(7 downto 0);  -- LCD Read Data
    lcd_wdata     : in    std_logic_vector(7 downto 0);  -- LCD Write Data
    lcd_bidir_sel : in    std_logic;                     -- LCD Bidir. Select

    -- I2C MASTER EEPROM Tristate
    sclk_io_eeprom : inout std_logic;   -- InOut SCLK
    sclk_eeprom    : in    std_logic;   -- SCLK
    sclk_en_eeprom : in    std_logic;   -- Enable SCLK
    sda_io_eeprom  : inout std_logic;   -- InOut SDA
    sda_in_eeprom  : out   std_logic;   -- Input Data
    sda_out_eeprom : in    std_logic;   -- Output Data
    sda_en_eeprom  : in    std_logic    -- Enable SDA
    );
end entity tristate;

architecture rtl of tristate is

begin  -- architecture rtl

  -- LCD DATA I/O
  -- BIDIR Management -- Write access when not G_POL
  io_lcd_data <= lcd_wdata when lcd_bidir_sel = not C_LCD_BIDIR_POLARITY else (others => 'Z');
  lcd_rdata   <= io_lcd_data;  -- io LCD DATA not synchronized in clk clock domain (50MHz) because it's dynamic is slewer than the clock

  -- I2C MASTER EEPROM I/O' 
  sclk_io_eeprom <= sclk_eeprom    when sclk_en_eeprom = '1' else 'Z';
  sda_io_eeprom  <= sda_out_eeprom when sda_en_eeprom = '1'  else 'Z';
  sda_in_eeprom  <= sda_io_eeprom;

end architecture rtl;
