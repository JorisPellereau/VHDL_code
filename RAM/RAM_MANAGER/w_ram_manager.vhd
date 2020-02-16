-------------------------------------------------------------------------------
-- Title      : WRITE RAM MANAGER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : w_ram_manager.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-02-16
-- Last update: 2020-02-16
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: WRITE RAM MANAGER - Roll Over mode
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

entity w_ram_manager is

  generic (
    G_ADDR_WIDTH : integer := 8;        -- ADDR RAM WIDTH
    G_DATA_WIDTH : integer := 8);       -- DATA RAM WIDTH

  port (
    clk          : in  std_logic;       -- Clock
    rst_n        : in  std_logic;       -- Asynchronous reset
    i_data_valid : in  std_logic;       -- DATA valid
    i_data       : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Input data
    o_addr       : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR to write on the RAM
    o_data       : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data to write
    o_me         : out std_logic;       -- Memory Enable
    o_we         : out std_logic);      -- Write command

end entity w_ram_manager;

architecture behv of w_ram_manager is

  -- INTERNAL SIGNALS
  signal s_data_valid        : std_logic;  -- Latch Data valid
  signal s_data_valid_r_edge : std_logic;  -- REDGE of i_data_valid

  signal s_me   : std_logic;            -- s_me
  signal s_me_p : std_logic;            -- s_me pipe

  signal s_data     : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Latch Data
  signal s_addr_ptr : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR Pointer

begin  -- architecture behv

  -- purpose: Latched inputs
  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_data_valid <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_data_valid <= i_data_valid;
    end if;
  end process p_latch_inputs;

  -- R EDGE DETECTION
  s_data_valid_r_edge <= i_data_valid and not s_data_valid;


  -- purpose: This process manages WRITE access to the RAM
  p_write_mngt : process (clk, rst_n) is
  begin  -- process p_write_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)    
      s_data <= (others => '0');
      o_we   <= '0';
      s_me   <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_data <= (others => '0');
      s_me   <= '0';
      o_we   <= '0';
      if(s_data_valid_r_edge = '1') then
        s_data <= i_data;
        s_me   <= '1';
        o_we   <= '1';
      end if;

    end if;
  end process p_write_mngt;

  -- purpose: Pipe  s_me
  p_pipe_me : process (clk, rst_n) is
  begin  -- process p_pipe_me
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_me_p     <= '0';
      s_addr_ptr <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_me_p <= s_me;

      if(s_me_p = '1') then
        s_addr_ptr <= unsigned(s_addr_ptr) + 1;  -- INC PTR
      end if;
    end if;
  end process p_pipe_me;

  -- OUTPUT AFFECTATION
  o_me   <= s_me;
  o_addr <= s_addr_ptr;
  o_data <= s_data;


end architecture behv;
