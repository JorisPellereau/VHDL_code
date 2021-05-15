-------------------------------------------------------------------------------
-- Title      : Sequencer UART Command
-- Project    : 
-------------------------------------------------------------------------------
-- File       : sequencer_uart_cmd.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-07
-- Last update: 2021-05-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-05-07  1.0      jorisp  Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_uart_display_ctrl;
use lib_uart_display_ctrl.pkg_uart_max7219_display_ctrl.all;


entity sequencer_uart_cmd is

  generic (
    G_NB_CMD          : integer              := 4;  -- Command Number
    G_UART_DATA_WIDTH : integer range 5 to 9 := 8);

  port (
    clk           : in std_logic;
    rst_n         : in std_logic;
    i_cmd_pulses  : in std_logic_vector(G_NB_CMD - 1 downto 0);
    i_cmd_discard : in std_logic;

    o_rx_data_sel : out std_logic;      --RX Data from UART RX Mux selector

    -- INIT Static RAM
    i_init_static_ram_done : in  std_logic;
    o_init_static_ram      : out std_logic;  -- Init Static RAM Command

    -- LOAD Static RAM
    o_load_pattern_static : out std_logic;  -- Command Load Pattern Static


    --i_load_pattern_static_rdy     : in  std_logic;  -- Load Pattern Static READY
    --i_load_pattern_static_discard : in  std_logic;  --Load Pattern Static Rejected
    i_load_pattern_static_done : in std_logic;  -- Load Pattern Static Done

    -- INIT Scroller RAM
    i_init_scroller_ram_done : in  std_logic;
    o_init_scroller_ram      : out std_logic;  -- Init Scroller RAM Command

    -- LOAD Scroller RAM
    o_load_pattern_scroller : out std_logic;  -- Command Load Pattern Scroller


    --i_load_pattern_scroller_rdy     : in  std_logic;  --Load Pattern Scroller READY
    --i_load_pattern_scroller_discard : in  std_logic;  -- Load Pattern Scroller Rejected
    i_load_pattern_scroller_done : in std_logic;  -- Commands LOAD Scroller done

    -- LOAD_CONFIG
    o_load_config      : out std_logic;  -- Command Load Matrix Config
    i_load_config_done : in  std_logic;  -- Command done

    -- UPDATE_CONFIG
    o_update_config      : out std_logic;  -- Command Update config
    i_update_config_done : in  std_logic;  -- Command done

    -- RUN_PATTERN_STATIC
    o_run_pattern_static         : out std_logic;
    i_run_pattern_static_rdy     : in  std_logic;
    i_run_pattern_static_done    : in  std_logic;
    i_run_pattern_static_discard : in  std_logic;

    -- RUN_PATTERN_SCROLLER
    o_run_pattern_scroller         : out std_logic;
    i_run_pattern_scroller_rdy     : in  std_logic;
    i_run_pattern_scroller_done    : in  std_logic;
    i_run_pattern_scroller_discard : in  std_logic;


    -- TX Uart commands
    i_tx_done       : in  std_logic;
    o_tx_uart_start : out std_logic;
    o_tx_data       : out std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0)

    );

end entity sequencer_uart_cmd;


architecture behv of sequencer_uart_cmd is


  -- INTERNAL Signals
  -- Commands
  signal s_init_static_ram     : std_logic;
  signal s_init_scroller_ram   : std_logic;
  signal s_load_pattern_static : std_logic;

  signal s_load_pattern_scroller : std_logic;

  signal s_tx_uart_start : std_logic;
  signal s_tx_data       : std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0);

  signal s_resp_ongoing : std_logic;

  signal s_cnt_tx_data : integer;
  signal s_resp_done   : std_logic;

  signal s_rx_data_sel : std_logic;     -- Selection of RX UART mux

  signal s_tx_done        : std_logic;  -- Pipe i_tx_done
  signal s_tx_done_r_edge : std_logic;  -- Rising Edge detection

  signal s_first_access : std_logic;

  signal s_index_resp : integer;

  signal s_load_matrix   : std_logic;
  signal s_update_matrix : std_logic;

  signal s_run_pattern_static : std_logic;

  --signal s_load_pattern_static_rdy : std_logic;

begin  -- architecture behv


  p_pipe_in : process (clk, rst_n) is
  begin  -- process p_pipe_in
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_tx_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_tx_done <= i_tx_done;
    end if;
  end process p_pipe_in;

  s_tx_done_r_edge <= i_tx_done and not s_tx_done;

  -- Pulses decoder
  p_pulses_decoder : process (clk, rst_n) is
  begin  -- process p_pulses_decoder
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_init_static_ram       <= '0';
      s_init_scroller_ram     <= '0';
      s_load_pattern_static   <= '0';
      s_rx_data_sel           <= '0';
      s_load_pattern_scroller <= '0';
      s_load_matrix           <= '0';
      s_update_matrix         <= '0';
      s_run_pattern_static    <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Wait for Pulses
      -- INIT_RAM_STATIC command
      if(i_cmd_pulses = conv_std_logic_vector(1, i_cmd_pulses'length)) then
        s_init_static_ram <= '1';
        s_rx_data_sel     <= '0';

      -- INIT_RAM_SCROLLER command
      elsif(i_cmd_pulses = conv_std_logic_vector(2, i_cmd_pulses'length)) then
        s_init_scroller_ram <= '1';
        s_rx_data_sel       <= '0';

      -- LOAD_PATTERN_STATIC command
      elsif(i_cmd_pulses = conv_std_logic_vector(16, i_cmd_pulses'length)) then
        s_load_pattern_static <= '1';
        s_rx_data_sel         <= '1';   -- Change mux selector


      -- LOAD_PATTERN_SCROLL
      elsif(i_cmd_pulses = conv_std_logic_vector(32, i_cmd_pulses'length)) then
        s_load_pattern_scroller <= '1';
        s_rx_data_sel           <= '1';  -- Change mux selector

      -- LOAD PATTER Static Done
      elsif(i_load_pattern_static_done = '1') then
        s_rx_data_sel <= '0';  -- Change mux selector - Back on initial

      elsif(i_load_pattern_scroller_done = '1') then
        s_rx_data_sel <= '0';  -- Change mux selector - Back on initial

      -- LOAD_MATRIX_CONFIG
      elsif(i_cmd_pulses = conv_std_logic_vector(8, i_cmd_pulses'length)) then
        s_load_matrix <= '1';
        s_rx_data_sel <= '1';           -- Change mux selector

      -- UPDATE_MATRIX_CONFIG
      elsif(i_cmd_pulses = conv_std_logic_vector(4, i_cmd_pulses'length)) then
        s_update_matrix <= '1';
        s_rx_data_sel   <= '0';         -- Change mux selector

      -- LOAD_MATRIX_CONFIG done
      elsif(i_load_config_done = '1') then
        s_rx_data_sel <= '0';           -- Change mux selector

      -- RUN_PATTERN_STATIC
      elsif(i_cmd_pulses = conv_std_logic_vector(64, i_cmd_pulses'length)) then
        s_run_pattern_static <= '1';
        s_rx_data_sel        <= '0';    -- Change mux selector

      -- RUN_PATTERN_STATIC RDY
      elsif(i_run_pattern_static_rdy = '1') then
        s_rx_data_sel <= '1';           -- Change mux selector


      elsif(i_run_pattern_static_done = '1') then
        s_rx_data_sel <= '0';           -- Change mux selector

        -- LOAD_PATTERN_STATIC RDY
        --elsif(i_load_pattern_static_rdy = '1') then
        --s_load_pattern_static_rdy <= '1';
        --  s_rx_data_sel <= '1';           -- Change mux selector

        -- LOAD_PATTERN_STATIC NOT RDY
        --elsif(i_load_pattern_static_discard = '1') then
        --s_load_pattern_static_discard <= '1';
        --  s_rx_data_sel <= '0';           -- Change mux selector

        -- LOAD_PATTERN_SCROLL RDY
        --elsif(i_load_pattern_scroller_rdy = '1') then
        --  s_rx_data_sel <= '1';           -- Change mux selector

        -- LOAD_PATTERN_SCROLL NOT RDY  
        --elsif(i_load_pattern_scroller_discard = '1') then
        --  s_rx_data_sel <= '0';           -- Change mux selector

      else
        s_init_static_ram       <= '0';
        s_init_scroller_ram     <= '0';
        s_load_pattern_static   <= '0';
        s_load_pattern_scroller <= '0';
        s_load_matrix           <= '0';
        s_update_matrix         <= '0';
        s_run_pattern_static    <= '0';
      end if;



    end if;
  end process p_pulses_decoder;


  -- TX UART Response management
  p_tx_uart_mngt : process (clk, rst_n) is
  begin  -- process p_tx_uart_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_tx_data       <= (others => '0');
      s_tx_uart_start <= '0';
      s_resp_ongoing  <= '0';
      s_cnt_tx_data   <= 0;
      s_resp_done     <= '0';
      s_first_access  <= '0';
      s_index_resp    <= 0;
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Check ack and latch ack until end of TX
      if(s_resp_ongoing = '0') then

        if(i_init_static_ram_done = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 0;

        elsif(i_init_scroller_ram_done = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 1;

        elsif(i_cmd_discard = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 2;

        -- TBD a RM ????
        -- Resp : LOAD_STATIC_RDY
        elsif(s_load_pattern_static = '1') then  -- TBD AJOUTER PATTERN LU EN COURS
          s_resp_ongoing <= '1';
          s_index_resp   <= 3;

        -- Resp : LOAD_STATIC_DONE
        elsif(i_load_pattern_static_done = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 5;

        -- TBD A RM ??????
        -- Resp : LOAD_SCROLL_RDY
        elsif(s_load_pattern_scroller = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 6;

        -- Rest : LOAD_SCROLL_DONE
        elsif(i_load_pattern_scroller_done = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 8;

        -- Resp : LOAD_MATRIX_RDY
        elsif(s_load_matrix = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 9;

        -- Resp : LOAD_MATRIX_DONE
        elsif(i_load_config_done = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 10;

        -- Resp : UPDATE_MATRIX_DONE
        elsif(i_update_config_done = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 11;



        -- Resp : STATIC_PTRN_RDY
        elsif(i_run_pattern_static_rdy = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 12;

        -- Resp : STATIC_PTRN_NOT_RDY
        elsif(i_run_pattern_static_discard = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 13;


        elsif(i_run_pattern_static_done = '1') then
          s_resp_ongoing <= '1';
          s_index_resp   <= 14;
          -- Resp : SCROLL_PTRN_RDY
          --elsif(i_load_pattern_scroller_rdy = '1') then
          --  s_resp_ongoing <= '1';
          --  s_index_resp   <= 15;

        -- Resp : SCROLL_PTRN_NOT_RDY
        --elsif(i_load_pattern_scroller_discard = '1') then
        --  s_resp_ongoing <= '1';
        -- s_index_resp   <= 16;
        end if;


      end if;


      -- Send Respons to send to TX Uart
      if(s_resp_ongoing = '1') then

        if(s_cnt_tx_data < C_RESP_LENGTH) then

          if(s_first_access = '0') then
            s_tx_data       <= C_RESP_LIST(s_index_resp)(s_cnt_tx_data);
            s_cnt_tx_data   <= s_cnt_tx_data + 1;  -- Inc Read ptr
            s_tx_uart_start <= '1';
            s_first_access  <= '1';

          else
            s_tx_uart_start <= '0';
            if(s_tx_done_r_edge = '1') then
              s_tx_data       <= C_RESP_LIST(s_index_resp)(s_cnt_tx_data);
              s_cnt_tx_data   <= s_cnt_tx_data + 1;  -- Inc Read ptr
              s_tx_uart_start <= '1';
            else
              s_tx_uart_start <= '0';
            end if;

          end if;

        else
          s_tx_uart_start <= '0';
          if(s_tx_done_r_edge = '1') then
            s_first_access <= '0';
            s_resp_done    <= '1';
            s_resp_ongoing <= '0';
            s_cnt_tx_data  <= 0;
          end if;
        end if;
      else
        s_resp_done <= '0';
      end if;

    end if;
  end process p_tx_uart_mngt;




  -- Memory of Last command ongoing



  -- Outputs affectations
  o_init_static_ram       <= s_init_static_ram;
  o_init_scroller_ram     <= s_init_scroller_ram;
  o_load_pattern_static   <= s_load_pattern_static;  -- TBD Ajouter filtre si ongoing
  o_tx_data               <= s_tx_data;
  o_tx_uart_start         <= s_tx_uart_start;
  o_rx_data_sel           <= s_rx_data_sel;
  o_load_pattern_scroller <= s_load_pattern_scroller;
  o_load_config           <= s_load_matrix;
  o_update_config         <= s_update_matrix;
  o_run_pattern_static    <= s_run_pattern_static;

end architecture behv;
