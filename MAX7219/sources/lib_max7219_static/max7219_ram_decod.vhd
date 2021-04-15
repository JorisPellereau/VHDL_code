-------------------------------------------------------------------------------
-- Title      : MAX7219 RAM decoder
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_ram_decod.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-13
-- Last update: 2021-04-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 RAM decoder to MAX7219 I/F
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-13  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219_static;
use lib_max7219_static.pkg_max7219_static.all;


entity max7219_ram_decod is

  generic (
    G_RAM_ADDR_WIDTH : integer                       := 8;   -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH : integer                       := 16;  -- RAM DATA WIDTH
    G_MAX_CNT_32B    : std_logic_vector(31 downto 0) := x"02FAF080");  -- MAX CNT

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous reset
    i_en  : in std_logic;               -- Enable the function

    -- RAM I/F
    o_me    : out std_logic;            -- MEMORY ENABLE
    o_we    : out std_logic;            -- W/R COMMAND
    o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
    i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

    -- RAM INFO.
    i_start_ptr    : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- ST ADDR
    i_last_ptr     : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST ADDR
    i_ptr_val      : in  std_logic;     -- PTRS VALIDS
    i_loop         : in  std_logic;     -- LOOP CONFIG.
    o_ptr_equality : out std_logic;     -- ADDR = LAST PTR
    o_discard      : out std_logic;     -- Start of pattern discard

    -- MAX7219 I/F
    o_start   : out std_logic;                      -- MAX7219 START
    o_en_load : out std_logic;                      -- MAX7219 EN LOAD
    o_data    : out std_logic_vector(15 downto 0);  -- MAX7219 DATA
    i_done    : in  std_logic);                     -- MAX7219 DONE

end entity max7219_ram_decod;

architecture behv of max7219_ram_decod is

  -- INTERNAL SIGNALS
  signal s_decod_busy       : std_logic;  -- BLOCK BUSY
  signal s_start_ram_access : std_logic;  -- START RD RAM ACCESS
  signal s_me               : std_logic;  -- MEMORY ENABLE
  signal s_we               : std_logic;  -- W/R MEMORY COMMAND
  signal s_me_p1            : std_logic;  -- ME pipe 1
  signal s_me_p2            : std_logic;  -- ME pipe 2
  signal s_rdata_valid      : std_logic;  -- RDATA VALID from RAM
  signal s_en_load          : std_logic;  -- EN LOAD
  signal s_decod_done       : std_logic;  -- DECODE terminated
  signal s_start            : std_logic;  -- START MAX7219 I/F
  signal s_inc_done         : std_logic;  -- INC done
  signal s_max_cnt_valid    : std_logic;  -- MAX CNT valid
  signal s_start_cnt        : std_logic;  -- Start the counter 32b
  signal s_cnt_done         : std_logic;  -- Cnt reach
  signal s_ptr_equality     : std_logic;  -- ADDR = LAST_PTR
  signal s_update_ptr       : std_logic;  -- UPDATE PTR

  signal s_data        : std_logic_vector(15 downto 0);  -- DATA to MAX7219
  signal s_addr        : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
  signal s_rdata       : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RDATA
  signal s_cnt_32b     : std_logic_vector(31 downto 0);  -- Counter for wait between 2 commands
  signal s_max_cnt_32b : std_logic_vector(31 downto 0);  -- MAXIMUM for counter 32b

  signal s_start_ptr : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- START PTR
  signal s_last_ptr  : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST PTR

begin  -- architecture behv

  -- purpose: Last PTR Update
  p_last_ptr_update : process (clk, rst_n) is
  begin  -- process p_last_ptr_update
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start_ptr  <= (others => '0');
      s_last_ptr   <= (others => '0');
      s_update_ptr <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_ptr_val = '1' and s_ptr_equality = '1') then
        s_last_ptr   <= i_last_ptr;
        s_start_ptr  <= i_start_ptr;
        s_update_ptr <= '1';
      else
        s_update_ptr <= '0';
      end if;
    end if;
  end process p_last_ptr_update;


  p_last_ptr_comp : process (clk, rst_n) is
  begin  -- process p_last_ptr_comp
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_decod_busy       <= '0';
      s_start_ram_access <= '0';
      s_ptr_equality     <= '1';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_en = '1') then
        -- RAZ DECOD BUSY
        if(s_inc_done = '1') then
          s_decod_busy <= '0';
        end if;
        s_start_ram_access <= '0';      -- PULSE
        if(s_decod_busy = '0') then
          if(s_addr /= s_last_ptr) then
            s_start_ram_access <= '1';
            s_decod_busy       <= '1';
            s_ptr_equality     <= '0';
          else
            s_ptr_equality <= '1';
          end if;
        end if;
      else
        s_decod_busy       <= '0';
        s_start_ram_access <= '0';
      end if;
    end if;
  end process p_last_ptr_comp;

  -- purpose: Generate a READ RAM access
  p_rd_ram_access : process (clk, rst_n) is
  begin  -- process p_rd_ram_access
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_me <= '0';
      s_we <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_me <= '0';
      s_we <= '0';
      if(s_start_ram_access = '1') then
        s_we <= '0';
        s_me <= '1';
      end if;
    end if;
  end process p_rd_ram_access;

  -- purpose: Pipe s_me signal
  p_pipe_me : process (clk, rst_n) is
  begin  -- process p_pipe_me
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_me_p1 <= '0';
      s_me_p2 <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_me_p1 <= s_me;
      s_me_p2 <= s_me_p1;
    end if;
  end process p_pipe_me;

  -- purpose: Latch RDATA from RAM
  p_rdata_latch : process (clk, rst_n) is
  begin  -- process p_rdata_latch
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_rdata       <= (others => '0');
      s_rdata_valid <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_rdata_valid <= '0';             -- PULSE
      if(s_me_p2 = '1') then
        s_rdata       <= i_rdata;
        s_rdata_valid <= '1';
      end if;
    end if;
  end process p_rdata_latch;

  -- purpose: DECOD RDATA
  p_decod_rdata : process (clk, rst_n) is
  begin  -- process p_decod_rdata
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_en_load       <= '0';
      s_data          <= (others => '0');
      s_decod_done    <= '0';
      s_max_cnt_32b   <= (others => '0');
      s_max_cnt_valid <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_decod_done    <= '0';           -- PULSE
      s_max_cnt_valid <= '0';           -- PULSE
      if(s_rdata_valid = '1') then

        -- "000" : Process command normaly
        if(s_rdata(15 downto 13) = "000") then
          s_en_load    <= s_rdata(12);
          s_data       <= x"0" & s_rdata(11 downto 0);
          s_decod_done <= '1';

        -- "001" : WAIT command
        elsif(s_rdata(15 downto 13) = "001") then
          s_max_cnt_32b(31 downto 13) <= x"0000" & "000";
          s_max_cnt_32b(12 downto 0)  <= s_rdata(12 downto 0);
          s_max_cnt_valid             <= '1';

        -- "010" : WAIT G_MAX_CNT_32B
        elsif(s_rdata(15 downto 13) = "010") then
          s_max_cnt_32b   <= G_MAX_CNT_32B;
          s_max_cnt_valid <= '1';
        end if;
      end if;
    end if;
  end process p_decod_rdata;

  -- purpose: Send command to MAX7219 I/F
  p_max7219_is_access : process (clk, rst_n) is
  begin  -- process p_max7219_is_access
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_decod_done = '1') then
        s_start <= '1';                 -- PULSE
      else
        s_start <= '0';
      end if;
    end if;
  end process p_max7219_is_access;

  -- purpose: ADDR inc
  p_addr_inc : process (clk, rst_n) is
  begin  -- process p_addr_inc
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_addr     <= (others => '0');
      s_inc_done <= '0';
      o_discard  <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- UPDATE START PTR when ENABLE disable
      if(s_update_ptr = '1') then
        s_addr <= s_start_ptr;

        -- Case Start_PTR = Last_PTR
        if(s_start_ptr = s_last_ptr) then
          o_discard <= '1';
        end if;

      -- UPDATE START PTR at then end of the CONFIG. done
      elsif(s_ptr_equality = '1' and i_loop = '1') then
        s_addr <= s_start_ptr;
      else
        o_discard <= '0';
      end if;

      s_inc_done <= '0';
      if(i_done = '1') then
        s_addr     <= unsigned(s_addr) + 1;  -- INC
        s_inc_done <= '1';
      elsif(s_cnt_done = '1') then
        s_addr     <= unsigned(s_addr) + 1;  -- INC
        s_inc_done <= '1';
      end if;
    end if;
  end process p_addr_inc;

  -- purpose: Manage the counter 32b for generate a wait
  p_cnt_mngt : process (clk, rst_n) is
  begin  -- process p_cnt_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_32b   <= (others => '0');
      s_start_cnt <= '0';
      s_cnt_done  <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_cnt_done <= '0';
      if(s_max_cnt_valid = '1')then
        s_start_cnt <= '1';
      end if;

      if(s_start_cnt = '1') then
        if(s_cnt_32b < s_max_cnt_32b) then
          s_cnt_32b <= unsigned(s_cnt_32b) + 1;  -- INC cnt
        else
          s_cnt_done  <= '1';
          s_start_cnt <= '0';
          s_cnt_32b   <= (others => '0');
        end if;
      end if;
    end if;
  end process p_cnt_mngt;

  -- OUTPUTS affectations

  -- RAM I/F
  o_we   <= s_we;
  o_me   <= s_me;
  o_addr <= s_addr;

  -- MAX7219 I/F
  o_start   <= s_start;
  o_data    <= s_data;
  o_en_load <= s_en_load;

  o_ptr_equality <= s_ptr_equality;

end architecture behv;
