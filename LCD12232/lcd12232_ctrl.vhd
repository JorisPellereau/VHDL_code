-------------------------------------------------------------------------------
-- Title      : LCD12232 controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd12232_ctrl.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-07
-- Last update: 2019-06-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the controller module for the LCD12232
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-07  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library lib_lcd12232;
use lib_lcd12232.pkg_lcd12232.all;

entity lcd12232_ctrl is

  port (
    clock_i   : in    std_logic;        -- System clock
    reset_n_i : in    std_logic;        -- Active low asynchronous reset
    reg_sel_o : out   std_logic;        -- Register sel
    en1_o     : out   std_logic;        -- Enable for IC1
    en2_o     : out   std_logic;        -- Enable for IC2
    rw_o      : out   std_logic;        -- Read/Write selection
    rst_o     : out   std_logic;        -- LCD reset
    data_io   : inout std_logic_vector(7 downto 0));  -- Data to LCD

end entity lcd12232_ctrl;

architecture arch_lcd12232_ctrl of lcd12232_ctrl is


  -- SIGNALS
  signal starts_rw_s : std_logic_vector;  -- Start a RW transaction on the bus
  signal run_rw_s    : std_logic;         -- Run RW on the bus
  signal rw_s        : std_logic;         -- R/W command  
  signal a0_s        : std_logic;         -- A0 signal

  -- Data IO signals
  signal en_data_io_s : std_logic;      -- Enable the R or Write on db_o
  signal data_i_s     : std_logic_vector(7 downto 0);  -- Data from the bus
  signal data_o_s     : std_logic_vector(7 downto 0);  -- Data to the bus

  signal en1_o_s : std_logic;           -- Enable 1 signal
  signal en2_o_s : std_logic;           -- Enable 2 signal
  signal rw_o_s  : std_logic;           -- RW output signal

  signal wdata_s : std_logic_vector(7 downto 0);  -- Data to write on the bus
  signal rdata_s : std_logic_vector(7 downto 0);  -- Data read from the bus
  signal rw_i_s  : std_logic;                     -- RW command
  signal a0_i_s  : std_logic;                     -- a0 command

  -- COUNTERS
  signal cnt_1us_s      : unsigned(5 downto 0);  -- Counter until 0x32
  signal cnt_1us_done_s : std_logic;             -- Max cnt 1 us reach

begin  -- architecture arch_lcd12232_ctrl



  -- purpose: This process manages the Read or Write transaction on the bus
  p_RW_manage : process (clock_i, reset_n_i) is
  begin  -- process p_RW_manage
    if reset_n_i = '0' then                 -- asynchronous reset (active low)
      run_rw_s     <= '0';
      en_data_io_s <= '0';
      en1_o_s      <= '0';
      en2_o_s      <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(starts_rw_s = '1') then
        run_rw_s <= '1';
      end if;

      if(run_rw_s = '1') then
        rw_o_s <= rw_i_s;
        a0_s   <= a0_i_s;
        if(cnt_1us_done_s = '1') then
          en1_o_s <= not en1_o_s;
          en2_o_s <= not en2_o_s;
        end if;

      end if;
    end if;
  end process p_RW_manage;


  en1_o     <= en1_o_s;
  en2_o     <= en2_o_s;
  rw_o      <= rw_o_s;
  reg_sel_o <= a0_s;

  data_io  <= data_o_s when en_data_io_s = '1' else 'Z';  -- Write on the bus
  data_i_s <= data_io;                                    -- Read from the bus


  -- purposeThis process counts until 50 in order to control enables outputs
  p_cnt_1us : process(clock_i, reset_n_i)
  begin  -- process p_cnt_1us
    if reset_n_i = '0' then                 -- asynchronous reset (active low)
      cnt_1us_s      <= (others => '0');
      cnt_1us_done_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(run_rw_s = '1') then
        if(cnt_1us_s < C_MAX_CNT_1U) then
          cnt_1us_done_s <= '0';
          cnt_1us_s      <= cnt_1us_s + 1;
        else
          cnt_1us_done_s <= '1';
          cnt_1us_s      <= 0;
        end if;
      else
        cnt_1us_s      <= (others => '0');
        cnt_1us_done_s <= '0';
      end if;

    end if;
  end process p_cnt_1us;

end architecture arch_lcd12232_ctrl;
