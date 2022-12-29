-------------------------------------------------------------------------------
-- Title      : Update Display Management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_update_display.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-12-24
-- Last update: 2022-12-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Update display management block
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-12-24  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah.all;

entity lcd_cfah_update_display is

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    i_update_lcd        : in std_logic;  -- Update LCD Command
    i_lcd_all_char      : in std_logic;  -- All Char or One char selection
    i_lcd_line_sel      : in std_logic;  -- Line 0 or 1 selection
    i_lcd_char_position : in std_logic_vector(3 downto 0);  -- Character position selection

    -- Command Done
    i_cmd_done : in std_logic;          -- Command done from Command buffer

    -- LCD Commands
    o_set_ddram_addr     : out std_logic;  -- SET DDRAM ADDR Command
    o_wr_data            : out std_logic;  -- Write data to RAM command
    o_ddram_data_or_addr : out std_logic_vector(7 downto 0);  -- Data or Addr bus

    -- LINE BUFFER I/F
    i_rdata       : in  std_logic_vector(7 downto 0);  -- Line RDATA
    i_rdata_val   : in  std_logic;                     -- Line RDATA Valid
    o_rd_req      : out std_logic;                     -- Read Request
    o_rd_char_pos : out std_logic_vector(3 downto 0);  -- Char Position
    o_rd_line_sel : out std_logic;                     -- Line selection

    o_update_ongoing : out std_logic;   -- Update ongoing flag

    -- LCD Update done flag
    o_update_done : out std_logic       -- LCD Update Done

    );

end entity lcd_cfah_update_display;

architecture rtl of lcd_cfah_update_display is

  -- INTERNAL Signals
  signal s_lcd_all_char      : std_logic;  -- Input latch
  signal s_lcd_line_sel      : std_logic;  -- Line selection
  signal s_lcd_char_position : std_logic_vector(3 downto 0);  -- Char position
  signal s_start             : std_logic;  -- Start Update of LCD
  signal s_wr_data_cnt       : std_logic_vector(5 downto 0);  -- WR DATA command counter
  signal s_wr_data_cnt_max   : std_logic_vector(5 downto 0);  -- WR DATA command
                                                              -- counter MAX

  signal s_en_rd_req      : std_logic;  -- Enable Read Request
  signal s_en_rd_req_p    : std_logic;  -- Read Req signal piped one time
  signal s_update_ongoing : std_logic;  -- Update ongoing
  signal s_update_done    : std_logic;  -- Update done
  signal s_wr_cnt_up      : std_logic;  -- Counter inc by one

begin  -- architecture rtl


  -- purpose: Pipe internal signals
  p_pipe_sig : process (clk, rst_n) is
  begin  -- process p_pipe_sig
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_en_rd_req_p <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_en_rd_req_p <= s_en_rd_req;
    end if;
  end process p_pipe_sig;

  -- purpose: Start Management
  p_start_mngt : process (clk, rst_n) is
  begin  -- process p_start_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_lcd_all_char      <= '0';
      s_lcd_line_sel      <= '0';
      s_lcd_char_position <= (others => '0');
      s_start             <= '0';
      s_wr_data_cnt_max   <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Update internal signal on update and start (pulse)
      if(i_update_lcd = '1') then
        s_lcd_all_char      <= i_lcd_all_char;
        s_lcd_line_sel      <= i_lcd_line_sel;
        s_lcd_char_position <= i_lcd_char_position;
        s_start             <= '1';

        -- If one -> 32 Char to update
        if(i_lcd_all_char = '1') then
          s_wr_data_cnt_max <= std_logic_vector(conv_unsigned(32, s_wr_data_cnt_max'length));

        -- All case -> Only one Char updated
        else
          s_wr_data_cnt_max <= std_logic_vector(conv_unsigned(1, s_wr_data_cnt_max'length));
        end if;

      -- Case All Char and end of first 16 characters
      elsif(s_lcd_all_char = '1' and i_cmd_done = '1') then
        if(unsigned(s_wr_data_cnt) = conv_unsigned(16-1, s_wr_data_cnt'length)) then
          s_start <= '1';
        else
          s_start <= '0';
        end if;

      else
        s_start <= '0';
      end if;

    end if;
  end process p_start_mngt;



  -- purpose: LCD Command generation 
  p_lcd_cmd_mngt : process (clk, rst_n) is
  begin  -- process p_lcd_cmd_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_set_ddram_addr     <= '0';
      o_wr_data            <= '0';
      o_ddram_data_or_addr <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- SET DDRAM ADDR Command on start or when new line sel
      if(s_start = '1') then
        o_set_ddram_addr <= '1';

        -- Update all Char -> first 0x00 and then 0x40
        if(s_lcd_all_char = '1') then
          if(unsigned(s_wr_data_cnt) = conv_unsigned(0, s_wr_data_cnt'length)) then
            o_ddram_data_or_addr <= (others => '0');
          elsif(unsigned(s_wr_data_cnt) = conv_unsigned(16, s_wr_data_cnt'length)) then
            o_ddram_data_or_addr <= x"40";
          end if;
        else
          o_ddram_data_or_addr <= "0" & s_lcd_line_sel & "00" & s_lcd_char_position;
        end if;
      else
        o_set_ddram_addr <= '0';
      end if;

      -- Generates a WR_data command when a data is read out from line buffer
      if(i_rdata_val = '1') then
        o_wr_data            <= '1';
        o_ddram_data_or_addr <= i_rdata;
      else
        o_wr_data <= '0';
      end if;

    end if;
  end process p_lcd_cmd_mngt;



  -- purpose: Enable Read Request
  p_en_rd_req : process (clk, rst_n) is
  begin  -- process p_en_rd_req
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_en_rd_req <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- 1st i_cmd_done is detected (command set_addr)
      if(s_en_rd_req = '0' and i_cmd_done = '1' and s_update_ongoing = '1') then
        s_en_rd_req <= '1';
      elsif(s_lcd_all_char = '1' and i_cmd_done = '1') then

        -- Reset signal for 2nd line
        if(unsigned(s_wr_data_cnt) = conv_unsigned(16-1, s_wr_data_cnt'length)) then
          s_en_rd_req <= '0';
        end if;

      -- Reset flag when all done  
      elsif(s_update_done = '1') then
        s_en_rd_req <= '0';
      end if;
    end if;
  end process p_en_rd_req;



  -- purpose: Read line buffer mngt
  p_read_line_buffer_mngt : process (clk, rst_n) is
  begin  -- process p_read_line_buffer_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_rd_req      <= '0';
      o_rd_char_pos <= (others => '0');
      o_rd_line_sel <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- When en_rd_req rising edge is detected or when in en_rd_req mode
      -- and a command is terminated (s_wr_cnt_up updated) -> we start a new read request
      -- Do it until max is not reach
      if(s_en_rd_req = '1' and (s_en_rd_req_p = '0' or s_wr_cnt_up = '1') and s_update_ongoing = '1') then
        if(unsigned(s_wr_data_cnt) < unsigned(s_wr_data_cnt_max)) then
          o_rd_req <= '1';

          -- All Char read -> Char pos get [3:0] of counter
          if(s_lcd_all_char = '1') then
            o_rd_char_pos <= s_wr_data_cnt(3 downto 0);
            o_rd_line_sel <= s_wr_data_cnt(4);  -- Line selection

          -- Case 1 char to read
          else
            o_rd_char_pos <= s_lcd_char_position;
            o_rd_line_sel <= s_lcd_line_sel;
          end if;
        else
          o_rd_req      <= '0';
          o_rd_char_pos <= (others => '0');
          o_rd_line_sel <= '0';
        end if;
      elsif(s_update_done = '1') then

        o_rd_req      <= '0';
        o_rd_char_pos <= (others => '0');
        o_rd_line_sel <= '0';

      else
        o_rd_req <= '0';                -- Pulse
      end if;

    end if;
  end process p_read_line_buffer_mngt;



  -- purpose: WR data command access counter 
  p_wr_data_access_cnt : process (clk, rst_n) is
  begin  -- process p_wr_data_access_cnt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_wr_data_cnt <= (others => '0');
      s_wr_cnt_up   <= '0';
      s_update_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- During Update
      if(s_update_ongoing = '1') then
        -- When read Enable and a command is done
        if(i_cmd_done = '1' and s_en_rd_req = '1') then
          if(unsigned(s_wr_data_cnt) < unsigned(s_wr_data_cnt_max)) then
            s_wr_data_cnt <= unsigned(s_wr_data_cnt) + 1;  -- Inc counter
            s_update_done <= '0';
            s_wr_cnt_up   <= '1';
          -- else
          --   s_update_done <= '1';
          --   s_wr_cnt_up   <= '0';
          end if;

        -- When Counter is reach -> Update done and reset counter
        elsif(unsigned(s_wr_data_cnt) = unsigned(s_wr_data_cnt_max)) then
          s_update_done <= '1';
          s_wr_cnt_up   <= '0';
          s_wr_data_cnt <= (others => '0');

        else
          s_update_done <= '0';
          s_wr_cnt_up   <= '0';
        end if;

      else
        s_update_done <= '0';
        s_wr_cnt_up   <= '0';
      end if;
    end if;
  end process p_wr_data_access_cnt;


  -- purpose: Ongoing flag management 
  p_ongoing_mngt : process (clk, rst_n) is
  begin  -- process p_ongoing_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_update_ongoing <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_start = '1') then
        s_update_ongoing <= '1';
      elsif(s_update_done = '1') then
        s_update_ongoing <= '0';
      end if;
    end if;
  end process p_ongoing_mngt;

  -- Output affectation
  o_update_ongoing <= s_update_ongoing;
  o_update_done    <= s_update_done;


end architecture rtl;
