-------------------------------------------------------------------------------
-- Title      : SPI ITF
-- Project    : 
-------------------------------------------------------------------------------
-- File       : spi_master_itf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-04
-- Last update: 2024-01-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: SPI MASTER ITF
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-04  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity spi_master_itf is

  generic (
    G_SPI_SIZE        : integer range 1 to 4  := 4;    -- SPI Size
    G_DATA_WIDTH      : integer               := 8;    -- Data Width
    G_FIFO_DATA_WIDTH : integer range 8 to 32 := 8;    -- FIFO DATA WIDTH
    G_FIFO_DEPTH      : integer               := 1024  -- FIFO DEPTH
    );
  port (
    clk_sys   : in std_logic;                          -- Clock System
    rst_n_sys : in std_logic;                          -- Asynchronous Reset

    -- FIFO TX Interface
    fifo_tx_rd_en : out std_logic;                                    -- FIFO TX Read Enable
    fifo_tx_data  : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- FIFO TX DATA

    -- FIFO RX Interface
    fifo_rx_wr_en : out std_logic;                                    -- FIFO RX Write Enable
    fifo_rx_data  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- FIFO RX DATA

    -- SPI Control
    start       : in  std_logic;                                          -- Start the SPI transaction on pulse
    nb_wr       : in  std_logic_vector(log2(G_FIFO_DEPTH) - 1 downto 0);  -- Number of write to send
    nb_rd       : in  std_logic_vector(log2(G_FIFO_DEPTH) - 1 downto 0);  -- Number of read to perform
    full_duplex : in  std_logic;                                          -- Fulle Duplux configuration
    cpha        : in  std_logic;                                          -- SPI SPHA Configuration
    cpol        : in  std_logic;                                          -- SPI CPOL Configuration
    clk_div     : in  std_logic_vector(7 downto 0);                       -- Clock Division
    spi_clk     : out std_logic;                                          -- MASTER SPI Clock
    spi_cs_n    : out std_logic;                                          -- MASTER SPI Chip Select - Actif at '0'
    spi_do      : out std_logic_vector(G_SPI_SIZE - 1 downto 0);          -- SPI Data Out
    spi_di      : in  std_logic_vector(G_SPI_SIZE - 1 downto 0);          -- SPI Data In
    spi_busy    : out std_logic                                           -- SPI Is busy
    );

end entity spi_master_itf;

architecture rtl of spi_master_itf is

  -- == TYPES ==
  type t_fsm_state is (ST_IDLE, ST_SYNCHRO, ST_INIT, ST_WR, ST_RD, ST_RW, ST_END);  -- FSM STATES

  -- == INTERNAL Signals ==
  signal nb_wr_int            : std_logic_vector(log2(G_FIFO_DEPTH) - 1 downto 0);  -- Number of write to send
  signal nb_rd_int            : std_logic_vector(log2(G_FIFO_DEPTH) - 1 downto 0);  -- Number of read to perform
  signal full_duplex_int      : std_logic;                                          -- Fulle Duplux configuration
  signal cpha_int             : std_logic;                                          -- SPI SPHA Configuration
  signal cpol_int             : std_logic;                                          -- SPI CPOL Configuration
  signal clk_div_int          : std_logic_vector(7 downto 0);                       -- Clock Division
  signal cnt_clk_div          : unsigned(7 downto 0);                               -- Counter clk_div
  signal clk_en               : std_logic;                                          -- Clock Enable
  signal fsm_cs               : t_fsm_state;                                        -- FSM Current state
  signal fsm_ns               : t_fsm_state;                                        -- FSM Next state
  signal cnt_bit_en           : std_logic;                                          -- Counter bit Enable
  signal cnt_bit              : unsigned(log2(G_DATA_WIDTH) - 1 downto 0);          -- Counter Bit
  signal cnt_data             : unsigned(log2(G_FIFO_DEPTH) - 1 downto 0);          -- Counter of Data
  signal cnt_data_done        : std_logic;                                          -- Counter of data done
  signal clk_spi_int          : std_logic;                                          -- Internal Clock SPI
  signal clk_spi_int_p1       : std_logic;                                          -- Internal Clock SPI Piped one time
  signal clk_spi_r_edge       : std_logic;                                          -- R Edge of Internal Clock SPI
  signal clk_spi_f_edge       : std_logic;                                          -- F Edge of Internal Clock SPI
  signal start_int            : std_logic;                                          -- Start piped one time
  signal fifo_tx_rd_en_int    : std_logic;                                          -- FIFO TX Read Enable internal
  signal fifo_tx_rd_en_int_p1 : std_logic;                                          -- FIFO TX Read Enable internal p1
  signal fifo_tx_rd_en_int_p2 : std_logic;                                          -- FIFO TX Read Enable internal p2
  signal spi_tx_data_int      : std_logic_vector(G_DATA_WIDTH - 1 downto 0);        -- SPI Data to send and shifted
  signal spi_rx_data_int      : std_logic_vector(G_DATA_WIDTH - 1 downto 0);        -- SPI Data to received and shifted
  signal wr_ongoing           : std_logic;                                          -- ST_WR ongoing state
  signal rd_ongoing           : std_logic;                                          -- ST_RD ongoing state
  signal rw_ongoing           : std_logic;                                          -- ST_RW ongoing state
  signal shift_tx             : std_logic;                                          -- Shift TX
  signal shift_rx             : std_logic;                                          -- Shift RX
  signal spi_di_p             : std_logic_vector(G_SPI_SIZE - 1 downto 0);          -- Latch one time SPI DI - Use for synchronization
  signal fifo_rx_wr_en_int    : std_logic;                                          -- FIFO RX Write Enable
  signal en_cs                : std_logic;                                          -- Enable Chip select
  signal init_ongoing         : std_logic;                                          -- INIT Ongoing
  signal rst_cnt_data         : std_logic;                                          -- Reset Counter data
  signal cnt_bit_done         : std_logic;                                          -- Counter of Bit Done

begin  -- architecture rtl

  -- purpose: Latch Inputs on start 
  p_latch_inputs : process (clk_sys, rst_n_sys) is
  begin  -- process p_latch_inputs
    if rst_n_sys = '0' then                               -- asynchronous reset (active low)
      nb_wr_int       <= (others => '0');
      nb_rd_int       <= (others => '0');
      full_duplex_int <= '0';
      cpha_int        <= '0';
      cpol_int        <= '0';
      clk_div_int     <= (0      => '1', others => '0');  -- Init a 1 by default
    elsif rising_edge(clk_sys) then                       -- rising clock edge

      -- On Start : latch inputs
      if(start = '1') then
        nb_wr_int       <= nb_wr;
        nb_rd_int       <= nb_rd;
        full_duplex_int <= full_duplex;
        cpha_int        <= cpha;
        cpol_int        <= cpol;
        clk_div_int     <= clk_div;
      end if;

    end if;
  end process p_latch_inputs;

  -- purpose: Pipe signals
  p_pipe_signals : process (clk_sys, rst_n_sys) is
  begin  -- process p_pipe_signals
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      start_int      <= '0';
      clk_spi_int_p1 <= '0';
      spi_di_p       <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge
      start_int      <= start;
      clk_spi_int_p1 <= clk_spi_int;
      spi_di_p       <= spi_di;
    end if;
  end process p_pipe_signals;

  -- Rising edge detection
  clk_spi_r_edge <= clk_spi_int and not clk_spi_int_p1;

  -- Falling Edge detection
  clk_spi_f_edge <= not clk_spi_int and clk_spi_int_p1;

  -- purpose: Clock Division Management
  p_cnt_clk_div_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_clk_div_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_clk_div <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Enable the downcounter only during the frame generation drived by en_cs
      if(en_cs = '1') then
        -- When the counter reach 0 -> REload it with the clk_div_integer
        if(cnt_clk_div = 0) then
          cnt_clk_div <= unsigned(clk_div_int);  -- Reload the counter
        else
          cnt_clk_div <= cnt_clk_div - 1;        -- Downcount
        end if;
      else
        cnt_clk_div <= (others => '0');
      end if;

    end if;
  end process p_cnt_clk_div_mngt;

  -- purpose: Clock Enable generatio 
  p_clk_en_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_clk_en_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      clk_en <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Enable the generation of clk_en only during a frame transaction drived by en_cs
      if(en_cs = '1') then
        if(cnt_clk_div = 0) then
          clk_en <= '1';
        else
          clk_en <= '0';
        end if;
      else
        clk_en <= '0';
      end if;

    end if;
  end process p_clk_en_mngt;


  -- purpose: Clock SPI generation
  p_clk_spi_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_clk_spi_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      clk_spi_int <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Initialized the clock polarity
      if(start_int = '1') then
        clk_spi_int <= cpol_int;

      -- Inverted the clock on clk enable
      elsif(clk_en = '1') then
        clk_spi_int <= not clk_spi_int;
      end if;

    end if;
  end process p_clk_spi_mngt;


  -- purpose: FIFO TX Read Management
  -- p_fifo_tx_rd_mngt : process (clk_sys, rst_n_sys) is
  -- begin  -- process p_fifo_tx_rd_mngt
  --   if rst_n_sys = '0' then             -- asynchronous reset (active low)
  --     fifo_tx_rd_en <= '0';
  --   elsif rising_edge(clk_sys) then     -- rising clock edge

  --     -- On start -> Data are already available
  --     if(fifo_tx_rd_en_int = '1' and (wr_ongoing = '1' or rw_ongoing = '1')) then
  --       fifo_tx_rd_en <= '1';
  --     else
  --       fifo_tx_rd_en <= '0';
  --     end if;
  --   end if;
  -- end process p_fifo_tx_rd_mngt;

  fifo_tx_rd_en <= fifo_tx_rd_en_int; -- Anticiper l'accès
  
  -- purpose: FIFO RX Write Management
  p_fifo_rx_wr_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_fifo_rx_wr_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fifo_rx_wr_en <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On the flag -> generate the output
      if(fifo_rx_wr_en_int = '1') then
        fifo_rx_wr_en <= '1';
      else
        fifo_rx_wr_en <= '0';
      end if;
    end if;
  end process p_fifo_rx_wr_mngt;

  -- purpose: FIFO RX Write Data management
  p_fifo_rx_data_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_fifo_rx_data_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fifo_rx_data <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On the flag -> generate the output
      if(fifo_rx_wr_en_int = '1') then
        fifo_rx_data <= spi_rx_data_int;
      else
        fifo_rx_data <= (others => '0');
      end if;
    end if;
  end process p_fifo_rx_data_mngt;

  -- purpose: Counter of bits management
  p_cnt_bit : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_bit
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_bit <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Inc. the counter
      if(cnt_bit_en = '1') then
        cnt_bit <= cnt_bit + 1;

      -- RESET §!!
      elsif(cnt_bit = to_unsigned(G_DATA_WIDTH / G_SPI_SIZE, cnt_bit'length)) then
        cnt_bit <= (others => '0');
      end if;

    end if;
  end process p_cnt_bit;

  -- This bit is set to one and it is used to count the bits to transmit
  cnt_bit_en <= '1' when cpha_int = '0' and cpol_int = '0' and clk_spi_r_edge = '1' and
                (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
                '1' when cpha_int = '0' and cpol_int = '1' and clk_spi_f_edge = '1' and
                (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
                '1' when cpha_int = '1' and cpol_int = '0' and clk_spi_f_edge = '1' and
                (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
                '1' when cpha_int = '1' and cpol_int = '1' and clk_spi_r_edge = '1' and
                (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
                '0';


  p_fifo_tx_rd_en_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_fifo_tx_rd_en_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fifo_tx_rd_en_int    <= '0';
      fifo_tx_rd_en_int_p1 <= '0';
      fifo_tx_rd_en_int_p2 <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Read Enable Flag : read a new data when the counter reach 0
      if(cnt_bit = to_unsigned(G_DATA_WIDTH / G_SPI_SIZE, cnt_bit'length)) then
        fifo_tx_rd_en_int <= '1';
      else
        fifo_tx_rd_en_int <= '0';
      end if;
      fifo_tx_rd_en_int_p1 <= fifo_tx_rd_en_int;
      fifo_tx_rd_en_int_p2 <= fifo_tx_rd_en_int_p1;
    end if;
  end process p_fifo_tx_rd_en_mngt;

  -- Read Enable Flag : read a new data when the counter reach 0
  cnt_bit_done <= '1' when cnt_bit = to_unsigned(G_DATA_WIDTH / G_SPI_SIZE, cnt_bit'length) else
                  '0';

  -- Write Enable Flag : write a new data when the counter reach 0
  fifo_rx_wr_en_int <= '1' when cnt_bit = to_unsigned(G_DATA_WIDTH / G_SPI_SIZE, cnt_bit'length) else
                       '0';

  -- Shift TX flag
  -- Shift TX flag in function of the SPI Configuration
  shift_tx <= '1' when cpha_int = '0' and cpol_int = '0' and clk_spi_f_edge = '1' and
              (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
              '1' when cpha_int = '0' and cpol_int = '1' and clk_spi_r_edge = '1' and
              (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
              '1' when cpha_int = '1' and cpol_int = '0' and clk_spi_r_edge = '1' and
              (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
              '1' when cpha_int = '1' and cpol_int = '1' and clk_spi_f_edge = '1' and
              (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
              '0';

  -- SHIFT RX flag
  -- Shift RX flag in function of the CPI Configuration
  shift_rx <= '1' when cpha_int = '0' and cpol_int = '0' and clk_spi_r_edge = '1' and
              (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
              '1' when cpha_int = '0' and cpol_int = '1' and clk_spi_f_edge = '1' and
              (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
              '1' when cpha_int = '1' and cpol_int = '0' and clk_spi_f_edge = '1' and
              (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
              '1' when cpha_int = '1' and cpol_int = '1' and clk_spi_r_edge = '1' and
              (wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') else
              '0';

  -- purpose: Counter of data
  p_cnt_data : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_data
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_data <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Inc the counter if the counter of bit is done
      if(cnt_bit_done = '1') then
        cnt_data <= cnt_data + 1;

      -- Reset the counter of data
      elsif(rst_cnt_data = '1') then
        cnt_data <= (others => '0');

      end if;
    end if;
  end process p_cnt_data;

  -- Generated the counter of data done in function of the number of data to read/write/RW
  cnt_data_done <= '1' when cnt_data = unsigned(nb_wr_int) and wr_ongoing = '1' else
                   '1' when cnt_data = unsigned(nb_rd_int) and rd_ongoing = '1' else
                   '1' when cnt_data = unsigned(nb_wr_int) and rw_ongoing = '1' else
                   '0';

  -- purpose: FSM Current state management
  p_fsm_cs : process (clk_sys, rst_n_sys) is
  begin  -- process p_fsm_cs
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fsm_cs <= ST_IDLE;                -- Set initial state
    elsif rising_edge(clk_sys) then     -- rising clock edge
      fsm_cs <= fsm_ns;                 -- Update current state from current
    end if;
  end process p_fsm_cs;

  p_fsm_ns : process (start, fsm_cs, cpol_int, cpha_int, clk_spi_r_edge, clk_spi_f_edge,
                      full_duplex_int, nb_wr_int, nb_rd_int, cnt_data) is
  begin  -- process p_fsm_ns

    -- Computes FSM Next state
    case fsm_cs is

      -- Wait on start pulse
      when ST_IDLE =>
        wr_ongoing   <= '0';            -- WR Ongoing Flag
        rd_ongoing   <= '0';            -- RD Ongoing Flag
        rw_ongoing   <= '0';            -- RW Ongoing Flag
        en_cs        <= '0';            -- Enable Chip Select
        init_ongoing <= '0';            -- INIT Ongoing Flag
        rst_cnt_data <= '0';            -- Reset Counter Data

        if(start = '1') then
          fsm_ns <= ST_SYNCHRO;
        else
          fsm_ns <= ST_IDLE;
        end if;

      -- Use for Synchronization in cpha = '1'
      when ST_SYNCHRO =>
        wr_ongoing   <= '0';            -- WR Ongoing Flag
        rd_ongoing   <= '0';            -- RD Ongoing Flag
        rw_ongoing   <= '0';            -- RW Ongoing Flag
        en_cs        <= '1';            -- Enable Chip Select
        init_ongoing <= '0';            -- INIT Ongoing Flag
        rst_cnt_data <= '0';            -- Reset Counter Data

        -- If CPHA = '0' do not wait for a half period
        if(cpha_int = '0') then
          fsm_ns <= ST_INIT;
        else

          -- CPHA = '1' and wait on clock spi rising edge
          if(cpol_int = '0' and clk_spi_r_edge = '1') then
            fsm_ns <= ST_INIT;

          -- CPHA = '1' and wait for clock spi falling edge
          elsif(cpol_int = '1' and clk_spi_f_edge = '1') then
            fsm_ns <= ST_INIT;

          -- Stay in the state
          else
            fsm_ns <= ST_SYNCHRO;
          end if;

        end if;

      -- In function of the configuration go to SPI generation states
      when ST_INIT =>
        wr_ongoing   <= '0';            -- WR Ongoing Flag
        rd_ongoing   <= '0';            -- RD Ongoing Flag
        rw_ongoing   <= '0';            -- RW Ongoing Flag
        en_cs        <= '1';            -- Enable Chip Select
        init_ongoing <= '1';            -- INIT Ongoing Flag
        rst_cnt_data <= '0';            -- Reset Counter Data

        -- Full duplex selection
        if(full_duplex_int = '1' and nb_wr_int /= std_logic_vector(to_unsigned(0, nb_wr_int'length))) then
          fsm_ns <= ST_RW;

        -- Half Duplex
        else

          -- Case : send Write access
          if(nb_wr_int /= std_logic_vector(to_unsigned(0, nb_wr_int'length))) then
            fsm_ns <= ST_WR;

          -- Case : send Read access
          elsif(nb_rd_int /= std_logic_vector(to_unsigned(0, nb_rd_int'length))) then
            fsm_ns <= ST_RD;

          -- Error -> Go to END State
          else
            fsm_ns <= ST_END;
          end if;

        end if;


      -- In WR state, go to the end or to read state
      when ST_WR =>
        wr_ongoing   <= '1';            -- WR Ongoing Flag
        rd_ongoing   <= '0';            -- RD Ongoing Flag
        rw_ongoing   <= '0';            -- RW Ongoing Flag
        en_cs        <= '1';            -- Enable Chip Select
        init_ongoing <= '0';            -- INIT Ongoing Flag
        rst_cnt_data <= '0';            -- Reset Counter Data

        --if(cpha_int = '0') then

        if(cpol_int = '0') then
          if(cnt_data_done = '1' and clk_spi_f_edge = '1') then
            if(nb_rd_int /= std_logic_vector(to_unsigned(0, nb_rd_int'length))) then
              fsm_ns       <= ST_RD;
              rst_cnt_data <= '1';      -- Reset Counter Data
            else
              fsm_ns <= ST_END;
            end if;

          -- cpol = '1'
          else

            if(cnt_data_done = '1' and clk_spi_r_edge = '1') then
              if(nb_rd_int /= std_logic_vector(to_unsigned(0, nb_rd_int'length))) then
                fsm_ns       <= ST_RD;
                rst_cnt_data <= '1';    -- Reset Counter Data
              else
                fsm_ns <= ST_END;
              end if;

            else
              fsm_ns <= ST_WR;
            end if;

          end if;

        end if;

      when ST_RD =>
        wr_ongoing   <= '0';            -- WR Ongoing Flag
        rd_ongoing   <= '1';            -- RD Ongoing Flag
        rw_ongoing   <= '0';            -- RW Ongoing Flag
        en_cs        <= '1';            -- Enable Chip Select
        init_ongoing <= '0';            -- INIT Ongoing Flag
        rst_cnt_data <= '0';            -- Reset Counter Data

        if(cpol_int = '0') then
          if(cnt_data_done = '1' and clk_spi_f_edge = '1') then
            if(nb_rd_int /= std_logic_vector(to_unsigned(0, nb_rd_int'length))) then
              fsm_ns <= ST_RD;
            else
              fsm_ns <= ST_END;
            end if;

          -- cpol = '1'
          else

            if(cnt_data_done = '1' and clk_spi_r_edge = '1') then
              if(nb_rd_int /= std_logic_vector(to_unsigned(0, nb_rd_int'length))) then
                fsm_ns <= ST_RD;
              else
                fsm_ns <= ST_END;
              end if;

            else
              fsm_ns <= ST_RD;
            end if;

          end if;

        end if;


      -- Synchronization on the last edge of the clock
      when ST_END =>
        wr_ongoing   <= '0';            -- WR Ongoing Flag
        rd_ongoing   <= '0';            -- RD Ongoing Flag
        rw_ongoing   <= '0';            -- RW Ongoing Flag
        en_cs        <= '1';            -- Enable Chip Select
        init_ongoing <= '0';            -- INIT Ongoing Flag
        rst_cnt_data <= '1';            -- Reset Counter Data

        -- Synchronization on the next internal rising edge
        if(cpha_int = '0' and cpol_int = '0' and clk_spi_r_edge = '1') then
          fsm_ns <= ST_IDLE;

        -- Synchronization on the next internal falling edge
        elsif(cpha_int = '0' and cpol_int = '1' and clk_spi_f_edge = '1') then
          fsm_ns <= ST_IDLE;

        -- Synchronization on the next internal rising edge
        elsif(cpha_int = '1' and cpol_int = '0' and clk_spi_r_edge = '1') then
          fsm_ns <= ST_IDLE;

        -- Synchronization on the next internal falling edge
        elsif(cpha_int = '1' and cpol_int = '1' and clk_spi_f_edge = '1') then
          fsm_ns <= ST_IDLE;

        -- Stay in this state
        else
          fsm_ns <= ST_END;
        end if;


      when ST_RW =>
        wr_ongoing   <= '0';            -- WR Ongoing Flag
        rd_ongoing   <= '0';            -- RD Ongoing Flag
        rw_ongoing   <= '1';            -- RW Ongoing Flag
        en_cs        <= '1';            -- Enable Chip Select
        init_ongoing <= '0';            -- INIT Ongoing Flag
        rst_cnt_data <= '0';            -- Reset Counter Data

      when others =>
        wr_ongoing   <= '0';            -- WR Ongoing Flag
        rd_ongoing   <= '0';            -- RD Ongoing Flag
        rw_ongoing   <= '0';            -- RW Ongoing Flag
        en_cs        <= '0';            -- Enable Chip Select
        init_ongoing <= '0';            -- INIT Ongoing Flag
        rst_cnt_data <= '0';            -- Reset Counter Data
        fsm_ns       <= ST_IDLE;

    end case;
  end process p_fsm_ns;


  -- SPI Data out generation
  -- Generate for 1 bit
  g_spi_1_bit : if(G_SPI_SIZE = 1) generate

    -- purpose: SPI TX DATA Management
    -- TX Data shift register
    p_spi_tx_data_mngt : process (clk_sys, rst_n_sys) is
    begin  -- process p_spi_tx_data_mngt
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        spi_tx_data_int <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge

        -- Load the shift register on the start (1st data) or 
        if(start = '1' or (fifo_tx_rd_en_int_p2 = '1' and en_cs = '1')) then
          spi_tx_data_int <= fifo_tx_data;  -- Latch data

        -- Shift the data one bit at a time
        elsif(shift_tx = '1') then
          spi_tx_data_int(G_DATA_WIDTH - 2 downto 0) <= spi_tx_data_int(G_DATA_WIDTH - 1 downto 1);  -- Shift 
        end if;

      end if;
    end process p_spi_tx_data_mngt;

    -- purpose: SPI RX DATA Management
    p_spi_rx_data_mngt : process (clk_sys, rst_n_sys) is
    begin  -- process p_spi_rx_data_mngt
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        spi_rx_data_int <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge

        -- Shift RX : load data on MSB and shift it
        -- TBD : latch DI ..
        if(shift_rx = '1') then
          spi_rx_data_int(G_DATA_WIDTH - 1)          <= spi_di_p(G_SPI_SIZE - 1);                    -- Load on MSBit
          spi_rx_data_int(G_DATA_WIDTH - 2 downto 0) <= spi_rx_data_int(G_DATA_WIDTH - 1 downto 1);  -- Shift it
        end if;
      end if;
    end process p_spi_rx_data_mngt;

  end generate;


  -- Generate for 2 bits
  g_spi_2_bit : if(G_SPI_SIZE = 2) generate

    -- purpose: SPI TX DATA Management
    -- TX Data shift register
    p_spi_tx_data_mngt : process (clk_sys, rst_n_sys) is
    begin  -- process p_spi_tx_data_mngt
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        spi_tx_data_int <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge

        -- Load the shift register on the start (1st data) or 
        if(start = '1' or (fifo_tx_rd_en_int_p2 = '1' and en_cs = '1')) then
          spi_tx_data_int <= fifo_tx_data;  -- Latch data

        -- Shift the data one bit at a time
        elsif(shift_tx = '1') then
          spi_tx_data_int(G_DATA_WIDTH - 3 downto 0) <= spi_tx_data_int(G_DATA_WIDTH - 1 downto G_SPI_SIZE);  -- Shift 
        end if;

      end if;
    end process p_spi_tx_data_mngt;

    -- purpose: SPI RX DATA Management
    p_spi_rx_data_mngt : process (clk_sys, rst_n_sys) is
    begin  -- process p_spi_rx_data_mngt
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        spi_rx_data_int <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge

        -- Shift RX : load data on MSB and shift it
        -- TBD : latch DI ..
        if(shift_rx = '1') then
          spi_rx_data_int(G_DATA_WIDTH - 1)          <= spi_di_p(G_SPI_SIZE - 1);                    -- Load on MSBit
          spi_rx_data_int(G_DATA_WIDTH - 2 downto 0) <= spi_rx_data_int(G_DATA_WIDTH - 1 downto 1);  -- Shift it
        end if;
      end if;
    end process p_spi_rx_data_mngt;

  end generate;

  -- Generate for 4 bits
  g_spi_4_bit : if(G_SPI_SIZE = 4) generate

    -- purpose: SPI TX DATA Management
    -- TX Data shift register
    p_spi_tx_data_mngt : process (clk_sys, rst_n_sys) is
    begin  -- process p_spi_tx_data_mngt
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        spi_tx_data_int <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge

        -- Load the shift register on the start (1st data) or 
        if(start = '1') then
          spi_tx_data_int <= fifo_tx_data;  -- Latch data

        -- Shift the data one bit at a time
        elsif(shift_tx = '1') then
          spi_tx_data_int(G_DATA_WIDTH - 4 - 1 downto 0) <= spi_tx_data_int(G_DATA_WIDTH - 1 downto G_SPI_SIZE);  -- Shift 
        end if;

      end if;
    end process p_spi_tx_data_mngt;

    -- purpose: SPI RX DATA Management
    p_spi_rx_data_mngt : process (clk_sys, rst_n_sys) is
    begin  -- process p_spi_rx_data_mngt
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        spi_rx_data_int <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge

        -- Shift RX : load data on MSB and shift it
        -- TBD : latch DI ..
        if(shift_rx = '1') then
          spi_rx_data_int(G_DATA_WIDTH - 1)          <= spi_di_p(G_SPI_SIZE - 1);                    -- Load on MSBit
          spi_rx_data_int(G_DATA_WIDTH - 2 downto 0) <= spi_rx_data_int(G_DATA_WIDTH - 1 downto 1);  -- Shift it
        end if;
      end if;
    end process p_spi_rx_data_mngt;

  end generate;

  -- purpose: SPI Data Out management
  p_spi_do_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_spi_do_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      spi_do <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      if(en_cs = '1') then --init_ongoing = '1' or wr_ongoing = '1' or rw_ongoing = '1') then
        spi_do(G_SPI_SIZE - 1 downto 0) <= spi_tx_data_int(G_SPI_SIZE - 1 downto 0);

      -- Reset the output data when the chip select is not enable
      else--if(en_cs = '0') then
        spi_do <= (others => '0');
      end if;

    end if;
  end process p_spi_do_mngt;

  --spi_do <= spi_tx_data_int(G_SPI_SIZE - 1 downto 0) when en_cs = '1' else (others => '0');

  -- purpose: SPI CLK Generation
  p_spi_clk_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_spi_clk_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      spi_clk <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      if(wr_ongoing = '1' or rd_ongoing = '1' or rw_ongoing = '1') then
        spi_clk <= clk_spi_int;
      else
        spi_clk <= cpol_int;
      end if;
    end if;
  end process p_spi_clk_mngt;


  -- purpose: CHIP Select management
  p_spi_cs_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_spi_cs_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      spi_cs_n <= '1';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      spi_cs_n <= not en_cs;            -- EN_CS is set to '1' inside the FSM

    end if;
  end process p_spi_cs_mngt;

  -- purpose: SPI Busy Management
  p_spi_busy_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_spi_busy_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      spi_busy <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      spi_busy <= en_cs;
    end if;
  end process p_spi_busy_mngt;

end architecture rtl;
