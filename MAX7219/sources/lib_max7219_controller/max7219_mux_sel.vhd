-------------------------------------------------------------------------------
-- Title      : MAX7219 MUX selector
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_mux_sel.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-02-14
-- Last update: 2021-04-08
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 MUX Selector
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-02-14  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

--library lib_max7219;
--use lib_max7219.pkg_max7219_controller.all;


entity max7219_mux_sel is

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- MAX selector
    i_mux_sel : in std_logic_vector(1 downto 0);  -- Mux Selector

    -- Config
    i_max7219_if_start_config   : in  std_logic;  -- START MAX7219 I/F - Config
    i_max7219_if_en_load_config : in  std_logic;  -- EN Load LAX7219 I/F - Config
    i_max7219_if_data_config    : in  std_logic_vector(15 downto 0);  -- MAX7219 I/D Data - Config
    o_max7219_if_done_config    : out std_logic;  -- MAX7219 I/F Done - Config

    -- Static
    i_max7219_if_start_static   : in  std_logic;  -- START MAX7219 I/F - Static
    i_max7219_if_en_load_static : in  std_logic;  -- EN Load LAX7219 I/F - Static
    i_max7219_if_data_static    : in  std_logic_vector(15 downto 0);  -- MAX7219 I/D Data - Static
    o_max7219_if_done_static    : out std_logic;  -- MAX7219 I/F Done - Static

    -- Scroller
    i_max7219_if_start_Scroller   : in  std_logic;  -- START MAX7219 I/F - Scroller
    i_max7219_if_en_load_Scroller : in  std_logic;  -- EN Load LAX7219 I/F - Scroller
    i_max7219_if_data_Scroller    : in  std_logic_vector(15 downto 0);  -- MAX7219 I/D Data - Scroller
    o_max7219_if_done_Scroller    : out std_logic;  -- MAX7219 I/F Done - Scroller

    -- MAX7219 I/F
    i_max7219_if_done    : in  std_logic;  -- MAX7219 I/F - Done
    o_max7219_if_start   : out std_logic;  -- MAX7219 I/F - Start
    o_max7219_if_en_load : out std_logic;  -- MAX7219 I/F - En Load
    o_max7219_if_data    : out std_logic_vector(15 downto 0)  -- MAX7219 I/F - Data
    );

end entity max7219_mux_sel;


architecture behv of max7219_mux_sel is

  -- INTERNAL SIGNALS
  signal s_max7219_if_start   : std_logic;
  signal s_max7219_if_en_load : std_logic;
  signal s_max7219_if_data    : std_logic_vector(15 downto 0);


begin  -- architecture behv


  -- purpose: Route signals in function of i_sel_mux
  p_mux_sel_mngt : process (clk, rst_n) is
  begin  -- process p_mux_sel_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_max7219_if_start         <= '0';
      s_max7219_if_en_load       <= '0';
      s_max7219_if_data          <= (others => '0');
      o_max7219_if_done_config   <= '0';
      o_max7219_if_done_static   <= '0';
      o_max7219_if_done_scroller <= '0';

    elsif clk'event and clk = '1' then  -- rising clock edge

      case i_mux_sel is
        when "11" =>
          s_max7219_if_start       <= i_max7219_if_start_config;
          s_max7219_if_en_load     <= i_max7219_if_en_load_config;
          s_max7219_if_data        <= i_max7219_if_data_config;
          o_max7219_if_done_config <= i_max7219_if_done;

        when "01" =>
          s_max7219_if_start       <= i_max7219_if_start_static;
          s_max7219_if_en_load     <= i_max7219_if_en_load_static;
          s_max7219_if_data        <= i_max7219_if_data_static;
          o_max7219_if_done_static <= i_max7219_if_done;


        when "10" =>
          s_max7219_if_start         <= i_max7219_if_start_scroller;
          s_max7219_if_en_load       <= i_max7219_if_en_load_scroller;
          s_max7219_if_data          <= i_max7219_if_data_scroller;
          o_max7219_if_done_scroller <= i_max7219_if_done;

        when others =>
          s_max7219_if_start         <= '0';
          s_max7219_if_en_load       <= '0';
          s_max7219_if_data          <= (others => '0');
          o_max7219_if_done_config   <= '0';
          o_max7219_if_done_static   <= '0';
          o_max7219_if_done_scroller <= '0';
      end case;

    end if;
  end process p_mux_sel_mngt;

  -- Outputs Affectation
  o_max7219_if_start   <= s_max7219_if_start;
  o_max7219_if_en_load <= s_max7219_if_en_load;
  o_max7219_if_data    <= s_max7219_if_data;


end architecture behv;


