-------------------------------------------------------------------------------
-- Title      : MAX7219 Display Sequencer
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_display_sequencer.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-01-16
-- Last update: 2022-03-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 display Sequencer
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-01-16  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity max7219_display_sequencer is

  generic (
    G_FIFO_DEPTH              : integer   := 10;    -- Fifo DEPTH
    G_RAM_ADDR_WIDTH_STATIC   : integer   := 8;     -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH_STATIC   : integer   := 16;    -- RAM DATA WIDTH
    G_RAM_ADDR_WIDTH_SCROLLER : integer   := 8;     -- RAM ADDR WITH
    G_RAM_DATA_WIDTH_SCROLLER : integer   := 8;     -- RAM DATA WIDTH
    G_USE_ALTERA              : std_logic := '0');  -- USE Altera Techno
  port (
    clk   : in std_logic;                           -- Clock
    rst_n : in std_logic;                           -- Asynchronos reset

    i_static_dyn  : in std_logic;       -- Static or Dynamic selection
    i_new_display : in std_logic;       -- Display Static or Dyn Valid


    -- Config I/F
    i_new_config_val : in  std_logic;   -- CONFIG. VALID
    i_config_done    : in  std_logic;   -- CONFIG. DONE
    o_new_config_val : out std_logic;   -- New Config to CONFIG Block


    -- Static I/F
    i_start_ptr : in std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
    i_last_ptr  : in std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);

    i_ptr_equality : in  std_logic;
    o_start_ptr    : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
    o_last_ptr     : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
    o_static_val   : out std_logic;

    -- Scroller I/F
    i_ram_start_ptr : in std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);
    i_msg_length    : in std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);

    i_busy_scroller : in std_logic;

    o_ram_start_ptr : out std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);
    o_msg_length    : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);
    o_start_scroll  : out std_logic;

    -- MUX SEL
    o_mux_sel : out std_logic_vector(1 downto 0)

    );

end entity max7219_display_sequencer;

architecture behv of max7219_display_sequencer is

  -- TYPES
  type t_states is (IDLE, WAIT_CMD, CONFIG, STATIC, SCROLL);  -- States
  type t_static_array is array (0 to G_FIFO_DEPTH - 1) of std_logic_vector(G_RAM_ADDR_WIDTH_STATIC -1 downto 0);
  type t_scroller_addr_array is array (0 to G_FIFO_DEPTH - 1) of std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);
  type t_scroller_data_array is array (0 to G_FIFO_DEPTH - 1) of std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);
  type t_next_cmd_array is array (0 to G_FIFO_DEPTH - 1) of std_logic_vector(1 downto 0);





  -- Internal Signals
  signal s_current_state : t_states;
  signal s_next_state    : t_states;

  signal s_config_done        : std_logic;
  signal s_config_done_r_edge : std_logic;  -- rising Edge of Config. Done

  signal s_new_config_val          : std_logic;  -- Pipe i_new_config_val
  signal s_new_config_val_r_edge   : std_logic;  -- Rising edge of i_new_config_val
  signal s_new_config_val_from_seq : std_logic;  -- New Config. Val from Sequencer

  signal s_new_display        : std_logic;  -- New display pipe
  signal s_new_display_r_edge : std_logic;  -- New Display rising edge

  -- Internal Writes and Read Ptrs
  signal s_cmd_wr_ptr    : integer range 0 to G_FIFO_DEPTH - 1;
  signal s_cmd_rd_ptr    : integer range 0 to G_FIFO_DEPTH - 1;
  signal s_cmd_fifo_cnt  : integer range 0 to G_FIFO_DEPTH - 1;
  signal s_cmd_wr_ptr_up : std_logic;
  signal s_cmd_rd_ptr_up : std_logic;

  signal s_static_wr_ptr : integer range 0 to G_FIFO_DEPTH - 1;
  signal s_static_rd_ptr : integer range 0 to G_FIFO_DEPTH - 1;


  signal s_scroller_wr_ptr : integer range 0 to G_FIFO_DEPTH - 1;
  signal s_scroller_rd_ptr : integer range 0 to G_FIFO_DEPTH - 1;


  signal s_next_cmd_config   : std_logic;
  signal s_next_cmd_static   : std_logic;
  signal s_next_cmd_scroller : std_logic;


  -- ARRAYS
  signal s_start_ptr_static_array    : t_static_array;
  signal s_last_ptr_static_array     : t_static_array;
  signal s_ram_start_scroller_array  : t_scroller_addr_array;
  signal s_msg_length_scroller_array : t_scroller_data_array;
  signal s_cmd_array                 : t_next_cmd_array;

  signal s_fifo_full  : std_logic;
  signal s_fifo_empty : std_logic;

  signal s_cmd_val  : std_logic;                     -- Command Val
  signal s_cmd_type : std_logic_vector(1 downto 0);  -- Command Type
  signal s_mux_sel  : std_logic_vector(1 downto 0);  -- MUX Selection

  -- STATIC signals
  signal s_start_ptr : std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
  signal s_last_ptr  : std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);

  -- SCROLLER signals
  signal s_ram_start_ptr : std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);
  signal s_msg_length    : std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);

  signal s_ptr_equality_r_edge : std_logic;
  signal s_ptr_equality        : std_logic;

  signal s_busy_scroller        : std_logic;
  signal s_busy_scroller_f_edge : std_logic;

begin  -- architecture behv


  p_pipe_inputs : process (clk, rst_n) is
  begin  -- process p_pipe_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_config_done    <= '0';
      s_ptr_equality   <= '0';
      s_busy_scroller  <= '0';
      s_new_display    <= '0';
      s_new_config_val <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_config_done    <= i_config_done;
      s_ptr_equality   <= i_ptr_equality;
      s_busy_scroller  <= i_busy_scroller;
      s_new_display    <= i_new_display;
      s_new_config_val <= i_new_config_val;
    end if;
  end process p_pipe_inputs;

  -- Rising Edge detection
  s_config_done_r_edge    <= i_config_done and not s_config_done;
  s_ptr_equality_r_edge   <= i_ptr_equality and not s_ptr_equality;
  s_new_display_r_edge    <= i_new_display and not s_new_display;
  s_new_config_val_r_edge <= i_new_config_val and not s_new_config_val;

  -- Falling Edge detection
  s_busy_scroller_f_edge <= not i_busy_scroller and s_busy_scroller;



  -- purpose: Current State management
  p_curr_state_mngt : process (clk, rst_n) is
  begin  -- process p_curr_state_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_current_state <= IDLE;
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_current_state <= s_next_state;
    end if;
  end process p_curr_state_mngt;

  -- Generation of FSM with calculation of next state in a combinatory process
  g_fsm_gen_no_altera : if G_USE_ALTERA = '0' generate

    --! fsm_extract
    p_next_state_mngt : process (s_current_state, s_config_done_r_edge, s_next_cmd_config, s_next_cmd_static, s_next_cmd_scroller, s_ptr_equality_r_edge, s_busy_scroller_f_edge) is
    begin  -- process p_next_state_mngt

      case s_current_state is
        when IDLE =>
          s_next_state <= CONFIG;

        when CONFIG =>
          if(s_config_done_r_edge = '1') then
            s_next_state <= WAIT_CMD;
          end if;

        when WAIT_CMD =>
          if(s_next_cmd_config = '1') then
            s_next_state <= CONFIG;
          elsif(s_next_cmd_static = '1') then
            s_next_state <= STATIC;
          elsif(s_next_cmd_scroller = '1') then
            s_next_state <= SCROLL;
          end if;

        when STATIC =>
          if(s_ptr_equality_r_edge = '1') then
            s_next_state <= WAIT_CMD;
          end if;

        when SCROLL =>
          if(s_busy_scroller_f_edge = '1') then
            s_next_state <= WAIT_CMD;
          end if;

        when others => null;

      end case;
    end process p_next_state_mngt;

  end generate g_fsm_gen_no_altera;


  g_fsm_gen_altera : if G_USE_ALTERA = '1' generate
    --! fsm_extract
    p_next_state_mngt : process (clk, rst_n) is
    begin  -- process p_next_state_mngt
      if rst_n = '0' then                 -- asynchronous reset (active low)
        s_next_state <= IDLE;
      elsif clk'event and clk = '1' then  -- rising clock edge

        case s_current_state is
          when IDLE =>
            s_next_state <= CONFIG;

          when CONFIG =>
            if(s_config_done_r_edge = '1') then
              s_next_state <= WAIT_CMD;
            end if;

          when WAIT_CMD =>
            if(s_next_cmd_config = '1') then
              s_next_state <= CONFIG;
            elsif(s_next_cmd_static = '1') then
              s_next_state <= STATIC;
            elsif(s_next_cmd_scroller = '1') then
              s_next_state <= SCROLL;
            end if;

          when STATIC =>
            if(s_ptr_equality_r_edge = '1') then
              s_next_state <= WAIT_CMD;
            end if;

          when SCROLL =>
            if(s_busy_scroller_f_edge = '1') then
              s_next_state <= WAIT_CMD;
            end if;

          when others => null;

        end case;

      end if;
    end process p_next_state_mngt;

  end generate g_fsm_gen_altera;




  p_new_cmd_decod : process (clk, rst_n) is
  begin  -- process p_new_cmd_decod
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cmd_val       <= '0';
      s_cmd_type      <= "11";          -- Config selected by default
      s_start_ptr     <= (others => '0');
      s_last_ptr      <= (others => '0');
      s_ram_start_ptr <= (others => '0');
      s_msg_length    <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_cmd_val <= '0';                 -- Pulse
      if(s_new_config_val_r_edge = '1') then
        s_cmd_type <= "11";
        s_cmd_val  <= '1';
      elsif(s_new_display_r_edge = '1') then
        -- Static selected
        if(i_static_dyn = '0') then
          s_cmd_type  <= "01";
          s_start_ptr <= i_start_ptr;
          s_last_ptr  <= i_last_ptr;
        else
          s_cmd_type      <= "10";
          s_ram_start_ptr <= i_ram_start_ptr;
          s_msg_length    <= i_msg_length;
        end if;
        s_cmd_val <= '1';
      end if;

    end if;
  end process p_new_cmd_decod;



  -- CMD Fifo Write Management
  p_fifo_cmd_write : process (clk, rst_n) is
  begin  -- process p_fifo_cmd_write
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cmd_array     <= (others => (others => '0'));
      s_cmd_wr_ptr    <= 0;
      s_cmd_wr_ptr_up <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_cmd_wr_ptr_up <= '0';
      -- Write Authorized
      if(s_fifo_full = '0') then
        if(s_cmd_val = '1') then
          s_cmd_array(s_cmd_wr_ptr) <= s_cmd_type;  -- Save Command Type
          if(s_cmd_wr_ptr < G_FIFO_DEPTH - 1) then
            s_cmd_wr_ptr <= s_cmd_wr_ptr + 1;       -- Inc Write Ptr
          --s_cmd_wr_ptr_up <= '1';
          else
            s_cmd_wr_ptr <= 0;
          end if;
          s_cmd_wr_ptr_up <= '1';                   -- Up in any way
        end if;
      end if;


    end if;
  end process p_fifo_cmd_write;

  -- CMD Fifo Read Management
  p_fifo_cmd_read : process (clk, rst_n) is
  begin  -- process p_fifo_cmd_read
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cmd_rd_ptr        <= 0;
      s_next_cmd_config   <= '0';
      s_next_cmd_static   <= '0';
      s_next_cmd_scroller <= '0';
      s_cmd_rd_ptr_up     <= '0';

      s_static_rd_ptr   <= 0;
      s_scroller_rd_ptr <= 0;
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_next_cmd_config   <= '0';       -- Pulse
      s_next_cmd_static   <= '0';       -- Pulse
      s_next_cmd_scroller <= '0';       -- Pulse
      s_cmd_rd_ptr_up     <= '0';
      -- Only when Fifo Not Empty
      if(s_fifo_empty = '0') then


        if(s_next_state = WAIT_CMD) then
          --if(s_current_state = WAIT_CMD) then
          if(s_cmd_array(s_cmd_rd_ptr) = "11") then
            s_next_cmd_config <= '1';
          elsif(s_cmd_array(s_cmd_rd_ptr) = "01") then
            s_next_cmd_static <= '1';
          elsif(s_cmd_array(s_cmd_rd_ptr) = "10") then
            s_next_cmd_scroller <= '1';
          else
            s_next_cmd_config   <= '0';
            s_next_cmd_static   <= '0';
            s_next_cmd_scroller <= '0';
          end if;
          --end if;

          -- READ PTR MNGT -- TBD :!\
          if(s_next_cmd_config = '1' or s_next_cmd_static = '1' or s_next_cmd_scroller = '1') then
            if(s_cmd_rd_ptr < G_FIFO_DEPTH - 1) then
              s_cmd_rd_ptr <= s_cmd_rd_ptr + 1;
            --s_cmd_rd_ptr_up <= '1';
            else
              s_cmd_rd_ptr <= 0;
            end if;
            s_cmd_rd_ptr_up <= '1';
          end if;


          if(s_next_cmd_static = '1') then
            if(s_static_rd_ptr < G_FIFO_DEPTH - 1) then
              s_static_rd_ptr <= s_static_rd_ptr + 1;
            else
              s_static_rd_ptr <= 0;
            end if;
          end if;

          if(s_next_cmd_scroller = '1') then
            if(s_scroller_rd_ptr < G_FIFO_DEPTH - 1) then
              s_scroller_rd_ptr <= s_scroller_rd_ptr + 1;
            else
              s_scroller_rd_ptr <= 0;
            end if;
          end if;

        end if;  -- End if(s_next_state = WAIT_CMD)

      end if;

    end if;
  end process p_fifo_cmd_read;

  -- Save each WR access or Read Access to FIFO CMD
  p_cmd_fifo_cnt : process (clk, rst_n) is
  begin  -- process p_cmd_fifo_cnt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cmd_fifo_cnt <= 0;
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Case Write is prio
      -- if(s_cmd_wr_ptr_up = '1') then
      --   if(s_cmd_fifo_cnt < G_FIFO_DEPTH - 1) then
      --     s_cmd_fifo_cnt <= s_cmd_fifo_cnt + 1;
      --   end if;
      -- elsif(s_cmd_rd_ptr_up = '1') then
      --   if(s_cmd_fifo_cnt > 0) then
      --     s_cmd_fifo_cnt <= s_cmd_fifo_cnt - 1;
      --   end if;
      -- end if;

      -- Case Write Only or Read Only - If Write and Read => +1 -1 = No Inc No
      -- downinc
      if(s_cmd_wr_ptr_up = '1' and s_cmd_rd_ptr_up = '0') then
        if(s_cmd_fifo_cnt < G_FIFO_DEPTH - 1) then
          s_cmd_fifo_cnt <= s_cmd_fifo_cnt + 1;
        end if;
      elsif(s_cmd_rd_ptr_up = '1' and s_cmd_wr_ptr_up = '0') then
        if(s_cmd_fifo_cnt > 0) then
          s_cmd_fifo_cnt <= s_cmd_fifo_cnt - 1;
        end if;
      end if;

      -- if(s_cmd_rd_ptr_up = '1') then
      --   if(s_cmd_fifo_cnt > 0) then
      --     s_cmd_fifo_cnt <= s_cmd_fifo_cnt - 1;
      --   end if;
      -- elsif(s_cmd_wr_ptr_up = '1') then
      --   if(s_cmd_fifo_cnt < G_FIFO_DEPTH) then
      --     s_cmd_fifo_cnt <= s_cmd_fifo_cnt + 1;
      --   end if;
      -- end if;

      -- Case No priority between WR and RD
      -- if(s_cmd_wr_ptr_up = '1') then
      --   if(s_cmd_fifo_cnt < G_FIFO_DEPTH) then
      --     s_cmd_fifo_cnt <= s_cmd_fifo_cnt + 1;
      --   end if;
      -- end if;

      -- if(s_cmd_rd_ptr_up = '1') then
      --   if(s_cmd_fifo_cnt > 0) then
      --     s_cmd_fifo_cnt <= s_cmd_fifo_cnt - 1;
      --   end if;
      -- end if;

    end if;
  end process p_cmd_fifo_cnt;

  p_fifo_cmd_status_comb: process (s_cmd_fifo_cnt) is
  begin  -- process p_fifo_cmd_status_comb
    -- FIFO Full mngt
      if(s_cmd_fifo_cnt = G_FIFO_DEPTH - 1) then
        s_fifo_full <= '1';
      else
        s_fifo_full <= '0';
      end if;

      if(s_cmd_fifo_cnt = 0) then
        s_fifo_empty <= '1';
      else
        s_fifo_empty <= '0';
      end if;
  end process p_fifo_cmd_status_comb;
  
  -- purpose: Fifo Full & Empty Management 
  -- p_fifo_cmd_status : process (clk, rst_n) is
  -- begin  -- process p_fifo_cmd_status
  --   if rst_n = '0' then                 -- asynchronous reset (active low)
  --     s_fifo_full  <= '0';
  --     s_fifo_empty <= '1';
  --   elsif clk'event and clk = '1' then  -- rising clock edge

  --     -- FIFO Full mngt
  --     if(s_cmd_fifo_cnt = G_FIFO_DEPTH - 1) then
  --       s_fifo_full <= '1';
  --     else
  --       s_fifo_full <= '0';
  --     end if;

  --     -- FIFO Empty mngt
  --     --if(s_cmd_wr_ptr = s_cmd_rd_ptr) then
  --     --if(s_cmd_wr_ptr - s_cmd_rd_ptr = 0) then
  --     if(s_cmd_fifo_cnt = 0) then
  --       s_fifo_empty <= '1';
  --     else
  --       s_fifo_empty <= '0';
  --     end if;

  --   end if;
  -- end process p_fifo_cmd_status;



  p_fifo_data_static_write : process (clk, rst_n) is
  begin  -- process p_fifo_data_static_write
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start_ptr_static_array <= (others => (others => '0'));
      s_last_ptr_static_array  <= (others => (others => '0'));
      s_static_wr_ptr          <= 0;
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_fifo_full = '0') then
        if(s_cmd_val = '1' and s_cmd_type = "01") then
          s_start_ptr_static_array(s_static_wr_ptr) <= s_start_ptr;
          s_last_ptr_static_array(s_static_wr_ptr)  <= s_last_ptr;

          if(s_static_wr_ptr < G_FIFO_DEPTH - 1) then
            s_static_wr_ptr <= s_static_wr_ptr + 1;  -- Inc Ptr
          else
            s_static_wr_ptr <= 0;
          end if;

        end if;
      end if;

    end if;
  end process p_fifo_data_static_write;



  p_fifo_data_scroller_write : process (clk, rst_n) is
  begin  -- process p_fifo_data_scroller_write
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_ram_start_scroller_array  <= (others => (others => '0'));
      s_msg_length_scroller_array <= (others => (others => '0'));
      s_scroller_wr_ptr           <= 0;
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_fifo_full = '0') then
        if(s_cmd_val = '1' and s_cmd_type = "10") then
          s_ram_start_scroller_array(s_scroller_wr_ptr)  <= s_ram_start_ptr;
          s_msg_length_scroller_array(s_scroller_wr_ptr) <= s_msg_length;

          if(s_scroller_wr_ptr < G_FIFO_DEPTH - 1) then
            s_scroller_wr_ptr <= s_scroller_wr_ptr + 1;  -- Inc Ptr
          else
            s_scroller_wr_ptr <= 0;
          end if;

        end if;
      end if;


    end if;
  end process p_fifo_data_scroller_write;



  -- Management of outputs
  p_outputs_mngt : process (clk, rst_n) is
  begin  -- process p_outputs_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_new_config_val_from_seq <= '0';

      o_static_val    <= '0';
      o_start_ptr     <= (others => '0');
      o_last_ptr      <= (others => '0');
      o_start_scroll  <= '0';
      o_ram_start_ptr <= (others => '0');
      o_msg_length    <= (others => '0');

      s_mux_sel <= "11";                -- Config. selected by default
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_new_config_val_from_seq <= '0';
      o_static_val              <= '0';
      o_start_ptr               <= (others => '0');
      o_last_ptr                <= (others => '0');
      o_start_scroll            <= '0';
      o_ram_start_ptr           <= (others => '0');
      o_msg_length              <= (others => '0');

      case s_current_state is
        -- when IDLE =>


        -- when CONFIG =>
        --   --if(s_next_cmd_config = '1'

        when WAIT_CMD =>
          if(s_next_cmd_config = '1') then
            s_new_config_val_from_seq <= '1';
            s_mux_sel                 <= "11";
          elsif(s_next_cmd_static = '1') then
            o_static_val <= '1';
            o_start_ptr  <= s_start_ptr_static_array(s_static_rd_ptr);
            o_last_ptr   <= s_last_ptr_static_array(s_static_rd_ptr);
            s_mux_sel    <= "01";
          elsif(s_next_cmd_scroller = '1') then
            o_start_scroll  <= '1';
            o_ram_start_ptr <= s_ram_start_scroller_array(s_scroller_rd_ptr);
            o_msg_length    <= s_msg_length_scroller_array(s_scroller_rd_ptr);
            s_mux_sel       <= "10";
          end if;

        -- when STATIC =>

        -- when SCROLL =>


        when others => null;
      end case;


    end if;
  end process p_outputs_mngt;


  -- Outputs affectation
  o_mux_sel        <= s_mux_sel;        --s_cmd_type;
  o_new_config_val <= s_new_config_val_from_seq;


end architecture behv;
