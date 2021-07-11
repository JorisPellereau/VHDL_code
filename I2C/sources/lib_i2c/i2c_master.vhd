-------------------------------------------------------------------------------
-- Title      : I2C Master
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2c_master.vhd<lib_i2c>
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-06-27
-- Last update: 2021-07-11
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-06-27  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_i2c;
use lib_i2c.pkg_i2c.all;

entity i2c_master is

  generic (
    G_SCL_FREQ   : t_i2c_frequency := f400k;      -- Frequency of SCL Clock
    G_CLOCK_FREQ : integer         := 50000000);  -- Input Clock Frequency

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Control Signals
    i_start     : in std_logic;         -- Start I2C Transaction
    i_rw        : in std_logic;         -- R/W acces
    i_chip_addr : in std_logic_vector(6 downto 0);  -- Chip addr to request
    i_nb_data   : in std_logic_vector(7 downto 0);  -- Number of Bytes to Read or Write
    i_wdata     : in std_logic_vector(7 downto 0);  -- Data to write

    -- Status and data
    o_rdata          : out std_logic_vector(7 downto 0);  -- Last read data
    o_rdata_valid    : out std_logic;                     -- Read Data valid
    o_next_wdata_rdy : out std_logic;                     -- Next Wdata ready
    o_sack_error     : out std_logic;                     -- Slave ACK Error

    -- I2C I/F
    scl : inout std_logic;              -- I2C Clock
    sda : inout std_logic);             -- I2C Data

end entity i2c_master;



architecture behv of i2c_master is

  -- CONSTANTS
  constant C_MAX_SCL_PERIOD     : integer := compute_scl_period(G_SCL_FREQ, G_CLOCK_FREQ);
  constant C_HALF_SCL_PERIOD    : integer := C_MAX_SCL_PERIOD / 2;
  constant C_QUARTER_SCL_PERIOD : integer := C_MAX_SCL_PERIOD / 4;

  -- INTERNAL SIGNALS

  signal s_scl_cnt_en   : std_logic;                     -- Enable SCL Counter
  signal s_scl_cnt      : std_logic_vector(9 downto 0);  -- TBD taille bus
  signal s_scl_cnt_done : std_logic;
  signal s_scl_cnt_stop : std_logic;                     -- Stop SCL Counter

  signal s_current_state : t_i2c_master_fsm;
  signal s_next_state    : t_i2c_master_fsm;

  signal s_start        : std_logic;
  signal s_start_r_edge : std_logic;

  signal s_cnt_9      : std_logic_vector(5 downto 0);  -- Counter until 9
  signal s_cnt_9_done : std_logic;                     -- Counter 9 Reach

  signal s_start_gen_done : std_logic;


  signal s_scl_in_p      : std_logic;
  signal s_scl_in_f_edge : std_logic;   -- Falling Edge of SCL IN
  signal s_scl_in_r_edge : std_logic;   -- Rising Edge of SCL IN

  signal s_ctrl_byte : std_logic_vector(7 downto 0);  -- 1st byte send on I2C I/F

  signal s_sampling_cnt      : std_logic_vector(9 downto 0);  -- Counter for sample on Edge of SCL
  signal s_sampling_cnt_done : std_logic;
  signal s_sampling_cnt_en   : std_logic;

  signal s_stop_gen_cnt      : std_logic_vector(9 downto 0);
  signal s_stop_gen_cnt_done : std_logic;
  signal s_stop_gen_cnt_en   : std_logic;

  -- SDA/SCL I/O management
  signal s_scl_in  : std_logic;
  signal s_sda_in  : std_logic;
  signal s_scl_out : std_logic;
  signal s_sda_out : std_logic;
  signal s_en_scl  : std_logic;
  signal s_en_sda  : std_logic;

begin  -- architecture behv

  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start    <= '0';
      s_scl_in_p <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_start    <= i_start;
      s_scl_in_p <= s_scl_in;
    end if;
  end process p_latch_inputs;

  s_start_r_edge  <= i_start and not s_start;
  s_scl_in_f_edge <= not s_scl_in and s_scl_in_p;
  s_scl_in_r_edge <= s_scl_in and not s_scl_in_p;


  p_curr_state_mngt : process (clk, rst_n) is
  begin  -- process p_curr_state_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_current_state <= IDLE;
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_current_state <= s_next_state;
    end if;
  end process p_curr_state_mngt;


  p_next_state_mngt : process (clk, rst_n) is
  begin  -- process p_next_state_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_next_state <= IDLE;
    --s_ctrl_byte  <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      case s_current_state is

        when IDLE =>
          if(s_start_r_edge = '1') then
            s_next_state <= START_GEN;
          --s_ctrl_byte  <= i_chip_addr & i_rw;
          end if;


        when START_GEN =>
          if(s_start_gen_done = '1') then
            s_next_state <= WR_CHIP;
          end if;

        when WR_CHIP =>

          if(s_cnt_9 = conv_std_logic_vector(9*2 - 2, s_cnt_9'length)) then
            s_next_state <= SACK_CHIP;
          end if;

        when SACK_CHIP =>
          if(s_sampling_cnt_done = '1') then

            -- Slave Ack OK
            if(sda = '0') then

              -- Write Case
              if(s_ctrl_byte(7) = '0') then
                s_next_state <= WR_DATA;
              else
                s_next_state <= RD_DATA;
              end if;

            -- SACK ERROR
            else
              s_next_state <= STOP_GEN;

            end if;
          end if;

        when STOP_GEN =>
          if(s_stop_gen_cnt_done = '1') then
            s_next_state <= IDLE;
          end if;

        when others => null;
      end case;

    end if;
  end process p_next_state_mngt;


  p_scl_tick_mngt : process (clk, rst_n) is
  begin  -- process p_scl_tick_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_scl_cnt      <= (others => '0');
      s_scl_cnt_done <= '0';
      s_scl_cnt_en   <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Enable SCL Counter 
      if(s_current_state = IDLE) then
        if(s_start_r_edge = '1') then
          s_scl_cnt_en <= '1';
        end if;

      elsif(s_current_state = STOP_GEN) then
        if(s_scl_cnt_stop = '1') then
          s_scl_cnt_en <= '0';
        end if;
      end if;

      -- Counter mngt
      if(s_scl_cnt_en = '1') then
        if(s_scl_cnt < conv_std_logic_vector(C_HALF_SCL_PERIOD, s_scl_cnt'length)) then
          s_scl_cnt_done <= '0';
          s_scl_cnt      <= unsigned(s_scl_cnt) + 1;
        else
          s_scl_cnt_done <= '1';
          s_scl_cnt      <= (others => '0');
        end if;
      else
        s_scl_cnt      <= (others => '0');
        s_scl_cnt_done <= '0';
      end if;

    end if;
  end process p_scl_tick_mngt;


  p_count_9_mngt : process (clk, rst_n) is
  begin  -- process p_count_9_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_9      <= (others => '0');
      s_cnt_9_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_cnt_9_done <= '0';
      if(s_current_state /= IDLE) then
        if(s_scl_cnt_done = '1') then
          if(s_cnt_9 < conv_std_logic_vector(9*2, s_cnt_9'length)) then
            s_cnt_9 <= unsigned(s_cnt_9) + 1;
          else
            s_cnt_9_done <= '1';
            s_cnt_9      <= (others => '0');
          end if;
        end if;
      else
        s_cnt_9      <= (others => '0');
        s_cnt_9_done <= '0';
      end if;

    end if;
  end process p_count_9_mngt;


  p_sampling_mngt : process (clk, rst_n) is
  begin  -- process p_sampling_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_sampling_cnt      <= (others => '0');
      s_sampling_cnt_done <= '0';
      s_sampling_cnt_en   <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_sampling_cnt_done <= '0';
      if(s_current_state = SACK_CHIP) then

        if(s_scl_in_r_edge = '1') then
          s_sampling_cnt_en <= '1';
        end if;

        if(s_sampling_cnt_en = '1') then
          if(s_sampling_cnt < conv_std_logic_vector(C_QUARTER_SCL_PERIOD, s_sampling_cnt'length)) then
            s_sampling_cnt <= unsigned(s_sampling_cnt) + 1;
          else
            s_sampling_cnt      <= (others => '0');
            s_sampling_cnt_done <= '1';
            s_sampling_cnt_en   <= '0';
          end if;

        end if;
      else
        s_sampling_cnt      <= (others => '0');
        s_sampling_cnt_done <= '0';
        s_sampling_cnt_en   <= '0';
      end if;

    end if;
  end process p_sampling_mngt;


  p_stop_gen_cnt_mngt : process (clk, rst_n) is
  begin  -- process p_stop_gen_cnt_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_stop_gen_cnt      <= (others => '0');
      s_stop_gen_cnt_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_current_state = STOP_GEN) then

        if(s_stop_gen_cnt_en = '1') then
          if(s_stop_gen_cnt < conv_std_logic_vector(C_MAX_SCL_PERIOD, s_stop_gen_cnt'length)) then
            s_stop_gen_cnt <= unsigned(s_stop_gen_cnt) + 1;
          else
            s_stop_gen_cnt_done <= '1';
          end if;
        end if;
      else
        s_stop_gen_cnt      <= (others => '0');
        s_stop_gen_cnt_done <= '0';
      end if;
    end if;
  end process p_stop_gen_cnt_mngt;



  p_scl_mngt : process (clk, rst_n) is
  begin  -- process p_scl_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_scl_out      <= '0';
      s_en_scl       <= '0';
      s_scl_cnt_stop <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_current_state = STOP_GEN) then
        if(s_scl_cnt_done = '1') then
          s_en_scl  <= not s_en_scl;
          s_scl_out <= '0';
        end if;

        if(s_scl_in_r_edge = '1') then
          s_scl_cnt_stop <= '1';
        end if;

      elsif(s_current_state /= IDLE) then
        if(s_scl_cnt_done = '1') then
          s_en_scl  <= not s_en_scl;
          s_scl_out <= '0';
        end if;

      else
        s_scl_cnt_stop <= '0';

      end if;

    end if;
  end process p_scl_mngt;


  p_sda_mngt : process (clk, rst_n) is
  begin  -- process psda_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_sda_out         <= '0';
      s_en_sda          <= '0';
      s_start_gen_done  <= '0';
      s_ctrl_byte       <= (others => '0');
      s_stop_gen_cnt_en <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_current_state = IDLE) then
        if(s_start_r_edge = '1') then
          s_ctrl_byte <= i_chip_addr & i_rw;
        end if;

      elsif(s_current_state = START_GEN) then
        s_sda_out        <= '0';
        s_en_sda         <= '1';
        s_start_gen_done <= '1';


      elsif(s_current_state = WR_CHIP) then
        s_sda_out <= '0';

        --Set Value on Falling Edge of SCL
        if(s_scl_in_f_edge = '1') then
          s_en_sda                <= not s_ctrl_byte(7);
          s_ctrl_byte(7 downto 1) <= s_ctrl_byte(6 downto 0);
        end if;

      elsif(s_current_state = STOP_GEN) then
        if(s_scl_in_f_edge = '1') then
          s_en_sda          <= '1';
          s_sda_out         <= '0';
          s_stop_gen_cnt_en <= '1';
        elsif(s_stop_gen_cnt_done = '1') then
          s_en_sda          <= '0';
          s_sda_out         <= '0';
          s_stop_gen_cnt_en <= '0';
        end if;

      else
        s_start_gen_done  <= '0';
        s_en_sda          <= '0';
        s_stop_gen_cnt_en <= '0';
      end if;

    end if;
  end process p_sda_mngt;

  -- Outputs Affectation
  scl <= s_scl_out when s_en_scl = '1' else 'Z';  -- Write on SCL output
  sda <= s_sda_out when s_en_sda = '1' else 'Z';  -- Write on SDA output

  s_scl_in <= scl;
  s_sda_in <= sda;

end architecture behv;
