-------------------------------------------------------------------------------
-- Title      : Test i2c master
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_i2c_master.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-28
-- Last update: 2019-06-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: test i2c master
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

entity test_i2c_master is

end entity test_i2c_master;



architecture arch_test_i2c_master of test_i2c_master is

  component i2c_master is
    generic (
      scl_frequency   : t_i2c_frequency := f400k;  -- Frequency of SCL clock
      clock_frequency : integer         := 20000000);  -- Input clock frequency
    port (
      reset_n      : in    std_logic;   -- Active Low asynchronous reset
      clock        : in    std_logic;   -- Input clock
      start_i2c    : in    std_logic;   -- Start an I2C transaction
      rw           : in    std_logic;   -- Read/Write command
      chip_addr    : in    std_logic_vector(6 downto 0);  -- Chip address [0:127]
      nb_data      : in    integer range 1 to 10;  -- Number of byte to Read or Write
      wdata        : in    std_logic_vector(7 downto 0);  -- Array of data to transmit
      i2c_done     : out   std_logic;   -- I2C transaction done
      sack_error   : out   std_logic;   -- Sack from slave not received
      rdata        : out   std_logic_vector(7 downto 0);  -- Output data read from an I2C transaction
      rdata_valid  : out   std_logic;   -- Rdata valid
      wdata_change : out   std_logic;   -- Ok for a new data
      scl          : inout std_logic;   -- I2C clock
      sda          : inout std_logic);  -- Data line
  end component;

  -- SIGNALS
  signal reset_n : std_logic := '1';
  signal clock   : std_logic := '0';

  -- COMPONENT SIGNALS

  signal start_i2c    : std_logic;
  signal rw           : std_logic;
  signal chip_addr    : std_logic_vector(6 downto 0);
  signal nb_data      : integer range 1 to 10;
  signal wdata        : std_logic_vector(7 downto 0);
  signal i2c_done     : std_logic;
  signal sack_error   : std_logic;
  signal rdata        : std_logic_vector(7 downto 0);
  signal rdata_valid  : std_logic;
  signal wdata_change : std_logic;
  signal scl          : std_logic;
  signal sda          : std_logic;


begin

  -- 50MHz clock
  p_clock_gen : process
  begin  -- process p_clock_gen
    clock <= not clock;
    wait for 10 ns;
  end process p_clock_gen;

  p_stimuli : process
  begin  -- process p_stimuli

    -- INIT
    start_i2c <= '0';
    rw        <= '0';
    chip_addr <= "1111101";
    nb_data   <= 1;
    wdata     <= (others => '0');

    wait for 10 us;

    -- RESET gen
    reset_n <= '0';
    wait for 20 us;
    reset_n <= '1';

    wait for 10 us;

    -- Start a transaction
    start_i2c <= '1';
    wait for 10 us;
    start_i2c <= '0';


    report "end of test !!!";
    wait;
  end process p_stimuli;

  -- I2C Master INST
  i2c_master_inst : i2c_master
    generic map (
      scl_frequency   => f400k,
      clock_frequency => 50000000)
    port map (
      reset_n      => reset_n,
      clock        => clock,
      start_i2c    => start_i2c,
      rw           => rw,
      chip_addr    => chip_addr,
      nb_data      => nb_data,
      wdata        => wdata,
      i2c_done     => i2c_done,
      sack_error   => sack_error,
      rdata        => rdata,
      rdata_valid  => rdata_valid,
      wdata_change => wdata_change,
      scl          => scl,
      sda          => sda);

  scl <= 'H';
  sda <= 'H';



end architecture arch_test_i2c_master;
