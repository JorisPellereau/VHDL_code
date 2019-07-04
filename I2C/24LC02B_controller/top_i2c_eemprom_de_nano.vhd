-------------------------------------------------------------------------------
-- Title      : Top for I2C test
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_i2c_eemprom_de_nano.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-28
-- Last update: 2019-07-04
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
    clock   : in std_logic;
    reset_n : in std_logic;

    -- I2C interface
    scl : inout std_logic;
    sda : inout std_logic;

    leds : out std_logic_vector(7 downto 0);

    -- I2C debug
    scl_debug : out std_logic;
    sda_debug : out std_logic
    );

end entity top_i2c_eemprom_de_nano;


architecture arch_top_i2c_eemprom_de_nano of top_i2c_eemprom_de_nano is

  component NIOS_II_eeprom_cmd is
    port (
      clk_clk                                 : in  std_logic                    := 'X';  -- clk
      reset_reset_n                           : in  std_logic                    := 'X';  -- reset_n
      po_commands_external_connection_export  : out std_logic_vector(4 downto 0);  -- export
      po_chip_addr_external_connection_export : out std_logic_vector(6 downto 0);  -- export
      po_word_addr_external_connection_export : out std_logic_vector(7 downto 0);  -- export
      pi_infos_external_connection_export     : in  std_logic_vector(1 downto 0) := (others => 'X')  -- export
      );
  end component NIOS_II_eeprom_cmd;

  component pll_20Mhz is
    port
      (
        areset : in  std_logic := '0';
        inclk0 : in  std_logic := '0';
        c0     : out std_logic;
        locked : out std_logic
        );
  end component;


  -- EEPROM CTRL SIGNALS
  signal en_s         : std_logic;
  signal start_s      : std_logic;
  signal byte_wr_s    : std_logic;
  signal page_wr_s    : std_logic;
  signal byte_rd_s    : std_logic;
  signal chip_addr_s  : std_logic_vector(6 downto 0);
  signal word_addr_s  : std_logic_vector(7 downto 0);
  -- signal wdata_s      : t_byte_array;
  -- signal rdata_s      : t_byte_array;
  signal sack_error_s : std_logic;
  signal i2c_busy_s   : std_logic;

  -- I2C MASTER SIGNALS
  signal wdata_s        : std_logic_vector(7 downto 0);
  signal rdata_s        : std_logic_vector(7 downto 0);
  signal rdata_valid_s  : std_logic;
  signal wdata_change_s : std_logic;
  signal rw_s           : std_logic;
  signal i2c_done_s     : std_logic;

  -- NIOS Signals
  signal po_commands_external_connection_export_s  : std_logic_vector(4 downto 0);  -- To input of the i2c eep ctrl
  signal po_chip_addr_external_connection_export_s : std_logic_vector(6 downto 0);  -- Chip addr cmd

  signal clock_20mhz : std_logic;       -- Clock 20MHz from PLL

begin  -- architecture arch_top_i2c_eemprom_de_nano

  wdata_s <= x"BE";

  -- wdata_s <= (0 => x"BE",
  --             1 => x"CA",
  --             2 => x"BB",
  --             3 => x"11",
  --             4 => x"45",
  --             5 => x"99",
  --             6 => x"69",
  --             7 => x"33",
  --             8 => x"12"
  --             );

  -- INST
  -- ctrl_inst : i2c_24lc02b_controller
  --   port map(
  --     clock      => clock_20mhz,
  --     reset_n    => reset_n,
  --     en         => en_s,
  --     start      => start_s,
  --     byte_wr    => byte_wr_s,
  --     page_wr    => page_wr_s,
  --     byte_rd    => byte_rd_s,
  --     chip_addr  => chip_addr_s,
  --     word_addr  => word_addr_s,
  --     wdata      => wdata_s,
  --     rdata      => rdata_s,
  --     sack_error => sack_error_s,
  --     i2c_busy   => i2c_busy_s,
  --     scl        => scl,
  --     sda        => sda
  --     );

  -- MASTER I2C INST
  master_i2c_inst : i2c_master
    generic map(
      scl_frequency   => f400k,
      clock_frequency => 20000000)
    port map(
      reset_n      => reset_n,
      clock        => clock_20mhz,
      start_i2c    => start_s,
      rw           => rw_s,
      chip_addr    => chip_addr_s,
      nb_data      => 1,
      wdata        => wdata_s,
      i2c_done     => i2c_done_s,
      sack_error   => sack_error_s,
      rdata        => rdata_s,
      rdata_valid  => rdata_valid_s,
      wdata_change => wdata_change_s,
      scl          => scl,
      sda          => sda,
      scl_o        => scl_debug,
      sda_o        => sda_debug);



  -- scl_debug <= scl;
  -- sda_debug <= sda;

  u0 : component NIOS_II_eeprom_cmd
    port map (
      clk_clk                                 => clock_20mhz,
      reset_reset_n                           => reset_n,
      po_commands_external_connection_export  => po_commands_external_connection_export_s,
      po_chip_addr_external_connection_export => chip_addr_s,
      po_word_addr_external_connection_export => word_addr_s,
      pi_infos_external_connection_export     => sack_error_s & i2c_done_s
      );

  leds(0)          <= sack_error_s;
  leds(7)          <= i2c_done_s;
  leds(6 downto 1) <= (others => '0');

  en_s      <= po_commands_external_connection_export_s(0);
  start_s   <= po_commands_external_connection_export_s(1);
  rw_s      <= po_commands_external_connection_export_s(2);
  page_wr_s <= po_commands_external_connection_export_s(3);
  byte_rd_s <= po_commands_external_connection_export_s(4);


  pll_20mhz_inst : pll_20Mhz
    port map
    (
      areset => reset_n,
      inclk0 => clock,
      c0     => clock_20mhz,
      locked => open
      );


end architecture arch_top_i2c_eemprom_de_nano;
