-------------------------------------------------------------------------------
-- Title      : SKIDBUFFER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : skidbuffer.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-06-08
-- Last update: 2024-06-09
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-06-08  1.0      linux-jp        Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity skidbuffer is

  generic (
    G_DATA_WIDTH : integer := 1);       -- Data Width of the buffer

  port (
    clk_sys   : in  std_logic;                                     -- Clock System
    rst_n_sys : in  std_logic;                                     -- Reset of the clk_sys clock domain
    i_valid   : in  std_logic;                                     -- Source Valid
    i_data    : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);   -- Input data
    o_ready   : out std_logic;                                     -- Source ready
    o_valid   : out std_logic;                                     -- Destination valid
    i_ready   : in  std_logic;                                     -- Destination ready
    o_data    : out std_logic_vector(G_DATA_WIDTH - 1 downto 0));  -- Data to destination

end entity skidbuffer;

architecture rtl of skidbuffer is

  -- == INTERNAL signals ==
  signal valid_flag  : std_logic;                                    -- Valid flag
  signal o_ready_int : std_logic;                                    -- Output ready
  signal o_valid_int : std_logic;                                    -- Output valid
  signal data_int    : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Input data latch

begin  -- architecture rtl

  -- Valid Flag Management
  p_valid_flag : process (clk_sys, rst_n_sys) is
  begin  -- process p_valid_flag
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      valid_flag <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Source side is valid and ready, the output side is valid but not ready
      -- In this case latch an internal flag : valid_flag
      if(i_valid = '1' and o_ready_int = '1' and o_valid_int = '1' and i_ready = '0') then
        valid_flag <= '1';

      -- In all other case, if the Destination side is ready -> reset the flag
      elsif(i_ready = '1') then
        valid_flag <= '0';
      end if;

    end if;
  end process p_valid_flag;

  -- Input data latch
  p_data_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_data_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      data_int <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- If the output is not valid or if the souce size is ready
      -- the internal data are reseted
      if(o_valid_int = '0' or i_ready = '1') then
        data_int <= (others => '0');

      -- If the source side is ready and the output/destination side is ready
      -- latch the input data
      elsif(i_valid = '1' and o_ready_int = '1') then
        data_int <= i_data;
      end if;
    end if;
  end process p_data_mngt;


  -- Output valid management
  p_o_valid_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_o_valid_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_valid_int <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- o_valid_int is update if the output o_valid is not set or if the source side is ready
      -- o_valid_int gets the value : from i_valid or valid_flag
      if(o_valid_int = '0' or i_ready = '1') then
        o_valid_int <= i_valid or valid_flag;
      end if;

    end if;
  end process p_o_valid_mngt;

  p_data_out_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_data_out_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      o_data <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- If internal valid flag is set, set to the data output internal data
      -- Valid Flag has a high priority
      if(valid_flag = '1') then
        o_data <= data_int;

      -- If i_valid is set to '1' and no valid flag, then set to the output data the input data
      elsif(i_valid = '1') then
        o_data <= i_data;
      else
        o_data <= (others => '0');
      end if;
    end if;
  end process p_data_out_mngt;

  -- Output affectation
  o_ready_int <= not valid_flag;        -- The output is the inversion of the valid flag
  o_ready     <= o_ready_int;
  o_valid     <= o_valid_int;           -- o_valid connected to internal o_valid_int

end architecture rtl;
