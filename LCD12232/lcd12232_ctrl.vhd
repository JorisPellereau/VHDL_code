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
use ieee.numeric_std.all;

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
  signal start_rw_s : std_logic;        -- Start a RW transaction on the bus 
  signal a0_s       : std_logic;        -- A0 signal


  signal fsm_rw_s  : t_fsm_rw;          -- FSM states RW
  signal rw_done_s : std_logic;         -- Transaction done

  signal fsm_ctrl_s : t_fsm_ctrl;       -- FSM of the controller



  -- Data IO signals
  signal en_data_io_s : std_logic;      -- Enable the R or Write on db_o
  signal data_i_s     : std_logic_vector(7 downto 0);  -- Data from the bus
  signal data_o_s     : std_logic_vector(7 downto 0);  -- Data to the bus

  signal en1_o_s : std_logic;           -- Enable 1 signal
  signal en2_o_s : std_logic;           -- Enable 2 signal
  signal rw_o_s  : std_logic;           -- RW output signal
  signal rst_o_s : std_logic;           -- LCD rst signal

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

  signal cnt_rst_s      : unsigned(7 downto 0);  -- LCd counter reset
  signal cnt_rst_done_s : std_logic;             -- Max cnt reset reach

begin  -- architecture arch_lcd12232_ctrl


  -- ==== MAIN FSM MANAGEMENT ==

  -- purpose: This process manages the LCd controller 
  p_fsm_controller : process (clock_i, reset_n_i)
  begin  -- process p_fsm_controller
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      fsm_ctrl_s <= IDLE;
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      case fsm_ctrl_s is

        when IDLE =>
          fsm_ctrl_s <= RST_LCD;

        when RST_LCD =>
          if(cnt_rst_done_s = '1') then
            fsm_ctrl_s <= INIT_LCD;
          end if;

        when INIT_LCD =>

        when others => null;
      end case;
    end if;
  end process p_fsm_controller;


  -- purpose: This process manages the reset of the LCD 
  p_cnt_rst_mng : process (clock_i, reset_n_i)
  begin  -- process p_cnt_rst_mng
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      cnt_rst_s      <= (others => '0');
      cnt_rst_done_s <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(fsm_ctrl_s = RST_LCD) then
        if(cnt_rst_s < C_MAX_CNT_1US - 1) then
          cnt_rst_s      <= cnt_rst_s + 1;
          cnt_rst_done_s <= '0';
        else
          cnt_rst_s      <= (others => '0');
          cnt_rst_done_s <= '1';
        end if;
      else
        cnt_rst_s      <= (others => '0');
        cnt_rst_done_s <= '0'
      end if;
    end if;
  end process p_cnt_rst_mng;


  -- ==== END MAIN FSM MANAGEMENT ==




  -- DEBUG purpose: This process manages the send of the command on the bus
  p_start_rw_mng : process (clock_i, reset_n_i)
    variable v_en_start : std_logic := '0';  -- init for test
  begin  -- process p_start_rw_mng
    if reset_n_i = '0' then                  -- asynchronous reset (active low)
      start_rw_s <= '0';
      rw_i_s     <= '0';
      a0_i_s     <= '0';
      wdata_s    <= (others => '0');
      rdata_s    <= (others => '0');
      v_en_start := '0';

    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(rw_done_s = '1' and v_en_start = '0') then
        start_rw_s <= '1';
        rw_i_s     <= '1';
        a0_i_s     <= '1';
        v_en_start := '1';
      else
        start_rw_s <= '0';
      end if;
    end if;
  end process p_start_rw_mng;


  -- ==== RW BUS MANAGEMENT ==

  -- purpose: This process manages the bus RW
  p_fsm_rw_mng : process (clock_i, reset_n_i)
  begin  -- process p_fsm_rw_mng
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      fsm_rw_s        <= IDLE;
      rw_o_s          <= '0';
      a0_s            <= '0';
      en1_o_s         <= '1';           -- A verifier
      en2_o_s         <= '1';
      en_data_io_s    <= '0';           -- Set 'Z' on the bus
      data_o_s        <= (others => '0');
      start_cnt_1us_s <= '0';
      rw_done_s       <= '1';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      case fsm_rw_s is

        when IDLE =>
          if(start_rw_s = '1') then
            fsm_rw_s        <= SET_RW_REG;
            en1_o_s         <= '0';
            en2_o_s         <= '0';
            start_cnt_1us_s <= '1';
            rw_done_s       <= '1';
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
          rw_done_s    <= '0';
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
  data_io  <= data_o_s when en_data_io_s = '1' else (others => 'Z');  -- Write on the bus
  data_i_s <= data_io;                  -- Read from the bus



  -- purpose : This process manages the counters for the FSM rw
  p_cnt_1us : process(clock_i, reset_n_i)
  begin  -- process p_cnt_1us
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      cnt_1us_s          <= (others => '0');
      cnt_1us_done_s     <= '0';
      cnt_tacc_rd_s      <= (others => '0');
      cnt_tacc_rd_done_s <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge

      if(start_cnt_1us_s = '1') then
        if(cnt_1us_s < C_MAX_CNT_1US - 1) then
          cnt_1us_done_s <= '0';
          cnt_1us_s      <= cnt_1us_s + 1;
        else
          cnt_1us_done_s <= '1';
          cnt_1us_s      <= (others => '0');
        end if;
      else
        cnt_1us_s      <= (others => '0');
        cnt_1us_done_s <= '0';
      end if;

      if(fsm_rw_s = RD_DATA) then
        if((cnt_tacc_rd_s < C_MAX_TACC_RD - 1) and cnt_tacc_rd_done_s = '0') then
          cnt_tacc_rd_s <= cnt_tacc_rd_s + 1;  -- Inc cnt
        elsif(cnt_tacc_rd_s = C_MAX_TACC_RD - 1) then
          cnt_tacc_rd_s      <= (others => '0');
          cnt_tacc_rd_done_s <= '1';
        elsif(cnt_tacc_rd_done_s = '1') then
          cnt_tacc_rd_done_s <= '0';
        end if;
      else
        cnt_tacc_rd_s      <= (others => '0');
        cnt_tacc_rd_done_s <= '0';
      end if;

    end if;
  end process p_cnt_1us;

  -- == END RW BUS MANAGEMENT ==


end architecture arch_lcd12232_ctrl;
