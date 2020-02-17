-------------------------------------------------------------------------------
-- Title      : PATTERN DETECTOR
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pattern_detector.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-02-17
-- Last update: 2020-02-17
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This block detects a pattern set in generic parameter
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-02-17  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity pattern_detector is

  generic (
    G_DATA_WIDTH   : integer              := 8;  -- INPUT DATA WIDTH
    G_PATTERN_SIZE : integer range 2 to 3 := 3);  -- Number of Symbol in the pattern    
    port (
      clk                : in  std_logic;        -- Clock
      rst_n              : in  std_logic;        -- Asynchronous Reset
      i_data             : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Input Data
      i_data_valid       : in  std_logic;        -- Data Valid
      o_pattern_detected : out std_logic);       -- Pattern Detected flag

end entity pattern_detector;

architecture behv of pattern_detector is


  -- TYPE
  type t_pattern is array (0 to G_PATTERN_SIZE - 1) of std_logic_vector(G_DATA_WIDTH - 1 downto 0);

  -- CONSTANTS  
  constant C_PATTERN : t_pattern := (2 => x"45", 1 => x"4E", 0 => x"44");  -- Pattern

  -- INTERNAL SIGNALS
  signal s_pattern : t_pattern;

  signal s_data_valid        : std_logic;  -- Data valid latch
  signal s_data_valid_r_edge : std_logic;  -- Data valid R EDGE detect
begin  -- architecture behv

  -- purpose: This process latch inputs 
  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_data_valid <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_data_valid <= i_data_valid;
    end if;
  end process p_latch_inputs;

  s_data_valid_r_edge <= i_data_valid and not s_data_valid;


  -- purpose: This process latch i_data on R_EDGE of i_data_valid
  p_data_latch : process (clk, rst_n) is
  begin  -- process p_data_latch
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_pattern <= (others => (others => '0'));
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_data_valid_r_edge = '1') then
        s_pattern(0)                       <= i_data;
        s_pattern(1 to G_PATTERN_SIZE -1) <= s_pattern(0 to G_PATTERN_SIZE - 2);
      end if;
    end if;
  end process p_data_latch;

  -- purpose: This process manages the detection of the pattern set in CONSTANT in this block
  p_pattern_detection : process (clk, rst_n) is
  begin  -- process p_pattern_detection
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_pattern_detected <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_pattern = C_PATTERN) then
        o_pattern_detected <= '1';
      else
        o_pattern_detected <= '0';
      end if;
    end if;
  end process p_pattern_detection;

end architecture behv;
