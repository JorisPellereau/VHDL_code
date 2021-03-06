-------------------------------------------------------------------------------
-- Title      : Test for INIT MAX7219
-- Project    : 
-------------------------------------------------------------------------------
-- File       : init_max7219.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-12
-- Last update: 2020-04-13
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-12  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity init_max7219 is

  generic(
    G_MAX_CNT : std_logic_vector(31 downto 0) := x"02FAF080");
  port (
    clk       : in  std_logic;                       -- Clock
    rst_n     : in  std_logic;                       -- Asynch. reset
    i_done    : in  std_logic;                       -- MAX7219 I/F done
    o_cnt     : out std_logic;
    o_start   : out std_logic;                       -- Start the MAX7219 Frame
    o_en_load : out std_logic;                       -- Load
    o_data    : out std_logic_vector(15 downto 0));  -- Data

end entity init_max7219;

architecture behv of init_max7219 is

  -- TYPES
  type t_fsm_state is (IDLE, SET_INT, RAZ_1, SET_SCAN, RAZ_2, SET_DECOD, RAZ_3, SET_OP, RAZ_4, SET_DIG0, RAZ_5,
                       SET_DIG1, RAZ_6, SET_DIG2, RAZ_7, SET_DIG3, RAZ_8, SET_DIG4, RAZ_9, SET_DIG5, RAZ_10,
                       SET_DIG6, RAZ_11, SET_DIG7, RAZ_12);  -- FSM STATE

  -- INTERNAL SIGNALS
  signal s_current_state : t_fsm_state;
  signal s_next_state    : t_fsm_state;

  signal s_cnt_32b    : std_logic_vector(31 downto 0);  -- Counter 32 Bits
  signal s_cnt_done   : std_logic;
  signal s_cnt_done_p : std_logic;
  signal s_start_cnt  : std_logic;

  signal s_done   : std_logic;
  signal s_done_p : std_logic;
  signal s_cnt_o  : std_logic;

begin  -- architecture behv


  p_latch_in : process (clk, rst_n) is
  begin  -- process p_latch_in
    if rst_n = '0' then                 -- asynchronous reset (active low)

      s_done       <= '0';
      s_done_p     <= '0';
      s_cnt_done_p <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_done       <= i_done;
      s_done_p     <= s_done;
      s_cnt_done_p <= s_cnt_done;
    end if;
  end process p_latch_in;



  -- purpose: Management of the current state
  p_curr_state_mngt : process (clk, rst_n) is
  begin  -- process p_curr_state_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_current_state <= IDLE;
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_current_state <= s_next_state;
    end if;
  end process p_curr_state_mngt;

  -- purpose: Management of the next state
  p_next_state_mngt : process (clk, rst_n)  --process (s_current_state, s_done_p, s_cnt_done_p) is

  begin  -- process p_next_state_mngt
    if(rst_n = '0') then
      s_next_state <= IDLE;
    elsif(rising_edge(clk)) then


      case s_current_state is
        when IDLE =>
          if(s_cnt_done_p = '1') then
            s_next_state <= SET_INT;
          end if;

        when SET_INT =>
          s_next_state <= RAZ_1;

        when RAZ_1 =>
          if(s_done_p = '1') then
            s_next_state <= SET_SCAN;
          end if;

        when SET_SCAN =>
          s_next_state <= RAZ_2;

        when RAZ_2 =>
          if(s_done_p = '1') then
            s_next_state <= SET_DECOD;
          end if;

        when SET_DECOD =>
          s_next_state <= RAZ_3;

        when RAZ_3 =>
          if(s_done_p = '1') then
            s_next_state <= SET_OP;
          end if;

        when SET_OP =>
          s_next_state <= RAZ_4;

        when RAZ_4 =>
          if(s_done_p = '1') then
            s_next_state <= SET_DIG0;
          end if;


        when SET_DIG0 =>
          s_next_state <= RAZ_5;

        when RAZ_5 =>
          if(s_done_p = '1') then
            s_next_state <= SET_DIG1;
          end if;

        when SET_DIG1 =>
          s_next_state <= RAZ_6;

        when RAZ_6 =>
          if(s_done_p = '1') then
            s_next_state <= SET_DIG2;
          end if;

        when SET_DIG2 =>
          s_next_state <= RAZ_7;

        when RAZ_7 =>
          if(s_done_p = '1') then
            s_next_state <= SET_DIG3;
          end if;

        when SET_DIG3 =>
          s_next_state <= RAZ_8;

        when RAZ_8 =>
          if(s_done_p = '1') then
            s_next_state <= SET_DIG4;
          end if;

        when SET_DIG4 =>
          s_next_state <= RAZ_9;

        when RAZ_9 =>
          if(s_done_p = '1') then
            s_next_state <= SET_DIG5;
          end if;


        when SET_DIG5 =>
          s_next_state <= RAZ_10;

        when RAZ_10 =>
          if(s_done_p = '1') then
            s_next_state <= SET_DIG6;
          end if;


        when SET_DIG6 =>
          s_next_state <= RAZ_11;

        when RAZ_11 =>
          if(s_done_p = '1') then
            s_next_state <= SET_DIG7;
          end if;

        when SET_DIG7 =>
          s_next_state <= RAZ_12;

        when RAZ_12 =>
          if(s_done_p = '1') then
            s_next_state <= IDLE;
          end if;

        when others => null;
      end case;

    end if;
  end process p_next_state_mngt;


  -- purpose: Management of the outputs
  p_outputs_mngt : process (clk, rst_n) is
  begin  -- process p_outputs_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_start     <= '0';
      o_en_load   <= '0';
      o_data      <= (others => '0');
      s_start_cnt <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      case s_current_state is

        when IDLE =>
          o_en_load   <= '0';
          o_data      <= (others => '0');
          s_start_cnt <= '1';
          o_start     <= '0';

        when SET_INT =>
          s_start_cnt <= '0';
          o_data      <= x"0A00";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_1 =>
          o_start <= '0';

        when SET_SCAN =>
          s_start_cnt <= '0';
          o_data      <= x"0B07";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_2 =>
          o_start <= '0';

        when SET_DECOD =>
          s_start_cnt <= '0';
          o_data      <= x"0900";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_3 =>
          o_start <= '0';

        when SET_OP =>
          s_start_cnt <= '0';
          o_data      <= x"0C01";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_4 =>
          o_start <= '0';

        when SET_DIG0 =>
          s_start_cnt <= '0';
          o_data      <= x"013c";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_5 =>
          o_start <= '0';

        when SET_DIG1 =>
          s_start_cnt <= '0';
          o_data      <= x"0242";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_6 =>
          o_start <= '0';

        when SET_DIG2 =>
          s_start_cnt <= '0';
          o_data      <= x"03a9";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_7 =>
          o_start <= '0';

        when SET_DIG3 =>
          s_start_cnt <= '0';
          o_data      <= x"0485";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_8 =>
          o_start <= '0';


        when SET_DIG4 =>
          s_start_cnt <= '0';
          o_data      <= x"0585";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_9 =>
          o_start <= '0';

        when SET_DIG5 =>
          s_start_cnt <= '0';
          o_data      <= x"06A9";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_10 =>
          o_start <= '0';

        when SET_DIG6 =>
          s_start_cnt <= '0';
          o_data      <= x"0742";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_11 =>
          o_start <= '0';

        when SET_DIG7 =>
          s_start_cnt <= '0';
          o_data      <= x"083C";
          o_en_load   <= '1';
          o_start     <= '1';

        when RAZ_12 =>
          o_start <= '0';

        when others => null;
      end case;

    end if;

  end process p_outputs_mngt;


  -- purpose: Management of the counter 
  p_cnt_mngt : process (clk, rst_n) is
  begin  -- process p_cnt_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_32b  <= (others => '0');
      s_cnt_done <= '0';
      s_cnt_o    <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_start_cnt = '1') then

        if(s_cnt_32b < G_MAX_CNT) then
          s_cnt_32b <= unsigned(s_cnt_32b) + 1;  -- INC +1          
        else
          s_cnt_32b  <= (others => '0');
          s_cnt_done <= '1';
          s_cnt_o    <= not s_cnt_o;
        end if;
      else
        s_cnt_32b  <= (others => '0');
        s_cnt_done <= '0';
      end if;
    end if;
  end process p_cnt_mngt;


  o_cnt <= s_cnt_o;
end architecture behv;
