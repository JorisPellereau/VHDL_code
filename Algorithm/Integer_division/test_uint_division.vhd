-------------------------------------------------------------------------------
-- Title      : TEST of uint_division.vhd
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_uint_division.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-17
-- Last update: 2020-06-14
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Test of Unsigned Integer Restoring Division
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-17  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity test_uint_division is

end entity test_uint_division;

architecture behv of test_uint_division is

  -- uint_division component
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
  constant C_WIDTH : integer := 32;      -- Width of data

  -- TB INTERNAL SIGNALS
  signal clk   : std_logic := '0';      -- Clock
  signal rst_n : std_logic := '1';      -- Asynchronous Reset

  signal s_start : std_logic;
  signal s_done  : std_logic;
  signal s_i_q   : std_logic_vector(C_WIDTH - 1 downto 0);
  signal s_i_m   : std_logic_vector(C_WIDTH - 1 downto 0);
  signal s_i_n   : std_logic_vector(C_WIDTH - 1 downto 0);
  signal s_o_q   : std_logic_vector(C_WIDTH - 1 downto 0);
  signal s_o_r   : std_logic_vector(C_WIDTH - 1 downto 0);

begin  -- architecture behv

  -- purpose: this process generate the input clock
  -- 50MHz : 20 ns
  p_clk_gen : process is
  begin  -- process p_clk_gen
    clk <= not clk;
    wait for 10 ns;
  end process p_clk_gen;

  p_stimuli : process is
  begin  -- process p_stimuli

    s_start <= '0';
    s_i_q   <= (others => '0');
    s_i_n   <= (others => '0');
    s_i_m   <= (others => '0');

    -- RESET
    wait for 50 ns;
    rst_n <= '0';
    wait for 50 ns;
    rst_n <= '1';
    wait for 50 ns;


    wait for 50 ns;



    -- 11/2
    s_i_q   <= x"0000000B";
    s_i_m   <= x"00000002";
    s_i_n   <= x"00000020";
    wait until falling_edge(clk);
    s_start <= '1';
    wait until falling_edge(clk);
    s_start <= '0';

    wait until rising_edge(s_done);
    assert s_o_q = x"00000005" report "QUOTIENT /= 5" severity error;
    assert s_o_r = x"00000001" report "REMAINDER /= 1" severity error;

    wait for 50 ns;


    -- OLD TESTS with C_WIDTH = 8
    
    -- 11/2
    -- s_i_q   <= x"0B";
    -- s_i_m   <= x"02";
    -- s_i_n   <= x"04";
    -- wait until falling_edge(clk);
    -- s_start <= '1';
    -- wait until falling_edge(clk);
    -- s_start <= '0';

    -- wait until rising_edge(s_done);
    -- assert s_o_q = x"05" report "QUOTIENT /= 5" severity error;
    -- assert s_o_r = x"01" report "REMAINDER /= 1" severity error;

    -- wait for 50 ns;

    -- 255/6
    -- s_i_q   <= x"FF";
    -- s_i_m   <= x"06";
    -- s_i_n   <= x"04";
    -- wait until falling_edge(clk);
    -- s_start <= '1';
    -- wait until falling_edge(clk);
    -- s_start <= '0';

    -- wait until rising_edge(s_done);
    -- assert s_o_q = x"2A" report "QUOTIENT /= 42" severity error;
    -- assert s_o_r = x"03" report "REMAINDER /= 3" severity error;


    -- wait for 50 ns;

    -- 15/15
    -- s_i_q   <= x"0F";
    -- s_i_m   <= x"0F";
    -- s_i_n   <= x"08";
    -- wait until falling_edge(clk);
    -- s_start <= '1';
    -- wait until falling_edge(clk);
    -- s_start <= '0';

    -- wait until rising_edge(s_done);
    -- assert s_o_q = x"01" report "QUOTIENT /= 1" severity error;
    -- assert s_o_r = x"00" report "REMAINDER /= 0" severity error;


    -- wait for 50 ns;

    -- 2/9
    -- s_i_q   <= x"02";
    -- s_i_m   <= x"09";
    -- s_i_n   <= x"08";
    -- wait until falling_edge(clk);
    -- s_start <= '1';
    -- wait until falling_edge(clk);
    -- s_start <= '0';

    -- wait until rising_edge(s_done);
    -- assert s_o_q = x"00" report "QUOTIENT /= 0" severity error;
    -- assert s_o_r = x"02" report "REMAINDER /= 2" severity error;



    -- wait for 50 ns;

    -- 150/36
    -- s_i_q   <= x"96";
    -- s_i_m   <= x"24";
    -- s_i_n   <= x"08";
    -- wait until falling_edge(clk);
    -- s_start <= '1';
    -- wait until falling_edge(clk);
    -- s_start <= '0';

    -- wait until rising_edge(s_done);
    -- assert s_o_q = x"04" report "QUOTIENT /= 4" severity error;
    -- assert s_o_r = x"06" report "REMAINDER /= 6" severity error;

    -- report "end of simu !!";

    wait;

  end process p_stimuli;

  -- INST
  uint_division_inst_0 : uint_division
    generic map(
      G_WIDTH => C_WIDTH)

    port map (
      clk     => clk,
      rst_n   => rst_n,
      i_start => s_start,
      i_q     => s_i_q,
      i_m     => s_i_m,
      i_n     => s_i_n,
      o_q     => s_o_q,
      o_r     => s_o_r,
      o_done  => s_done);               -- Result Available

end architecture behv;
