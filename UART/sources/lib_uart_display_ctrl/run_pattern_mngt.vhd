-------------------------------------------------------------------------------
-- Title      : Run Pattern Management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : run_pattern_mngt.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-12
-- Last update: 2021-06-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-05-12  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_uart_display_ctrl;
use lib_uart_display_ctrl.pkg_uart_max7219_display_ctrl.all;

entity run_pattern_mngt is

  generic (
    G_RAM_DATA_WIDTH_STATIC   : integer := 16;
    G_RAM_ADDR_WIDTH_STATIC   : integer := 8;
    G_RAM_DATA_WIDTH_SCROLLER : integer := 8;
    G_RAM_ADDR_WIDTH_SCROLLER : integer := 8;
    G_UART_DATA_WIDTH         : integer range 5 to 9
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Commands from Sequencer
    i_run_static_pattern      : in  std_logic;  -- RUN STATIC PATTERN
    o_run_static_pattern_done : out std_logic;
    o_run_static_pattern_rdy  : out std_logic;
    o_run_static_discard      : out std_logic;

    i_run_scroller_pattern      : in  std_logic;
    o_run_scroller_pattern_done : out std_logic;
    o_run_scroller_pattern_rdy  : out std_logic;
    o_run_scroller_discard      : out std_logic;

    -- RX UART I/F
    i_rx_data : in std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0);
    i_rx_done : in std_logic;


    o_static_dyn  : out std_logic;      -- Static or Dynamic Pattern selection
    o_new_display : out std_logic;      -- Valid

    -- STATIC MNGT
    o_en_static           : out std_logic;  -- Enable Static Block
    i_ptr_equality_static : in  std_logic;  -- Static Ptr equality
    o_start_ptr_static    : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
    o_last_ptr_static     : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
    i_static_busy         : in  std_logic;

    -- SCROLLER MNGT
    i_scroller_busy          : in  std_logic;
    o_ram_start_ptr_scroller : out std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM START PTR
    o_msg_length_scroller    : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- Message Length

    i_load_tempo_scroller      : in  std_logic;
    o_load_tempo_scroller_done : out std_logic;
    o_max_tempo_cnt_scroller   : out std_logic_vector(31 downto 0)  -- Scroller Tempo
    );


end entity run_pattern_mngt;

architecture behv of run_pattern_mngt is

  -- INTERNAL SIGNALS
  signal s_run_static_pattern_rdy : std_logic;
  signal s_run_static_ongoing     : std_logic;

  signal s_run_scroller_pattern_rdy : std_logic;
  signal s_run_scroller_ongoing     : std_logic;


  signal s_start_ptr_static : std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
  signal s_last_ptr_static  : std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
  signal s_cnt_1            : integer range 0 to 1;

  signal s_ram_start_ptr_scroller : std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);
  signal s_msg_length             : std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);
  signal s_max_tempo_cnt_scroller : std_logic_vector(31 downto 0);

  signal s_load_tempo_scroller_rdy     : std_logic;
  signal s_load_tempo_scroller_ongoing : std_logic;
  signal s_cnt_3                       : integer range 0 to 4;

begin  -- architecture behv


  p_pulse_cmd_mngt : process (clk, rst_n) is
  begin  -- process p_pulse_cmd_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_run_static_pattern_rdy   <= '0';
      s_run_scroller_pattern_rdy <= '0';
      o_run_static_discard       <= '0';
      o_run_scroller_discard     <= '0';
      s_load_tempo_scroller_rdy  <= '0';

    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_run_static_pattern = '1') then

        if(i_static_busy = '0') then
          s_run_static_pattern_rdy <= '1';
        else
          o_run_static_discard <= '1';
        end if;

      elsif(i_run_scroller_pattern = '1') then

        if(i_scroller_busy = '0') then
          s_run_scroller_pattern_rdy <= '1';
        else
          o_run_scroller_discard <= '1';
        end if;

      elsif(i_load_tempo_scroller = '1') then
        s_load_tempo_scroller_rdy <= '1';

      else
        s_run_static_pattern_rdy   <= '0';
        o_run_static_discard       <= '0';
        s_run_scroller_pattern_rdy <= '0';
        o_run_scroller_discard     <= '0';
        s_load_tempo_scroller_rdy  <= '0';
      end if;

    end if;
  end process p_pulse_cmd_mngt;


  p_rx_data_mngt : process (clk, rst_n) is
  begin  -- process p_rx_data_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)

      s_run_static_ongoing      <= '0';
      s_start_ptr_static        <= (others => '0');
      s_last_ptr_static         <= (others => '0');
      s_cnt_1                   <= 0;
      o_run_static_pattern_done <= '0';
      o_static_dyn              <= '0';
      o_new_display             <= '0';

      s_run_scroller_ongoing   <= '0';
      s_ram_start_ptr_scroller <= (others => '0');
      s_msg_length             <= (others => '0');
      s_max_tempo_cnt_scroller <= (others => '0');

      s_load_tempo_scroller_ongoing <= '0';
      s_cnt_3                       <= 0;
      o_load_tempo_scroller_done    <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_run_static_pattern_rdy = '1') then
        s_run_static_ongoing <= '1';

      elsif(s_run_scroller_pattern_rdy = '1') then
        s_run_scroller_ongoing <= '1';

      elsif(s_load_tempo_scroller_rdy = '1') then
        s_load_tempo_scroller_ongoing <= '1';
      end if;


      if(s_run_static_ongoing = '1') then

        if(i_rx_done = '1') then
          if(s_cnt_1 = 0) then
            s_start_ptr_static <= i_rx_data;
            s_cnt_1            <= s_cnt_1 + 1;
          elsif(s_cnt_1 = 1) then
            s_last_ptr_static         <= i_rx_data;
            o_static_dyn              <= '0';
            o_new_display             <= '1';
            o_run_static_pattern_done <= '1';
            s_run_static_ongoing      <= '0';
          end if;
        else
          --s_cnt_1                   <= 0;
          o_run_static_pattern_done <= '0';
          o_static_dyn              <= '0';
          o_new_display             <= '0';
        end if;

      elsif(s_run_scroller_ongoing = '1') then

        if(i_rx_done = '1') then

          if(s_cnt_1 = 0) then
            s_ram_start_ptr_scroller <= i_rx_data;
            s_cnt_1                  <= s_cnt_1 + 1;
          elsif(s_cnt_1 = 1) then
            s_msg_length                <= i_rx_data;
            o_static_dyn                <= '1';
            o_new_display               <= '1';
            o_run_scroller_pattern_done <= '1';
            s_run_scroller_ongoing      <= '0';
          end if;

        else
          o_static_dyn                <= '0';
          o_new_display               <= '0';
          o_run_scroller_pattern_done <= '0';
        end if;

      -- Load Tempo Scroller Mngt
      elsif(s_load_tempo_scroller_ongoing = '1') then

        if(i_rx_done = '1') then
          if(s_cnt_3 < 4) then

            -- First Byte received == MSB - Last byte == LSB
            s_max_tempo_cnt_scroller(7 downto 0)  <= i_rx_data;
            s_max_tempo_cnt_scroller(31 downto 8) <= s_max_tempo_cnt_scroller(23 downto 0);
            s_cnt_3                               <= s_cnt_3 + 1;  --Inc cnt
          else
            s_load_tempo_scroller_ongoing <= '0';
            o_load_tempo_scroller_done    <= '1';
          end if;

        elsif(s_cnt_3 = 4) then
          s_load_tempo_scroller_ongoing <= '0';
          o_load_tempo_scroller_done    <= '1';
        end if;

      -- No Command ongoing
      else
        s_cnt_1                     <= 0;
        o_new_display               <= '0';
        o_run_static_pattern_done   <= '0';
        o_static_dyn                <= '0';
        o_run_scroller_pattern_done <= '0';
        s_cnt_3                     <= 0;
        o_load_tempo_scroller_done  <= '0';
      end if;
    end if;
  end process p_rx_data_mngt;



  -- Outputs Affectation
  o_en_static              <= '1';      -- enable by default
  o_run_static_pattern_rdy <= s_run_static_pattern_rdy;
  o_start_ptr_static       <= s_start_ptr_static;
  o_last_ptr_static        <= s_last_ptr_static;

  o_run_scroller_pattern_rdy <= s_run_scroller_pattern_rdy;

  o_ram_start_ptr_scroller <= s_ram_start_ptr_scroller;
  o_msg_length_scroller    <= s_msg_length;
  o_max_tempo_cnt_scroller <= s_max_tempo_cnt_scroller;

end architecture behv;
