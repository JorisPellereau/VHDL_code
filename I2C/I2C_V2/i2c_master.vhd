-------------------------------------------------------------------------------
-- Title      : Generic I2C Master
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2c_master.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-28
-- Last update: 2019-06-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Generic I2C Master
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

entity i2c_master is
  generic (
    scl_frequency   : t_i2c_frequency := f400k;  -- Frequency of SCL clock
    clock_frequency : integer         := 20000000);  -- Input clock frequency
  port (
    reset_n      : in    std_logic;     -- Active Low asynchronous reset
    clock        : in    std_logic;     -- Input clock
    start_i2c    : in    std_logic;     -- Start an I2C transaction
    rw           : in    std_logic;     -- Read/Write command
    chip_addr    : in    std_logic_vector(6 downto 0);  -- Chip address [0:127]
    nb_data      : in    integer range 1 to 10;  -- Number of byte to Read or Write
    wdata        : in    std_logic_vector(7 downto 0);  -- Array of data to transmit
    i2c_done     : out   std_logic;     -- I2C transaction done
    sack_error   : out   std_logic;     -- Sack from slave not received
    rdata        : out   std_logic_vector(7 downto 0);  -- Output data read from an I2C transaction
    rdata_valid  : out   std_logic;     -- Rdata valid
    wdata_change : out   std_logic;     -- Ok for a new data
    scl          : inout std_logic;     -- I2C clock
    sda          : inout std_logic);    -- Data line
end entity i2c_master;


architecture arch_i2c_master of i2c_master is

  -- CONSTANTS
  constant T_scl               : integer := compute_scl_period(scl_frequency, clock_frequency);  -- SCL period according to the I2C config and the input clock freq.
  constant T_2_scl             : integer := T_scl / 2;  -- Half period of SCL
  constant start_stop_duration : integer := T_2_scl;  -- Duration of the start duration
  constant C_tick_ack          : integer := T_scl/4;  -- Duration to sample the ACK
  constant C_tick_wdata        : integer := T_scl/4;  -- Duration for tick wdata


  -- SIGNALS
  signal i2c_master_state : t_i2c_master_fsm;  -- Current state of the i2c master
  signal next_state       : t_i2c_master_fsm;  -- Next state computation

  signal start_i2c_old : std_logic;     -- Latch start_i2c
  signal start_i2c_re  : std_logic;     -- Rising edge of start_i2c
  signal start_i2c_s   : std_logic;     -- Start the frame

  signal rw_s        : std_logic;                     -- Latch rw input
  signal chip_addr_s : std_logic_vector(6 downto 0);  -- Latch Chip addr input
  signal nb_data_s   : integer range 1 to max_array;  -- Latch nb_data to R/W
  signal wdata_s     : std_logic_vector(7 downto 0);

  signal cnt_8        : integer range 0 to 8;  -- Count the bits of a byte
  signal cnt_8_done_s : std_logic;             -- Cnt_8 reach

  signal cnt_start_stop    : integer range 0 to start_stop_duration;  -- Counter that counts until the start duration
  signal start_stop_done_s : std_logic;  -- Flag that indicates if the start condition is done

  signal en_sclk_s      : std_logic;    -- Start the counter for the SCLK
  signal tick_clock     : std_logic;    -- Tick for sclk
  signal cnt_tick_clock : integer range 0 to T_2_scl;  -- Counter that counts until half SCL period

  signal tick_wdata        : std_logic;  -- Tick for write data on the bus
  signal cnt_tick_wdata    : integer range 0 to C_tick_wdata;  -- Counter for generated tick_wdata
  signal en_cnt_tick_wdata : std_logic;  -- Enable the counter

  signal tick_ack : std_logic;  -- Tick in order to read the ACK from the slave
  signal cnt_ack  : integer range 0 to C_tick_ack - 1;  -- Counter or the tick

  signal en_scl_fe    : std_logic;      -- Falling edge of en_scl
  signal en_scl_re    : std_logic;      -- Rising Edge of en_scl
  signal en_scl_old_s : std_logic;      -- Old en_scl

  signal ack_verif_s  : std_logic;      -- Ack verif
  signal sack_ok      : std_logic;      -- '0' : KO '1' : OK
  signal sack_error_s : std_logic;      -- Error on sack

  -- I2C inout signals
  signal scl_in  : std_logic;           -- Read the SCL
  signal sda_in  : std_logic;           -- Read SDA
  signal scl_out : std_logic;           -- Write SCL
  signal sda_out : std_logic;           -- Write SDA
  signal en_scl  : std_logic;           -- Enable scl_out
  signal en_sda  : std_logic;           -- Enable sda_out

begin


  -- purpose: This process detects the rising edge of start_i2c
  p_start_i2c_detect : process(clock, reset_n)
  begin
    if reset_n = '0' then               -- asynchronous reset (active low)
      start_i2c_old <= '0';
    elsif clock'event and clock = '1' then              -- rising clock edge
      if(i2c_master_state = IDLE) then
        start_i2c_old <= start_i2c;
      end if;
      start_i2c_re <= start_i2c and not start_i2c_old;  -- start I2C
    end if;
  end process p_start_i2c_detect;
  -- start_i2c_re <= start_i2c and not start_i2c_old;  -- start I2C

  -- purpose: This process latches the inputs when start_i2c_re = '1'
  p_latch_inputs : process (clock, reset_n)
  begin  -- process p_latch_inputs
    if reset_n = '0' then                   -- asynchronous reset (active low)
      rw_s        <= '0';
      chip_addr_s <= (others => '0');
      nb_data_s   <= 1;
      wdata_s     <= (others => '0');
      start_i2c_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(start_i2c_re = '1') then
        rw_s        <= rw;
        chip_addr_s <= chip_addr;
        nb_data_s   <= nb_data;
        wdata_s     <= wdata;
        start_i2c_s <= '1';                 -- Start the frame        
      end if;

      -- TO modify ?
      if(sack_error_s = '1') then
        start_i2c_s <= '0';
      end if;

    end if;
  end process p_latch_inputs;

  -- purpose: This process computes the next state 
  p_next_state_mng : process (clock, reset_n) is
  begin  -- process p_next_state_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      i2c_master_state <= IDLE;
    elsif clock'event and clock = '1' then  -- rising clock edge
      i2c_master_state <= next_state;
    end if;
  end process p_next_state_mng;

  -- purpose: This process manages the state
  p_state_mng : process (i2c_master_state, start_i2c_s, start_stop_done_s,
                         cnt_8_done_s, ack_verif_s, sack_ok, rw_s)
  begin

    case i2c_master_state is
      when IDLE =>
        if(start_i2c_s = '1') then
          next_state <= START_GEN;
        end if;

      when START_GEN =>
        if(start_stop_done_s = '1') then
          next_state <= WR_CHIP;
        end if;

      when WR_CHIP =>
        if(cnt_8_done_s = '1') then
          next_state <= SACK_CHIP;
        end if;

      when SACK_CHIP =>
        if(ack_verif_s = '1') then
          if(sack_ok = '1') then
            if(rw_s = '1') then
              next_state <= RD_DATA;
            elsif(rw_s = '0') then
              next_state <= WR_DATA;
            end if;
          else
            next_state <= IDLE;         -- SACK not received
          end if;
        end if;

      when others => null;
    end case;

  end process p_state_mng;

  -- purpose : This process counts until the start duration and generates a tick
  p_tick_start_stop : process (clock, reset_n)
  begin  -- process p_tick_start_stop
    if (reset_n = '0') then             -- asynchronous reset (active low)
      cnt_start_stop    <= 0;
      start_stop_done_s <= '0';
      en_sclk_s         <= '0';
    elsif (rising_edge(clock)) then     -- rising clock edge
      if(i2c_master_state = START_GEN and start_stop_done_s = '0') then
        if(cnt_start_stop < start_stop_duration - 1) then
          cnt_start_stop    <= cnt_start_stop + 1;
          start_stop_done_s <= '0';
        else
          cnt_start_stop    <= 0;
          start_stop_done_s <= '1';
          en_sclk_s         <= '1';
        end if;

      elsif(i2c_master_state = STOP_GEN and start_stop_done_s = '0') then
        en_sclk_s <= '0';
        if(cnt_start_stop < start_stop_duration - 1) then
          cnt_start_stop    <= cnt_start_stop + 1;
          start_stop_done_s <= '0';
        else
          cnt_start_stop    <= 0;
          start_stop_done_s <= '1';
        end if;
      else
        start_stop_done_s <= '0';
        cnt_start_stop    <= 0;
      end if;
    end if;
  end process p_tick_start_stop;

  -- purpose: This process detect the FE of en_scl
  p_en_scl_fe_mng : process (clock, reset_n)
  begin  -- process p_en_scl_fe_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      en_scl_old_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      en_scl_old_s <= en_scl;
    end if;
  end process p_en_scl_fe_mng;
  en_scl_fe <= not en_scl and en_scl_old_s;
  en_scl_re <= en_scl and not en_scl_old_s;

  -- purpose: This process counts from 0 to 7 
  p_cnt_8_mng : process (clock, reset_n)
  begin  -- process p_cnt_8_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_8        <= 0;
      cnt_8_done_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_state = WR_CHIP) then
        if(en_scl_fe = '1') then
          if(cnt_8 < 8) then
            cnt_8        <= cnt_8 + 1;
            cnt_8_done_s <= '0';
          else
            cnt_8        <= 0;
            cnt_8_done_s <= '1';
          end if;
        end if;
      else
        cnt_8        <= 0;
        cnt_8_done_s <= '0';
      end if;
    end if;
  end process p_cnt_8_mng;

  -- purpose: This process manages the ACK sampling 
  p_tick_ack_mng : process (clock, reset_n)
  begin  -- process p_tick_ack_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      tick_ack <= '0';
      cnt_ack  <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_state = SACK_CHIP) then
        if(cnt_ack < C_tick_ack - 1) then
          cnt_ack  <= cnt_ack + 1;
          tick_ack <= '0';
        else
          tick_ack <= '1';
          cnt_ack  <= 0;
        end if;
      else
        tick_ack <= '0';
        cnt_ack  <= 0;
      end if;
    end if;
  end process p_tick_ack_mng;

  -- purpose: This process generates the SCL output
  p_scl_gen : process (clock, reset_n)
  begin  -- process p_scl_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      en_scl  <= '0';
      scl_out <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_state = IDLE) then
        en_scl  <= '0';                     -- Disable SCL
        scl_out <= '0';
      elsif(i2c_master_state = START_GEN) then
        if(cnt_start_stop = start_stop_duration - 1) then
          en_scl  <= '1';
          scl_out <= '0';                   -- Write '0' of the bus
        end if;

      elsif(en_sclk_s = '1') then
        if(tick_clock = '1') then
          scl_out <= '0';
          en_scl  <= not en_scl;        -- Invert each tick clock
        end if;

      elsif(i2c_master_state = STOP_GEN) then
        if(cnt_start_stop > (start_stop_duration - 1)/ 2) then
          scl_out <= '0';
          en_scl  <= '0';               -- Set 'Z' on the bus => '1'
        else
          scl_out <= '0';
          en_scl  <= '1';               -- Write '0' on SCL line
        end if;
      else
        en_scl  <= '0';
        scl_out <= '0';
      end if;
    end if;
  end process p_scl_gen;

  -- purpose: This process manages the SDA lines
  p_sda_gen : process (clock, reset_n)
  begin  -- process p_sda_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      en_sda       <= '0';
      sda_out      <= '0';
      sack_ok      <= '0';
      sack_error_s <= '0';
      ack_verif_s  <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_state = IDLE) then
        en_sda      <= '0';
        sda_out     <= '0';
        ack_verif_s <= '0';

      elsif(i2c_master_state = START_GEN) then
        if(cnt_start_stop = (start_stop_duration - 1) / 2) then
          en_sda  <= '1';
          sda_out <= '0';               -- Write '0' on the bus
        end if;

      elsif(i2c_master_state = WR_CHIP) then
        if(tick_wdata = '1') then
          if(cnt_8 < 8) then

          end if;
        end if;

      elsif(i2c_master_state = SACK_CHIP) then
        en_sda  <= '0';
        sda_out <= '0';                 -- Release the bus
        if(tick_ack = '1') then
          ack_verif_s <= '1';
          if(sda_in = '0') then
            sack_ok      <= '1';
            sack_error_s <= '0';
          else
            sack_ok      <= '0';
            sack_error_s <= '1';
          end if;
        end if;

      elsif(i2c_master_state = STOP_GEN) then
        if(cnt_start_stop > (start_stop_duration - 1)) then
          en_sda  <= '0';               -- Set 'Z' => '1' on the sda line
          sda_out <= '0';
        else
          en_sda  <= '1';
          sda_out <= '0';               -- Set '0' on the sda line
        end if;

      end if;
    end if;
  end process p_sda_gen;

-- purpose: This process generates tick in order to generate the SCL clock
  p_tick_clock_gen : process (clock, reset_n)
  begin  -- process p_tick_clock_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_tick_clock <= 0;
      tick_clock     <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(en_sclk_s = '1') then
        if(cnt_tick_clock < T_2_scl) then
          cnt_tick_clock <= cnt_tick_clock + 1;
          tick_clock     <= '0';
        else
          cnt_tick_clock <= 0;
          tick_clock     <= '1';
        end if;
      elsif(i2c_master_state = STOP_GEN) then
        cnt_tick_clock <= 0;
        tick_clock     <= '0';
      elsif(i2c_master_state = IDLE) then
        cnt_tick_clock <= 0;
        tick_clock     <= '0';
      end if;
    end if;
  end process p_tick_clock_gen;


  scl <= scl_out when en_scl = '1' else 'Z';  -- Write on SCL output
  sda <= sda_out when en_sda = '1' else 'Z';  -- Write on SDA output

  scl_in <= scl;
  sda_in <= sda;

end architecture arch_i2c_master;
