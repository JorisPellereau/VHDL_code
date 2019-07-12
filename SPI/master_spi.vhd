-------------------------------------------------------------------------------
-- Title      : Master SPI - 4 Wire mode
-- Project    : 
-------------------------------------------------------------------------------
-- File       : master_spi.vhd
-- Author     :   Joris Pellereau
-- Company    : 
-- Created    : 2019-05-03
-- Last update: 2019-07-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file is le master SPI module - 4 Wire mode
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-03  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_spi;
use lib_spi.pkg_spi.all;

entity master_spi is

  generic (
    cpol         : std_logic                           := '0';  -- Clock Polarity
    cpha         : std_logic                           := '0';  -- Clock phase
    data_size    : integer                             := 8;  -- Size of the data
    slave_number : integer range 1 to max_slave_number := max_slave_number);  -- Number of slave

  port (
    reset_n     : in  std_logic;        -- Asynchronous reset
    clock       : in  std_logic;        -- System clock
    ssi         : in  std_logic_vector(slave_number - 1 downto 0);  -- Slave Select input
    start_spi   : in  std_logic;        -- Start SPI transaction
    wdata       : in  std_logic_vector(data_size - 1 downto 0);  -- Data to transmit
    miso        : in  std_logic;        -- Master In Slave Out
    mosi        : out std_logic;        -- Master Out Slave In
    sclk        : out std_logic;        -- Serial Clock
    ssn         : out std_logic_vector(slave_number - 1 downto 0);  -- Slave Select
    rdata       : out std_logic_vector(data_size - 1 downto 0);  -- Read data
    rdata_valid : out std_logic
    );

end entity master_spi;



architecture arch_master_spi of master_spi is

  -- SIGNALS

  -- Rising edge detect (start_spi)
  signal start_spi_s  : std_logic;      -- Latch start_spi input
  signal start_spi_re : std_logic;  -- Pulse that indicate a start_spi Rising edge

  -- Clock gen
  signal tick_clock         : std_logic;                    -- Tick clock
  signal cnt_half_spi_clock : integer range 0 to T_2_sclk;  -- Counter that counts until Half Period of SCLK

  signal sclk_s    : std_logic;         -- Serial clock Signal
  signal sclk_re_s : std_logic;         -- RE of sclk
  signal sclk_fe_s : std_logic;         -- FE of sclk
  signal sclk_ss   : std_logic;         -- Sclk_s latch

  signal cnt_period_clock_spi : integer range 0 to T_sclk;  -- Counter that counts until t_sclk

  -- Input to latch
  signal ssi_s   : std_logic_vector(slave_number - 1 downto 0);  -- Latch slave select input
  signal wdata_s : std_logic_vector(data_size - 1 downto 0);     -- Latch wdata

  signal rdata_s        : std_logic_vector(data_size - 1 downto 0);
  signal rdata_valid_s  : std_logic;
  -- Controls
  signal en_transaction : std_logic;    -- Start transaction

  signal cnt_data : integer range 0 to data_size;  -- Counter that counts until the number of bit to transmit

begin  -- architecture arch_master_spi

  -- purpose: This process detect the start SPI input 
  p_start_detect : process (clock, reset_n) is
  begin  -- process p_start_detect
    if reset_n = '0' then                   -- asynchronous reset (active low)
      start_spi_s  <= '0';
      start_spi_re <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge

      start_spi_s  <= start_spi;
      start_spi_re <= start_spi and not start_spi_s;

    end if;
  end process p_start_detect;
  -- start_spi_re <= start_spi and not start_spi_s;


  -- purpose: This process latch the input when a rising edge of start_spi occurs
  p_latch_inputs : process (clock, reset_n) is
  begin  -- process p_latch_inputs
    if reset_n = '0' then               -- asynchronous reset (active low)
      ssi_s          <= (others => '0');
      wdata_s        <= (others => '0');
      en_transaction <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(start_spi_re = '1') then
        ssi_s          <= ssi;
        wdata_s        <= wdata;
        en_transaction <= '1';
      elsif(cnt_data = data_size and (((sclk_fe_s = '1' or sclk_re_s = '1') and cpha = '0') or cpha = '1')) then  -- RAZ en_transaction
        en_transaction <= '0';
        ssi_s          <= (others => '0');
        wdata_s        <= (others => '0');
      end if;
    end if;
  end process p_latch_inputs;


  ssn <= ssi_s when en_transaction = '1' else (others => '1');  -- '1' : idle state

  -- purpose: This process generates tick clock in order to generates the output clock 
  p_tick_clock_gen : process (clock, reset_n) is
  begin  -- process p_tick_clock_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      tick_clock         <= '0';
      cnt_half_spi_clock <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(en_transaction = '1') then
        if(cnt_half_spi_clock < T_2_sclk - 1) then
          cnt_half_spi_clock <= cnt_half_spi_clock + 1;
          tick_clock         <= '0';
        else
          cnt_half_spi_clock <= 0;
          tick_clock         <= '1';
        end if;
      else
        cnt_half_spi_clock <= 0;
        tick_clock         <= '0';
      end if;
    end if;
  end process p_tick_clock_gen;


  -- purpose: This process generates SCLK 
  p_clock_gen : process (clock, reset_n) is
  begin  -- process p_clock_gen
    if reset_n = '0' then               -- asynchronous reset (active low)     
      sclk_s               <= cpol;
      cnt_period_clock_spi <= 0;

    elsif clock'event and clock = '1' then  -- rising clock edge
      if(en_transaction = '1') then
        if(tick_clock = '1') then
          sclk_s <= not sclk_s;
        end if;

      elsif(en_transaction = '0') then
        cnt_period_clock_spi <= 0;
        sclk_s               <= cpol;
      end if;

    end if;
  end process p_clock_gen;

  sclk <= sclk_s;

  -- purpose: This process manages the RE and FE of sclk 
  p_sclk_re_mng : process (clock, reset_n) is
  begin  -- process p_sclk_re_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      sclk_ss <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      sclk_ss <= sclk_s;
    end if;
  end process p_sclk_re_mng;
  sclk_re_s <= sclk_s and not sclk_ss;
  sclk_fe_s <= not sclk_s and sclk_ss;

  -- purpose: This process manages the MISO port
  p_miso_mng : process (clock, reset_n) is
  begin  -- process p_miso_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      rdata_s       <= (others => '0');
      rdata_valid_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge

      if(cpol = '0' and cpha = '0') then
        if(sclk_re_s = '1') then
          rdata_s(0)          <= miso;
          rdata_s(7 downto 1) <= rdata_s(6 downto 0);
        end if;

      elsif(cpol = '1' and cpha = '0') then
        if(sclk_fe_s = '1') then
          rdata_s(0)          <= miso;
          rdata_s(7 downto 1) <= rdata_s(6 downto 0);
        end if;

      elsif(cpol = '0' and cpha = '1') then
        if(sclk_fe_s = '1') then
          rdata_s(0)          <= miso;
          rdata_s(7 downto 1) <= rdata_s(6 downto 0);
        end if;

      elsif(cpol = '1' and cpha = '1') then
        if(sclk_re_s = '1') then
          rdata_s(0)          <= miso;
          rdata_s(7 downto 1) <= rdata_s(6 downto 0);
        end if;

      end if;

    end if;
  end process p_miso_mng;

  rdata       <= rdata_s;
  rdata_valid <= rdata_valid_s;


  -- purpose: This process manages the MOSI port 
  p_mosi_mng : process (clock, reset_n) is
  begin  -- process p_mosi_mng
    if reset_n = '0' then               -- asynchronous reset (active low)

    elsif clock'event and clock = '1' then  -- rising clock edge

    end if;
  end process p_mosi_mng;

  -- purpose: This process counts the data
  p_cnt_data_mng : process (clock, reset_n) is
  begin  -- process p_cnt_data_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_data <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(cnt_data < data_size and en_transaction = '1') then
        if(cpol = '0' and cpha = '0') then
          if(sclk_re_s = '1') then
            cnt_data <= cnt_data + 1;
          end if;

        elsif(cpol = '1' and cpha = '0') then
          if(sclk_fe_s = '1') then
            cnt_data <= cnt_data + 1;
          end if;

        elsif(cpol = '0' and cpha = '1') then
          if(sclk_fe_s = '1') then
            cnt_data <= cnt_data + 1;
          end if;

        elsif(cpol = '1' and cpha = '1') then
          if(sclk_re_s = '1') then
            cnt_data <= cnt_data + 1;
          end if;

        end if;
      elsif(en_transaction = '0') then
        cnt_data <= 0;
      end if;
    end if;
  end process p_cnt_data_mng;

end architecture arch_master_spi;
