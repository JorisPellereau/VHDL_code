-------------------------------------------------------------------------------
-- Title      : TDPRAM Single Clock Description
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tdpram_sclk.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-02-16
-- Last update: 2020-02-16
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: True Dual Port RAM Single Clock
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-02-16  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tdpram_sclk is

  generic (
    G_ADDR_WIDTH : integer := 8;        -- ADDR WIDTH
    G_DATA_WIDTH : integer := 8);       -- DATA WIDTH

  port (
    clk       : in  std_logic;          -- Clock
    i_me_a    : in  std_logic;          -- Memory Enable port A
    i_we_a    : in  std_logic;          -- Memory Write/Read access port A
    i_addr_a  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR port A
    i_wdata_a : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA port A
    o_rdata_a : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- RDATA port A

    i_me_b    : in  std_logic;          -- Memory Enable port B
    i_we_b    : in  std_logic;          -- Memory Write/Read access port B
    i_addr_b  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR port B
    i_wdata_b : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA port B
    o_rdata_b : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0)  -- RDATA port B
    );

end entity tdpram_sclk;


architecture behv of tdpram_sclk is

  -- TYPE
  type t_memory is array (0 to 2**G_ADDR_WIDTH - 1) of std_logic_vector(G_DATA_WIDTH - 1 downto 0);

  -- RAM
  shared variable v_ram : t_memory;

begin  -- architecture behv

  -- purpose: This process manages the R/W acces on port A
  p_port_a : process (clk)
  begin  -- process p_port_a
    if clk'event and clk = '1' then     -- rising clock edge
      if(i_me_a = '1') then
        if(i_we_a = '1') then
          v_ram(conv_integer(unsigned(i_addr_a))) := i_wdata_a;
        else
          o_rdata_a <= v_ram(conv_integer(unsigned(i_addr_a)));
        end if;
      end if;

    end if;
  end process p_port_a;


  -- purpose: This process manages the R/W acces on port B
  p_port_b : process (clk)
  begin  -- process p_port_b
    if clk'event and clk = '1' then     -- rising clock edge
      if(i_me_b = '1') then
        if(i_we_b = '1') then
          v_ram(conv_integer(unsigned(i_addr_b))) := i_wdata_b;
        else
          o_rdata_b <= v_ram(conv_integer(unsigned(i_addr_b)));
        end if;
      end if;

    end if;
  end process p_port_b;


end architecture behv;
