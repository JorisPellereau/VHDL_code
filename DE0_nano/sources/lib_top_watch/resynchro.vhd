-------------------------------------------------------------------------------
-- Title      : Resynchronization Block
-- Project    : 
-------------------------------------------------------------------------------
-- File       : resynchro.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-05-12
-- Last update: 2024-05-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-05-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity resynchro is
  port (
    clk_sys    : in  std_logic;         -- Clock System
    rst_n_sys  : in  std_logic;         -- Reset of Clock System
    rx         : in  std_logic;         -- Asynchronous input UART RX   
    rx_clk_sys : out std_logic          -- RX resynchronized in clk_sys clock domain
    );
end entity resynchro;


architecture rtl of resynchro is

  -- == INTERNAL Signals ==
  signal rx_p1 : std_logic;             -- RX piped one time
  signal rx_p2 : std_logic;             -- RX Piped a second time
begin  -- architecture rtl


  p_resyn_rx : process (clk_sys, rst_n_sys) is
  begin  -- process p_resyn_rx
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      rx_p1 <= '1';                     -- 1 By default
      rx_p2 <= '1';                     -- 1 By default
    elsif rising_edge(clk_sys) then     -- rising clock edge
      rx_p1 <= rx;
      rx_p2 <= rx_p1;
    end if;
  end process p_resyn_rx;

  -- Output affectation
  rx_clk_sys <= rx_p2;

end architecture rtl;
