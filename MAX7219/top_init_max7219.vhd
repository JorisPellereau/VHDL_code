-------------------------------------------------------------------------------
-- Title      : TOP INIT MAX7219 (DEBUG)
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_init_max7219.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-12
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
-- 2020-04-12  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity top_init_max7219 is

  generic(
    G_MAX_CNT         : std_logic_vector(31 downto 0) := x"02FAF080";
    G_MAX_HALF_PERIOD : integer                       := 125;
    G_LOAD_DURATION   : integer                       := 4);
  port (
    clk   : in std_logic;
    rst_n : in std_logic;

    o_cnt : out std_logic;

    o_max7219_load : out std_logic;
    o_max7219_clk  : out std_logic;
    o_max7219_data : out std_logic);

end entity top_init_max7219;


architecture behv of top_init_max7219 is


  -- COMPONENTS
  component init_max7219

    generic(
      G_MAX_CNT : std_logic_vector(31 downto 0) := x"02FAF080");
    port (
      clk       : in  std_logic;        -- Clock
      rst_n     : in  std_logic;        -- Asynch. reset
      i_done    : in  std_logic;        -- MAX7219 I/F done
      o_cnt     : out std_logic;
      o_start   : out std_logic;        -- Start the MAX7219 Frame
      o_en_load : out std_logic;        -- Load
      o_data    : out std_logic_vector(15 downto 0));  -- Data

  end component init_max7219;

  -- INTERNAL SIGNALS
  signal s_start   : std_logic;
  signal s_start_p : std_logic;
  signal s_en_load : std_logic;
  signal s_data    : std_logic_vector(15 downto 0);
  signal s_done    : std_logic;

  signal s_max7219_load   : std_logic;
  signal s_max7219_clk    : std_logic;
  signal s_max7219_data   : std_logic;
  signal s_max7219_load_p : std_logic;
  signal s_max7219_clk_p  : std_logic;
  signal s_max7219_data_p : std_logic;
begin  -- architecture behv


  -- MAX7219 I/F
  max7219_if_inst : max7219_if
    generic map (
      G_MAX_HALF_PERIOD => G_MAX_HALF_PERIOD,
      G_LOAD_DURATION   => G_LOAD_DURATION
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      -- Input commands
      i_start   => s_start_p,
      i_en_load => s_en_load,
      i_data    => s_data,

      -- MAX7219 I/F
      o_max7219_load => s_max7219_load,
      o_max7219_data => s_max7219_data,
      o_max7219_clk  => s_max7219_clk,

      -- Transaction Done
      o_done => s_done);


  -- INIT_MAX7219_INST
  init_max7219_inst : init_max7219
    generic map (
      G_MAX_CNT => G_MAX_CNT)
    port map(
      clk       => clk,
      rst_n     => rst_n,
      i_done    => s_done,
      o_cnt     => o_cnt,
      o_start   => s_start,
      o_en_load => s_en_load,
      o_data    => s_data
      );

  p_pipe_outputs : process (clk, rst_n) is
  begin  -- process p_pipe_outputes
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_max7219_data_p <= '0';
      s_max7219_clk_p  <= '0';
      s_max7219_load_p <= '0';
      s_start_p        <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_max7219_data_p <= s_max7219_data;
      s_max7219_clk_p  <= s_max7219_clk;
      s_max7219_load_p <= s_max7219_load;
      s_start_p        <= s_start;
    end if;
  end process p_pipe_outputs;

  -- Outputs affectations

  o_max7219_clk  <= s_max7219_clk_p;
  o_max7219_data <= s_max7219_data_p;
  o_max7219_load <= s_max7219_load_p;
end architecture behv;
