-------------------------------------------------------------------------------
-- Title      : LCD12232 controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd12232_ctrl.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-07
-- Last update: 2019-06-10
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
    reg_sel_o : out   std_logic;        -- Register sel (A0)
    en1_o     : out   std_logic;        -- Enable for IC1
    en2_o     : out   std_logic;        -- Enable for IC2
    rw_o      : out   std_logic;        -- Read/Write selection
    rst_o     : out   std_logic;        -- LCD reset
    data_io   : inout std_logic_vector(7 downto 0));  -- Data to LCD

end entity lcd12232_ctrl;

architecture arch_lcd12232_ctrl of lcd12232_ctrl is


  -- SIGNALS
  signal starts_rw_s : std_logic_vector;  -- Start a RW transaction on the bus
  signal rw_s        : std_logic;         -- R/W command  
  signal a0_s        : std_logic;         -- A0 signal


  signal fsm_rw_s : t_fsm_rw;           -- FSM states

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
  signal cnt_1us_s       : unsigned(5 downto 0);  -- Counter until 0x32
  signal start_cnt_1us_s : std_logic;             -- Start counts
  signal cnt_1us_done_s  : std_logic;             -- Max cnt 1 us reach

  signal cnt_tacc_rd_s      : unsigned(2 downto 0);  -- Counter until 5
  signal cnt_tacc_rd_done_s : std_logic;             -- Max cnt reach


begin  -- architecture arch_lcd12232_ctrl



  -- purpose: This process manages the bus RW
  p_fsm_rw_mng : process (clock_i, reset_n_i)
  begin  -- process p_fsm_rw_mng
    if reset_n_i = '0' then                 -- asynchronous reset (active low)
      fsm_rw_s        <= IDLE;
      rw_o_s          <= '0';
      a0_s            <= '0';
      en1_o_s         <= '1';               -- A verifier
      en2_o_s         <= '1';
      en_data_io_s    <= '0';               -- Set 'Z' on the bus
      data_o_s        <= (others => '0');
      start_cnt_1us_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      case fsm_rw_s is

        when IDLE =>
          if(starts_rw_s = '1') then
            fsm_rw_s        <= SET_RW_REG;
            en1_o_s         <= '0';
            en2_o_s         <= '0';
            start_cnt_1us_s <= '1';
          end if;

        when SET_RW_REG =>
          rw_o_s <= rw_i_s;
          a0_s   <= a0_i_s;
          if(cnt_1us_done_s = '1') then
            fsm_rw_s <= SET_ENi;
          end if;

        when SET_ENi =>
          en1_o_s <= '1';
          en2_o_s <= '1';
          if(rw_o_s = '0') then
            fsm_rw_s <= WR_DATA;
          elsif(rw_o_s = '1') then
            fsm_rw_s <= RD_DATA;
          end if;

        when WR_DATA =>
          en_data_io_s <= '1';
          data_o_s     <= wdata_s;
          if(cnt_1us_done_s = '1') then
            fsm_rw_s        <= RST_ENi;
            start_cnt_1us_s <= '0';
          end if;

        when RD_DATA =>
          if(cnt_tacc_rd_done_s = '1') then
            rdata_s <= data_i_s;
          end if;
          if(cnt_1us_done_s = '1') then
            fsm_rw_s        <= RST_ENi;
            start_cnt_1us_s <= '0';
          end if;

        when RST_ENi =>
          en1_o_s  <= '0';
          en2_o_s  <= '0';
          fsm_rw_s <= RST_DATA;

        when RST_DATA =>
          en_data_io_s <= '0';          -- Set 'Z' on the bus
          data_o_s     <= (others => '0');
          fsm_rw_s     <= IDLE;

        when others => null;
      end case;
    end if;
  end process p_fsm_rw_mng;

  -- Output connection
  en1_o     <= en1_o_s;
  en2_o     <= en2_o_s;
  rw_o      <= rw_o_s;
  reg_sel_o <= a0_s;

  -- DATA selector
  data_io  <= data_o_s when en_data_io_s = '1' else 'Z';  -- Write on the bus
  data_i_s <= data_io;                                    -- Read from the bus



  -- purpose : This process manages the counters for the FSM rw
  p_cnt_1us : process(clock_i, reset_n_i)
  begin  -- process p_cnt_1us
    if reset_n_i = '0' then                 -- asynchronous reset (active low)
      cnt_1us_s          <= (others => '0');
      cnt_1us_done_s     <= '0';
      cnt_tacc_rd_s      <= (others => '0');
      cnt_tacc_rd_done_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(start_cnt_1us_s = '1') then        -- A voir
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

      if(fsm_rw_s = RD_DATA) then
        if((cnt_tacc_rd_s < C_MAX_TACC_RD) and cnt_tacc_rd_done_s = '0') then
          cnt_tacc_rd_s <= cnt_tacc_rd_s + 1;  -- Inc cnt
        else
          cnt_tacc_rd_s      <= '0';
          cnt_tacc_rd_done_s <= '1';
        end if;
      else
        cnt_tacc_rd_s      <= '0';
        cnt_tacc_rd_done_s <= '0';
      end if;

    end if;
  end process p_cnt_1us;

end architecture arch_lcd12232_ctrl;
