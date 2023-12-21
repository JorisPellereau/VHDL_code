-------------------------------------------------------------------------------
-- Title      : Write FIFO Management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : wr_fifo_mngt.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-12-06
-- Last update: 2023-12-21
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Management of the write access to the FIFO
-- Limitation : This block doesn't detect if a FIFO is full during a write access to the FIFO. The Fifo FULL
-- is detected only on the start command.
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-12-06  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity wr_fifo_mngt is

  generic (
    G_MATRIX_NB : integer range 1 to 8 := 4                            -- Number of Matrix
    );
  port (
    clk_sys    : in  std_logic;                                        -- Clock System
    rst_n_sys  : in  std_logic;                                        -- Asynchronous Reset
    cmd_start  : in  std_logic;                                        -- Command Start
    cmd        : in  std_logic_vector(13 downto 0);                    -- Possible Commands
    cmd_data   : in  std_logic_vector(7 downto 0);                     -- Data Command
    matrix_idx : in  std_logic_vector(log2(G_MATRIX_NB) -1 downto 0);  -- Number of Matrix
    wr_en      : out std_logic;                                        -- Fifo Write Access
    wdata      : out std_logic_vector(16 downto 0);                    -- DAta to write in the fifo
    fifo_full  : in  std_logic;                                        -- FIFO Full
    fifo_empty : in  std_logic;                                        -- Fifo Empty
    done       : out std_logic;                                        -- Write access is terminated
    status     : out std_logic                                         -- Output Status : 0 OK - 1 NOK
    );

end entity wr_fifo_mngt;

architecture rtl of wr_fifo_mngt is

  -- == CONSTANTS ==
  constant C_CMD_NOOP         : std_logic_vector(13 downto 0) := "00" & x"001";  -- NULL Command
  constant C_CMD_D0           : std_logic_vector(13 downto 0) := "00" & x"002";  -- Digit 0 Command
  constant C_CMD_D1           : std_logic_vector(13 downto 0) := "00" & x"004";  -- Digit 1 Command
  constant C_CMD_D2           : std_logic_vector(13 downto 0) := "00" & x"008";  -- Digit 2 Command
  constant C_CMD_D3           : std_logic_vector(13 downto 0) := "00" & x"010";  -- Digit 3 Command
  constant C_CMD_D4           : std_logic_vector(13 downto 0) := "00" & x"020";  -- Digit 4 Command
  constant C_CMD_D5           : std_logic_vector(13 downto 0) := "00" & x"040";  -- Digit 5 Command
  constant C_CMD_D6           : std_logic_vector(13 downto 0) := "00" & x"080";  -- Digit 6 Command
  constant C_CMD_D7           : std_logic_vector(13 downto 0) := "00" & x"100";  -- Digit 7 Command
  constant C_CMD_DECODE_MODE  : std_logic_vector(13 downto 0) := "00" & x"200";  -- DECOD Mode Command
  constant C_CMD_INTENSITY    : std_logic_vector(13 downto 0) := "00" & x"400";  -- Intensity Command
  constant C_CMD_SCAN_LIMIT   : std_logic_vector(13 downto 0) := "00" & x"800";  -- SCAN LIMIT Command
  constant C_CMD_SHUTDOWN     : std_logic_vector(13 downto 0) := "01" & x"000";  -- SHUTDOWN Command
  constant C_CMD_DISPLAY_TEST : std_logic_vector(13 downto 0) := "10" & x"000";  -- Display Test Command

  -- == INTERNAL Signals ==
  signal addr_reg     : std_logic_vector(3 downto 0);                      -- Addr Register
  signal cmd_data_p   : std_logic_vector(7 downto 0);                      -- Command Data to send
  signal matrix_idx_p : std_logic_vector(log2(G_MATRIX_NB) - 1 downto 0);  -- Matrix Number
  signal cnt_wr_en    : unsigned(log2(G_MATRIX_NB) -1 downto 0);           -- Counter for Write Enable
  signal load_en      : std_logic;                                         -- Load Enable Flag
  signal wr_en_int    : std_logic;                                         -- Write Enable

begin  -- architecture rtl

  -- purpose: Addr Decoder - comb.
  addr_reg <= (others => '0') when cmd = C_CMD_NOOP else
              x"1" when cmd = C_CMD_D0 else
              x"2" when cmd = C_CMD_D1 else
              x"3" when cmd = C_CMD_D2 else
              x"4" when cmd = C_CMD_D3 else
              x"5" when cmd = C_CMD_D4 else
              x"6" when cmd = C_CMD_D5 else
              x"7" when cmd = C_CMD_D6 else
              x"8" when cmd = C_CMD_D7 else
              x"9" when cmd = C_CMD_DECODE_MODE else
              x"A" when cmd = C_CMD_INTENSITY else
              x"B" when cmd = C_CMD_SCAN_LIMIT else
              x"C" when cmd = C_CMD_SHUTDOWN else
              x"F" when cmd = C_CMD_DISPLAY_TEST else
              (others => '0');

  -- purpose: MAX Counter update 
  p_max_cnt_update : process (clk_sys, rst_n_sys) is
  begin  -- process p_max_cnt_update
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      matrix_idx_p <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      if(cmd_start = '1') then
        matrix_idx_p <= matrix_idx;
      end if;


    end if;
  end process p_max_cnt_update;


  -- purpose: Command Data pipe 
  p_cmd_data_pipe : process (clk_sys, rst_n_sys) is
  begin  -- process p_cmd_data_pipe
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cmd_data_p <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      if(cmd_start = '1') then
        cmd_data_p <= cmd_data;
      end if;

    end if;
  end process p_cmd_data_pipe;


  -- purpose: Counter Management
  p_cnt_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_wr_en <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Load the Counter on start
      if(cmd_start = '1') then
        cnt_wr_en <= unsigned(matrix_idx);

      -- Downcouter otherwise
      else
        cnt_wr_en <= cnt_wr_en - 1;     -- Downcounter
      end if;

    end if;
  end process p_cnt_mngt;

  -- purpose: Write Enable Management 
  p_wr_en_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_wr_en_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      wr_en_int <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- First Start. Enable only if the fifo is not full
      if(cmd_start = '1' and fifo_full = '0') then
        wr_en_int <= '1';

      -- Disable the signal when the counter reach 0
      elsif(cnt_wr_en = "0000") then
        wr_en_int <= '0';
      end if;

    end if;
  end process p_wr_en_mngt;


  -- purpose: Wdata Management 
  p_wdata_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_wdata_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      wdata <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Case : Start with index number different from 0 -> NO LOAD SIGNAL generated
      if(cmd_start = '1' and matrix_idx /= std_logic_vector(to_unsigned(0, matrix_idx'length))) then
        wdata <= '0' & x"0" & addr_reg & cmd_data;

      -- Case : Start with index number equals to 0 -> LOAD SIGNAL generated
      elsif(cmd_start = '1' and matrix_idx = std_logic_vector(to_unsigned(0, matrix_idx'length))) then
        wdata <= '1' & x"0" & addr_reg & cmd_data;

      -- Others Case : generate NOOP command with the load signal on the MSBit
      else
        wdata <= load_en & x"0" & x"000";
      end if;

    end if;
  end process p_wdata_mngt;

  -- purpose: Status Management
  p_status_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_status_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      status <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      if(cmd_start = '1' and fifo_full = '1') then
        status <= '1';
      else
        status <= '0';
      end if;
    end if;
  end process p_status_mngt;


  -- == Outputs Affectations ==
  wr_en <= wr_en_int;                   -- Write Enable Affectaion

  load_en <= '1' when cnt_wr_en = "0001" else '0';  -- A flag for the Load enable

  done <= '1' when wr_en_int = '1' and cnt_wr_en = "0000" else  -- Done generated only when wr_en_int is set with load_en
          '1' when cmd_start = '1' and fifo_full = '1' else     -- Done generated in case of Fifo Full on a start command
          '0';

end architecture rtl;
