-------------------------------------------------------------------------------
-- Title      : Test master SPI
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_master_spi.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-05-03
-- Last update: 2019-07-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is a unitary test
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-03  1.0      pellereau       Created
-------------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;

library lib_spi;
use lib_spi.pkg_spi.all;


entity test_master_spi is

end entity test_master_spi;


architecture arch_test_master_spi of test_master_spi is

  -- CONSTANTS
  constant data_size     : integer := 8;      -- Data size
  constant T_input_clock : time    := 20 ns;  -- Clock input : 50MHz 1/50MHz => 20 ns

  -- TB signals
  signal clock   : std_logic := '0';    -- Clock
  signal reset_n : std_logic := '1';    -- Asynchronous reset

  -- Master SPI signals
  signal ssi         : std_logic_vector(max_slave_number - 1 downto 0);  -- Slave select input
  signal start_spi   : std_logic;       -- start SPI
  signal wdata       : std_logic_vector(data_size - 1 downto 0);  --  data to write on the bus;
  signal miso        : std_logic;       -- MISO
  signal mosi        : std_logic;       -- MOSI
  signal sclk        : std_logic;       -- SCLK
  signal ssn         : std_logic_vector(max_slave_number - 1 downto 0);  -- Slave select output
  signal rdata       : std_logic_vector(data_size - 1 downto 0);  -- RDATA
  signal rdata_valid : std_logic;       -- Rdata valid

begin  -- architecture arch_test_master_spi

  p_clock_gen : process
  begin  -- process p_clock_gen
    clock <= not clock;
    wait for T_input_clock / 2;
  end process p_clock_gen;

  -- Master SPI INST
  inst_master_spi : master_spi
    generic map (
      cpol         => '1',
      cpha         => '1',
      data_size    => data_size,
      slave_number => 2)
    port map (
      reset_n     => reset_n,
      clock       => clock,
      ssi         => ssi,
      start_spi   => start_spi,
      wdata       => wdata,
      miso        => miso,
      mosi        => mosi,
      sclk        => sclk,
      ssn         => ssn,
      rdata       => rdata,
      rdata_valid => rdata_valid);


-- This process generates stimuli in order to test the master_spi
  p_stimuli : process
  begin  -- process p_stimuli

    -- INIT signals/Inputs
    ssi       <= (others => '0');
    start_spi <= '0';
    wdata     <= (others => '0');
    miso      <= '0';                   -- ?

    -- Reset system
    wait for 10 us;
    reset_n <= '0', '1' after 100 us;

    wait for 223 us;

    wdata     <= x"E9";
    ssi       <= b"01";
    wait for 0.7 us;
    start_spi <= '1', '0' after 10 us;


    wait for 200 ms;

    assert false report "end of SPI test !!!" severity failure;
    wait;
  end process p_stimuli;

end architecture arch_test_master_spi;
