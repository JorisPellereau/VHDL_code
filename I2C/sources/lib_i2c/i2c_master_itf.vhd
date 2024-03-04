-------------------------------------------------------------------------------
-- Title      : I2C Master Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2c_master_itf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-30
-- Last update: 2024-03-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: I2C Master Interface
-- /!\ Limitations : - Data are send MSB First and store MSB first
--                   - Start input shall be a pulse
--                   - No SACK Polling
--                   - Only 8 bits data are supported
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-30  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity i2c_master_itf is
  generic(
    G_I2C_FREQ    : integer range 100000 to 400000 := 400000;    -- '0' : 100kHz - '1' : 400kHz
    G_CLKSYS_FREQ : integer                        := 50000000;  -- clk_sys frequency
    G_NB_DATA     : integer                        := 256        -- Number of MAXIMUM data to transmit
    );
  port(
    clk_sys   : in std_logic;                                    -- Clock System
    rst_n_sys : in std_logic;                                    -- Asynchronous Reset

    -- FIFO TX Interface
    fifo_tx_rd_en : out std_logic;                     -- FIFO TX Read Enable
    fifo_tx_data  : in  std_logic_vector(7 downto 0);  -- FIFO TX DATA

    -- FIFO RX Interface
    fifo_rx_wr_en : out std_logic;                     -- FIFO RX Write Enable
    fifo_rx_data  : out std_logic_vector(7 downto 0);  -- FIFO RX DATA

    -- Control Signals
    start     : in std_logic;                                   -- Start I2C Transaction
    rw        : in std_logic;                                   -- R/W acces
    chip_addr : in std_logic_vector(6 downto 0);                -- Chip addr to request
    nb_data   : in std_logic_vector(log2(G_NB_DATA) downto 0);  -- Number of Bytes to Read or Write

    -- I2C Status
    sack_error : out std_logic;         -- SACK Error Occurs
    busy       : out std_logic;         -- I2C Master busy flag

    -- I2C Interface    
    sclk    : out std_logic;            -- SCLK
    sclk_en : out std_logic;            -- Enable SCLK
    sda_in  : in  std_logic;            -- Input Data
    sda_out : out std_logic;            -- Output Data
    sda_en  : out std_logic             -- Enable SDA
    );
end entity i2c_master_itf;

architecture rtl of i2c_master_itf is

  -- == TYPES ==
  type t_fsm_states is (ST_IDLE, ST_START, ST_CTRL, ST_SACK, ST_MACK, ST_WR, ST_RD, ST_STOP, ST_SYNCH_END, ST_END, ST_SYNCH_WR, ST_SYNCH_RD);  -- FSM States

  -- == INTERNAL Signals ==
  signal chip_addr_int     : std_logic_vector(6 downto 0);                                 -- Chip Addr
  signal nb_data_int       : std_logic_vector(log2(G_NB_DATA) downto 0);                   -- Number of Data width
  signal rw_int            : std_logic;  -- Read = '1' or write = '0'
  signal fsm_cs            : t_fsm_states;                                                 -- FSM Current State
  signal fsm_ns            : t_fsm_states;                                                 -- FSM Next State
  signal sr_rdata          : std_logic_vector(7 downto 0);                                 -- Shift register rdata
  signal sr_wdata          : std_logic_vector(7 downto 0);                                 -- Shift register wdata
  signal sr_en             : std_logic;  -- Shift data to SDA enable
  signal gen_start         : std_logic;  -- Gen start pulse
  signal gen_stop          : std_logic;  -- Gen stop pulse
  signal cnt_bit           : unsigned(3 downto 0);                                         -- Bit counter (until 8)
  signal cnt_bit_done      : std_logic;  -- Indicates that 8 bits was counted
  signal ack_synch         : std_logic;  -- Signal use for the synchronization of for the SACK/MACK
  signal sampling_pulse    : std_logic;  -- Sampling pulse
  signal sack_error_int    : std_logic;  -- Slave ACK Error
  signal cnt_data          : unsigned(log2(G_NB_DATA) downto 0);                           -- Data Counter
  signal cnt_data_done     : std_logic;  -- Number of Data to Write or Read done
  signal en_sclk_gen       : std_logic;  -- Enable SCLK generation
  signal sclk_cnt          : unsigned(log2((G_CLKSYS_FREQ / G_I2C_FREQ)/2) - 1 downto 0);  -- SCLK Counter
  signal sclk_int          : std_logic;  -- Internal SCLK
  signal sclk_int2         : std_logic;  -- Internal SCLK piped one time
  signal sclk_int_r_edge   : std_logic;  -- Internal SCLK rising edge
  signal sclk_int_f_edge   : std_logic;  -- Internal SCLK falling edge
  signal sclk_change       : std_logic;  -- SCLK Change pulse flag
  signal sclk_change_en    : std_logic;  -- Enable sclk_change only in state /= ST_STOP
  signal sclk_en_int       : std_logic;  -- SCLK EN internal
  signal wr_ongoing        : std_logic;  -- Write ongoing flag - indicate that the FSM is in RD/WR or CTRL state
  signal rd_ongoing        : std_logic;  -- Read Ongoing flag
  signal end_ongoing       : std_logic;  -- ST_END State ongoing
  signal sack_ongoing      : std_logic;  -- SACK Ongoing flag
  signal ctrl_byte_ongoing : std_logic;  -- Control Byte ongoing
  signal idle_ongoing      : std_logic;  -- IDLE ongoing flag
  signal start_ongoing     : std_logic;  -- Start Ongoing
  signal mack_ongoing      : std_logic;  -- MACK Ongoing

begin  -- architecture rtl

  p_latch_inputs : process (clk_sys, rst_n_sys) is
  begin  -- process p_latch_inputs
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      chip_addr_int <= (others => '0');
      nb_data_int   <= (others => '0');
      rw_int        <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On start save inputs
      if(start = '1') then
        chip_addr_int <= chip_addr;
        nb_data_int   <= std_logic_vector(to_unsigned((to_integer(unsigned(nb_data)) + 1), nb_data_int'length));  -- Add +1 because the ctrl byte is counted
        rw_int        <= rw;
      end if;
    end if;
  end process p_latch_inputs;

  -- purpose: Pipe start signal one time
  -- Use in order to reset internal counters
  p_pipe_start : process (clk_sys, rst_n_sys) is
  begin  -- process p_pipe_start
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      gen_start <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      gen_start <= start;               -- Pipe start input
    end if;
  end process p_pipe_start;

  p_pipe_sclk_int : process (clk_sys, rst_n_sys) is
  begin  -- process p_pipe_sclk_int
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      sclk_int2 <= '1';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      sclk_int2 <= sclk_int;
    end if;
  end process p_pipe_sclk_int;

  sclk_int_r_edge <= sclk_int and not sclk_int2;  -- Rising edge detection
  sclk_int_f_edge <= not sclk_int and sclk_int2;  -- Falling edge detection

  -- purpose: FSM Current State update
  p_fsm_cs_update : process (clk_sys, rst_n_sys) is
  begin  -- process p_fsm_cs_update
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fsm_cs <= ST_IDLE;
    elsif rising_edge(clk_sys) then     -- rising clock edge
      fsm_cs <= fsm_ns;
    end if;
  end process p_fsm_cs_update;


  -- Next state computation
  p_fsm_ns_update : process (fsm_cs, start, cnt_bit_done, sampling_pulse, sda_in, rw_int,
                             cnt_data_done, sclk_change, sclk_int_r_edge, sclk_int_f_edge, ack_synch) is
  begin  -- process p_fsm_ns_update

    case fsm_cs is

      -- Wait for the start pulse
      when ST_IDLE =>
        en_sclk_gen       <= '0';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '0';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '0';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '0';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '1';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        if(start = '1') then
          fsm_ns <= ST_START;
        else
          fsm_ns <= ST_IDLE;
        end if;

      -- On ST_START state go directly to ST_CTRL state
      when ST_START =>
        en_sclk_gen       <= '1';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '0';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '1';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '0';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '0';       -- Idle Ongoing
        start_ongoing     <= '1';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        -- Leave this state on the next falling edge of sclk
        if(sclk_int_f_edge = '1') then
          fsm_ns <= ST_CTRL;
        else
          fsm_ns <= ST_START;
        end if;


      -- Genenation of the Control Byte
      when ST_CTRL =>
        en_sclk_gen       <= '1';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '1';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '1';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '0';       -- SACK Ongoing
        ctrl_byte_ongoing <= '1';       -- Control Byte Ongoing
        idle_ongoing      <= '0';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        -- Go to ST_SACK State
        if(sclk_int_f_edge = '1' and ack_synch = '1') then
          fsm_ns <= ST_SACK;
        else
          fsm_ns <= ST_CTRL;
        end if;

      when ST_SACK =>
        en_sclk_gen       <= '1';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '0';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '1';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '1';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '0';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        -- Correct sampling : ACK is here and go to READ state
        if(sampling_pulse = '1' and sda_in = '0' and rw_int = '1' and cnt_data_done = '0') then
          fsm_ns <= ST_SYNCH_RD;

        -- Correct sampling : ACK is here and go to SYNCH Write State
        elsif(sampling_pulse = '1' and sda_in = '0' and rw_int = '0'and cnt_data_done = '0') then
          fsm_ns <= ST_SYNCH_WR;

        -- NO ACK From Slave : go to STOP STATE
        elsif(sampling_pulse = '1' and sda_in = '1') then
          sack_error_int <= '1';        -- SACK ERROR
          fsm_ns         <= ST_SYNCH_END;

        -- ACK is correct and no data to send/read
        elsif(sampling_pulse = '1' and sda_in = '0' and cnt_data_done = '1') then
          fsm_ns <= ST_SYNCH_END;

        -- Stay in the state
        else
          fsm_ns <= ST_SACK;
        end if;

        -- SYnchronization on the falling edge of sclk before ging to ST_WR state

      when ST_SYNCH_WR =>
        en_sclk_gen       <= '1';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '0';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '1';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '0';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '0';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        -- In this state on the falling edge of SCLK_int -> Go to ST_WR State
        if(sclk_int_f_edge = '1') then
          fsm_ns <= ST_WR;
        else
          fsm_ns <= ST_SYNCH_WR;
        end if;

      -- In Write State wait until the end of the 8th bit to go to SACK state
      when ST_WR =>
        en_sclk_gen       <= '1';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '1';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '1';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '0';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '0';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        -- When all bits are transmitted go to SACK state
        -- Go to ST_SACK State
        if(sclk_int_f_edge = '1' and ack_synch = '1') then
          fsm_ns <= ST_SACK;
        else
          fsm_ns <= ST_WR;
        end if;

      -- ST_SYNCH_RD State : 
      when ST_SYNCH_RD =>
        en_sclk_gen       <= '1';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '0';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '1';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '1';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '0';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        -- In this state wait for the next falling edge and then go to ST_RD state
        if(sclk_int_f_edge = '1') then
          fsm_ns <= ST_RD;
        else
          fsm_ns <= ST_SYNCH_RD;
        end if;

      -- In Read State : wait until the end of the 8th bit to go to MACK state
      when ST_RD =>
        en_sclk_gen       <= '1';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '0';       -- Write Ongoing Flag
        rd_ongoing        <= '1';       -- Read Ongoing Flag
        sclk_change_en    <= '1';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '0';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '0';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        -- When all bits are received go to MACK state
        -- Go to ST_SACK State
        if(sclk_int_f_edge = '1' and ack_synch = '1') then
          fsm_ns <= ST_MACK;
        else
          fsm_ns <= ST_RD;
        end if;


      -- In MACK State : generate the ACK and go to RD state if needed
      when ST_MACK =>
        en_sclk_gen       <= '1';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '1';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '1';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '0';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '0';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '1';       -- MACK Ongoing

        -- Case : there is pending data to read -> Return in RD state
        if(sampling_pulse = '1' and cnt_data_done = '0') then
          fsm_ns <= ST_RD;

        -- Case : there is no pending data to read -> Go to ST_SYNCH_END state
        elsif(sampling_pulse = '1' and cnt_data_done = '1') then
          fsm_ns <= ST_SYNCH_END;

        -- Stay in this state until sampling_pulse is set to '1'
        else
          fsm_ns <= ST_MACK;
        end if;

      -- Synchronization on the last sclk clock pulse
      when ST_SYNCH_END =>
        en_sclk_gen       <= '1';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '0';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '1';       -- Enable SCLK CHANGE
        end_ongoing       <= '1';       -- End Ongoing flag
        sack_ongoing      <= '0';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '0';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        -- Go to ST_END on the falling edge
        if(sclk_int_r_edge = '1') then
          fsm_ns <= ST_END;
        else
          fsm_ns <= ST_SYNCH_END;
        end if;

      when ST_END =>
        en_sclk_gen       <= '1';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '0';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '0';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '0';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '0';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        -- Go to ST_STOP on the falling edge of SCLK
        if(sclk_change = '1') then
          fsm_ns <= ST_STOP;
        else
          fsm_ns <= ST_END;
        end if;

      -- Generate the STOP Condition
      when ST_STOP =>
        en_sclk_gen       <= '1';       -- Enable SCLK generation
        gen_stop          <= '1';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '0';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '0';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '0';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '0';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        if(sclk_change = '1') then
          fsm_ns <= ST_IDLE;
        else
          fsm_ns <= ST_STOP;
        end if;

      when others =>
        en_sclk_gen       <= '0';       -- Enable SCLK generation
        gen_stop          <= '0';       -- Generation of the stop condition
        sack_error_int    <= '0';       -- SACK ERROR
        wr_ongoing        <= '0';       -- Write Ongoing Flag
        rd_ongoing        <= '0';       -- Read Ongoing Flag
        sclk_change_en    <= '0';       -- Enable SCLK CHANGE
        end_ongoing       <= '0';       -- End Ongoing flag
        sack_ongoing      <= '0';       -- SACK Ongoing
        ctrl_byte_ongoing <= '0';       -- Control Byte Ongoing
        idle_ongoing      <= '1';       -- Idle Ongoing
        start_ongoing     <= '0';       -- Start ongoing flag
        mack_ongoing      <= '0';       -- MACK Ongoing

        fsm_ns <= ST_IDLE;
    end case;

  end process p_fsm_ns_update;

  -- Assert only for bad configuration purpose
  assert(G_CLKSYS_FREQ > G_I2C_FREQ) report "Error : i2c_master_itf.vhd : G_CLKSYS_FREQ <= G_I2C_FREQ" severity error;

  -- purpose: Counter for SCLK generation 
  p_cnt_sclk : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_sclk
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      sclk_cnt <= (others => '1');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Enable to load and downcounts
      if(en_sclk_gen = '1')then

        -- Reload the counter at the half value for the period generation when 0 is reach
        -- or
        -- on the gen_start pulse
        if(gen_start = '1' or sclk_cnt = to_unsigned(0, sclk_cnt'length)) then
          sclk_cnt <= to_unsigned((G_CLKSYS_FREQ / G_I2C_FREQ) / 2, sclk_cnt'length);  -- Reload the counter

        -- Downcounts
        else
          sclk_cnt <= sclk_cnt - 1;     -- Downcount
        end if;

      -- Reset the counter to all 1
      else
        sclk_cnt <= (others => '1');
      end if;

    end if;
  end process p_cnt_sclk;


  sclk_change <= '1' when sclk_cnt = to_unsigned(0, sclk_cnt'length) else '0';  -- When 0 is reach the flag is set to 1

  -- Sampling pulse is generated during a high value of sclk and when the counter reach its half value
  sampling_pulse <= '1' when sclk_int = '1' and sclk_cnt = to_unsigned((G_CLKSYS_FREQ / G_I2C_FREQ) / 4, sclk_cnt'length) else '0';

  -- Sampling pulse is generated during a low value of sclk and when the counter reach its half value
  sr_en <= '1' when sclk_int = '0' and sclk_cnt = to_unsigned((G_CLKSYS_FREQ / G_I2C_FREQ) / 4, sclk_cnt'length) else '0';

  -- sclk generation
  sclk_generation : process (clk_sys, rst_n_sys) is
  begin  -- process sclk_generation
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      sclk_int    <= '1';
      sclk_en_int <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- When Disable, set to '1' by default
      if(sclk_change_en = '0') then
        sclk_int    <= '1';
        sclk_en_int <= '0';
      -- Change the state of the sclk clock
      elsif(sclk_change = '1' and sclk_change_en = '1') then
        sclk_int    <= not sclk_int;
        sclk_en_int <= not sclk_en_int;
      end if;

    end if;
  end process sclk_generation;


  -- purpose: Shift register management
  p_sr_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_sr_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      sr_wdata <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Load the shift register on gen_start pulse
      if(sr_en = '1' and cnt_bit = to_unsigned(0, cnt_bit'length) and wr_ongoing = '1' and ctrl_byte_ongoing = '1') then  --gen_start = '1') then
        sr_wdata <= chip_addr_int & rw_int;

      -- Load the data into the Shift Register on the first sr_en pulse in order to load the data from the fifo
      elsif(sr_en = '1' and cnt_bit = to_unsigned(0, cnt_bit'length) and wr_ongoing = '1' and ctrl_byte_ongoing = '0') then
        sr_wdata <= fifo_tx_data;       -- Data from the FIFO TX

      -- Shift the register on sr_en_pulse
      elsif(sr_en = '1' and wr_ongoing = '1' and cnt_bit /= to_unsigned(0, cnt_bit'length)) then
        sr_wdata(7 downto 1) <= sr_wdata(6 downto 0);  -- Shift on MSB

      -- At the end of the frame, reset the SR
      elsif(end_ongoing = '1') then
        sr_wdata <= (others => '0');
      end if;

    end if;
  end process p_sr_mngt;

  -- Management of the next read data pulse
  p_rd_next_tx_data : process (clk_sys, rst_n_sys) is
  begin  -- process p_rd_next_tx_data
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fifo_tx_rd_en <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Send pulse to read the next data
      -- Read the next data only at the end of the trnsmitted bit and only in ST_WR state
      if(cnt_bit_done = '1' and wr_ongoing = '1' and ctrl_byte_ongoing = '0') then
        fifo_tx_rd_en <= '1';
      else
        fifo_tx_rd_en <= '0';
      end if;

    end if;
  end process p_rd_next_tx_data;


  -- purpose: Counter of bit
  p_cnt_bit : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_bit
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_bit <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Reset the counter when 8 is reach
      if(cnt_bit = to_unsigned(8, cnt_bit'length)) then
        cnt_bit <= (others => '0');     -- Reset the counter

      -- Inc. the counter on sr_en pulse
      elsif(sr_en = '1' and ((wr_ongoing = '1' and mack_ongoing = '0') or rd_ongoing = '1')) then
        cnt_bit <= cnt_bit + 1;
      end if;

    end if;

  end process p_cnt_bit;

  cnt_bit_done <= '1' when cnt_bit = to_unsigned(8, cnt_bit'length) else '0';  -- This flag is set to '1' when the value 8 is reach

  -- SACK/MACK Synchronization signal
  p_ack_synch : process (clk_sys, rst_n_sys) is
  begin  -- process p_ack_synch
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      ack_synch <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Latch cnt_bit_done into ack_synch
      if(cnt_bit_done = '1') then
        ack_synch <= '1';

      -- On sack_sych and sclk_falling edge detection -> Rrset it
      elsif(ack_synch = '1' and sclk_int_f_edge = '1') then
        ack_synch <= '0';
      end if;
    end if;
  end process p_ack_synch;

  -- purpose: Counter of DATA
  p_cnt_data : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_data
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_data <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- on the gen_start signal -> Initialized the counter to 0
      if(gen_start = '1') then
        cnt_data <= (others => '0');

      -- Inc it
      elsif(cnt_bit_done = '1') then
        cnt_data <= cnt_data + 1;       -- Inc by one
      end if;

    end if;
  end process p_cnt_data;

  cnt_data_done <= '1' when cnt_data = unsigned(nb_data_int) else '0';  -- This flag is set to '1' when the number of send/received data is reach
  p_sr_rdata : process (clk_sys, rst_n_sys) is
  begin  -- process p_sr_rdata
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      sr_rdata <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On a sampling pulse load the data to the SR
      if(rd_ongoing = '1' and sampling_pulse = '1') then
        sr_rdata(0)          <= sda_in;
        sr_rdata(7 downto 1) <= sr_rdata(6 downto 0);  -- Shift it

      -- During the end state reset the SR
      elsif(end_ongoing = '1') then
        sr_rdata <= (others => '0');
      end if;

    end if;
  end process p_sr_rdata;

  p_write_fifo_rx : process (clk_sys, rst_n_sys) is
  begin  -- process p_write_fifo_rx
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fifo_rx_wr_en <= '0';
      fifo_rx_data  <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- During a read access, on the transition to go to the MACK state -> Store the sr_data into the RX FIFO
      if(sclk_int_f_edge = '1' and ack_synch = '1' and rd_ongoing = '1') then
        fifo_rx_wr_en <= '1';
        fifo_rx_data  <= sr_rdata;
      else
        fifo_rx_wr_en <= '0';
        fifo_rx_data  <= (others => '0');
      end if;

    end if;
  end process p_write_fifo_rx;

  -- purpose: SDA Output generation
  p_sda_out_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_sda_out_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      sda_out <= '1';
      sda_en  <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Generation of the start condition
      -- Set sda_out at '0' on start_ongoing or on end_going and sclk_int_f_edge = '1' (initialized stop condition generation)
      if(start_ongoing = '1' or (end_ongoing = '1' and sclk_int_f_edge = '1')) then
        sda_out <= '0';
        sda_en  <= '1';

      -- Generation of the stop condition or generation of the MACK 
      elsif(gen_stop = '1' or mack_ongoing = '1') then
        sda_out <= '1';
        sda_en  <= '1';

      -- Enable only if we are in write mode (BYTE CTRL or ST_WR)
      elsif(wr_ongoing = '1') then
        sda_out <= sr_wdata(7);         -- Send MSB
        sda_en  <= '1';

      elsif(rd_ongoing = '1' or sack_ongoing = '1' or idle_ongoing = '1') then
        sda_en <= '0';
      end if;

    end if;
  end process p_sda_out_mngt;

  -- == OUTPUTS affectation ==
  sclk       <= sclk_int;
  sclk_en    <= sclk_en_int;
  sack_error <= sack_error_int;
  busy       <= not idle_ongoing;

end architecture rtl;
