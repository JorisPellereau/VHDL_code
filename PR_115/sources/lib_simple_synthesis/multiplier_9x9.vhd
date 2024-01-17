-------------------------------------------------------------------------------
-- Title      : Multiplier 9*9
-- Project    : 
-------------------------------------------------------------------------------
-- File       : multiplier_9x9.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-17
-- Last update: 2024-01-17
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-17  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_9x9 is
  generic(
    G_SEL_VERSION : string := "COMB_UNSIGNED_"       -- Version to selected -- 14 char
    );
  port (
    clk_sys   : in  std_logic;                       -- Clock system
    rst_n_sys : in  std_logic;                       -- Asynchronous Reset
    data_a    : in  std_logic_vector(8 downto 0);    -- Data A
    data_b    : in  std_logic_vector(8 downto 0);    -- Data B
    data_out  : out std_logic_vector(17 downto 0));  -- Data Out

end entity multiplier_9x9;

architecture rtl of multiplier_9x9 is

  -- == INTERNAL Signals ==
  signal data_a_int   : std_logic_vector(8 downto 0);
  signal data_b_int   : std_logic_vector(8 downto 0);
  signal data_out_int : std_logic_vector(17 downto 0);

begin  -- architecture rtl


  g_version_comb_unsigned : if(G_SEL_VERSION = "COMB_UNSIGNED_") generate
    data_out <= std_logic_vector(unsigned(data_a)*unsigned(data_b));
  end generate;

  g_version_comb_signed : if(G_SEL_VERSION = "COMB_SIGNED___") generate
    data_out <= std_logic_vector(signed(data_a)*signed(data_b));
  end generate;



  g_version_synch_unsigned : if(G_SEL_VERSION = "SYNCH_UNSIGNED") generate
    p_mult : process (clk_sys, rst_n_sys) is
    begin  -- process p_mult
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        data_out <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge
        data_out <= std_logic_vector(unsigned(data_a)*unsigned(data_b));
      end if;
    end process p_mult;
  end generate;

  g_version_synch_signed : if(G_SEL_VERSION = "SYNCH_SIGNED__") generate
    p_mult : process (clk_sys, rst_n_sys) is
    begin  -- process p_mult
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        data_out <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge
        data_out <= std_logic_vector(signed(data_a)*signed(data_b));
      end if;
    end process p_mult;
  end generate;


  -- Piped inputs
  g_version_synch_unsigned_piped_data_in : if(G_SEL_VERSION = "SYNCH_UNPIPIN1") generate
    p_mult : process (clk_sys, rst_n_sys) is
    begin  -- process p_mult
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        data_out   <= (others => '0');
        data_a_int <= (others => '0');
        data_b_int <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge
        data_a_int <= data_a;
        data_b_int <= data_b;
        data_out   <= std_logic_vector(unsigned(data_a_int)*unsigned(data_b_int));
      end if;
    end process p_mult;
  end generate;

  -- Piped inputs and outputs
  g_version_synch_unsigned_piped_data_in_and_out : if(G_SEL_VERSION = "SYNCH_UNPIPIN2") generate
    p_mult : process (clk_sys, rst_n_sys) is
    begin  -- process p_mult
      if rst_n_sys = '0' then           -- asynchronous reset (active low)
        data_out     <= (others => '0');
        data_a_int   <= (others => '0');
        data_b_int   <= (others => '0');
        data_out_int <= (others => '0');
      elsif rising_edge(clk_sys) then   -- rising clock edge
        data_a_int   <= data_a;
        data_b_int   <= data_b;
        data_out_int <= std_logic_vector(unsigned(data_a_int)*unsigned(data_b_int));
        data_out     <= data_out_int;
      end if;
    end process p_mult;
  end generate;

end architecture rtl;
