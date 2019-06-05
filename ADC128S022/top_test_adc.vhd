-------------------------------------------------------------------------------
-- Title      : Test Top ADC
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_test_adc.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-04
-- Last update: 2019-06-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Test ADC on DE NANO board
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-04  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

entity top_test_adc is

  port (
    clock     : in  std_logic;          -- System clock
    reset_n   : in  std_logic;          -- Active low asynchronous reset
    adc_sdat  : in  std_logic;          -- From ADC
    tx        : out std_logic;          -- TX uart output
    adc_cs_n  : out std_logic;          -- ADC chip select
    adc_sclk  : out std_logic;          -- ADC Clock
    adc_saddr : out std_logic;          -- ADC addr

    -- DEBUG : connected to the GPIO pins
    adc_sdat_o  : out std_logic;
    adc_cn_n_o  : out std_logic;
    adc_sclk_o  : out std_logic;
    adc_saddr_o : out std_logic);


end entity top_test_adc;

architecture arch_top_test_adc of top_test_adc is

  -- COMPONENTs
  component adc128s022_ctrl is
    port (
      clock       : in  std_logic;      -- Input system clock
      reset_n     : in  std_logic;      -- Active low asynchronous reset
      adc_sdat    : in  std_logic;      -- ADC serial data
      channel_sel : in  std_logic_vector(2 downto 0);   -- ADC channel selector
      en          : in  std_logic;      -- Enable - Start conversion
      adc_cs_n    : out std_logic;      -- ADC Chip select
      adc_sclk    : out std_logic;      -- ADC Serial Clock
      adc_saddr   : out std_logic;      -- ADC d_in controller
      adc_data    : out std_logic_vector(11 downto 0);  -- ADC data
      adc_channel : out std_logic_vector(2 downto 0);   -- Current ADC channel
      data_valid  : out std_logic);     -- Data and Current channel available
  end component;


  -- ADC SIGNALS
  signal channel_sel_s : std_logic_vector(2 downto 0);
  signal en_s          : std_logic;
  signal adc_data_s    : std_logic_vector(11 downto 0);
  signal adc_channel_s : std_logic_vector(2 downto 0);
  signal data_valid_s  : std_logic;


  -- TX UART signals
  signal start_tx_s : std_logic;
  signal tx_data_s  : std_logic_vector(7 downto 0);
  signal tx_done_s  : std_logic;


  -- INTERNALS SIGNALS
  signal data_ctrl_s : std_logic;       -- Control the data to send
  signal adc_sdat_s  : std_logic;
  signal adc_cs_n_s  : std_logic;
  signal adc_sclk_s  : std_logic;
  signal adc_saddr_s : std_logic;


  signal cnt_2 : integer range 0 to 1;  -- Counter
  signal cnt   : integer range 0 to 50;

begin  -- architecture arch_top_test_adc


  -- purpose: This process manages the ADC 
  p_adc_manage : process (clock, reset_n) is
  begin  -- process p_adc_manage
    if reset_n = '0' then                   -- asynchronous reset (active low)
      channel_sel_s <= (others => '0');
      en_s          <= '0';
      cnt_2         <= 0;
      cnt           <= 0;
      start_tx_s    <= '0';
      tx_data_s     <= (others => '0');
      cnt           <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      channel_sel_s <= "000";

      if(cnt = 50) then
        en_s <= '0';
      else
        en_s <= '1';
        cnt  <= cnt + 1;
      end if;

      if(data_valid_s = '1') then
        tx_data_s  <= adc_data_s(7 downto 0);
        start_tx_s <= '1';
      -- cnt        <= 0;
      elsif(tx_done_s = '1') then
        start_tx_s <= '0';
        cnt        <= 0;
      end if;

      -- if(data_valid_s = '1') then

      --   en_s       <= '0';
      --   tx_data_s  <= adc_data_s(7 downto 0);
      --   start_tx_s <= '1';
      -- elsif(tx_done_s = '1') then
      --   start_tx_s <= '0';
      --   en_s       <= '1';
      -- end if;


      -- if(cnt_2 = 1) then
      --   cnt_2 <= 0;
      --   en_s  <= '0';
      -- else
      --   cnt_2 <= cnt_2 + 1;
      --   en_s  <= '1';
      -- end if;
      -- end if;

    end if;
  end process p_adc_manage;


-- purpose: This process manage the data to send
-- p_uart_mng : process (clock, reset_n) is
-- begin  -- process p_uart_mng
--   if reset_n = '0' then                   -- asynchronous reset (active low)
--     data_ctrl_s <= '0';
--     start_tx_s  <= '0';
--     tx_data_s   <= (others => '0');
--   elsif clock'event and clock = '1' then  -- rising clock edge
--     if(data_ctrl_s = '0') then
--       if(tx_done_s = '1') then            -- UART available to send
--         if(data_valid_s = '1') then       -- Latch data when ok
--           tx_data_s   <= adc_data_s(7 downto 0);
--           data_ctrl_s <= '1';
--         end if;
--       end if;
--     else
--       if(tx_done_s = '1') then
--         start_tx_s <= '1';
--       elsif(tx_done_s = '0') then
--         start_tx_s  <= '0';
--         data_ctrl_s <= '0';
--       end if;
--     end if;
--   end if;
-- end process p_uart_mng;


-- ADC inst
  adc_ctrl_inst : adc128s022_ctrl
    port map(clock       => clock,
             reset_n     => reset_n,
             adc_sdat    => adc_sdat_s,
             channel_sel => channel_sel_s,
             en          => en_s,
             adc_cs_n    => adc_cs_n_s,
             adc_sclk    => adc_sclk_s,
             adc_saddr   => adc_saddr_s,
             adc_data    => adc_data_s,
             adc_channel => adc_channel_s,
             data_valid  => data_valid_s);


-- From input
  adc_sdat_s <= adc_sdat;

-- To output  
  adc_cs_n  <= adc_cs_n_s;
  adc_sclk  <= adc_sclk_s;
  adc_saddr <= adc_saddr_s;

-- DEBUG
  adc_sdat_o  <= adc_sdat_s;
  adc_cn_n_o  <= adc_cs_n_s;
  adc_sclk_o  <= adc_sclk_s;
  adc_saddr_o <= adc_saddr_s;



-- TX UART inst
  tx_rs232_inst : tx_rs232
    generic map(stop_bit_number => 1,
                parity          => none,
                baudrate        => b115200,
                data_size       => 8,
                polarity        => '1',
                first_bit       => lsb_first,
                clock_frequency => 50000000)
    port map(reset_n  => reset_n,
             clock    => clock,
             start_tx => start_tx_s,
             tx_data  => tx_data_s,
             tx       => tx,
             tx_done  => tx_done_s);




end architecture arch_top_test_adc;
