-------------------------------------------------------------------------------
-- Title      : MAX7219 Configuration Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_config_if.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-09-26
-- Last update: 2021-02-14
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 Configuration I/F
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-09-26  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity max7219_config_if is
  generic(
    G_MATRIX_NB : integer := 8
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous clock

    -- MATRIX CONFIG.
    i_decod_mode     : in  std_logic_vector(7 downto 0);  -- DECOD MODE
    i_intensity      : in  std_logic_vector(7 downto 0);  -- INTENSITY
    i_scan_limit     : in  std_logic_vector(7 downto 0);  -- SCAN LIMIT
    i_shutdown       : in  std_logic_vector(7 downto 0);  -- SHUTDOWN MODE
    i_display_test   : in  std_logic;   -- DISPLAY TEST Config
    i_new_config_val : in  std_logic;   -- CONFIG. VALID
    o_config_done    : out std_logic;   -- CONFIG. DONE

    -- MAX7219 I/F
    i_max7219_if_done    : in  std_logic;  -- MAX7219 I/F Done
    o_max7219_if_start   : out std_logic;  -- MAX7219 I/F Start
    o_max7219_if_en_load : out std_logic;  -- MAX7219 Enable Load
    o_max7219_if_data    : out std_logic_vector(15 downto 0));  -- MAX7219 I/F Data
end entity max7219_config_if;

architecture behv of max7219_config_if is

  -- INTERNAL SIGNALS

  signal s_init_config    : std_logic;  -- Init Configuration
  signal s_init_config_p  : std_logic;  -- INIT Cnfig. p
  signal s_init_config_p2 : std_logic;  -- INIT Cnfig. p2

  signal s_new_config_val        : std_logic;
  signal s_new_config_val_r_edge : std_logic;  -- Rising Edge of New Config. Val

  signal s_config_done : std_logic;     -- Config Done

  signal s_cnt_config      : std_logic_vector(2 downto 0);  -- Counter to 5
  signal s_cnt_config_done : std_logic;  -- Coutner to 5 reach

  signal s_cnt_matrix      : std_logic_vector(3 downto 0);
  signal s_cnt_matrix_up   : std_logic;
  signal s_cnt_matrix_done : std_logic;

  signal s_max7219_if_start       : std_logic;
  signal s_max7219_if_en_load     : std_logic;
  signal s_max7219_if_data        : std_logic_vector(15 downto 0);
  signal s_max7219_if_done        : std_logic;
  signal s_max7219_if_done_r_edge : std_logic;

begin  -- architecture behv


  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_new_config_val  <= '0';
      s_max7219_if_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- New config Available only if a config. is done
      if(s_config_done = '1') then
        s_new_config_val <= i_new_config_val;
      end if;

      s_max7219_if_done <= i_max7219_if_done;
    end if;
  end process p_latch_inputs;

  -- Rising Edge management
  s_new_config_val_r_edge  <= i_new_config_val and not s_new_config_val;
  s_max7219_if_done_r_edge <= i_max7219_if_done and not s_max7219_if_done;

  p_cnt_matrix : process (clk, rst_n) is
  begin  -- process p_cnt_matrix
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_matrix      <= (others => '0');
      s_cnt_matrix_done <= '0';
      s_cnt_matrix_up   <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_max7219_if_done_r_edge = '1') then
        if(unsigned(s_cnt_matrix) < G_MATRIX_NB - 1) then
          s_cnt_matrix    <= unsigned(s_cnt_matrix) + 1;
          s_cnt_matrix_up <= '1';
        else
          s_cnt_matrix_done <= '1';
          s_cnt_matrix      <= (others => '0');
        end if;
      else
        s_cnt_matrix_up   <= '0';
        s_cnt_matrix_done <= '0';
      --   s_cnt_matrix      <= (others => '0');
      end if;

    end if;
  end process p_cnt_matrix;


  p_cnt_config : process (clk, rst_n) is
  begin  -- process p_cnt_config
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_config      <= (others => '0');
      s_cnt_config_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_cnt_matrix_done = '1') then
        if(s_cnt_config < "100") then
          s_cnt_config <= unsigned(s_cnt_config) + 1;
        else
          s_cnt_config_done <= '1';
          s_cnt_config      <= (others => '0');
        end if;
      else
        s_cnt_config_done <= '0';
      end if;
    end if;
  end process p_cnt_config;

  p_config_mngt : process (clk, rst_n) is
  begin  -- process p_config_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_init_config    <= '1';
      s_init_config_p  <= '0';
      s_init_config_p2 <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_init_config_p  <= s_init_config;
      s_init_config_p2 <= s_init_config_p;
      if(s_cnt_config_done = '1') then
        s_init_config <= '0';
      end if;
    end if;
  end process p_config_mngt;


  p_max7219_if_mngt : process (clk, rst_n) is
  begin  -- process p_max7219_if_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)

      s_max7219_if_start   <= '0';
      s_max7219_if_en_load <= '0';
      s_max7219_if_data    <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- 1st Start after reset
      if(s_init_config_p = '1' and s_init_config_p2 = '0') then
        s_max7219_if_start <= '1';

      -- An other start 
      elsif(s_new_config_val_r_edge = '1') then
        s_max7219_if_start <= '1';

      -- Start auto
      elsif(s_cnt_matrix_up = '1') then
        s_max7219_if_start <= '1';
      elsif(s_cnt_matrix_done = '1' and s_cnt_config < "100") then
        s_max7219_if_start <= '1';
      else
        s_max7219_if_start <= '0';
      end if;

      -- SET Data Command
      if(s_cnt_config = "000") then
        s_max7219_if_data <= x"09" & i_decod_mode;
      elsif(s_cnt_config = "001") then
        s_max7219_if_data <= x"0A" & i_intensity;
      elsif(s_cnt_config = "010") then
        s_max7219_if_data <= x"0B" & i_scan_limit;
      elsif(s_cnt_config = "011") then
        s_max7219_if_data <= x"0C" & i_shutdown;
      elsif(s_cnt_config = "100") then
        s_max7219_if_data <= x"0F0" & "000" & i_display_test;
      end if;

      -- Set Enable Load
      if(s_cnt_matrix_up = '1') then
        if(unsigned(s_cnt_matrix) = G_MATRIX_NB - 1) then
          s_max7219_if_en_load <= '1';
        end if;
      else
        s_max7219_if_en_load <= '0';
      end if;

    end if;
  end process p_max7219_if_mngt;

  p_config_done_mngt : process (clk, rst_n) is
  begin  -- process p_config_done_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_config_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_cnt_config_done = '1') then
        s_config_done <= '1';
      elsif(s_new_config_val_r_edge = '1') then
        s_config_done <= '0';
      end if;
    end if;
  end process p_config_done_mngt;



  -- Output Affectations
  o_max7219_if_start   <= s_max7219_if_start;
  o_max7219_if_en_load <= s_max7219_if_en_load;
  o_max7219_if_data    <= s_max7219_if_data;
  o_config_done        <= s_config_done;

end architecture behv;
