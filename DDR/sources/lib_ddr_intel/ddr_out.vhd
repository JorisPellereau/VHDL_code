-------------------------------------------------------------------------------
-- Title      : Intel DDR Output
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ddr_out.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-02-15
-- Last update: 2024-02-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-02-15  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ddr_out is

  generic (
    G_DATA_WIDTH : integer := 1);       -- Data Range

  port (
    clk_sys        : in  std_logic;                                    -- Clock System
    rst_n_sys      : in  std_logic;                                    -- Asynchronous reset
    data_in_r_edge : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DDR Data in R Edge
    data_in_f_edge : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DDR Data in F Edge
    ddr_out        : out std_logic_vector(G_DATA_WIDTH - 1 downto 0)   -- DDR Data out
    );

end entity ddr_out;

architecture rtl of ddr_out is

  -- == Internal Signals ==
  signal data_r_edge_int : std_logic_vector(G_DATA_WIDTH -1 downto 0);  -- Data On rising edge
  signal data_f_edge_int : std_logic_vector(G_DATA_WIDTH -1 downto 0);  -- Data On falling edge


begin  -- architecture rtl

  p_data_r_edge : process (clk_sys, rst_n_sys) is
  begin  -- process p_data_r_edge
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      data_r_edge_int <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge
      data_r_edge_int <= data_in_r_edge;
    end if;
  end process p_data_r_edge;

  p_data_f_edge : process (clk_sys, rst_n_sys) is
  begin  -- process p_data_f_edge
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      data_f_edge_int <= (others => '0');
    elsif falling_edge(clk_sys) then    -- rising clock edge
      data_f_edge_int <= data_in_f_edge;
    end if;
  end process p_data_f_edge;

  ddr_out <= data_r_edge_int when not(clk_sys and rst_n_sys) = '0' else
             data_f_edge_int;

end architecture rtl;
