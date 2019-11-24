-------------------------------------------------------------------------------
-- Title      : WS2812 REGISTERS management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ws2812_registers_mngt.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2019-11-24
-- Last update: 2019-11-24
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This file manages the registers of the WS2812
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-11-24  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity ws2812_registers_mngt is

  generic (
    G_REG_SIZE : integer := 8;          -- Registers Size
    G_CNT_SIZE : integer := 16);        -- Counter size 
  port (
    clock               : in  std_logic;  -- Clock
    rst_n               : in  std_logic;  -- Asynchronous reset
    i_stat_dyn          : in  std_logic;  -- Static-Dyn. command
    i_leds_conf_update  : in  std_logic;  -- Upadate config. Leds
    i_dyn_ongoing       : in  std_logic;  -- Dynamic mode ongoing
    i_rfrsh_dyn_done    : in  std_logic;  -- Dyn. Refresh done
    i_rfrsh_value_valid : in  std_logic;  -- Rfresh value valid
    i_rfrsh_value       : in  std_logic_vector(G_CNT_SIZE - 1 downto 0);  -- Refresh in
    o_rfrsh_value       : out std_logic_vector(G_CNT_SIZE - 1 downto 0);  -- Refresh out
    o_status            : out std_logic_vector(G_REG_SIZE - 1 downto 0)  -- Status reg
    );

end entity ws2812_registers_mngt;

architecture arch_ws2812_registers_mngt of ws2812_registers_mngt is

  -- Internal signals
  signal s_status : std_logic_vector(G_REG_SIZE - 1 downto 0);  -- Status register

begin  -- architecture arch_ws2812_registers_mngt


  -- purpose: This block manage the status Register
  p_status_mngt : process (clock, rst_n) is
  begin  -- process p_status_mngt
    if rst_n = '0' then                     -- asynchronous reset (active low)
      s_status <= (others => '0');
    elsif clock'event and clock = '1' then  -- rising clock edge
      s_status(0) <= i_stat_dyn;
      s_status(1) <= i_dyn_ongoing;
      s_status(2) <= i_rfrsh_dyn_done;
    end if;
  end process p_status_mngt;


  -- Outputs affectation
  o_status <= s_status;



end architecture arch_ws2812_registers_mngt;
