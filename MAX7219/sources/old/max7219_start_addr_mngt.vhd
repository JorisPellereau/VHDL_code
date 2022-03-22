-------------------------------------------------------------------------------
-- Title      : MAX7219 Start Addr. Management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_start_addr_mngt.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-07-25
-- Last update: 2020-07-25
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 Start Addr. Management
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-07-25  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_start_addr_mngt is
  generic (
    G_RAM_ADDR_WIDTH : integer              := 16;  -- RAM ADDR WIDTH
    G_DIGITS_NB      : integer range 2 to 8 := 8);  -- Digits Number on the Display
  port (
    clk                 : in  std_logic;
    rst_n               : in  std_logic;            -- Asynchronous reset
    o_config_start_addr : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    o_score_start_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    o_msg_start_addr    : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0)
    );
end entity max7219_start_addr_mngt;

architecture behv of max7219_start_addr_mngt is

  -- CONSTANTS
  constant C_CONFIG_START_ADDR : integer := 0;
  constant C_SCORE_START_ADDR  : integer := 32;
  constant C_MSG_START_ADDR    : integer := 95;

  -- INTERNAL SIGNALS
  signal s_config_start_addr : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_score_start_addr  : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_msg_start_addr    : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);





begin  -- architecture behv

  p_start_addr_mngt : process (clk, rst_n) is
  begin  -- process p_start_addr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_config_start_addr <= (others => '0');
      s_score_start_addr  <= (others => '0');
      s_msg_start_addr    <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_config_start_addr <= conv_std_logic_vector(C_CONFIG_START_ADDR, s_config_start_addr'length);
      s_score_start_addr  <= conv_std_logic_vector(C_SCORE_START_ADDR, s_config_start_addr'length);
      s_msg_start_addr    <= conv_std_logic_vector(C_MSG_START_ADDR, s_config_start_addr'length);
    end if;
  end process p_start_addr_mngt;


  -- OUTPUTS AFFECTATION
  o_config_start_addr <= s_config_start_addr;
  o_score_start_addr  <= s_score_start_addr;
  o_msg_start_addr    <= s_msg_start_addr;
  
end architecture behv;
