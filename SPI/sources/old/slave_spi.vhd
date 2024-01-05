-------------------------------------------------------------------------------
-- Title      : Slave SPI
-- Project    : 
-------------------------------------------------------------------------------
-- File       : slave_spi.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-07-17
-- Last update: 2019-07-17
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Slave SPI module
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-17  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_spi;
use lib_spi.pkg_spi.all;

entity slave_spi is

  generic (
    cpol      : std_logic := '0';       -- Clock Polaroty
    cpha      : std_logic := '0';       -- Clock Phase
    data_size : integer   := 8;         -- Size of the data
    msb_first : boolean   := true);     -- True  :  MSB first else LSB

  port (
    reset_n     : in  std_logic;        -- Active low asynchronous reset
    clock       : in  std_logic;
    cs          : in  st_ogic;          -- Slave select
    mosi        : in  std_logic;        -- MOSI
    sclk        : in  std_logic;        -- SPI clock
    wdata       : in  std_logic_vector(data_size - 1 downto 0);  -- Data to send to the master
    miso        : out std_logic;        -- MISO
    rdata       : out std_logic_vector(data_size - 1 downto 0);  -- read data from master
    rdata_valid : out std_logic);       -- Data available

end entity slave_spi;


architecture arch_slave_spi of slave_spi is

begin  -- architecture arch_slave_spi



end architecture arch_slave_spi;
