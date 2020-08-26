-------------------------------------------------------------------------------
-- Title      : MAX7219 SCROLLER I/F
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_scroller_if.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2020-08-26
-- Last update: 2020-08-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 SCROLLER I/F
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-08-26  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;


entity max7219_scroller_if is

  generic (
    G_MATRIX_NB : integer range 2 to 8 := 8);  -- MATRIX_NB

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    i_seg_data       : in  std_logic_vector(7 downto 0);   -- Segment Data
    i_seg_data_valid : in  std_logic;
    i_max_tempo_cnt  : in  std_logic_vector(31 downto 0);  -- Max Tempo Counter
    o_busy           : out std_logic;                      -- Scroller I/F Busy

    -- MAX7219 I/F
    i_max7219_if_done    : in  std_logic;  -- MAX7219 I/F Done
    o_max7219_if_start   : out std_logic;  -- MAX7219 I/F Start
    o_max7219_if_en_load : out std_logic;  -- MAX7219 Enable Load
    o_max7219_if_data    : out std_logic_vector(15 downto 0));  -- MAX7219 I/F Data

end entity max7219_scroller_if;

architecture behv of max7219_scroller_if is

  -- TYPES
  type t_matrix_array is array (0 to G_MATRIX_NB - 1) of std_logic_vector(63 downto 0);



  -- INTERNAL SIGNALS

  -- Segment_7 : 63 downto 56
  -- Segment_6 : 55 downto 48
  -- Segment_5 : 47 downto 40
  -- Segment_4 : 39 downto 32
  -- Segment_3 : 31 downto 24
  -- Segment_2 : 23 downto 16
  -- Segment_1 : 15 downto 8
  -- Segment_0 : 7 downto 0
  signal s_matrix_array : t_matrix_array;  -- Matrix Array

  signal s_shift_matrix : std_logic;    -- Shift Matrix Order

  signal s_busy : std_logic;            -- Busy

  -- COUNTERS
  signal s_segment_cnt : integer range 0 to 8;
  signal s_matrix_cnt  : integer range 0 to G_MATRIX_NB;  -- Matrix Counter
  signal s_tempo_cnt   : std_logic_vector(31 downto 0);   -- Tempo. Counter

  -- Segment Adr : 0x01 => 0x09
  signal s_segment_addr : std_logic_vector(7 downto 0);

  signal s_new_data_flag : std_logic;   -- New Data Flag

  -- MAX7219 I/F SIGNALS
  signal s_max7219_start   : std_logic;
  signal s_max7219_en_load : std_logic;
  signal s_max7219_data    : std_logic_vector(15 downto 0);

  signal s_max7219_if_done        : std_logic;
  signal s_max7219_if_done_r_edge : std_logic;
  signal s_max7219_if_done_f_edge : std_logic;

  signal s_matrix_updated_flag : std_logic;  -- Matrix Updated

  signal s_start_tempo : std_logic;     -- Start Tempo
  signal s_tempo_done  : std_logic;     -- Tempo. Done


begin  -- architecture behv

  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_max7219_if_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_max7219_if_done <= i_max7219_if_done;
    end if;
  end process p_latch_inputs;

  -- Rising Edge Detection
  s_max7219_if_done_r_edge <= i_max7219_if_done and not s_max7219_if_done;
  s_max7219_if_done_f_edge <= not i_max7219_if_done and s_max7219_if_done;


  -- SHIFT MANAGEMENT
  p_shift_matrix_mngt : process (clk, rst_n) is
  begin  -- process p_shift_matrix_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_matrix_array  <= (others => (others => '0'));
      s_new_data_flag <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge


      -- Set New Data on Segment_0 of G_MATRIX_NB - 1 (Last Matrix)
      if(i_seg_data_valid = '1') then
        s_matrix_array(G_MATRIX_NB - 1)(7 downto 0) <= i_seg_data;
        s_new_data_flag                             <= '1';
      elsif(s_shift_matrix = '1') then

        for i in 0 to G_MATRIX_NB - 1 loop

          -- Segment 0 of Matrix i+1 go to Segment 7 of Matrix i
          if(i < G_MATRIX_NB - 1) then
            s_matrix_array(i)(7 downto 0) <= s_matrix_array(i + 1)(63 downto 56);
          end if;

          -- Shift Segment
          s_matrix_array(i)(63 downto 8) <= s_matrix_array(i)(55 downto 0);
        end loop;  -- i

      else                              --if(s_matrix_updated_flag = '1') then
        s_new_data_flag <= '0';         -- Pulse

      end if;

    end if;
  end process p_shift_matrix_mngt;


  -- MAX7219 I/F - Slow (Pilot SPI I/)
  p_max7219_if_mngt : process (clk, rst_n) is
  begin  -- process p_max7219_if_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_max7219_start       <= '0';
      s_max7219_en_load     <= '0';
      s_max7219_data        <= (others => '0');
      s_matrix_cnt          <= G_MATRIX_NB- 1;
      s_segment_cnt         <= 0;
      s_segment_addr        <= x"01";
      s_matrix_updated_flag <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- On RE ?
      if(s_new_data_flag = '1' or i_max7219_if_done = '1') then  -- and i_max7219_if_done = '1') then
        if(s_segment_cnt < 8) then
          if(s_matrix_cnt > 0) then
            -- Last Matrix First - Segment 0 First => Segment 7
            s_max7219_data <= s_segment_addr & s_matrix_array(s_matrix_cnt)(8*s_segment_cnt + 7 downto 8*s_segment_cnt);

            s_matrix_cnt    <= s_matrix_cnt - 1;
            s_max7219_start <= '1';

          else
            s_max7219_start   <= '1';
            s_max7219_en_load <= '1';
            s_max7219_data    <= s_segment_addr & s_matrix_array(s_matrix_cnt)(8*s_segment_cnt + 7 downto 8*s_segment_cnt);
            s_segment_cnt     <= s_segment_cnt + 1;
            s_segment_addr    <= unsigned(s_segment_addr) + 1;
            s_matrix_cnt      <= G_MATRIX_NB - 1;
          end if;

        -- All Segment of All Matrix Updated
        else
          s_segment_cnt         <= 0;
          s_matrix_updated_flag <= '1';
          s_segment_addr        <= x"01";
        end if;
        --elsif(s_start_tempo = '1') then

      else
        s_matrix_updated_flag <= '0';
        s_max7219_start       <= '0';   -- Pulse
        s_max7219_en_load     <= '0';   -- Pulse
      end if;


    end if;
  end process p_max7219_if_mngt;


  -- purpose: Tempo. Management
  p_tempo_cnt_mngt : process (clk, rst_n) is
  begin  -- process p_tempo_cnt_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_tempo_cnt   <= (others => '0');
      s_start_tempo <= '0';
      s_tempo_done  <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Start Counter On R Edge and after Matrix Update
      if(s_matrix_updated_flag = '1') then  --s_max7219_if_done_r_edge = '1' and s_matrix_updated_flag = '1') then
        s_start_tempo <= '1';
      end if;

      if(s_start_tempo = '1') then
        if(s_tempo_cnt < i_max_tempo_cnt) then
          s_tempo_cnt <= unsigned(s_tempo_cnt) + 1;
        else
          s_start_tempo <= '0';
          s_tempo_cnt   <= (others => '0');  -- RAZ Counter
          s_tempo_done  <= '1';              -- Tempo Done
        end if;
      else
        s_tempo_done <= '0';                 -- Pulse
      end if;
    end if;
  end process p_tempo_cnt_mngt;

  s_shift_matrix <= s_tempo_done;


  -- BUSY MANAGEMENT
  p_busy_mngt : process (clk, rst_n) is
  begin  -- process p_busy_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_busy <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_new_data_flag = '1') then
        s_busy <= '1';
      elsif(s_tempo_done = '1') then
        s_busy <= '0';
      end if;

    end if;
  end process p_busy_mngt;


  -- OUTPUTS AFFECTATIONS
  o_max7219_if_start   <= s_max7219_start;
  o_max7219_if_en_load <= s_max7219_en_load;
  o_max7219_if_data    <= s_max7219_data;
  o_busy               <= s_busy;

end architecture behv;
