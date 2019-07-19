-------------------------------------------------------------------------------
-- Title      : MAX7219 interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_interface.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-07-18
-- Last update: 2019-07-19
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

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_interface is

  port (
    clock_i       : in  std_logic;      -- System clock
    reset_n_i     : in  std_logic;      -- Asynchronous active low reset
    wdata_i       : in  std_logic_vector(15 downto 0);  -- Data to send te the Max7219
    start_frame_i : in  std_logic;      -- Start the transaction
    load_o        : out std_logic;      -- LOAD command
    data_o        : out std_logic;      -- DATA to send th
    clk_o         : out std_logic;      -- CLK
    frame_done_o  : out std_logic);     -- Frame done

end entity max7219_interface;



architecture arch_max7219_interface of max7219_interface is


  -- INTERNAL SIGNALS
  signal start_frame_i_s      : std_logic;  -- Latch start_frame_i 
  signal start_frame_i_r_edge : std_logic;  -- Rising edge of start frame

  signal wdata_s        : std_logic_vector(15 downto 0);  -- Latch write data
  signal en_transaction : std_logic;    -- Enable the transaction

  signal cnt_half_spi_clock : integer range 0 to C_T_2_sclk;  -- Counter that counts until Half Period of SCLK
  signal tick_clock         : std_logic;                      -- Tick clock

  signal clk_o_s      : std_logic;      -- SPI CLK
  signal clk_o_r_edge : std_logic;      -- Rising edge of CLK
  signal clk_o_f_edge : std_logic;      -- Falling edge of CLK
  signal clk_o_ss     : std_logic;      -- Latch SPI CLK

  signal cnt_data : integer range 0 to 16;  -- Counts the data to transmit

begin  -- architecture arch_max7219_interface

  -- purpose: This process manages the start frame signal
  p_start_mng : process (clock_i, reset_n_i) is
  begin  -- process p_start_mng
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      start_frame_i_s <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      start_frame_i_s <= start_frame_i;
    end if;
  end process p_start_mng;

  start_frame_i_r_edge <= start_frame_i and not start_frame_i_s;  -- REDGE of start


  -- purpose: This process latch the input when a rising edge of start_spi occurs
  p_latch_inputs : process (clock_i, reset_n_i) is
  begin  -- process p_latch_inputs
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      wdata_s <= (others => '0');

    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(start_spi_re = '1') then
        wdata_s        <= wdata_i;
        en_transaction <= '1';

      -- To verif
      elsif(cnt_data = data_size and (sclk_fe_s = '1' or sclk_re_s = '1')) then  -- RAZ en_transaction
        en_transaction <= '0';
        wdata_s        <= (others => '0');
      end if;

    end if;
  end process p_latch_inputs;

  -- purpose: This process generates tick clock in order to generates the output clock 
  p_tick_clock_gen : process (clock_i, reset_n_i) is
  begin  -- process p_tick_clock_gen
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      tick_clock         <= '0';
      cnt_half_spi_clock <= 0;
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
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
  p_clock_gen : process (clock_i, reset_n_i) is
  begin  -- process p_clock_gen
    if reset_n_i = '0' then             -- asynchronous reset (active low)     
      clk_o_s <= '0';

    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(en_transaction = '1') then
        if(tick_clock = '1') then
          clk_o_s <= not clk_o_s;
        end if;
      elsif(en_transaction = '0') then
        clk_o_s <= '0';
      end if;

    end if;
  end process p_clock_gen;


  -- purpose: This process manages the RE and FE of sclk 
  p_sclk_re_mng : process (clock_i, reset_n_i) is
  begin  -- process p_sclk_re_mng
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      clk_o_ss <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      clk_o_ss <= clk_o_s;
    end if;
  end process p_sclk_re_mng;
  clk_o_r_edge <= sclk_s and not clk_o_ss;
  clk_o_f_edge <= not sclk_s and clk_o_ss;

  
end architecture arch_max7219_interface;
