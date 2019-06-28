-------------------------------------------------------------------------------
-- Title      : Top for I2C test
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_i2c_eemprom_de_nano.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-28
-- Last update: 2019-06-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-28  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_i2c;
use lib_i2c.pkg_i2c.all;


entity top_i2c_eemprom_de_nano is

  port (
    clock      : in    std_logic;
    reset_n    : in    std_logic;
    bp1        : in    std_logic;
    bp2        : in    std_logic;
    sack_error : out   std_logic;
    i2c_busy   : out   std_logic;
    scl        : inout std_logic;
    sda        : inout std_logic;

    scl_debug : out std_logic;
    sda_debug : out std_logic
    );

end entity top_i2c_eemprom_de_nano;


architecture arch_top_i2c_eemprom_de_nano of top_i2c_eemprom_de_nano is

  component i2c_24lc02b_controller is

    port (
      clock      : in    std_logic;     -- System Clock 50MHz
      reset_n    : in    std_logic;     -- Asynchronous active low reset
      en         : in    std_logic;
      byte_wr    : in    std_logic;
      page_wr    : in    std_logic;
      byte_rd    : in    std_logic;
      chip_addr  : in    std_logic_vector(6 downto 0);
      wdata      : in    t_byte_array;
      rdata      : out   t_byte_array;
      sack_error : out   std_logic;
      i2c_busy   : out   std_logic;
      scl        : inout std_logic;     -- Clock line
      sda        : inout std_logic
      );

  end component;

  signal en_s         : std_logic;
  signal byte_wr_s    : std_logic;
  signal page_wr_s    : std_logic;
  signal byte_rd_s    : std_logic;
  signal wdata_s      : t_byte_array;
  signal rdata_s      : t_byte_array;
  signal sack_error_s : std_logic;
  signal i2c_busy_s   : std_logic;


begin  -- architecture arch_top_i2c_eemprom_de_nano

  wdata_s <= (0      => x"BE",
              1      => x"CA",
              2      => x"BB",
              others => x"00");

  -- INST
  ctrl_inst : i2c_24lc02b_controller
    port map(
      clock      => clock,
      reset_n    => reset_n,
      en         => en_s,
      byte_wr    => byte_wr_s,
      page_wr    => page_wr_s,
      byte_rd    => byte_rd_s,
      chip_addr  => "1010000",
      wdata      => wdata_s,
      rdata      => rdata_s,
      sack_error => sack_error_s,
      i2c_busy   => i2c_busy_s,
      scl        => scl,
      sda        => sda
      );

  sack_error <= sack_error_s;
  i2c_busy   <= i2c_busy_s;
  en_s       <= '1' when i2c_busy_s = '0'         else '0';
  byte_wr_s  <= '1' when bp1 = '1' and en_s = '1' else '0';
  page_wr_s  <= '0';
  byte_rd_s  <= '1' when bp2 = '1' and en_s = '1' else '0';


  scl_debug <= scl;
  sda_debug <= sda;

end architecture arch_top_i2c_eemprom_de_nano;
