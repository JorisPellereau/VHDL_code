-------------------------------------------------------------------------------
-- Title      : TOP MAX7219 MATRIX DISPLAY
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_max7219_matrix_display.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-05-09
-- Last update: 2020-05-10
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: TOP MAX7219 MATRIX DISPLAY on DE0 NANO BOARD
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-05-09  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;


entity top_max7219_matrix_display is
  generic (
    G_MAX_CNT                    : std_logic_vector(31 downto 0) := x"02FAF080";
    G_DIGITS_NB                  : integer range 2 to 8          := 2;  -- DIGIT NB on THE MATRIX DISPLAY
    G_DATA_WIDTH                 : integer                       := 32;  -- INPUTS SCORE WIDTH
    G_RAM_ADDR_WIDTH             : integer                       := 8;  -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH             : integer                       := 16;  -- RAM DATA WIDTH
    G_DECOD_MAX_CNT_32B          : std_logic_vector(31 downto 0) := x"02FAF080";
    G_MAX7219_IF_MAX_HALF_PERIOD : integer                       := 50;  -- MAX HALF PERIOD for MAX729 CLK generation
    G_MAX7219_LOAD_DUR           : integer                       := 4);  -- MAX7219 LOAD duration in period of clk
  port (
    clk            : in  std_logic;     -- Clock
    rst_n          : in  std_logic;     -- Asynchronous Reset
    o_max7219_load : out std_logic;     -- LOAD
    o_max7219_data : out std_logic;     -- DATA
    o_max7219_clk  : out std_logic);    -- CLK

end entity top_max7219_matrix_display;

architecture behv of top_max7219_matrix_display is

  -- INTERNAL SIGNALS
  signal s_decod_mode     : std_logic_vector(7 downto 0);
  signal s_intensity      : std_logic_vector(7 downto 0);
  signal s_scan_limit     : std_logic_vector(7 downto 0);
  signal s_shutdown       : std_logic_vector(7 downto 0);
  signal s_new_config_val : std_logic;
  signal s_score          : std_logic_vector(31 downto 0);
  signal s_score_val      : std_logic;
  signal s_max7219_load   : std_logic;
  signal s_max7219_data   : std_logic;
  signal s_max7219_clk    : std_logic;

  signal s_cnt      : std_logic_vector(31 downto 0);
  signal s_cnt_done : std_logic;

  signal s_cnt_2digits : integer range 0 to 99;

  signal s_config_score_sel : std_logic;

begin  -- architecture behv

  -- SET CONFIG
  s_decod_mode <= x"00";
  s_intensity  <= x"00";
  s_scan_limit <= x"07";
  s_shutdown   <= x"01";


  p_loop : process (clk, rst_n) is
  begin  -- process p_loop
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt              <= (others => '0');
      s_cnt_done         <= '0';
      s_config_score_sel <= '0';
      s_cnt_2digits      <= 0;
      s_new_config_val   <= '0';
      s_score_val        <= '0';
      s_score            <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_cnt < G_MAX_CNT) then
        s_cnt      <= unsigned(s_cnt) + 1;
        s_cnt_done <= '0';
      else
        s_cnt_done <= '1';
        s_cnt      <= (others => '0');
      end if;

      if(s_cnt_done = '1') then
        if(s_config_score_sel = '0') then
          s_new_config_val   <= '1';
          s_config_score_sel <= '1';
        else
          if(s_cnt_2digits < 99) then
            s_cnt_2digits <= s_cnt_2digits + 1;
            s_score       <= unsigned(s_score) + 1;
            s_score_val   <= '1';
          else
            s_cnt_2digits <= 0;
            s_score       <= (others => '0');
          end if;
        end if;

      else
        s_score_val      <= '0';
        s_new_config_val <= '0';
      end if;
    end if;
  end process p_loop;

  -- MAX7219 MATRIX DISPLAY INST
  max7219_matrix_display_inst_0 : max7219_matrix_display
    generic map(
      G_DIGITS_NB                  => G_DIGITS_NB,
      G_DATA_WIDTH                 => G_DATA_WIDTH,
      G_RAM_ADDR_WIDTH             => G_RAM_ADDR_WIDTH,
      G_RAM_DATA_WIDTH             => G_RAM_DATA_WIDTH,
      G_DECOD_MAX_CNT_32B          => G_DECOD_MAX_CNT_32B,
      G_MAX7219_IF_MAX_HALF_PERIOD => G_MAX7219_IF_MAX_HALF_PERIOD,
      G_MAX7219_LOAD_DUR           => G_MAX7219_LOAD_DUR)
    port map(
      clk              => clk,
      rst_n            => rst_n,
      i_decod_mode     => s_decod_mode,
      i_intensity      => s_intensity,
      i_scan_limit     => s_scan_limit,
      i_shutdown       => s_shutdown,
      i_new_config_val => s_new_config_val,
      i_score          => s_score,
      i_score_val      => s_score_val,
      o_max7219_load   => s_max7219_load,
      o_max7219_data   => s_max7219_data,
      o_max7219_clk    => s_max7219_clk
      );

  -- OUTPUTS AFFECTATION
  o_max7219_clk  <= s_max7219_clk;
  o_max7219_data <= s_max7219_data;
  o_max7219_load <= s_max7219_load;

end architecture behv;
