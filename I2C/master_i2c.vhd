-------------------------------------------------------------------------------
-- Title      : Master I2C 
-- Project    : 
-------------------------------------------------------------------------------
-- File       : master_i2c.vhd
-- Author     :  Joris Pellereau
-- Company    : 
-- Created    : 2019-04-30
-- Last update: 2019-05-05
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
    scl_frequency   : t_i2c_frequency := f100k;       -- Frequency of SCL clock
    clock_frequency : integer         := 20000000);   -- Input clock frequency
  port (
    reset_n    : in    std_logic;       -- Asynchronous reset
    clock      : in    std_logic;       -- Input clock
    start_i2c  : in    std_logic;       -- Start an I2C transaction
    rw         : in    std_logic;       -- Read/Write command
    chip_addr  : in    std_logic_vector(6 downto 0);  -- Chip address [0:127]
    nb_data    : in    integer range 1 to max_array;  -- Number of byte to Read or Write
    wdata      : in    t_byte_array;    -- Array of data to transmit
    i2c_done   : out   std_logic;       -- I2C transaction done
    sack_error : out   std_logic;       -- Sack from slave not received
    rdata      : out   t_byte_array;  -- Output data read from an I2C transaction
    scl        : inout std_logic;       -- I2C clock
    sda        : inout std_logic);      -- Data line

end entity master_i2c;


architecture arch_macter_i2c of master_i2c is

  -- CONSTANTS
  constant T_scl               : integer := compute_scl_period(scl_frequency, clock_frequency);  -- SCL period according to the I2C config and the input clock freq.
  constant T_2_scl             : integer := T_scl / 2;  -- Half period of SCL
  constant start_stop_duration : integer := T_2_scl;  -- Duration of the start duration                                                 

  -- SIGNALS
  signal start_i2c_old  : std_logic;    -- Latch start_i2c
  signal start_i2c_re   : std_logic;    -- Rising edge of start_i2c
  signal i2c_master_fsm : t_i2c_master_fsm;  -- FSM of the I2C master
  signal tick_clock     : std_logic;    -- Tick clock generation
  signal start_gen_done : std_logic;  -- Flag that indicates if the start condition is done

  signal en_scl_old : std_logic;        -- Latch en_scl
  signal en_scl_re  : std_logic;  -- Flag that indicates a rising edge of en_scl

  signal rw_s         : std_logic;      -- Latch rw input
  signal chip_addr_s  : std_logic_vector(6 downto 0);  -- Latch Chip addr input
  signal nb_data_s    : integer range 1 to max_array;  -- Latch nb_data to R/W
  signal wdata_s      : t_byte_array;   -- Latch data to transmit
  signal rdata_s      : t_byte_array;   -- Lact read data
  signal i2c_done_s   : std_logic;  -- Flag that indicates if a i2c transaction is done
  signal sack_error_s : std_logic;      -- Sack error flag
  signal byte_ctrl    : std_logic_vector(7 downto 0);  -- Control byte, chip add & RW

  signal sack_ok : std_logic;  -- sack_ok = '0' => KO - sack_ok = '1' => ok

  signal tick_data : std_logic;         -- Tick in order to write or read data

  -- COUNTERS
  signal cnt_tick_clock : integer range 0 to T_2_scl;  -- Counter that counts until half SCL period
  signal cnt_start_stop : integer range 0 to start_stop_duration;  -- Counter that counts until the start duration
  signal cnt_9          : integer range 0 to 9;  -- Counter that counts data + ack
  signal en_cnt_9       : std_logic;    -- Enable the counting of cnt_9

  signal cnt_tick_data_1 : integer range 0 to T_2_scl;  -- Counter that counts until half SCL period;
  signal cnt_tick_data_2 : integer range 0 to T_scl;  -- Counter that counts until SCL period
  signal cnt_tick_data_3 : integer range 0 to 3*T_scl/4;  -- Counter that until (3/4)*T_scl
  signal sel_cnt_1_2     : std_logic;  -- Sel the cnt_tick_data_1 or cnt_tick_data_2

  signal cnt_nb_data : integer range 0 to max_array;  -- Counter that counts the number of byte to read or write

  -- I2C inout signals
  signal scl_in  : std_logic;           -- Read the SCL
  signal sda_in  : std_logic;           -- Read SDA
  signal scl_out : std_logic;           -- Write SCL
  signal sda_out : std_logic;           -- Write SDA
  signal en_scl  : std_logic;           -- Enable scl_out
  signal en_sda  : std_logic;           -- Enable sda_out

begin  -- architecture arch_macter_i2c


  -- purpose: This process manages the FSM of the master i2c 
  p_fsm_mng : process (clock, reset_n)
  begin  -- process p_fsm_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      i2c_master_fsm <= IDLE;
      i2c_done_s     <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      case i2c_master_fsm is
        when IDLE =>
          if(start_i2c_re = '1') then
            i2c_master_fsm <= START_GEN;
          end if;

        when START_GEN =>
          i2c_done_s <= '0';
          if(start_gen_done = '1') then
            i2c_master_fsm <= WR_CHIP;
          end if;

        when WR_CHIP =>
          if(cnt_9 = 8) then
            i2c_master_fsm <= SACK_CHIP;
          end if;

        when SACK_CHIP =>
          if(cnt_9 = 9) then
            if(sack_ok = '1') then
              if(rw_s = '1') then
                i2c_master_fsm <= RD_DATA;
              elsif(rw_s = '0') then
                i2c_master_fsm <= WR_DATA;
              end if;
            else
              i2c_master_fsm <= IDLE;   -- SACK not received
            end if;
          end if;

        when WR_DATA =>
          if(cnt_9 = 8) then
            i2c_master_fsm <= SACK_WR;
          end if;
        when SACK_WR =>
          if(cnt_9 = 9) then
            if(sack_ok = '1') then
              if(cnt_nb_data = nb_data_s) then
                i2c_master_fsm <= STOP_GEN;
              else
                i2c_master_fsm <= WR_DATA;
              end if;
            else
              i2c_master_fsm <= IDLE;   -- SACK not received
            end if;
          end if;
        when RD_DATA =>
          if(cnt_9 = 8) then
            i2c_master_fsm <= MACK;
          end if;
        when MACK =>
          if(cnt_9 = 9) then
            if(cnt_nb_data = nb_data_s) then
              i2c_master_fsm <= STOP_GEN;
            else
              i2c_master_fsm <= RD_DATA;
            end if;
          end if;
        when STOP_GEN =>
          if(start_gen_done = '1') then
            i2c_done_s     <= '1';
            i2c_master_fsm <= IDLE;
          end if;
        when others => null;
      end case;
    end if;
  end process p_fsm_mng;

  i2c_done <= i2c_done_s;               -- Output affectation

  -- purpose: This process latches the inputs
  p_latch_inputs : process (clock, reset_n) is
  begin  -- process p_latch_inputs
    if reset_n = '0' then                   -- asynchronous reset (active low)
      rw_s        <= '0';
      chip_addr_s <= (others => '0');
      nb_data_s   <= 1;
      byte_ctrl   <= (others => '0');
      wdata_s     <= (others => (others => '0'));
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_fsm = IDLE) then
        if(start_i2c_re = '1') then
          rw_s        <= rw;
          chip_addr_s <= chip_addr;
          nb_data_s   <= nb_data;
          wdata_s     <= wdata;
        end if;
      elsif(i2c_master_fsm = START_GEN) then
        byte_ctrl <= chip_addr_s & rw_s;
      end if;
    end if;
  end process p_latch_inputs;


  -- purpose: This process detects the rising edge of start_i2c
  p_start_i2c_detect : process (clock, reset_n) is
  begin
    if reset_n = '0' then               -- asynchronous reset (active low)
      start_i2c_old <= '0';
    elsif clock'event and clock = '1' then                 -- rising clock edge
      if(i2c_master_fsm = IDLE) then
        start_i2c_old <= start_i2c;
        -- else
        --   start_i2c_old <= '0';
        start_i2c_re  <= start_i2c and not start_i2c_old;  -- start I2C 
      end if;
    end if;
  end process p_start_i2c_detect;
  -- start_i2c_re <= start_i2c and not start_i2c_old;  -- start I2C 


  -- purpose: This process detects the rising edge of en_scl signal
  -- -- usless
  p_en_scl_fe_detect : process (clock, reset_n)
  begin  -- process p_en_scl_fe_detect
    if reset_n = '0' then               -- asynchronous reset (active low)
      en_scl_old <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_fsm = WR_CHIP or i2c_master_fsm = SACK_CHIP) then
        en_scl_old <= en_scl;
      else
        en_scl_old <= '0';
      end if;
    end if;
  end process p_en_scl_fe_detect;
  en_scl_re <= en_scl and not en_scl_old;  -- Pulse that detects the RE of en_scl


  -- purpose: This process counts until 9 (data + ack) 
  p_count_data_and_ack : process (clock, reset_n)
  begin  -- process p_count_data_and_ack
    if reset_n = '0' then                   -- asynchronous reset (active low)
      en_cnt_9 <= '0';
      cnt_9    <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_fsm = IDLE) then
        cnt_9    <= 0;
        en_cnt_9 <= '0';
      elsif(i2c_master_fsm /= IDLE or i2c_master_fsm /= START_GEN or i2c_master_fsm /= STOP_GEN) then
        --if(en_scl_re = '1') then
        if(tick_clock = '1') then
          if(en_cnt_9 = '1') then
            if(cnt_9 < 9) then
              cnt_9 <= cnt_9 + 1;
            else
              cnt_9 <= 1;
            end if;
            en_cnt_9 <= '0';
          else
            en_cnt_9 <= '1';
          end if;
        end if;
      -- elsif(i2c_master_fsm = IDLE) then
      --   cnt_9    <= 0;
      --   en_cnt_9 <= '0';
      end if;
    end if;
  end process p_count_data_and_ack;


  -- purpose: This process generates tick in order to generate the SCL clock
  p_tick_clock_gen : process (clock, reset_n)
  begin  -- process p_tick_clock_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_tick_clock <= 0;
      tick_clock     <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_fsm = WR_CHIP or i2c_master_fsm = SACK_CHIP or i2c_master_fsm = WR_DATA or i2c_master_fsm = SACK_WR or (i2c_master_fsm = RD_DATA) or i2c_master_fsm = MACK) then
        if(cnt_tick_clock < T_2_scl) then
          cnt_tick_clock <= cnt_tick_clock + 1;
          tick_clock     <= '0';
        else
          cnt_tick_clock <= 0;
          tick_clock     <= '1';
        end if;
      elsif(i2c_master_fsm = STOP_GEN) then
        cnt_tick_clock <= 0;
        tick_clock     <= '0';
      elsif(i2c_master_fsm = IDLE) then
        cnt_tick_clock <= 0;
        tick_clock     <= '0';
      end if;
    end if;
  end process p_tick_clock_gen;

  -- purpose: This process generates tick in order to read or write data on the bus
  p_tick_data_gen : process (clock, reset_n) is
  begin  -- process p_tick_data_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      sel_cnt_1_2     <= '0';
      tick_data       <= '0';
      cnt_tick_data_1 <= 0;
      cnt_tick_data_2 <= 0;
      cnt_tick_data_3 <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_fsm = WR_CHIP or i2c_master_fsm = WR_DATA) then
        cnt_tick_data_3 <= 0;
        if(sel_cnt_1_2 = '0') then
          if(cnt_tick_data_1 < T_2_scl / 2) then
            cnt_tick_data_1 <= cnt_tick_data_1 + 1;
            tick_data       <= '0';
          else
            cnt_tick_data_1 <= 0;
            tick_data       <= '1';
            sel_cnt_1_2     <= '1';
          end if;
        elsif(sel_cnt_1_2 = '1') then
          if(cnt_tick_data_2 < T_scl) then
            cnt_tick_data_2 <= cnt_tick_data_2 + 1;
            tick_data       <= '0';
          else
            cnt_tick_data_2 <= 0;
            tick_data       <= '1';
          end if;
        end if;
      elsif(i2c_master_fsm = SACK_CHIP or i2c_master_fsm = SACK_WR or i2c_master_fsm = MACK) then
        cnt_tick_data_1 <= 0;
        cnt_tick_data_2 <= 0;
        sel_cnt_1_2     <= '0';             -- RAZ  sel
        if(cnt_tick_data_3 < 3*T_scl/4) then
          cnt_tick_data_3 <= cnt_tick_data_3 + 1;
          tick_data       <= '0';
        else
          cnt_tick_data_3 <= 0;
          tick_data       <= '1';
        end if;
      elsif(i2c_master_fsm = RD_DATA) then
        cnt_tick_data_3 <= 0;
        if(sel_cnt_1_2 = '0') then
          if(cnt_tick_data_2 < 3*T_scl/4) then
            cnt_tick_data_2 <= cnt_tick_data_2 + 1;
            tick_data       <= '0';
          else
            cnt_tick_data_2 <= 0;
            tick_data       <= '1';
            sel_cnt_1_2     <= '1';
          end if;
        elsif(sel_cnt_1_2 = '1') then
          if(cnt_tick_data_2 < T_scl) then
            cnt_tick_data_2 <= cnt_tick_data_2 + 1;
            tick_data       <= '0';
          else
            cnt_tick_data_2 <= 0;
            tick_data       <= '1';
          end if;
        end if;
      elsif(i2c_master_fsm = IDLE) then
        sel_cnt_1_2     <= '0';
        tick_data       <= '0';
        cnt_tick_data_1 <= 0;
        cnt_tick_data_2 <= 0;
        cnt_tick_data_3 <= 0;
      end if;
    end if;
  end process p_tick_data_gen;

  -- purpose: This process counts until the start duration and generates a tick
  p_tick_start_stop : process (clock, reset_n)
  begin  -- process p_tick_start_stop
    if (reset_n = '0') then             -- asynchronous reset (active low)
      cnt_start_stop <= 0;
      start_gen_done <= '0';
    elsif (rising_edge(clock)) then     -- rising clock edge
      if(i2c_master_fsm = START_GEN) then
        if(cnt_start_stop < start_stop_duration) then
          cnt_start_stop <= cnt_start_stop + 1;
          start_gen_done <= '0';
        else
          cnt_start_stop <= 0;
          start_gen_done <= '1';
        end if;

      elsif(i2c_master_fsm = STOP_GEN) then
        if(cnt_start_stop < start_stop_duration) then
          cnt_start_stop <= cnt_start_stop + 1;
          start_gen_done <= '0';
        else
          cnt_start_stop <= 0;
          start_gen_done <= '1';
        end if;
      else
        start_gen_done <= '0';
        cnt_start_stop <= 0;
      end if;
    end if;
  end process p_tick_start_stop;


-- purpose: This process generates the SCL output
  p_scl_gen : process (clock, reset_n)
  begin  -- process p_scl_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      en_scl  <= '0';
      scl_out <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(i2c_master_fsm = IDLE) then
        en_scl  <= '0';                     -- Disable SCL
        scl_out <= '0';
      elsif(i2c_master_fsm = START_GEN) then
        if(cnt_start_stop = start_stop_duration) then
          en_scl  <= '1';
          scl_out <= '0';                   -- Write '0' of the bus
        end if;
      elsif(i2c_master_fsm = WR_CHIP or i2c_master_fsm = SACK_CHIP) then
        if(tick_clock = '1') then
          scl_out <= '0';
          en_scl  <= not en_scl;            -- Invert each tick clock
        end if;
      elsif(i2c_master_fsm = WR_DATA or i2c_master_fsm = SACK_WR) then
        if(tick_clock = '1') then
          scl_out <= '0';
          en_scl  <= not en_scl;            -- Invert each tick clock
        end if;
      elsif(i2c_master_fsm = RD_DATA or i2c_master_fsm = MACK) then
        if(tick_clock = '1') then
          scl_out <= '0';
          en_scl  <= not en_scl;            -- Invert each tick clock
        end if;
      elsif(i2c_master_fsm = STOP_GEN) then
        if(cnt_start_stop >= start_stop_duration / 2) then
          scl_out <= '0';
          en_scl  <= '0';                   -- Set 'Z' on the bus => '1'
        else
          scl_out <= '0';
          en_scl  <= '1';                   -- Write '0' on SCL line
        end if;
      end if;
    end if;
  end process p_scl_gen;


-- purpose: This process manages the SDA lines
  p_sda_gen : process (clock, reset_n)
  begin  -- process p_sda_gen
    if reset_n = '0' then               -- asynchronous reset (active low)
      en_sda       <= '0';
      sda_out      <= '0';
      sack_ok      <= '0';
      cnt_nb_data  <= 0;
      sack_error_s <= '0';
      rdata_s      <= (others => (others => '0'));
    elsif clock'event and clock = '1' then          -- rising clock edge
      if(i2c_master_fsm = IDLE) then
        en_sda      <= '0';
        sda_out     <= '0';
        cnt_nb_data <= 0;
      elsif(i2c_master_fsm = START_GEN) then
        sack_error_s <= '0';
        if(cnt_start_stop = start_stop_duration / 2) then
          en_sda  <= '1';
          sda_out <= '0';               -- Write '0' on the bus
        end if;
      elsif(i2c_master_fsm = WR_CHIP) then
        if(tick_data = '1') then
          if(cnt_9 < 8) then
            -- MSB first
            if(byte_ctrl(7 - cnt_9) = '1') then     -- 'Z' generation
              en_sda  <= '0';
              sda_out <= '0';
            elsif(byte_ctrl(7 - cnt_9) = '0') then  -- '0' generation
              en_sda  <= '1';
              sda_out <= '0';
            end if;
          end if;
        end if;
      elsif(i2c_master_fsm = SACK_CHIP) then
        en_sda  <= '0';
        sda_out <= '0';                 -- Release the bus
        if(tick_data = '1') then
          if(sda_in = '0') then
            sack_ok      <= '1';
            sack_error_s <= '0';
          else
            sack_ok      <= '0';
            sack_error_s <= '1';
          end if;
        end if;
      elsif(i2c_master_fsm = WR_DATA) then
        sack_ok <= '0';                 -- RAZ sack_ok

        -- MSB first
        if(cnt_9 < 8) then
          if(wdata_s(cnt_nb_data)(7 - cnt_9) = '1') then     -- 'Z' generation
            en_sda  <= '0';
            sda_out <= '0';
          elsif(wdata_s(cnt_nb_data)(7 - cnt_9) = '0') then  -- '0' generation
            en_sda  <= '1';
            sda_out <= '0';
          end if;
        end if;

      elsif(i2c_master_fsm = SACK_WR) then
        en_sda  <= '0';
        sda_out <= '0';                 -- Release the bus
        if(tick_data = '1') then
          if(sda_in = '0') then
            sack_ok      <= '1';
            sack_error_s <= '0';
            if(cnt_nb_data < nb_data_s) then
              cnt_nb_data <= cnt_nb_data + 1;
            else
              cnt_nb_data <= 0;
            end if;
          else
            sack_ok      <= '0';
            sack_error_s <= '1';
          end if;
        end if;

      elsif(i2c_master_fsm = RD_DATA) then
        sack_ok <= '0';                 -- Raz sack_ok
        en_sda  <= '0';
        sda_out <= '0';                 -- Release the bus
        if(tick_data = '1') then

          -- MSB first
          if(cnt_9 < 8) then
            rdata_s(cnt_nb_data)(7 - cnt_9) <= sda_in;
          elsif(cnt_9 = 9) then
            rdata_s(cnt_nb_data)(7) <= sda_in;
          end if;
        end if;
      elsif(i2c_master_fsm = MACK) then
        en_sda  <= '0';
        sda_out <= '0';                 -- Release the bus
        if(tick_data = '1') then
          if(cnt_nb_data < nb_data_s) then
            cnt_nb_data <= cnt_nb_data + 1;
          else
            cnt_nb_data <= 0;
          end if;
        end if;
      elsif(i2c_master_fsm = STOP_GEN) then
        if(cnt_start_stop = start_stop_duration) then
          en_sda  <= '0';               -- Set 'Z' => '1' on the sda line
          sda_out <= '0';
        else
          en_sda  <= '1';
          sda_out <= '0';               -- Set '0' on the sda line
        end if;
      end if;
    end if;
  end process p_sda_gen;

  rdata      <= rdata_s;
  sack_error <= sack_error_s;

  scl <= scl_out when en_scl = '1' else 'Z';  -- Write on SCL output
  sda <= sda_out when en_sda = '1' else 'Z';  -- Write on SDA output

  scl_in <= scl;
  sda_in <= sda;

end architecture arch_macter_i2c;





