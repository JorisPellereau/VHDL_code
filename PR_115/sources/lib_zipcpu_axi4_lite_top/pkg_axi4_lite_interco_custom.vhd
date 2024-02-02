-------------------------------------------------------------------------------
-- Title      : Custom Package of the Interconnect
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_axi4_lite_interco_custom.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-19
-- Last update: 2024-02-02
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Custom Package of the Interconnect.
-- THIS FILE MUST BE EDITED 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-19  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pkg_axi4_lite_interco_cutom is

  -- == CONSTANTS ==

  -- ZIPCPU address bus shall be greater than 16 bits
  constant C_AXI_ADDR_WIDTH : integer := 32;  -- AXI ADDR WIDTH
  constant C_AXI_DATA_WIDTH : integer := 32;  -- AXI DATA WIDTH

  constant C_SLAVE_NB : integer := 8;   -- Number of Slave

  -- Index 0 -> AXI4 Lite 7SEGMENTS
  -- Index 1 -> AXI4 Lite LCD
  -- Index 2 -> AXI4 Lite ZIPCPU PERIPHerals
  -- Index 3 -> AXI4 Lite MAX7219
  -- Index 4 -> AXI4 Lite ZIPUART
  -- Index 5 -> AXI4 Lite SPI MASTER
  -- Index 6 -> AXI4 Lite SPI SLAVE
  -- Index 7 -> AXI4 Lite I2C MASTER - EEPROM
  constant C_7SEGMENTS_IDX     : integer := 0;  -- Index Connection of 7Segments
  constant C_LCD_IDX           : integer := 1;  -- Index Connection of LCD
  constant C_ZIPCPU_PERIPH_IDX : integer := 2;  -- Index Connection of ZIPCPU PERIPH
  constant C_MAX7219_IDX       : integer := 3;  -- Index Connection of MAX7219
  constant C_ZIPUART_IDX       : integer := 4;  -- Index Connection of ZIPUART
  constant C_SPI_MASTER_IDX    : integer := 5;  -- Index Connection of SPI MASTER
  constant C_SPI_SLAVE_IDX     : integer := 6;  -- Index Connection of SPI SLAVE
  constant C_I2C_MASTER_EEPROM : integer := 7;  -- Index Connection of I2C MASTER EEPROM

  -- == TYPES ==
  type t_slv_addr is array (0 to C_SLAVE_NB - 1) of std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0);  -- Array of Slave Addr



  constant C_BASE_ADDR_SLAVE_0 : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"00000000";  -- SLAVE 0 Base Addr
  constant C_BASE_ADDR_SLAVE_1 : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"00001000";  -- SLAVE 1 Base Addr
  constant C_BASE_ADDR_SLAVE_2 : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"00002000";  -- SLAVE 2 Base Addr
  constant C_BASE_ADDR_SLAVE_3 : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"00003000";  -- SLAVE 3 Base address
  constant C_BASE_ADDR_SLAVE_4 : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"00004000";  -- SLAVE 4 Base address
  constant C_BASE_ADDR_SLAVE_5 : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"00005000";  -- SLAVE 5 Base address
  constant C_BASE_ADDR_SLAVE_6 : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"00006000";  -- SLAVE 6 Base address
  constant C_BASE_ADDR_SLAVE_7 : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"00007000";  -- SLAVE 7 Base address
  constant C_SLAVE_ADDR_RANGE  : std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0) := x"00000FFF";  -- ADDR Range

  -- Slave Addr MIN
  constant C_SLV_ADDR_MIN_ARRAY : t_slv_addr := (0 => C_BASE_ADDR_SLAVE_0,
                                                 1 => C_BASE_ADDR_SLAVE_1,
                                                 2 => C_BASE_ADDR_SLAVE_2,
                                                 3 => C_BASE_ADDR_SLAVE_3,
                                                 4 => C_BASE_ADDR_SLAVE_4,
                                                 5 => C_BASE_ADDR_SLAVE_5,
                                                 6 => C_BASE_ADDR_SLAVE_6,
                                                 7 => C_BASE_ADDR_SLAVE_7
                                                 );

  -- Slave Addr MAX
  constant C_SLV_ADDR_MAX_ARRAY : t_slv_addr := (0 => std_logic_vector(unsigned(C_BASE_ADDR_SLAVE_0) + unsigned(C_SLAVE_ADDR_RANGE)),
                                                 1 => std_logic_vector(unsigned(C_BASE_ADDR_SLAVE_1) + unsigned(C_SLAVE_ADDR_RANGE)),
                                                 2 => std_logic_vector(unsigned(C_BASE_ADDR_SLAVE_2) + unsigned(C_SLAVE_ADDR_RANGE)),
                                                 3 => std_logic_vector(unsigned(C_BASE_ADDR_SLAVE_3) + unsigned(C_SLAVE_ADDR_RANGE)),
                                                 4 => std_logic_vector(unsigned(C_BASE_ADDR_SLAVE_4) + unsigned(C_SLAVE_ADDR_RANGE)),
                                                 5 => std_logic_vector(unsigned(C_BASE_ADDR_SLAVE_5) + unsigned(C_SLAVE_ADDR_RANGE)),
                                                 6 => std_logic_vector(unsigned(C_BASE_ADDR_SLAVE_6) + unsigned(C_SLAVE_ADDR_RANGE)),
                                                 7 => std_logic_vector(unsigned(C_BASE_ADDR_SLAVE_7) + unsigned(C_SLAVE_ADDR_RANGE))
                                                 );

  -- 7 segments Configuration
  constant C_AXI4_LITE_7SEGS_ADDR_WIDTH : integer := 16;  -- 7 segments ADDR Width

  -- AXI4 Lite LCD Configuration
  constant C_AXI4_LITE_LCD_ADDR_WIDTH : integer := 16;  -- LCD ADDR WIDTH

  -- ZIPCPU PERIPHERAL Configuration
  constant C_AXI4_LITE_PERIPHS_ADDR_WIDTH : integer := 6;  -- ZIPCPU PERIPHERAL ADDR WIDTH

  -- MAX7219 Axi4Lite configuration
  constant C_AXI4_LITE_MAX7219_ADDR_WIDTH : integer range 10 to 64 := 10;  -- MAX7219 AXI4 Lite Addr range

  -- ZIPUART Axi4Lite Configuration
  constant C_AXI4_LITE_ZIPUART_ADDR_WIDTH : integer := 32;  --4;  -- ZIPUART Axi4 Lite Addr range

  -- AXI4 Lite SPI MASTER Configuration
  constant C_AXI4_LITE_SPI_MASTER_ADDR_WIDTH : integer := 16;  -- SPI MASTER ADDR WIDTH

  -- AXI4 Lite SPI SLAVE Configuration
  constant C_AXI4_LITE_SPI_SLAVE_ADDR_WIDTH : integer := 16;  -- SPI SLAVE ADDR WIDTH

  -- AXI4 Lite I2C MASTER EEPROM Configuration
  constant C_AXI4_LITE_I2C_MASTER_EEPROM_ADDR_WIDTH : integer := 16;  -- I2C MASTER EEPROM ADDR WIDTH

end package;

