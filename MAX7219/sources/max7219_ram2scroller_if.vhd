-------------------------------------------------------------------------------
-- Title      : MAX7219 RAM to SCROLLER I/F
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_ram2scroller_if.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2020-08-28
-- Last update: 2020-09-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 RAM to SCROLLER I/F
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-08-28  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_ram2scroller_if is
  generic (
    G_MATRIX_NB      : integer range 2 to 8 := 8;   -- MATRIX NUMBER
    G_RAM_ADDR_WIDTH : integer              := 8;   -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH : integer              := 8);  -- RAM DATA WIDTH

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- EXTERNAL I/F
    i_start         : in std_logic;     -- START SCROLL
    i_msg_length    : in std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
    i_ram_start_ptr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);

    -- RAM I/F
    i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA
    o_me    : out std_logic;            -- Memory Enable
    o_we    : out std_logic;            -- W/R command
    o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR

    -- RAM SCROLLER I/F
    o_seg_data       : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- SEG DATA
    o_seg_data_valid : out std_logic;   -- SEG DATA VAL

    i_scroller_if_busy : in  std_logic;
    o_busy             : out std_logic);  -- Scroller Controller Busy
end entity max7219_ram2scroller_if;


architecture behv of max7219_ram2scroller_if is

  -- INTERNAL SIGNALS
  signal s_busy                    : std_logic;  -- Busy
  signal s_start                   : std_logic;  -- Start Pipe
  signal s_start_r_edge            : std_logic;  -- Start R EDGE
  signal s_scroller_if_busy        : std_logic;  -- S_scroller if busy pipe
  signal s_scroller_if_busy_f_edge : std_logic;
  signal s_inputs_val              : std_logic;
  signal s_we                      : std_logic;
  signal s_me                      : std_logic;
  signal s_me_p                    : std_logic;
  signal s_rdata_valid             : std_logic;
  signal s_read_ram_done           : std_logic;  -- Last Ram Data Read
  signal s_scroller_access_done    : std_logic;  -- Number of scroller access done

  signal s_msg_length    : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
  signal s_ram_start_ptr : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_ram_addr      : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_rdata         : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
  signal s_access_cnt    : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);

begin  -- architecture behv

  p_pipe_in : process (clk, rst_n) is
  begin  -- process p_pipe_in
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start            <= '0';
      s_scroller_if_busy <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_start            <= i_start;
      s_scroller_if_busy <= i_scroller_if_busy;
    end if;
  end process p_pipe_in;

  -- Rising Edge Management
  s_start_r_edge <= i_start and not s_start;

  -- Falling Edge Management
  s_scroller_if_busy_f_edge <= not i_scroller_if_busy and s_scroller_if_busy;


  p_latch_in : process (clk, rst_n) is
  begin  -- process p_latch_in
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_msg_length <= (others => '0');
      s_inputs_val <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_start_r_edge = '1') then

        -- Only if not busy
        if(s_busy = '0') then
          s_msg_length <= i_msg_length;
          s_inputs_val <= '1';
        end if;
      else
        s_inputs_val <= '0';
      end if;

    end if;
  end process p_latch_in;


  p_ram_rd_access_mngt : process (clk, rst_n) is
  begin  -- process p_ram_rd_access_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_ram_addr      <= (others => '0');
      s_me            <= '0';
      s_we            <= '0';
      s_me_p          <= '0';
      s_rdata         <= (others => '0');
      s_rdata_valid   <= '0';
      s_read_ram_done <= '0';
      s_access_cnt    <= unsigned(8*G_MATRIX_NB);
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_me_p <= s_me;

      -- Init Start Addr
      if(s_start_r_edge = '1') then
        s_ram_addr <= i_ram_start_ptr;
      end if;

      -- 1st access from start
      if(s_inputs_val = '1') then
        s_me <= '1';
        s_we <= '0';

      -- Next access
      elsif(s_scroller_if_busy_f_edge = '1') then
        s_me <= '1';
        s_we <= '0';
      else
        s_me <= '0';
        s_we <= '0';
      end if;

      if(s_me_p = '1' and s_read_ram_done = '0') then
        s_rdata       <= i_rdata;
        s_rdata_valid <= '1';
        if(unsigned(s_ram_addr) < unsigned(s_ram_addr) + unsigned(s_msg_length)) then
          s_ram_addr <= unsigned(s_ram_addr) + 1;
        else
          s_read_ram_done <= '1';
        end if;
      elsif(s_read_ram_done = '1') then
        
      else
        s_rdata         <= (others => '0');
        s_read_ram_done <= '0';
        s_rdata_valid   <= '0';
      end if;


    end if;
  end process p_ram_rd_access_mngt;

  p_busy_mngt : process (clk, rst_n) is
  begin  -- process p_busy_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_busy <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- On start Rising Edge
      if(s_start_r_edge = '1') then
        s_busy <= '1';
      elsif(s_scroller_access_done = '1') then
        s_busy <= '0';
      end if;

    end if;

  end process p_busy_mngt;


  -- Outputs Affectations
  o_busy           <= s_busy;
  o_seg_data       <= s_rdata;
  o_seg_data_valid <= s_rdata_valid;

end architecture behv;
