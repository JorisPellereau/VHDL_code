-------------------------------------------------------------------------------
-- Title      : CLD CFAH Command buffer
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_cmd_buffer.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-12-02
-- Last update: 2022-12-02
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Buffer command and check if lcd is busy or not. If not busy
-- send command req. Otherwise send busy polling until lcd becime not busy
-- Limitation : Only one command shall be send at a time
-- Command are buffered but no fifo manages command
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-12-02  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah.all;



entity lcd_cfah_cmd_buffer is

  generic (
    G_NB_CMD : integer := 11);          -- Number of possible Command

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Commands from specific block
    i_clear_display : in std_logic;     -- Clear Display Cmd request
    i_return_home   : in std_logic;     -- Return Home Cmd Request

    i_entry_mode_set : in std_logic;    -- Entry Mode Set Cmd Request
    i_id_sh          : in std_logic_vector(1 downto 0);  -- Bits Control

    i_display_ctrl : in std_logic;      -- Display ON/OFF Ctrl Cmd Req
    i_dcb          : in std_logic_vector(2 downto 0);  -- Control bits

    i_cursor_display_shift : in std_logic;  -- Cursor Display Shift Cmd Req
    i_sc_rl                : in std_logic_vector(1 downto 0);  -- Cursor Display Bits control

    i_function_set   : in std_logic;    -- Function Set cmd Req
    i_set_gcram_addr : in std_logic;    -- Set CGRAM Address Command Req
    i_set_ddram_addr : in std_logic;    -- Set DDRAM Address Command Req
    i_read_busy_flag : in std_logic;    -- Read Busy Flag and Addr command Req
    i_wr_data        : in std_logic;    -- Write Data to RAM Command Req
    i_rd_data        : in std_logic;    -- Read Data from RAM Command Req
    i_data_bus       : in std_logic_vector(7 downto 0);  -- Write data bus


    i_cmd_done : in  std_logic;         -- Command Done
    o_cmd_done : out std_logic;         -- Command Done

    -- Outputs to Commands Generator
    o_cmd_req  : out std_logic;         -- Command Request
    o_cmd      : out std_logic_vector(G_NB_CMD - 1 downto 0);  -- Command bus
    o_id_sh    : out std_logic_vector(1 downto 0);  -- Bits Control
    o_dcb      : out std_logic_vector(2 downto 0);  -- Control bits
    o_sc_rl    : out std_logic_vector(1 downto 0);  -- Cursor Display Bits control 
    o_data_bus : out std_logic_vector(7 downto 0);  -- Write data bus

    -- BUSY SCROLLER I/F
    i_lcd_rdy    : in  std_logic;       -- LCD Ready
    o_start_poll : out std_logic;       -- Start Polling command

    );

end entity lcd_cfah_cmd_buffer;


architecture rtl of lcd_cfah_cmd_buffer is

  -- INTERNAL signals
  signal s_cmd       : std_logic_vector(G_NB_CMD - 1 downto 0);  -- Command Latch
  signal s_id_sh     : std_logic_vector(1 downto 0);  -- ID SH latch
  signal s_dcb       : std_logic_vector(2 downto 0);  -- DCB Latch
  signal s_sc_rl     : std_logic_vector(1 downto 0);  -- sc rl Latch 
  signal s_data_bus  : std_logic_vector(7 downto 0);  -- data bus latch
  signal s_cmd_latch : std_logic;       -- A new command was detected
  signal s_cmd_req   : std_logic;       -- Command request

begin  -- architecture rtl

  -- purpose: Latch input commands
  p_latch_cmd : process (clk, rst_n) is
  begin  -- process p_latch_cmd
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cmd       <= (others => '0');
      s_id_sh     <= (others => '0');
      s_dcb       <= (others => '0');
      s_sc_rl     <= (others => '0');
      s_data_bus  <= (others => '0');
      s_cmd_latch <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_cmd_latch <= '0';
      if(i_clear_display = '1') then
        s_cmd(0)    <= '1';
        s_cmd_latch <= '1';
      end if;

      if(i_return_home <= '0') then
        s_cmd(1)    <= '1';
        s_cmd_latch <= '1';
      end if;

      if(i_entry_mode_set = '1') then
        s_cmd(2)    <= '1';
        s_id_sh     <= i_id_sh;
        s_cmd_latch <= '1';
      end if;

      if(i_display_ctrl = '1') then
        s_cmd(3)    <= '1');
        s_dcb       <= i_dcb;
        s_cmd_latch <= '1';
      end if;

      if(i_cursor_display_shift = '1') then
        s_cmd(4)    <= '1';
        s_sc_rl     <= i_sc_rl;
        s_cmd_latch <= '1';
      end if;

      if(i_function_set = '1') then
        s_cmd(5)    <= '1';
        s_cmd_latch <= '1';
      end if;

      if(i_set_gcram_addr = '1') then
        s_cmd(6)    <= '1';
        s_data_bus  <= i_data_bus;
        s_cmd_latch <= '1';
      end if;

      if(i_set_ddram_addr = '1') then
        s_cmd(7)    <= '1';
        s_data_bus  <= i_data_bus;
        s_cmd_latch <= '1';
      end if;

      if(i_wr_data = '1') then
        s_cmd(8)    <= '1';
        s_data_bus  <= i_data_bus;
        s_cmd_latch <= '1';
      end if;

      if(i_rd_data = '1') then
        s_cmd(9)    <= '1';
        s_cmd_latch <= '1';
      end if;

      s_cmd(10) <= i_read_busy_flag;    -- Latch one time this command

      if(s_cmd_req = '1') then
        s_cmd_req <= (others => '0');
      end if;

    end if;
  end process p_latch_cmd;


  -- purpose: Busy Flag Check when new command is available
  p_busy_flag_check : process (clk, rst_n) is
  begin  -- process p_busy_flag_check
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_start_poll <= '0';
      s_cmd_req    <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- If not Rdy -> Run busy polling
      if(s_cmd_latch = '1' and i_lcd_rdy = '0') then
        o_start_poll <= '1';

      -- Run Command when ready
      elsif(i_lcd_rdy = '1') then
        s_cmd_req <= '1';

      -- Specific Command - When activate -> generate req
      elsif(i_read_busy_flag = '1') then
        s_cmd_req <= '1';
        
      else
        o_start_poll <= '0';
        s_cmd_req    <= '0';
      end if;
    end if;
  end process p_busy_flag_check;


  -- Output affectation
  o_cmd_req <= s_cmd_req;               -- Command Req

  -- Command
  o_cmd <= s_cmd;


  -- purpose: Command done Management - Pipe input to output
  p_done_mngt : process (clk, rst_n) is
  begin  -- process p_done_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_cmd_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      o_cmd_done <= i_cmd_done;
    end if;
  end process p_done_mngt;

end architecture rtl;
