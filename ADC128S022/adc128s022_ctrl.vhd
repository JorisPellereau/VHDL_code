-------------------------------------------------------------------------------
-- Title      : ADC128s022 Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : adc128s022_ctrl.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-29
-- Last update: 2019-05-29
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
    conv_mode   : in  std_logic_vector(1 downto 0);   -- Conversion mode
    en          : in  std_logic;        -- Enable - Start conversion
    adc_cs_n    : out std_logic;        -- ADC Chip select
    adc_sclk    : out std_logic;        -- ADC Serial Clock
    adc_saddr   : out std_logic;        -- ADC d_in controller
    adc_data    : out std_logic_vector(11 downto 0);  -- ADC data
    adc_channel : out std_logic_vector(2 downto 0);   -- Current ADC channel
    data_valid  : out std_logic);       -- Data and Current channel available

end entity adc128s022_ctrl;



architecture arch_adc128s022_ctrl of adc128s022_ctrl is

  -- CONSTANTS
  constant C_max_T  : integer := 50;    -- Max counter for the SCLK generation
  constant C_half_T : integer := C_max_T/2;  -- Half T of sclk

  -- SIGNALS
  signal run_conv : std_logic;          -- Run the conversion when = '1'

  signal en_old_s : std_logic;          -- Old enable
  signal en_re_s  : std_logic;          -- RE of enable

  signal cnt_sclk  : integer range 0 to C_max_T;  -- Counts from 0 to 50
  signal cnt_16_re : integer range 0 to 16;       -- Counts until 16 on RE
  signal cnt_16_fe : integer range 0 to 16;       -- Counts untils 16 on FE

  signal cnt_7 : integer range 0 to 7;  -- Counts until 7, select the channe

  signal adc_cs_n_s : std_logic;        -- Chip select signal
  signal adc_sclk_s : std_logic;        -- ADC SCLK signal

  -- Rising edge and falling edge detect
  signal adc_sclk_old_s : std_logic;    -- Old adc_sclk_s
  signal adc_sclk_re_s  : std_logic;    -- RE of adc_sclk
  signal adc_sclk_fe_s  : std_logic;    -- FE of adc sclk

  signal adc_data_16b_s : std_logic_vector(15 downto 0);  -- Save the entire data from ADC
  signal adc_saddr_s    : std_logic_vector(15 downto 0);  -- Data to send to the ADC
  signal adc_data_s     : std_logic_vector(11 downto 0);  -- Save the data from adc_sdat input

  signal data_valid_s  : std_logic;     -- Data valid flag
  signal channel_sel_s : std_logic_vector(2 downto 0);  -- Channel sel signal
  signal conv_mode_s   : std_logic_vector(1 downto 0);  -- Conversion moe signal

begin


  -- purpose: This process manages the Chip Select output
  p_cs_mng : process (clock, reset_n)
  begin  -- process p_cs_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      adc_cs_n_s <= '1';                    -- Set to '1' on reset
      run_conv   <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(en = '1') then
        adc_cs_n_s <= '0';
        run_conv   <= '1';
      elsif(en = '0' and cnt_16_re = 16) then
        adc_cs_n_s <= '1';
        run_conv   <= '0';
      end if;
    end if;
  end process p_cs_mng;

  adc_cs_n <= adc_cs_n_s;               -- Output connection



  -- purpose: This process manages the SCLK output
  p_sclk_mng : process (clock, reset_n)
  begin  -- process p_sclk_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_sclk   <= 0;
      adc_sclk_s <= '1';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(run_conv = '0') then
        cnt_sclk   <= 0;
        adc_sclk_s <= '1';
      else
        if(cnt_sclk = C_half_T) then
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
    if reset_n = '0' then                   -- asynchronous reset (active low)
      adc_sclk_old_s <= '0';
      en_old_s       <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      adc_sclk_old_s <= adc_sclk_s;
      en_old_s       <= en;
    end if;
  end process p_sclk_re_fe_detect;
  adc_sclk_re_s <= adc_sclk_s and not adc_sclk_old_s;
  adc_sclk_fe_s <= not adc_sclk_s and adc_sclk_old_s;
  en_re_s       <= en and not en_old_s;

  -- purpose: This process counts the bit to transmit
  p_cnt16_mng : process (clock, reset_n)
  begin  -- process p_cnt16_ng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_16_re <= 0;
      cnt_16_fe <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(run_conv = '0') then
        cnt_16_re <= 0;
        cnt_16_fe <= 0;
      else
        if(adc_sclk_re_s = '1') then
          if(cnt_16_re = 16) then
            cnt_16_re <= 1;
          else
            cnt_16_re <= cnt_16_re + 1;
          end if;
        end if;

        if(adc_sclk_fe_s = '1') then
          if(cnt_16_fe = 16) then
            cnt_16_fe <= 1;
          else
            cnt_16_fe <= cnt_16_fe + 1;
          end if;
        end if;

      end if;
    end if;
  end process p_cnt16_mng;


  -- purpose: This process save the data from adc_sdat 
  p_adc_sdat_mng : process (clock, reset_n) is
  begin  -- process p_adc_sdat_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      adc_data_s     <= (others => '0');
      adc_data_16b_s <= (others => '0');
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(run_conv = '0') then
      else
        if(adc_sclk_re_s = '1') then
          adc_data_16b_s(16 - cnt_16_fe) <= adc_sdat;
        end if;
      end if;
    end if;
  end process p_adc_sdat_mng;

  adc_data <= adc_data_16b_s(11 downto 0);


  -- purpose: This process manages the datavalid output
  p_data_valid_mng : process (clock, reset_n) is
  begin  -- process p_data_valid_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      data_valid_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(run_conv = '0') then
        if(cnt_16_re = 16) then
          data_valid_s <= '1';          -- Set to '1' after an terminated conv
        end if;
      else
        if(cnt_16_re = 16) then
          data_valid_s <= '1';          -- Set to '1' during an ongoing conv
        else
          data_valid_s <= '0';  -- Else set to '0' when another conv is ongoing
        end if;
      end if;
    end if;
  end process p_data_valid_mng;

  data_valid <= data_valid_s;


  -- purpose: This process latches the inputs on RE of en
  p_latch_inputs : process (clock, reset_n) is
  begin  -- process p_latch_inputs
    if reset_n = '0' then                   -- asynchronous reset (active low)
      conv_mode_s <= (others => '0');
    elsif clock'event and clock = '1' then  -- rising clock edge      
      if(en_re_s = '1') then
        conv_mode_s <= conv_mode;
      end if;
    end if;
  end process p_latch_inputs;


  -- purpose: This process manages the addr to send to the ADC
  p_mode_sel_mng : process (clock, reset_n) is
  begin  -- process p_mode_sel_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      channel_sel_s <= (others => '0');
      cnt_7         <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(run_conv = '1') then
        if(conv_mode_s = "00") then
          if(cnt_16_re = 16 and adc_sclk_fe_s = '1') then
            if(cnt_7 = 7) then
              cnt_7 <= 0;
            else
              cnt_7 <= cnt_7 + 1;
            end if;
          end if;
          channel_sel_s <= std_logic_vector(to_unsigned(cnt_7, channel_sel_s'length));
        end if;
      end if;
    end if;
  end process p_mode_sel_mng;


  -- purpose: This process manages the data to send the the ADC CTRL reg 
  p_adc_saddr_mng : process (clock, reset_n) is
  begin  -- process p_adc_saddr_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      adc_saddr_s <= (others => '0');
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(run_conv = '1') then
        if(conv_mode_s = "00") then
        end if;
      end if;
    end if;
  end process p_adc_saddr_mng;

end architecture arch_adc128s022_ctrl;
