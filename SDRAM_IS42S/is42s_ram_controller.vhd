-------------------------------------------------------------------------------
-- Title      : This is an IS42S SDRAM controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : is42s_ram_controller.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-27
-- Last update: 2019-05-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file is the controller of the SDRAM IS42S
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-27  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity is42s_ram_controller is

  port (
    clock_i          : in    std_logic;  -- System clock
    reset_n_i        : in    std_logic;  -- Active low asynchronous reset
    sdram_addr_o     : out   std_logic_vector(12 downto 0);   -- SDRAM address
    sdram_clock_o    : out   std_logic;  -- SDRAM clock
    sdram_clock_en_o : out   std_logic;  -- SDRAM clock enable
    sdram_cs_n_o     : out   std_logic;  -- SDRAM Chip Select
    sdram_ras_n_o    : out   std_logic;  -- SDRAM Raw Address Strobe
    sdram_cas_n_o    : out   std_logic;  -- SDRAM Column Address Strobe
    sdram_we_n_o     : out   std_logic;  -- SDRAM Write Enable
    sdram_dqm_o      : out   std_logic_vector(1 downto 0);  -- SDRAM byte data mask High-Low
    sdram_ba_o       : out   std_logic_vector(1 downto 0);  -- SDRAM Bank Access
    sdram_data_io    : inout std_logic_vector(15 downto 0));  -- SDRAM Data

end entity is42s_ram_controller;
