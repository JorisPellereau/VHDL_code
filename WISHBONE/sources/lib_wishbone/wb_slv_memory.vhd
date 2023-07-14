-------------------------------------------------------------------------------
-- Title      : A Wishbone Slave Memory
-- Project    : 
-------------------------------------------------------------------------------
-- File       : wb_slv_memory.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-06-09
-- Last update: 2023-06-09
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: A Wishbone Slave Memory
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-06-09  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wb_slv_memory is
  generic(G_ADDR_WIDTH : integer := 32;  -- ADDR Width
          G_DATA_WIDH  : integer := 32;  -- DATA Width
          G_RAM_DEPTH  : integer := 512  -- RAM DEPTH
          );
  port(
    clk_sys       : in std_logic;       -- Clock System
    rst_n_clk_sys : in std_logic;       -- Asynchronous Reset

    -- Wishbone ITF
    i_wb_cyc   : in  std_logic;
    i_wb_stb   : in  std_logic;
    i_wb_we    : in  std_logic;
    i_wb_addr  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);
    i_wb_data  : in  std_logic_vector(G_DATA_WIDH - 1 downto 0);
    i_wb_sel   : in  std_logic_vector((G_DATA_WIDH/8) - 1 downto 0);  -- STROBE
    o_wb_stall : out std_logic;
    o_wb_ack   : out std_logic;
    o_wb_data  : out std_logic_vector(G_DATA_WIDH - 1 downto 0)
    );
end entity wb_slv_memory;

architecture tl of wb_slv_memory is

  -- == TYPES ==
  type T_RAM_ARRAY is array (0 to G_RAM_DEPTH - 1) of std_logic_vector(G_DATA_WIDH - 1 downto 0);  -- RAM Type

  -- == INTERNAL Signals ==
  signal s_wb_stall : std_logic;        -- Wishbone Stall
  signal ram_array  : T_RAM_ARRAY;      -- RAM Array
begin  -- architecture tl


  -- purpose: WishBone Data Management  
  P_WB_DATA_MNGT : process (clk_sys, rst_n_clk_sys) is
  begin  -- process P_WB_DATA_MNGT
    if rst_n_clk_sys = '0' then         -- asynchronous reset (active low)
      o_wb_data <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge
      o_wb_data <= ram_array(to_integer(unsigned(i_wb_addr)));
    end if;
  end process P_WB_DATA_MNGT;

  -- purpose: WishBone Ack Management  
  P_WB_ACK_MNGT : process (clk_sys, rst_n_clk_sys) is
  begin  -- process P_WB_ACK_MNGT
    if rst_n_clk_sys = '0' then         -- asynchronous reset (active low)
      o_wb_ack <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      o_wb_ack <= i_wb_stb and (not s_wb_stall);
    end if;
  end process P_WB_ACK_MNGT;

  -- purpose: WishBone Stall Management
  P_WB_STALL_MNGT : process (clk_sys, rst_n_clk_sys) is
  begin  -- process P_WB_STALL_MNGT
    if rst_n_clk_sys = '0' then         -- asynchronous reset (active low)
      s_wb_stall <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      s_wb_stall <= '0';
    end if;
  end process P_WB_STALL_MNGT;

  -- == OUTPUTS Affectation ==
  o_wb_stall <= s_wb_stall;

end architecture tl;
