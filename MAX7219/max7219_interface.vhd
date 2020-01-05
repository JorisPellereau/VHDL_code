-------------------------------------------------------------------------------
-- Title      : MAX7219 interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_interface.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-07-18
-- Last update: 2020-01-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the interface controler for 8x8 matrix
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-18  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_interface is

  port (
    clk           : in  std_logic;      -- System clock
    rst_n         : in  std_logic;      -- Asynchronous active low reset
    i_wdata       : in  std_logic_vector(15 downto 0);  -- Data to send te the Max7219
    i_start_frame : in  std_logic;      -- Start the transaction
    i_en_load     : in  std_logic;      -- Enable the generation of o_load
    o_load        : out std_logic;      -- LOAD command
    o_data        : out std_logic;      -- DATA to send th
    o_clk         : out std_logic;      -- CLK
    o_frame_done  : out std_logic);     -- Frame done

end entity max7219_interface;



architecture arch_max7219_interface of max7219_interface is


  -- INTERNAL SIGNALS
  signal i_start_frame_s      : std_logic;  -- Latch i_start_frame 
  signal i_start_frame_r_edge : std_logic;  -- Rising edge of start frame

  signal wdata_s        : std_logic_vector(15 downto 0);  -- Latch write data
  signal en_transaction : std_logic;    -- Enable the transaction

  signal cnt_half_spi_clock : integer range 0 to C_T_2_sclk;  -- Counter that counts until Half Period of SCLK
  signal tick_clock         : std_logic;                      -- Tick clock

  signal o_clk_s      : std_logic;      -- SPI CLK
  signal o_clk_r_edge : std_logic;      -- Rising edge of CLK
  signal o_clk_f_edge : std_logic;      -- Falling edge of CLK
  signal o_clk_ss     : std_logic;      -- Latch SPI CLK

  signal cnt_data        : integer range 0 to 16;  -- Counts the data to transmit
  signal cnt_data_done_s : std_logic;   -- Max reach

  signal en_first_bit_s : std_logic;    -- Set the first bit

  signal o_load_s       : std_logic;                     -- Load output
  signal s_load_shift   : std_logic_vector(2 downto 0);  -- Shift extend 
  signal o_frame_done_s : std_logic;                     -- Frame done output
  signal o_data_s       : std_logic;                     -- Data output

begin  -- architecture arch_max7219_interface

  -- purpose: This process manages the start frame signal
  p_start_mng : process (clk, rst_n) is
  begin  -- process p_start_mng
    if rst_n = '0' then                 -- asynchronous reset (active low)
      i_start_frame_s <= '0';
    --i_start_frame_r_edge <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      i_start_frame_s <= i_start_frame;
    --i_start_frame_r_edge <= i_start_frame and not i_start_frame_s;  -- REDGE of start
    end if;
  end process p_start_mng;

  i_start_frame_r_edge <= i_start_frame and not i_start_frame_s;  -- REDGE of start


  -- purpose: This process latch the input when a rising edge of start_spi occurs
  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)    
      en_transaction <= '0';
      o_load_s       <= '0';
      o_frame_done_s <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge


      o_load_s       <= '0';
      o_frame_done_s <= '0';
      if(i_start_frame_r_edge = '1') then

        en_transaction <= '1';
        o_load_s       <= '0';
        --o_frame_done_s <= '0';

      elsif(cnt_data_done_s = '1' and o_clk_f_edge = '1') then
        en_transaction <= '0';
        --o_frame_done_s <= '1';

        if(i_en_load = '1') then
          o_load_s <= '1';
        else
          o_frame_done_s <= '1';
          o_load_s       <= '0';
        end if;

      end if;

      if(s_load_shift(2) = '1') then
        o_frame_done_s <= '1';
      else
        o_frame_done_s <= '0';
      end if;

    end if;
  end process p_latch_inputs;

  -- purpose: This process extend the output 
  p_pulse_extend : process (clk, rst_n) is
  begin  -- process p_pulse_extend
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_load_shift <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_load_shift(0)          <= o_load_s;
      s_load_shift(2 downto 1) <= s_load_shift(1 downto 0);
    end if;
  end process p_pulse_extend;


  -- Set o_load when i_en_load = '1' => use the NO OP instr
  o_load       <= s_load_shift(0) or s_load_shift(1) or s_load_shift(2);
  o_frame_done <= o_frame_done_s;

  -- purpose: This process generates tick clock in order to generates the output clock 
  p_tick_clock_gen : process (clk, rst_n) is
  begin  -- process p_tick_clock_gen
    if rst_n = '0' then                 -- asynchronous reset (active low)
      tick_clock         <= '0';
      cnt_half_spi_clock <= 0;
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(en_transaction = '1') then
        if(cnt_half_spi_clock >= C_T_2_sclk - 1) then
          cnt_half_spi_clock <= 0;
          tick_clock         <= '1';

        else
          cnt_half_spi_clock <= cnt_half_spi_clock + 1;
          tick_clock         <= '0';

        end if;

      else
        cnt_half_spi_clock <= 0;
        tick_clock         <= '0';
      end if;

    end if;
  end process p_tick_clock_gen;

  -- purpose: This process generates SCLK 
  p_clock_gen : process (clk, rst_n) is
  begin  -- process p_clock_gen
    if rst_n = '0' then                 -- asynchronous reset (active low)     
      o_clk_s <= '0';

    elsif clk'event and clk = '1' then  -- rising clock edge
      if(en_transaction = '1') then
        if(tick_clock = '1') then
          o_clk_s <= not o_clk_s;
        end if;
      elsif(en_transaction = '0') then
        o_clk_s <= '0';
      end if;

    end if;
  end process p_clock_gen;

  o_clk <= o_clk_s;

  -- purpose: This process manages the RE and FE of sclk 
  p_sclk_re_mng : process (clk, rst_n) is
  begin  -- process p_sclk_re_mng
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_clk_ss <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      o_clk_ss <= o_clk_s;
    end if;
  end process p_sclk_re_mng;
  o_clk_r_edge <= o_clk_s and not o_clk_ss;
  o_clk_f_edge <= not o_clk_s and o_clk_ss;

  -- purpose: This process manages the counter cnt_data 
  p_cnt_data_mng : process (clk, rst_n) is
  begin  -- process p_cnt_data_mng
    if rst_n = '0' then                 -- asynchronous reset (active low)
      cnt_data        <= 0;
      cnt_data_done_s <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(en_transaction = '1') then
        if(o_clk_r_edge = '1') then
          if(cnt_data >= 16 - 1) then
            cnt_data        <= 0;
            cnt_data_done_s <= '1';
          else
            cnt_data        <= cnt_data + 1;
            cnt_data_done_s <= '0';
          end if;
        end if;
      else
        cnt_data        <= 0;
        cnt_data_done_s <= '0';
      end if;
    end if;
  end process p_cnt_data_mng;


  -- purpose: This process manages the data output
  p_o_dataut_mng : process (clk, rst_n) is
  begin  -- process p_o_dataut_mng
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_data_s       <= '0';
      wdata_s        <= (others => '0');
      en_first_bit_s <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_start_frame_r_edge = '1' and en_transaction = '0') then
        wdata_s        <= i_wdata;
        en_first_bit_s <= '1';
      end if;


      if(en_transaction = '1') then
        if(en_first_bit_s = '1') then
          wdata_s(15 downto 1) <= wdata_s(14 downto 0);
          o_data_s             <= wdata_s(15);
          en_first_bit_s       <= '0';

        else
          if(o_clk_f_edge = '1') then
            wdata_s(15 downto 1) <= wdata_s(14 downto 0);
            o_data_s             <= wdata_s(15);
          end if;
        end if;
      else
        o_data_s <= '0';

      end if;
    end if;

  end process p_o_dataut_mng;

  o_data <= o_data_s;




  --

end architecture arch_max7219_interface;
