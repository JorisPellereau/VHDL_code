-------------------------------------------------------------------------------
-- Title      : VHDL TOP Testbench for GHDL coverage
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_top.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-06-07
-- Last update: 2021-06-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-06-07  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_uart;
use lib_uart.pkg_uart.all;

library lib_uart_display_ctrl;
use lib_uart_display_ctrl.pkg_uart_max7219_display_ctrl.all;

entity tb_top is

end entity tb_top;

architecture behv of tb_top is

  component uart_max7219_ctrl_top is

    port (
      clk   : in std_logic;
      rst_n : in std_logic;

      i_rx : in  std_logic;
      o_tx : out std_logic;

      o_max7219_load : out std_logic;
      o_max7219_data : out std_logic;
      o_max7219_clk  : out std_logic;

      o_leds : out std_logic_vector(7 downto 0)
      );

  end component;

  signal clk            : std_logic;
  signal rst_n          : std_logic;
  signal s_rx           : std_logic;
  signal s_tx           : std_logic;
  signal s_max7219_load : std_logic;

  signal s_max7219_data : std_logic;
  signal s_max7219_clk  : std_logic;
  signal s_leds         : std_logic_vector(7 downto 0);


begin  -- architecture behv



  i_uart_max7219_ctrl_top_0 : uart_max7219_ctrl_top

    port map (
      clk   => clk,
      rst_n => rst_n,

      i_rx => s_rx,
      o_tx => s_tx,

      o_max7219_load => s_max7219_load,
      o_max7219_data => s_max7219_data,
      o_max7219_clk  => s_max7219_clk,

      o_leds => s_leds
      );

end architecture behv;
