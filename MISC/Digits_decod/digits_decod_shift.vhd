-------------------------------------------------------------------------------
-- Title      : DIGIT DECOD shift method
-- Project    : 
-------------------------------------------------------------------------------
-- File       : digits_decod_shift.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-05-02
-- Last update: 2020-07-18
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: DIGITS DECODER block with one uint_division
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-05-02  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity digits_decod_shift is
  generic (
    G_DIGITS_NB  : integer range 2 to 8 := 8;    -- DIGITS Number to decod
    G_DATA_WIDTH : integer              := 32);  -- DATA WIDTH

  port (
    clk          : in  std_logic;       -- Clock
    rst_n        : in  std_logic;       -- Asynchronous Reset
    i_data2decod : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data to decod
    i_val        : in  std_logic;       -- Input valid
    o_decod      : out std_logic_vector(G_DIGITS_NB*4 - 1 downto 0);  -- Decod output
    o_done       : out std_logic);      -- Decod Done
end entity digits_decod_shift;

architecture behv of digits_decod_shift is

  -- COMPONENT
  component uint_division is

    generic (
      G_WIDTH : integer := 4);          -- Input Width

    port (
      clk     : in  std_logic;          -- Clock
      rst_n   : in  std_logic;          -- Asynchronous Reset
      i_start : in  std_logic;          -- Start the division    
      i_q     : in  std_logic_vector(G_WIDTH - 1 downto 0);  -- Dividend
      i_m     : in  std_logic_vector(G_WIDTH - 1 downto 0);  -- Divisor
      i_n     : in  std_logic_vector(G_WIDTH - 1 downto 0);  -- Number of useful bits in the dividend
      o_q     : out std_logic_vector(G_WIDTH - 1 downto 0);  -- Result
      o_r     : out std_logic_vector(G_WIDTH - 1 downto 0);  -- Remainder
      o_done  : out std_logic);         -- Result Available

  end component uint_division;

  -- CONSTANTS
  constant C_DIVISOR_10000000 : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"00989680";
  constant C_DIVISOR_1000000  : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"000F4240";
  constant C_DIVISOR_100000   : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"000186A0";
  constant C_DIVISOR_10000    : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"00002710";
  constant C_DIVISOR_1000     : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"000003E8";
  constant C_DIVISOR_100      : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"00000064";
  constant C_DIVISOR_10       : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"0000000A";

  -- INTERNAL SIGNALS
  signal s_n              : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
  signal s_done           : std_logic;
  signal s_q              : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
  signal s_i_q_shift      : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
  signal s_r              : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
  signal s_m              : std_logic_vector((8 - 1)*G_DATA_WIDTH - 1 downto 0);
  signal s_m_shift        : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
  signal s_data2decod_sat : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data to Decod Saturate

  signal s_decod : std_logic_vector(G_DIGITS_NB*4 - 1 downto 0);  -- Decod output

  signal s_val   : std_logic;           -- S val
  signal s_start : std_logic;           -- Start the DIVISION
  signal s_cnt   : integer;             -- Counter

  signal s_done_p        : std_logic;   -- cnt INC
  signal s_done_r_edge   : std_logic;   -- rising edge of Done DIV
  signal s_done_r_edge_p : std_logic;

  signal s_decod_done   : std_logic;
  signal s_decod_done_p : std_logic;
begin  -- architecture behv

  -- INPUTS SATURATION
  p_data2decod_saturation : process (clk, rst_n) is
  begin  -- process p_data2decod_saturation
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_data2decod_sat <= (others => '0');
      s_val            <= '0';
      s_m              <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge      
      if(i_val = '1') then
        s_val <= '1';
        case G_DIGITS_NB is
          when 8 =>
            -- SATURATION INPUT at 99 999 999
            if(i_data2decod > x"05F5E0FF") then
              s_data2decod_sat <= x"05F5E0FF";
            else
              s_data2decod_sat <= i_data2decod;
            end if;

          when 7 =>
            -- SATURATION at 9 999 999
            if(i_data2decod > x"0098967F") then
              s_data2decod_sat <= x"0098967F";
            else
              s_data2decod_sat <= i_data2decod;
            end if;

          when 6 =>
            -- SATURATION at 999 999
            if(i_data2decod > x"000F423F") then
              s_data2decod_sat <= x"000F423F";
            else
              s_data2decod_sat <= i_data2decod;
            end if;

          when 5 =>
            -- SATURATION at 99 999
            if(i_data2decod > x"0001869F") then
              s_data2decod_sat <= x"0001869F";
            else
              s_data2decod_sat <= i_data2decod;
            end if;

          when 4 =>
            -- SATURATION at 9 999
            if(i_data2decod > x"0000270F") then
              s_data2decod_sat <= x"0000270F";
            else
              s_data2decod_sat <= i_data2decod;
            end if;

          when 3 =>
            -- SATURATION at 999
            if(i_data2decod > x"000003E7") then
              s_data2decod_sat <= x"000003E7";
            else
              s_data2decod_sat <= i_data2decod;
            end if;

          when 2 =>
            --SATURATION at 99
            if(i_data2decod > x"00000063") then
              s_data2decod_sat <= x"00000063";
            else
              s_data2decod_sat <= i_data2decod;
            end if;


          when others => null;
        end case;

        -- DIVISIOR SET
        s_m(G_DATA_WIDTH - 1 downto 0)                               <= C_DIVISOR_10;
        s_m(1*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 1*G_DATA_WIDTH) <= C_DIVISOR_100;
        s_m(2*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 2*G_DATA_WIDTH) <= C_DIVISOR_1000;
        s_m(3*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 3*G_DATA_WIDTH) <= C_DIVISOR_10000;
        s_m(4*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 4*G_DATA_WIDTH) <= C_DIVISOR_100000;
        s_m(5*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 5*G_DATA_WIDTH) <= C_DIVISOR_1000000;
        s_m(6*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 6*G_DATA_WIDTH) <= C_DIVISOR_10000000;

      else
        s_val <= '0';
      end if;
    end if;
  end process p_data2decod_saturation;


  p_shift_mngt : process (clk, rst_n) is
  begin  -- process p_shift_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)     
      s_n            <= (others => '0');
      s_start        <= '0';
      s_decod_done   <= '0';
      s_decod_done_p <= '0';
      s_m_shift      <= (others => '0');
      s_i_q_shift    <= (others => '0');
      s_cnt          <= G_DIGITS_NB - 2;
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_n          <= conv_std_logic_vector(G_DATA_WIDTH, s_n'length);
      s_start      <= '0';
      s_decod_done <= '0';

      if(s_done_r_edge = '1') then
        s_i_q_shift <= s_r;

        if(s_cnt > 0) then              --G_DIGITS_NB - 2) then
          s_cnt <= s_cnt - 1;
        else
          s_decod_done <= '1';
        end if;
      end if;

      s_decod_done_p <= s_decod_done;

      -- REMAINDER becomes Input
      if(s_decod_done = '1') then
        s_n          <= (others => '0');
        s_start      <= '0';
        s_decod_done <= '0';
        s_m_shift    <= (others => '0');
        s_i_q_shift  <= (others => '0');
        s_cnt        <= G_DIGITS_NB - 2;
      elsif(s_done_r_edge_p = '1') then  -- and s_cnt /= 0) then  --s_done_p = '1' and s_decod_done = '0') then
        s_m_shift   <= s_m(s_cnt*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto s_cnt*G_DATA_WIDTH);
        s_i_q_shift <= s_r;
        s_start     <= '1';
      end if;

      -- 1st start from OUSTIDE
      if(s_val = '1')then
        s_m_shift   <= s_m(s_cnt*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto s_cnt*G_DATA_WIDTH);
        s_i_q_shift <= s_data2decod_sat;
        s_start     <= '1';
      end if;

    end if;
  end process p_shift_mngt;

  p_out_mngt : process (clk, rst_n) is
  begin  -- process p_out_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_decod <= (others => '0');

    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_done_r_edge = '1') then
        s_decod(3 downto 0) <= s_q(3 downto 0);
      end if;

      if(s_done_r_edge_p = '1') then
        if(s_decod_done = '1') then
          s_decod(3 downto 0) <= s_r(3 downto 0);
        end if;

        s_decod(G_DIGITS_NB*4 - 1 downto 4) <= s_decod((G_DIGITS_NB-1)*4 - 1 downto 0);
      end if;

    end if;
  end process p_out_mngt;

  p_latch_signals : process (clk, rst_n) is
  begin  -- process p_latch_signals
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_done_p        <= '0';
      s_done_r_edge_p <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_done_p        <= s_done;
      s_done_r_edge_p <= s_done_r_edge;
    end if;
  end process p_latch_signals;

  -- R EDGE DETECTION
  s_done_r_edge <= s_done and not s_done_p;

  uint_division_inst_0 : uint_division
    generic map (
      G_WIDTH => G_DATA_WIDTH
      )
    port map(
      clk     => clk,
      rst_n   => rst_n,
      i_start => s_start,
      i_q     => s_i_q_shift,
      i_m     => s_m_shift,
      i_n     => s_n,
      o_q     => s_q,
      o_r     => s_r,
      o_done  => s_done
      );

  -- OUTPUTS AFFECTATION
  o_done  <= s_decod_done_p;
  o_decod <= s_decod;

end architecture behv;
