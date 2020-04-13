-------------------------------------------------------------------------------
-- Title      : TEST for MAX7219_CMD_DECO
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_max7219_cmd_decod.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-13
-- Last update: 2020-04-13
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-13  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity test_max7219_cmd_decod is

end entity test_max7219_cmd_decod;

architecture behv of test_max7219_cmd_decod is

  -- COMPONENT
  component max7219_cmd_decod is

    generic (
      G_RAM_ADDR_WIDTH             : integer := 8;   -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH             : integer := 16;  -- RAM DATA WIDTH
      G_MAX7219_IF_MAX_HALF_PERIOD : integer := 50;  -- MAX HALF PERIOD for MAX729 CLK generation
      G_MAX7219_LOAD_DUR           : integer := 4);  -- MAX7219 LOAD duration in period of clk

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous reset

      -- RAM I/F
      i_me    : in  std_logic;          -- Memory Enable
      i_we    : in  std_logic;          -- W/R command
      i_addr  : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
      i_wdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM WDATA
      o_rdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

      -- RAM INFO.
      i_last_ptr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST ADDR

      -- MAX7219 I/F
      o_max7219_load : out std_logic;   -- MAX7219 LOAD
      o_max7219_data : out std_logic;   -- MAX7219 DATA
      o_max7219_clk  : out std_logic);  -- MAX7219 CLK

  end component max7219_cmd_decod;


  -- INTERNAL SIGNALS
  signal clk   : std_logic := '0';
  signal rst_n : std_logic := '1';

  signal s_max7219_load : std_logic;
  signal s_max7219_clk  : std_logic;
  signal s_max7219_data : std_logic;

  signal s_me       : std_logic;
  signal s_we       : std_logic;
  signal s_addr     : std_logic_vector(7 downto 0);
  signal s_wdata    : std_logic_vector(15 downto 0);
  signal s_rdata    : std_logic_vector(15 downto 0);
  signal s_last_ptr : std_logic_vector(7 downto 0);

begin  -- architecture behv

  -- purpose: this process generate the input clock
  -- 50MHz : 20 ns
  p_clk_gen : process is
  begin  -- process p_clk_gen
    clk <= not clk;
    wait for 10 ns;
  end process p_clk_gen;


  p_stimulis : process is
  begin  -- process p_stimulis
    s_me       <= '0';
    s_we       <= '0';
    s_addr     <= (others => '0');
    s_wdata    <= (others => '0');
    s_last_ptr <= (others => '0');

    wait for 1 us;
    rst_n <= '0';
    wait for 1 us;
    rst_n <= '1';

    wait for 10 us;

    s_last_ptr <= x"00";
    -- INIT RAM

    for i in 0 to 255 loop

      s_addr      <= std_logic_vector(to_unsigned(i, s_addr'length));
      s_wdata     <= std_logic_vector(to_unsigned(i, s_wdata'length));
      s_wdata(12) <= '1';
      wait until falling_edge(clk);
      s_me        <= '1';
      s_we        <= '1';
      wait until falling_edge(clk);
      s_me        <= '0';
      s_we        <= '0';
    end loop;  -- i

    wait for 10 us;

    s_last_ptr <= x"05";

    wait for 10 us;

    report "end of simu !!";
    wait;
  end process p_stimulis;


  -- MAX7219 CMD DECOD INST
  max7219_cmd_decod_inst : max7219_cmd_decod
    generic map (
      G_RAM_ADDR_WIDTH             => 8,  -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH             => 16,  -- RAM DATA WIDTH
      G_MAX7219_IF_MAX_HALF_PERIOD => 50,  -- MAX HALF PERIOD for MAX729 CLK generation
      G_MAX7219_LOAD_DUR           => 4)  -- MAX7219 LOAD duration in period of clk

    port map (
      clk   => clk,
      rst_n => rst_n,

      -- RAM I/F
      i_me    => s_me,
      i_we    => s_we,
      i_addr  => s_addr,
      i_wdata => s_wdata,
      o_rdata => s_rdata,

      -- RAM INFO.
      i_last_ptr => s_last_ptr,

      -- MAX7219 I/F
      o_max7219_load => s_max7219_load,
      o_max7219_data => s_max7219_data,
      o_max7219_clk  => s_max7219_clk);  -- MAX7219 CLK

end architecture behv;
