-------------------------------------------------------------------------------
-- Title      : Master I2C 
-- Project    : 
-------------------------------------------------------------------------------
-- File       : master_i2c.vhd
-- Author     :  Joris Pellereau
-- Company    : 
-- Created    : 2019-04-30
-- Last update: 2019-04-30
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-04-30  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_i2c;
use lib_i2c.pkg_i2c.all;

entity master_i2c is

  generic (
    scl_frequency   : t_i2c_frequency := f100k;      -- Frequency of SCL clock
    clock_frequency : integer         := 20000000);  -- Input clock frequency
  port (
    reset_n   : in    std_logic;        -- Asynchronous reset
    clock     : in    std_logic;        -- Input clock
    start_i2c : in    std_logic;        -- Start an I2C transaction
    rw        : in    std_logic;        -- Read/Write command
    chip_addr : in    std_logic_vector(6 downto 0);  -- Chip address [0:127]
    nb_data   : in    integer range 1 to max_array;  -- Number of byte to Read or Write
    wdata     : in    t_byte_array;     -- Array of data to transmit
    i2c_done  : out   std_logic;        -- I2C transaction done
    rdata     : out   t_byte_array;  -- Output data read from an I2C transaction
    scl       : inout std_logic;        -- I2C clock
    sda       : inout std_logic);       -- Data line

end entity master_i2c;


architecture arch_macter_i2c of master_i2c is

  -- CONSTANTS
  constant T_scl          : integer := compute_scl_period(scl_frequency, clock_frequency);  -- SCL period according to the I2C config and the input clock freq.
  constant T_2_scl        : integer := T_scl / 2;  -- Half period of SCL
  constant start_duration : integer := T_2_scl;  -- Duration of the start command

  -- SIGNALS
  signal start_i2c_old  : std_logic;    -- Latch start_i2c
  signal start_i2c_re   : std_logic;    -- Rising edge of start_i2c
  signal i2c_master_fsm : t_i2c_master_fsm;  -- FSM of the I2C master
  signal tick_clock     : std_logic;    -- Tick clock generation
  signal start_gen_done : std_logic;  -- Flag that indicates if the start condition is done

  -- COUNTERS
  signal cnt_tick_clock : integer range 0 to T_2_scl;  -- Counter that counts until half SCL period
  signal cnt_start_stop : integer range 0 to start_duration;  -- Counter that counts until the start duration

  -- I2C inout signals
  signal scl_in  : std_logic;           -- Read the SCL
  signal sda_in  : std_logic;           -- Read SDA
  signal scl_out : std_logic;           -- Write SCL
  signal sda_out : std_logic;           -- Write SDA
  signal en_scl  : std_logic;           -- Enable scl_out
  signal en_sda  : std_logic;           -- Enable sda_out

begin  -- architecture arch_macter_i2c


  -- purpose: This process manages the FSM of the master i2c 
  p_fsm_mng : process (clock, reset_n) is
  begin  -- process p_fsm_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      i2c_master_fsm <= IDLE;
    elsif clock'event and clock = '1' then  -- rising clock edge
      case i2c_master_fsm is
        when IDLE =>
          if(start_i2c_re = '1') then
            i2c_master_fsm <= START_GEN;
          end if;

        when START_GEN =>
          if(start_gen_done = '1') then
            i2c_master_fsm <= WR_CHIP;
          end if;

        when WR_CHIP =>

        when others => null;
      end case;
    end if;
  end process p_fsm_mng;



  -- purpose: This process detects the rising edge of start_i2c
  p_start_i2c_detect : process (clock, reset_n) is
  begin
    if reset_n = '0' then               -- asynchronous reset (active low)
      start_i2c_old <= '0';
    elsif clock'event and clock = '1' then          -- rising clock edge
      if(i2c_master_fsm = IDLE) then
        start_i2c_old <= start_i2c;
      else
        start_i2c_old <= '0';
      end if;
    end if;
  end process p_start_i2c_detect;
  start_i2c_re <= start_i2c and not start_i2c_old;  -- start I2C RE detect


  -- purpose: This process generates tick in order to generate the SCL clock
  p_tick_clock_gen : process (clock, reset_n) is
  begin  -- process p_tick_clock_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_tick_clock <= 0;
      tick_clock     <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_fsm /= IDLE and i2c_master_fsm /= START_GEN)then
        if(cnt_tick_clock < T_2_scl) then
          cnt_tick_clock <= cnt_tick_clock + 1;
          tick_clock     <= '0';
        else
          cnt_tick_clock <= 0;
          tick_clock     <= '1';
        end if;
      end if;
    else
      cnt_tick_clock <= 0;
      tick_clock     <= '0';
    end if;
  end process p_tick_clock_gen;


  -- purpose: This process counts until the start duration
  p_tick_start_stop : process (clock, reset_n) is
  begin  -- process p_tick_start_stop
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_start_stop <= 0;
      start_gen_done <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_fsm = START_GEN) then
        if(cnt_start_stop < start_duration) then
          cnt_start_stop <= cnt_start_stop + 1;
          start_gen_done <= '0';
        else
          cnt_start_stop <= 0;
          start_gen_done <= '1';
        end if;
      end if;
    elsif(i2c_master_fsm = STOP_GEN) then
      if(cnt_start_stop < start_duration) then
        cnt_start_stop <= cnt_start_stop + 1;
        start_gen_done <= '0';
      else
        cnt_start_stop <= 0;
        start_gen_done <= '1';
      end if;
    end if;
  end process p_tick_start_stop;



  -- purpose: This process generates the SCL output
  p_scl_gen : process (clock, reset_n) is
  begin  -- process p_scl_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      en_scl  <= '0';
      scl_out <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_fsm = IDLE) then
        en_scl  <= '0';                     -- Disable SCL
        scl_out <= '0';
      elsif(i2c_master_fsm = START_GEN) then
        if(cnt_start_stop = start_duration) then
          en_scl  <= '1';
          scl_out <= '0';                   -- Write '0' of the bus
        end if;
      elsif(i2c_master_fsm = WR_CHIP) then

      elsif(i2c_master_fsm = STOP_GEN) then

      end if;
    end if;
  end process p_scl_gen;


  -- purpose: This process manages the SDA lines
  p_sda_gen : process (clock, reset_n) is
  begin  -- process p_sda_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      en_sda  <= '0';
      sda_out <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_fsm = IDLE) then
        en_sda  <= '0';
        sda_out <= '0';
      elsif(i2c_master_fsm = START_GEN) then
        if(cnt_start_stop = start_duration / 2) then
          en_sda  <= '1';
          sda_out <= '0';                   -- Wirte '0' on the bus
        end if;
      elsif(i2c_master_fsm = WR_CHIP) then

      elsif(i2c_master_fsm = STOP_GEN) then

      end if;
    end if;
  end process p_sda_gen;

  scl <= scl_out when en_scl = '1' else 'Z';  -- Write on SCL output
  sda <= sda_out when en_sda = '1' else 'Z';  -- Write on SDA output

  scl_in <= scl;
  sda_in <= sda;

end architecture arch_macter_i2c;
