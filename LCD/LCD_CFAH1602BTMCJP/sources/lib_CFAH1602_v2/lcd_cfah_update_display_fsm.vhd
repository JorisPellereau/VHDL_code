-------------------------------------------------------------------------------
-- Title      : FSM LCD CFAH UPDATE
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_update_display_fsm.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-15
-- Last update: 2023-09-17
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: FSM for the LCD UPDATE function
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-15  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_cfah_update_display_fsm is
  generic (
    G_DATA_WIDTH : integer := 8;        -- DATA Width
    G_ADDR_WIDTH : integer := 10
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Commands
    i_update_all_lcd  : in std_logic;   -- Update the entire LCD Command
    i_update_one_char : in std_logic;   -- One char update
    i_char_position   : in std_logic_vector(4 downto 0);  -- Character position selection [0:31]

    -- LCD Commands
    o_set_ddram_addr     : out std_logic;  -- SET DDRAM ADDR Command
    o_wr_data            : out std_logic;  -- Write data to RAM command
    o_ddram_data_or_addr : out std_logic_vector(7 downto 0);  -- Data or Addr bus
    o_start              : out std_logic;  -- Start the command

    -- Polling block ready
    i_poll_done : in std_logic;         -- Polling Block ready flag

    -- Update Done flag
    o_update_done : out std_logic;      -- Update done flag

    -- FIFO CTRL 
    rd_en     : out std_logic;          -- Write Enable
    rdata     : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DATA to read
    rdata_val : in  std_logic           -- DATA to read valid
    );

end entity lcd_cfah_update_display_fsm;

architecture rtl of lcd_cfah_update_display_fsm is

  -- == TYPES ==
  type t_fsm_states is (IDLE, INIT, RD_DATA, SET_DDRAM_ADDR, WR_DATA);  -- FSM States

  -- == INTERNAL Signals ==
  signal fsm_cs : t_fsm_states;         -- Current State
  signal fsm_ns : t_fsm_states;         -- Next State

  signal cnt_char     : unsigned(4 downto 0);  -- Counter for character
  signal cnt_char_max : unsigned(4 downto 0);  -- MAX Counter for character

  signal ddram_addr      : std_logic_vector(7 downto 0);  -- DDRAM ADDR
  signal init_ongoing    : std_logic;   -- INIT State ongoing
  signal wr_data_ongoing : std_logic;   -- WR DATA State ongoing

begin  -- architecture rtl

  -- purpose: Counter MAX selection in function of the inputs
  p_cnt_char_max_mngt : process (clk, rst_n) is
  begin  -- process p_cnt_char_max_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      cnt_char_max <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- If all char are updated -> Set max at 31 (32-1)
      if(i_update_all_lcd = '1') then
        cnt_char_max <= (others => '1');

      -- Only one char is updated in this case
      elsif(i_update_one_char = '1') then
        cnt_char_max <= to_unsigned(1, cnt_char_max'length);
      end if;

    end if;
  end process p_cnt_char_max_mngt;


  -- purpose: FSM Current state update
  -- Update fsm_cs from fsm_ns
  p_fsm_cs_update : process (clk, rst_n) is
  begin  -- process p_fsm_cs_update
    if rst_n = '0' then                 -- asynchronous reset (active low)
      fsm_cs <= IDLE;
    elsif rising_edge(clk) then         -- rising clock edge
      fsm_cs <= fsm_ns;
    end if;
  end process p_fsm_cs_update;

  -- purpose: FSM Next State computation
  -- Update fsm_ns from fsm_cs and inputs
  p_fsm_ns_update : process (fsm_cs, i_update_all_lcd, i_update_one_char, rdata_val, i_poll_done, cnt_char, cnt_char_max) is
  begin  -- process p_fsm_ns_update

    case fsm_cs is

      -- In IDLE State wait for command all or one character
      when IDLE =>

        rd_en           <= '0';         -- Read Enable
        init_ongoing    <= '0';         -- INIT State ongoing
        wr_data_ongoing <= '0';         -- WR_DATA State ongoing
        o_update_done   <= '0';         -- Update done flag
        if(i_update_all_lcd = '1' or i_update_one_char = '1') then
          fsm_ns <= INIT;
        else
          fsm_ns <= IDLE;
        end if;

      -- In INIT state go directly to the next state
      when INIT =>
        rd_en           <= '0';         -- Read Enable
        init_ongoing    <= '1';         -- INIT State ongoing
        wr_data_ongoing <= '0';         -- WR_DATA State ongoing
        o_update_done   <= '0';         -- Update done flag
        fsm_ns          <= SET_DDRAM_ADDR;


      -- In this state wait for the end of the command execution with
      -- i_poll_done = '1'
      when SET_DDRAM_ADDR =>
        rd_en           <= '0';         -- Read Enable
        init_ongoing    <= '0';         -- INIT State ongoing
        wr_data_ongoing <= '0';         -- WR_DATA State ongoing
        o_update_done   <= '0';         -- Update done flag

        if(i_poll_done = '1') then
          fsm_ns <= RD_DATA;
          rd_en  <= '1';                -- Read Enable
        else
          fsm_ns <= SET_DDRAM_ADDR;
        end if;


      -- In RD_DATA state wait for the rdata_val signal and go to WR_DATA state
      when RD_DATA =>
        rd_en           <= '0';         -- Read Enable
        init_ongoing    <= '0';         -- INIT State ongoing
        wr_data_ongoing <= '0';         -- WR_DATA State ongoing
        o_update_done   <= '0';         -- Update done flag
        if(rdata_val = '1') then
          fsm_ns <= WR_DATA;
        else
          fsm_ns <= RD_DATA;
        end if;

      -- In WR_DATA state, wait until the end the polling function (polling
      -- ready) and in function of the value of the counter go to SET_DDRAM_ADDR or
      -- IDLE state
      when WR_DATA =>

        rd_en           <= '0';         -- Read Enable
        init_ongoing    <= '0';         -- INIT State ongoing
        wr_data_ongoing <= '1';         -- WR_DATA State ongoing
        o_update_done   <= '0';         -- Update done flag

        -- Case that the counter do not reach the MAX (All char update)
        if(i_poll_done = '1' and cnt_char < cnt_char_max) then
          fsm_ns <= SET_DDRAM_ADDR;

        -- Case that all char are updated
        elsif(i_poll_done = '1' and cnt_char = cnt_char_max) then
          o_update_done <= '1';         -- Update done flag
          fsm_ns        <= IDLE;
          rd_en         <= '0';         -- Read Enable
        -- Until we stay in the state until ready rise
        else
          fsm_ns <= WR_DATA;
          rd_en  <= '0';                -- Read Enable
        end if;

      when others =>
        rd_en           <= '0';         -- Read Enable
        init_ongoing    <= '0';         -- INIT State ongoing
        wr_data_ongoing <= '0';         -- WR_DATA State ongoing
        o_update_done   <= '0';         -- Update done flag
        fsm_ns          <= IDLE;

    end case;

  end process p_fsm_ns_update;


  -- purpose: DDRAM ADDR or Data Management
  -- Set DDRAM ADDR or DATA
  p_ddram_addr_data_mngt : process (clk, rst_n) is
  begin  -- process p_ddram_addr_data_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_ddram_data_or_addr <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- If all char are updated -> Set initial value of the ADDR : 0x00
      if(i_update_all_lcd = '1') then
        o_ddram_data_or_addr <= (others => '0');

      -- Only one char is updated in this case -> Get the char position (0:31)
      -- and transform it into the display DDRAM ADDR (0x00:0x0F / 0x40:0x4F)
      elsif(i_update_one_char = '1') then
        o_ddram_data_or_addr <= i_char_position(4) & "00" & i_char_position(3 downto 0);

      -- Update o_ddram_data_or_add with rdata on valid
      elsif(rdata_val = '1') then
        o_ddram_data_or_addr <= rdata;
      end if;

    end if;
  end process p_ddram_addr_data_mngt;

  -- purpose: Counter of character management
  p_cnt_mngt : process (clk, rst_n) is
  begin  -- process p_cnt_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      cnt_char <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Initialized the counter on i_update_* inputs
      if(i_update_all_lcd = '1' or i_update_one_char = '1') then
        cnt_char <= (others => '0');

      -- When a data is dread from the RAM, inc. the counter
      elsif(rdata_val = '1') then
        cnt_char <= cnt_char + 1;       -- Inc Char Counter       
      end if;

    end if;
  end process p_cnt_mngt;

  -- purpose: Commands SET_DDRAM_ADDR management
  -- Generates tge command pulse in function of the FSM State
  p_cmd_set_addr_mngt : process (clk, rst_n) is
  begin  -- process p_cmd_set_addr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_set_ddram_addr <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- SET_DDRAM command is generated when enter into the INIT state or when
      -- there are pending command the send
      if(init_ongoing = '1' or (wr_data_ongoing = '1' and i_poll_done = '1' and cnt_char < cnt_char_max)) then
        o_set_ddram_addr <= '1';
      else
        o_set_ddram_addr <= '0';
      end if;

    end if;
  end process p_cmd_set_addr_mngt;

  -- purpose: Command WR_DATA management
  -- Generate the Command WR_DATA in function of the state of the FSM
  p_cmd_wr_data_mngt : process (clk, rst_n) is
  begin  -- process p_cmd_wr_data_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_wr_data <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      o_wr_data <= rdata_val;
    end if;
  end process p_cmd_wr_data_mngt;

  -- purpose: Start pulse management
  -- Generate the start pulse output in function of the state of the FSM
  p_start_mngt : process (clk, rst_n) is
  begin  -- process p_start_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_start <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- SET_DDRAM command is generated when enter into the INIT state or when
      -- there are pending command the send
      if(init_ongoing = '1' or (wr_data_ongoing = '1' and i_poll_done = '1' and cnt_char < cnt_char_max) or rdata_val = '1') then
        o_start <= '1';
      else
        o_start <= '0';
      end if;

    end if;
  end process p_start_mngt;

end architecture rtl;
