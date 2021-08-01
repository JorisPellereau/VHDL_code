-------------------------------------------------------------------------------
-- Title      : MAX7219 Low level interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_if.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-05
-- Last update: 2021-08-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Interface with the MAX7219
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-05  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

--library lib_max7219;
--use lib_max7219.pkg_max7219.all;

entity max7219_if is

  generic (
    G_MAX_HALF_PERIOD : integer := 4;   -- 4 => 6.25MHz with 50MHz input
    G_LOAD_DURATION   : integer := 4    -- LOAD DURATION in clk_in period
    );
  port (
    clk   : in std_logic;               -- System clock
    rst_n : in std_logic;               -- Asynchronous active low reset

    -- Input commands
    i_start   : in std_logic;           -- Start the transaction
    i_en_load : in std_logic;           -- Enable the generation of o_load
    i_data    : in std_logic_vector(15 downto 0);  -- Data to send te the Max7219

    -- MAX7219 I/F
    o_max7219_load : out std_logic;     -- LOAD command
    o_max7219_data : out std_logic;     -- DATA to send
    o_max7219_clk  : out std_logic;     -- CLK

    -- Transaction Done
    o_done : out std_logic);            -- Frame done

end entity max7219_if;

architecture behv of max7219_if is

  -- INTERNALS SIGNALS
  signal s_data               : std_logic_vector(15 downto 0);  -- Latch Data
  signal s_en_load            : std_logic;  -- Latch En load
  signal s_start              : std_logic;  -- Start pulse
  signal s_init_data          : std_logic;  -- Init Data
  signal s_en_clk             : std_logic;  -- Enable the clk generation
  signal s_max7219_data       : std_logic;  -- Data on output
  signal s_max7219_clk        : std_logic;  -- Clk output
  signal s_max7219_clk_p      : std_logic;  -- Clk output
  signal s_max7219_clk_f_edge : std_logic;  -- Falling Edge of s_clk
  signal s_max7219_clk_r_edge : std_logic;  -- Rising edge of s_clk
  signal s_max7219_load       : std_logic;  -- Load bit
  signal s_start_r_edge       : std_logic;  -- Rising Edge of i_start
  signal s_done               : std_logic;  -- o_done output
  signal s_cnt_15             : integer range 0 to 15;  -- 15 Down Counter
  signal s_cnt_16             : integer range 0 to 16;  -- 16 Counter
  signal s_cnt_half_period    : integer range 0 to G_MAX_HALF_PERIOD - 1;  -- Counter for clk generation
  signal s_load_px            : std_logic_vector(G_LOAD_DURATION - 1 downto 0);  -- Pipe of s_load
  signal s_end_frame          : std_logic;  -- End of frame internal flag
begin  -- architecture behv

  -- Latch the inputs
  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start     <= '0';
      s_en_load   <= '0';
      s_data      <= (others => '0');
      s_init_data <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_start     <= i_start;
      s_init_data <= '0';
      if(s_start_r_edge = '1') then
        s_en_load   <= i_en_load;
        s_data      <= i_data;
        s_init_data <= '1';
      elsif(s_done = '1') then
        s_en_load <= '0';
        s_data    <= (others => '0');
      end if;
    end if;
  end process p_latch_inputs;

  -- Rising edge detection
  s_start_r_edge <= i_start and not s_start;

  -- Manages the start of the o_clk generation
  p_en_clk : process (clk, rst_n) is
  begin  -- process p_en_clk
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_en_clk       <= '0';
      s_max7219_load <= '0';
      s_end_frame    <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_max7219_load <= '0';
      s_end_frame    <= '0';
      if(s_init_data = '1') then
        s_en_clk <= '1';
      elsif(s_max7219_clk_f_edge = '1' and s_cnt_16 = 16) then
        s_en_clk <= '0';
        if(s_en_load = '1') then
          s_max7219_load <= '1';
        else
          s_max7219_load <= '0';
        end if;
        s_end_frame <= '1';
      end if;
    end if;
  end process p_en_clk;

  -- purpose: Manages the data generation
  p_data_mngt : process (clk, rst_n) is
  begin  -- process p_data_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_15       <= 15;
      s_max7219_data <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_init_data = '1') then
        s_max7219_data <= s_data(15);
        s_cnt_15       <= s_cnt_15 - 1;
      elsif(s_max7219_clk_f_edge = '1' and s_cnt_16 /= 16) then
        s_max7219_data <= s_data(s_cnt_15);
        if(s_cnt_15 > 0) then
          s_cnt_15 <= s_cnt_15 - 1;
        -- Last data
        else
          s_cnt_15 <= 15;
        end if;
      elsif(s_en_clk = '0') then
        s_max7219_data <= '0';
      end if;
    end if;
  end process p_data_mngt;

  -- purpose: Management of the done signal 
  p_done_mngt : process (clk, rst_n) is
  begin  -- process p_done_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_16 <= 0;
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_max7219_clk_r_edge = '1') then
        if(s_cnt_16 < 16) then
          s_cnt_16 <= s_cnt_16 + 1;
        else
          s_cnt_16 <= 0;
        end if;
      elsif(s_end_frame = '1') then
        s_cnt_16 <= 0;
      end if;
    end if;
  end process p_done_mngt;

  -- Management of the generation of clk
  p_clk_mngt : process (clk, rst_n) is
  begin  -- process p_clk_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_half_period <= 0;
      s_max7219_clk     <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_en_clk = '1') then
        if(s_cnt_half_period < G_MAX_HALF_PERIOD - 1) then
          s_cnt_half_period <= s_cnt_half_period + 1;  -- INC cnt
        else
          s_max7219_clk     <= not s_max7219_clk;
          s_cnt_half_period <= 0;
        end if;
      else
        s_cnt_half_period <= 0;
        s_max7219_clk     <= '0';
      end if;
    end if;
  end process p_clk_mngt;

  -- Pipe s_max7219_clk
  p_clk_f_edge_mngt : process (clk, rst_n) is
  begin  -- process p_clk_f_edge_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_max7219_clk_p <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_max7219_clk_p <= s_max7219_clk;
    end if;
  end process p_clk_f_edge_mngt;
  s_max7219_clk_f_edge <= not s_max7219_clk and s_max7219_clk_p;
  s_max7219_clk_r_edge <= s_max7219_clk and not s_max7219_clk_p;

  p_pipe_load : process (clk, rst_n) is
  begin  -- process p_pipe_load
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_load_px <= (others => '0');
      s_done    <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_en_load = '1') then
        s_load_px(0)                            <= s_max7219_load;
        s_load_px(G_LOAD_DURATION - 1 downto 1) <= s_load_px(G_LOAD_DURATION - 2 downto 0);

        if(s_load_px(G_LOAD_DURATION - 1) = '1') then
          s_done <= '1';
        else
          s_done <= '0';
        end if;
      else
        s_done <= s_end_frame;
      end if;

    end if;
  end process p_pipe_load;

  -- OUTPUTS AFFECTATIONS
  o_max7219_data <= s_max7219_data;
  o_max7219_clk  <= s_max7219_clk;
  o_max7219_load <= '1' when s_load_px /= conv_std_logic_vector(0, s_load_px'length) else '0';
  o_done         <= s_done;

end architecture behv;
