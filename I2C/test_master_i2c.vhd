-------------------------------------------------------------------------------
-- Title      : Master I2C unitary test
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_master_i2c.vhd
-- Author     :   Joris Pellereau
-- Company    : 
-- Created    : 2019-05-02
-- Last update: 2019-05-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is an unitary test of the Master I2C
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-02  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_i2c;
use lib_i2c.pkg_i2c.all;

entity test_master_i2c is

end entity test_master_i2c;

architecture behv_master_i2c of test_master_i2c is

  -- TB signals
  constant T_clock : time := 20 ns;     -- Clock period : 50 MHz

  -- SIGNALS
  signal reset_n    : std_logic                    := '1';  -- Asynchronous reset
  signal clock      : std_logic                    := '0';  -- Sytem clock
  signal start_i2c  : std_logic                    := '0';  -- Start an I2C transaction
  signal rw         : std_logic                    := '0';  -- Read/Write order
  signal chip_addr  : std_logic_vector(6 downto 0) := (others => '0');  -- Chip address
  signal nb_data    : integer range 1 to max_array := 2;  -- Number of byte to read or write
  signal wdata      : t_byte_array                 := (others => (others => '0'));  -- Array of byte to write on the bus
  signal i2c_done   : std_logic;        -- Flag i2c trasaction done
  signal sack_error : std_logic;        -- Indicates error if SACK not received
  signal rdata      : t_byte_array;     -- Array of data read on the I2C bus
  signal scl        : std_logic;        -- scl line
  signal sda        : std_logic;        -- sda line

  -- Slave emul signals
  signal cnt_9    : integer range 0 to 9 := 0;  -- data + ack cnt
  signal scl_re   : std_logic;                  -- scl RE detect
  signal scl_old  : std_logic;                  -- latch scl
  signal gen_sack : std_logic;

  -- Master I2C

begin  -- architecture behv_master_i2c


  -- Master I2C instance
  inst_master_i2c : master_i2c
    generic map (
      scl_frequency   => f400k,
      clock_frequency => 50000000)
    port map (
      reset_n    => reset_n,
      clock      => clock,
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


  -- This process generates the input clock
  p_clock : process
  begin
    clock <= not clock;
    wait for T_clock / 2.0;
  end process;


  -- purpose: This process emulates an I2C Slave
  p_slave_emul : process(clock, reset_n)
    --variable cnt_9 : integer range 0 to 9 := 0;    -- data + ack cnt
    -- variable rw : std_logic := '0';     -- rw recover
    variable wr_chip_detect : std_logic             := '0';
    variable cnt_bytes      : integer range 0 to 10 := 0;
  begin  -- process p_slave_emul

    if(reset_n = '0') then
      sda            <= 'Z';
      scl_old        <= '0';
      wr_chip_detect := '0';
      cnt_bytes      := 0;
      gen_sack       <= '0';
      cnt_9          <= 0;
    elsif(rising_edge(clock)) then
      scl_old <= scl;
      if(scl_re = '1') then
        if(cnt_9 < 9) then
          cnt_9 <= cnt_9 + 1;
        else
          cnt_9 <= 1;
        end if;
      end if;


      if(cnt_9 = 9 and scl_re = '1') then
        if(cnt_bytes < 10) then
          cnt_bytes := cnt_bytes + 1;
        else
          cnt_bytes := 0;
        end if;
      end if;

      if(cnt_bytes >= 1 and rw = '1') then
        gen_sack <= '0';
      else
        gen_sack <= '1';
      end if;

      if(i2c_done = '1') then
        sda            <= 'Z';
        scl_old        <= '0';
        wr_chip_detect := '0';
        cnt_bytes      := 0;
        gen_sack       <= '0';
        cnt_9          <= 0;
      end if;

    end if;
  end process p_slave_emul;
  scl_re <= (scl and not scl_old) when reset_n = '1'                                else '0';
  scl    <= 'H'                   when reset_n = '1'                                else '0';
  sda    <= '0'                   when (cnt_9 = 9 and scl = 'H' and gen_sack = '1') else 'H';





  -- This process generates stimuli
  p_test : process
  begin  -- process p_test


    report "Constante : " & integer'image(compute_scl_period(f100k, 20000000));

    -- Init signals
    start_i2c <= '0';
    rw        <= '0';
    chip_addr <= (others => '0');
    nb_data   <= 2;
    wdata     <= (others => (others => '0'));

    -- Reset system
    reset_n <= '0', '1' after 100 ns;

    chip_addr <= b"1011011";
    rw        <= '0';                   -- Write or read order
    wdata     <= (0 => x"E9", 1 => x"99", others => x"00");
    start_i2c <= '1', '0' after 10 us;
    wait until rising_edge(i2c_done) for 50 ms;

    wait for 100 us;
    rw        <= '1';
    wait for 1 us;
    start_i2c <= '1', '0' after 10 us;
    wait until rising_edge(i2c_done) for 50 ms;

    chip_addr <= b"1011011";
    rw        <= '0';                   -- Write or read order
    wdata     <= (0 => x"AA", 1 => x"7E", others => x"00");
    start_i2c <= '1', '0' after 10 us;
    wait until rising_edge(i2c_done) for 50 ms;

    assert false report "end of test !!!" severity failure;
    wait;
  end process p_test;
end architecture behv_master_i2c;
