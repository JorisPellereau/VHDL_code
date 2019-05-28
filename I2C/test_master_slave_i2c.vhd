-------------------------------------------------------------------------------
-- Title      : This is the test of the modules Master and Slave I2C
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_master_slave_i2c.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-28
-- Last update: 2019-05-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Test Slave and master i2c
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-28  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_i2c;
use lib_i2c.pkg_i2c.all;

entity test_master_slave_i2c is

end entity test_master_slave_i2c;

architecture arch_test_master_slave_i2c of test_master_slave_i2c is

  -- TB signals
  signal reset_n      : std_logic;         -- Asynchronous reset
  signal clock_master : std_logic := '0';  -- Master clock
  signal clock_slave  : std_logic := '0';  -- Slave clock

  -- I2C MASTER SIGNALS
  signal start_i2c  : std_logic;        -- Start an I2C transfert
  signal rw         : std_logic;        -- RW command
  signal chip_addr  : std_logic_vector(6 downto 0);  -- SLave Addr
  signal nb_data    : integer range 1 to max_array;  -- Number of data to transmit
  signal wdata      : t_byte_array;     -- Array of data to transmit
  signal i2c_done   : std_logic;        -- Transoaction done
  signal sack_error : std_logic;        -- Sack from slave not rcvd
  signal rdata      : t_byte_array;     -- Array of byte read from the slave

  -- I2C SLAVE SIGNALS
  signal data_to_master_o     : std_logic_vector(7 downto 0);  -- Data to transmit
  signal set_data_to_master_i : std_logic;  -- Req to set the data to send
  signal data_valid_i         : std_logic;  -- Data valid from the slave
  signal data_from_master_i   : std_logic_vector(7 downto 0);  -- Read data


  -- I2C interface
  signal scl : std_logic;               -- SCL
  signal sda : std_logic;               -- SDA


begin  -- architecture arch_test_master_slave_i2c


  -- 50 MHz clock master
  p_clock_master : process
  begin  -- process p_clock_master
    clock_master <= not clock_master;
    wait for 10 ns;
  end process p_clock_master;


  -- 5 MHz clock slave
  p_clock_slave : process
  begin  -- process p_clock_slave
    clock_slave <= not clock_slave;
    wait for 100 ns;
  end process p_clock_slave;


  -- purpose: Stimuli for the test
  p_stimuli : process
  begin

    -- INIT inputs
    reset_n          <= '1';
    -- Master inputs
    start_i2c        <= '0';
    rw               <= '0';
    chip_addr        <= (others => '0');
    nb_data          <= 1;
    wdata            <= (others => (others => '0'));
    -- Slave inputs
    data_to_master_o <= (others => '0');

    wait for 10 us;

    -- Gen. reset
    reset_n <= '0';
    wait for 10 us;
    reset_n <= '1';

    -- Start transaction
    wdata(0)  <= x"7E";
    chip_addr <= "1111110";
    start_i2c <= '1';

    wait until rising_edge(i2c_done) for 5 ms;  -- Wait for a end of transaction                                               

    assert false report "end of simulation !!" severity failure;
    wait;
  end process p_stimuli;


  -- Master I2C INST
  master_i2c_inst : master_i2c
    generic map(scl_frequency   => f400k,
                clock_frequency => 50000000)
    port map(reset_n    => reset_n,
             clock      => clock_master,
             start_i2c  => start_i2c,
             rw         => rw,
             chip_addr  => chip_addr,
             nb_data    => nb_data,
             wdata      => wdata,
             i2c_done   => i2c_done,
             sack_error => sack_error,
             rdata      => rdata,
             scl        => scl,
             sda        => sda);


  -- Slave I2C INST
  slave_i2c_inst : i2c_slave
    generic map(slave_addr => "HHHHHH0")
    port map(clock_i              => clock_slave,
             reset_n_i            => reset_n,
             data_to_master_i     => data_to_master_o,
             set_data_to_master_o => set_data_to_master_i,
             data_valid_o         => data_valid_i,
             data_from_master_o   => data_from_master_i,
             scl                  => scl,
             sda                  => sda);

  -- Pullup
  scl <= 'H';
  sda <= 'H';

end architecture arch_test_master_slave_i2c;
