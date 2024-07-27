-------------------------------------------------------------------------------
-- Title      : Core of the WATCH FPGA
-- Project    : 
-------------------------------------------------------------------------------
-- File       : watch_core.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-05-12
-- Last update: 2024-05-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-05-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_top_watch;
use lib_top_watch.watch_pkg.all;

library lib_max7219_interface;

entity watch_core is

  port (
    clk_sys   : in std_logic;           -- Clock System
    rst_n_sys : in std_logic;           -- Reset of Clock System clock domain

    -- UART I/F
    uart_rx : in  std_logic;            -- UART RX
    uart_tx : out std_logic;

    -- MAX7219 I/F
    max7219_load : out std_logic;       -- LOAD command
    max7219_data : out std_logic;       -- DATA to send
    max7219_clk  : out std_logic        -- CLK
    );

end entity watch_core;

architecture rtl of watch_core is

  -- == INTERNAL Signals ==
  signal update_watch        : std_logic;  -- Update Watch Pulse
  signal compute_next_update : std_logic;  -- Compute next update pulse

  signal hours_tens_digit  : std_logic_vector(1 downto 0);  -- Hour tens digit
  signal hours_unity_digit : std_logic_vector(2 downto 0);  -- Hour unity digit
  signal mins_tens_digit   : std_logic_vector(2 downto 0);  -- Minutes tens digit
  signal mins_unity_digit  : std_logic_vector(3 downto 0);  -- Minutes unity digit
  signal watch_24h_done    : std_logic;                     -- Watch 24h next update done

  signal watch24h_data_array : t_uint_data_array(0 to C_NB_UINT2MAX7219_DATA - 1);  -- Array of data from watch24h block resize on 4 bits per vector
  signal char_data_0_array   : t_char_data_array(0 to C_NB_UINT2MAX7219_DATA - 1);  -- Array of Char DATA 0
  signal char_data_1_array   : t_char_data_array(0 to C_NB_UINT2MAX7219_DATA - 1);  -- Array of Char DATA 1
  signal char_data_2_array   : t_char_data_array(0 to C_NB_UINT2MAX7219_DATA - 1);  -- Array of Char DATA 2
  signal char_data_3_array   : t_char_data_array(0 to C_NB_UINT2MAX7219_DATA - 1);  -- Array of Char DATA 3
  signal char_data_4_array   : t_char_data_array(0 to C_NB_UINT2MAX7219_DATA - 1);  -- Array of Char DATA 4

  signal framebuffer_data      : t_framebuffer_array;  -- Frame Buffer Data array
  signal framebuffer_init_data : t_framebuffer_array;  -- Frame Buffer Init Data array
  signal framebuffer           : t_framebuffer_array;  -- Frame Buffer Data array at the input of the MAX7219 Controller

  signal max7219_start    : std_logic;                      -- MAX7219 Start
  signal max7219_en_load  : std_logic;                      -- MAX7219 load enable
  signal max7219_data_int : std_logic_vector(15 downto 0);  -- MAX7219 Data to send
  signal max7219_done     : std_logic;                      -- MAX7219 ITF done

  signal init_ongoing : std_logic;      -- Init Ongoing
  signal run_ongoing  : std_logic;      -- Run ongoing
  signal init_done    : std_logic;      -- Initialization done

begin  -- architecture rtl


  -- Watch internal pulse generation
  i_watch_pulse_gen_0 : entity lib_top_watch.watch_pulse_gen
    port map (
      rst_n_sys => rst_n_sys,
      clk_sys   => clk_sys,

      -- Output Pulse
      update_watch        => update_watch,
      compute_next_update => compute_next_update
      );

  -- MAIN FSM
  i_main_fsm_0 : entity lib_top_watch.main_fsm
    port map (
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      init_done    => init_done,
      init_ongoing => init_ongoing,
      run_ongoing  => run_ongoing
      );

  -- Watch 24H Instanciation
  i_watch_24h_0 : entity lib_top_watch.watch_24h
    port map (
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Pulse for the compuation
      start => compute_next_update,

      -- PRELOAD
      preload               => '0',
      pre_hours_tens_digit  => open,
      pre_hours_unity_digit => open,
      pre_mins_tens_digit   => open,
      pre_mins_unity_digit  => open,

      -- Next hours computed
      hours_tens_digit  => hours_tens_digit,
      hours_unity_digit => hours_unity_digit,
      mins_tens_digit   => mins_tens_digit,
      mins_unity_digit  => mins_unity_digit,

      -- Done
      done => watch_24h_done
      );

  -- Affectation of output vector of watch24h to watch24h_data_array signal
  watch24h_data_array(C_HOURS_TENS_DIGIT_IDX)  <= "00" & hours_tens_digit;
  watch24h_data_array(C_HOURS_UNITY_DIGIT_IDX) <= "0" & hours_unity_digit;
  watch24h_data_array(C_MINS_TENS_DIGIT_IDX)   <= "0" & mins_tens_digit;
  watch24h_data_array(C_MINS_UNITY_DIGIT_IDX)  <= mins_unity_digit;

  -- Multiple instanciation of uint2max7219_data block
  g_uint2max7219_data : for i in 0 to C_NB_UINT2MAX7219_DATA - 1 generate

    -- Convert data from watch24h to data to print on the matrix
    i_uint2max7219_data_0 : entity lib_top_watch.uint2max7219_data
      port map (
        clk_sys   => clk_sys,
        rst_n_sys => rst_n_sys,

        uint_data => watch24h_data_array(i),

        -- Output Data character
        char_data_0 => char_data_0_array(i),
        char_data_1 => char_data_1_array(i),
        char_data_2 => char_data_2_array(i),
        char_data_3 => char_data_3_array(i),
        char_data_4 => char_data_4_array(i)
        );

  end generate;

  -- Instanciation of the framebuffer
  i_watch_framebuffer_0 : entity lib_top_watch.watch_framebuffer
    port map (
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Input data to organized
      char_data_0_array => char_data_0_array,
      char_data_1_array => char_data_1_array,
      char_data_2_array => char_data_2_array,
      char_data_3_array => char_data_3_array,
      char_data_4_array => char_data_4_array,

      -- Output Frame Buffer Array
      framebuffer => framebuffer_data
      );

  -- Framebuffer MUX
  framebuffer <= framebuffer_init_data when init_ongoing = '1' else
                 framebuffer_data;

  -- MAX7219 Control
  i_watch_max7219_ctrl_0 : entity lib_top_watch.watch_max7219_ctrl
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Control Interface
      init_sel    => init_ongoing,
      framebuffer => framebuffer,
      start       => update_watch,

      -- MAX7219 Interface
      max7219_done    => max7219_done,
      max7219_load_en => max7219_load,
      max7219_data    => max7219_data_int,
      max7219_start   => max7219_start
      );


  -- MAX7219 Interface instanciation
  i_max7219_if_0 : entity lib_max7219_interface.max7219_if
    generic map (
      G_MAX_HALF_PERIOD => C_MAX_HALF_PERIOD,
      G_LOAD_DURATION   => C_LOAD_DURATION
      )
    port map (
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- Input commands
      i_start   => max7219_start,
      i_en_load => max7219_en_load,
      i_data    => max7219_data_int,

      -- MAX7219 I/F
      o_max7219_load => max7219_load,
      o_max7219_data => max7219_data,
      o_max7219_clk  => max7219_clk,

      -- Transaction Done
      o_done => max7219_done
      );

end architecture rtl;
