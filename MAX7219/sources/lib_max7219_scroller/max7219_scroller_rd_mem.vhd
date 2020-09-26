-------------------------------------------------------------------------------
-- Title      : MAX7219 SCROLLER - Memory Reader
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_scroller_rd_mem.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-07-25
-- Last update: 2020-07-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 SCROLLER - Memory Reader
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-07-25  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_scroller_rd_mem is

  generic (
    G_RAM_ADDR_WIDTH : integer := 8;    -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH : integer := 16;   -- RAM DATA_WIDTH
    G_DIGITS_NB      : integer := 8);   -- DIGITS NUMBER

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    i_start_scroll : in std_logic;      -- Start Scroll

    o_me    : out std_logic;            -- Memory Enable
    o_we    : out std_logic;            -- R/W enable
    o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
    i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM DATA

    o_msg2scroll_array : out t_msg2scroll_array(0 to 2**G_RAM_ADDR_WIDTH - 2);  -- Mesage to Scroll
    o_shift_nb         : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- Number of shift to perform
    o_start            : out std_logic);  -- Start

end entity max7219_scroller_rd_mem;


architecture behv of max7219_scroller_rd_mem is

  -- TYPES
  type t_scroller_rd_mem_states is (IDLE, RD_MSG_LENGTH, RD_MEM);  -- States

  -- INTERNAL SIGNALS
  signal s_start_scroll        : std_logic;  -- Latch i_start_scroll
  signal s_start_scroll_r_edge : std_logic;  -- R EDGE pf i_start_scroll

  signal s_current_state : t_scroller_rd_mem_states;
  signal s_next_state    : t_scroller_rd_mem_states;

  signal s_me         : std_logic;      -- Memory Enable
  signal s_me_p1      : std_logic;      -- Memory Enable
  signal s_we         : std_logic;      -- R/W memory
  signal s_addr       : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
  signal s_msg_length : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- Message length

  signal s_read_msg_length    : std_logic;  -- Read Message Length
  signal s_read_msg_length_p1 : std_logic;  -- Read Message Length
  signal s_read_ram           : std_logic;  -- Read RAM info.
  signal s_read_done          : std_logic;  -- Read Done

  signal s_shift_nb : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- Shift Number


begin  -- architecture behv


  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start_scroll       <= '0';
      s_read_msg_length_p1 <= '0';
      s_me_p1              <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge      
      s_start_scroll       <= i_start_scroll;
      s_read_msg_length_p1 <= s_read_msg_length;
      s_me_p1              <= s_me;
    end if;
  end process p_latch_inputs;


  -- R EDGE DETECTION
  s_start_scroll_r_edge <= i_start_scroll and not s_start_scroll;


  p_curr_state_update : process (clk, rst_n) is
  begin  -- process p_curr_state_update
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_current_state <= IDLE;
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_current_state <= s_next_state;
    end if;
  end process p_curr_state_update;

  p_next_state_computation : process (clk, rst_n) is
  begin  -- process p_next_state_computation
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_next_state <= IDLE;
    elsif clk'event and clk = '1' then  -- rising clock edge
      case s_current_state is
        when IDLE =>
          if(s_start_scroll_r_edge = '1') then
            s_next_state <= RD_MSG_LENGTH;
          end if;

        when RD_MSG_LENGTH =>

        when RD_MEM =>

        when others => null;
      end case;
    end if;
  end process p_next_state_computation;

  p_rd_mem_access : process (clk, rst_n) is
  begin  -- process p_rd_mem_access
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_me              <= '0';
      s_we              <= '0';
      s_addr            <= (others => '0');
      s_read_msg_length <= '0';
      s_read_ram        <= '0';
      s_read_done       <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_start_scroll_r_edge = '1') then
        s_me              <= '1';
        s_we              <= '0';       -- Read Access
        s_read_msg_length <= '1';
      else
        s_me              <= '0';
        s_we              <= '0';       -- Read Access
        s_read_msg_length <= '0';
      end if;

      if(s_read_msg_length_p1 = '1') then
        s_addr     <= unsigned(s_addr) + 1;
        s_read_ram <= '1';
      end if;



      if(s_read_ram = '1') then
        if(unsigned(s_addr) < unsigned(s_msg_length) + 1) then
          s_me <= '1';
          s_we <= '0';
        --s_addr <= unsigned(s_addr) + 1;
        else
          s_me        <= '0';
          s_addr      <= (others => '0');
          s_read_done <= '1';
          s_read_ram  <= '0';
        end if;

        if(s_me_p1 = '1') then
          s_addr <= unsigned(s_addr) + 1;
        end if;
      else
        s_read_done <= '0';
      end if;


    end if;
  end process p_rd_mem_access;

  p_rd_mem_data_mngt : process (clk, rst_n) is
  begin  -- process p_rd_mem_data_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_msg_length       <= (others => '0');
      o_msg2scroll_array <= (others => (others => '0'));
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_read_msg_length_p1 = '1') then
        s_msg_length <= i_rdata;
      end if;

      if(s_read_ram = '1') then
        if(s_me_p1 = '1') then
          o_msg2scroll_array(conv_integer(unsigned(s_addr))) <= i_rdata;
        end if;
      end if;

    end if;
  end process p_rd_mem_data_mngt;


  p_shift_nb_mngt : process (clk, rst_n) is
  begin  -- process p_shift_nb_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_shift_nb <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_read_ram = '1') then
        s_shift_nb <= conv_unsigned(8*G_DIGITS_NB, s_shift_nb'length) + unsigned(s_msg_length);
      end if;
    end if;
  end process p_shift_nb_mngt;


  -- OUTPUTS AFFECTATION
  o_shift_nb <= s_shift_nb;
  o_start    <= s_read_done;
  o_me       <= s_me;
  o_we       <= s_we;
  o_addr     <= s_addr;

end architecture behv;
