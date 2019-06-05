-------------------------------------------------------------------------------
-- Title      : ADC128s022 Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : adc128s022_ctrl.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-29
-- Last update: 2019-06-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the controller for the ADC128S022 component
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-29  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adc128s022_ctrl is

  port (
    clock       : in  std_logic;        -- Input system clock
    reset_n     : in  std_logic;        -- Active low asynchronous reset
    adc_sdat    : in  std_logic;        -- ADC serial data
    channel_sel : in  std_logic_vector(2 downto 0);   -- ADC channel selector
    en          : in  std_logic;        -- Enable - Start conversion
    adc_cs_n    : out std_logic;        -- ADC Chip select
    adc_sclk    : out std_logic;        -- ADC Serial Clock
    adc_saddr   : out std_logic;        -- ADC d_in controller
    adc_data    : out std_logic_vector(11 downto 0);  -- ADC data
    adc_channel : out std_logic_vector(2 downto 0);   -- Current ADC channel
    data_valid  : out std_logic);       -- Data and Current channel available

end entity adc128s022_ctrl;



architecture arch_adc128s022_ctrl of adc128s022_ctrl is


  -- System Clock : 50Mhz : 20 ns
  -- CONSTANTS
  constant C_max_T  : integer := 50;         -- 50 : 1 MHz 16 : 3.125 MHz
  constant C_half_T : integer := C_max_T/2;  -- Half T of sclk

  -- SIGNALS
  signal run_conv : std_logic;          -- Run the conversion when = '1'
  signal cnt_sclk : integer range 0 to C_max_T;  -- Counts from 0 to 50

  signal adc_cs_n_s : std_logic;        -- Chip select signal
  signal adc_sclk_s : std_logic;        -- ADC SCLK signal

  -- Rising edge and falling edge detect
  signal adc_sclk_old_s : std_logic;    -- Old adc_sclk_s
  signal adc_sclk_re_s  : std_logic;    -- RE of adc_sclk
  signal adc_sclk_fe_s  : std_logic;    -- FE of adc sclk

  signal adc_data_16b_s : std_logic_vector(15 downto 0);  -- Save the entire data from ADC
  signal adc_data_s     : std_logic_vector(11 downto 0);  -- Save the data from adc_sdat input
  signal adc_saddr_s    : std_logic;    -- To output

  signal data_valid_s  : std_logic;                     -- Data valid flag
  signal channel_sel_s : std_logic_vector(2 downto 0);  -- Latch channel_sel

  -- Modif
  signal en_s            : std_logic;   -- Enable signal
  signal en_clock_cnt_s  : std_logic;   -- Enable clock counter
  signal cnt_data_s      : integer range 0 to 15;         -- Counter of data
  signal cnt_data_done_s : std_logic;   -- Counter done
  signal adc_channel_s   : std_logic_vector(2 downto 0);  -- Current Channel

begin


  -- purpose: This process manages the Chip Select output
  p_cs_mng : process (clock, reset_n)
  begin  -- process p_cs_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      adc_cs_n_s     <= '1';            -- Set to '1' on reset
      run_conv       <= '0';
      en_clock_cnt_s <= '0';
    elsif clock'event and clock = '1' then              -- rising clock edge
      en_s <= en;
      if(en_s = '1') then
        adc_cs_n_s <= '0';
        run_conv   <= '1';
      elsif(en_s = '0' and cnt_data_done_s = '1') then  --cnt_16_re = 16) then
        adc_cs_n_s <= '1';
        run_conv   <= '0';
      end if;
      en_clock_cnt_s <= run_conv;
    end if;
  end process p_cs_mng;

  adc_cs_n <= adc_cs_n_s;               -- Output connection


  -- purpose: This process counter the data on each RE of sclk
  p_counter_data : process (clock, reset_n) is
  begin  -- process p_counter data
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_data_s      <= 0;
      cnt_data_done_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(en_clock_cnt_s = '1') then
        if(adc_sclk_re_s = '1') then
          if(cnt_data_s < 15) then
            cnt_data_s      <= cnt_data_s + 1;
            cnt_data_done_s <= '0';
          else
            cnt_data_s      <= 0;           -- RAZ
            cnt_data_done_s <= '1';         -- Max done
          end if;
        else
          cnt_data_done_s <= '0';
        end if;
      else
        cnt_data_s      <= 0;
        cnt_data_done_s <= '0';
      end if;
    end if;
  end process p_counter_data;


  -- purpose: This process manages the SCLK output
  p_sclk_mng : process (clock, reset_n)
  begin  -- process p_sclk_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_sclk   <= 0;
      adc_sclk_s <= '1';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(en_clock_cnt_s = '0') then
        cnt_sclk   <= 0;
        adc_sclk_s <= '1';
      else
        if(cnt_sclk = C_half_T - 1) then
          adc_sclk_s <= not adc_sclk_s;
          cnt_sclk   <= 0;
        else
          cnt_sclk <= cnt_sclk + 1;
        end if;
      end if;
    end if;
  end process p_sclk_mng;

  adc_sclk <= adc_sclk_s;

  -- purpose: This process detects the RE and FE of sclk and en
  p_sclk_re_fe_detect : process (clock, reset_n)
  begin  -- process p_sclk_re_fe_detect
    if reset_n = '0' then               -- asynchronous reset (active low)
      adc_sclk_old_s <= '0';

    elsif clock'event and clock = '1' then  -- rising clock edge
      adc_sclk_old_s <= adc_sclk_s;

    end if;
  end process p_sclk_re_fe_detect;
  adc_sclk_re_s <= adc_sclk_s and not adc_sclk_old_s;
  adc_sclk_fe_s <= not adc_sclk_s and adc_sclk_old_s;



  -- purpose: This process manages the sdat 
  p_sdat_mng : process (clock, reset_n)
  begin  -- process p_sdat_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      adc_data_16b_s <= (others => '0');
      channel_sel_s  <= (others => '0');
    elsif clock'event and clock = '1' then  -- rising clock edge

      if(cnt_data_done_s = '1') then
        channel_sel_s <= channel_sel;   -- New channel
      end if;

      if(adc_sclk_re_s = '1') then
        adc_data_16b_s(15 - cnt_data_s) <= adc_sdat;
      end if;

    end if;
  end process p_sdat_mng;


  -- purpose: This process manages the saddr output
  p_saddr_mng : process (clock, reset_n)
  begin  -- process p_saddr_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      adc_channel_s <= (others => '0');
      adc_data_s    <= (others => '0');
      adc_saddr_s   <= '1';
      data_valid_s  <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge

      if(cnt_data_done_s = '1') then
        adc_channel_s <= channel_sel_s;  -- Update current conversion
        adc_data_s    <= adc_data_16b_s(11 downto 0);
      end if;
      data_valid_s <= cnt_data_done_s;

      if(adc_sclk_fe_s = '1') then
        case cnt_data_s is
          when 2 =>
            adc_saddr_s <= channel_sel_s(2);
          when 3 =>
            adc_saddr_s <= channel_sel_s(1);
          when 4 =>
            adc_saddr_s <= channel_sel_s(0);
          when others => adc_saddr_s <= '0';
        end case;
      end if;

    end if;
  end process p_saddr_mng;

  adc_channel <= adc_channel_s;
  adc_saddr   <= adc_saddr_s;
  data_valid  <= data_valid_s;
  adc_data    <= adc_data_s;

end architecture arch_adc128s022_ctrl;
