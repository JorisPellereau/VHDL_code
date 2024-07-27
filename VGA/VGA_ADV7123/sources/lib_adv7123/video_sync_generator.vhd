-------------------------------------------------------------------------------
-- Title      : Video Synchronization generator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : video_sync_generator.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-03-14
-- Last update: 2024-03-14
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Video Synchronization generator for VGA
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-03-14  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_utils;
use lib_utils.pkg_utils.all;

entity video_sync_generator is
  generic (
    G_HORI_LINE     : integer := 800;   -- Horizontal line total length
    G_HORI_BACK     : integer := 144;   -- BACK PORCH
    G_HORI_FRONT    : integer := 16;    -- FRONT PORCH
    G_VERT_LINE     : integer := 525;   -- Vertival line total length
    G_VERT_BACK     : integer := 34;    -- BACK PORCH
    G_VERT_FRONT    : integer := 11;    -- FRONT PORCH
    G_H_SYNCH_CYCLE : integer := 96;
    G_V_SYNC_CYCLE  : integer := 2);
  port (
    clk        : in  std_logic;         -- Clock system
    rst_n      : in  std_logic;         -- Asynchronous Reset
    blank_n    : out std_logic;         -- BLANK Command
    horiz_sync : out std_logic;         -- Horiz Synchronization
    vert_sync  : out std_logic);        -- Verti Synchronization
end entity video_sync_generator;


--VGA Timing
--Horizontal :
--                ______________                 _____________
--               |              |               |
--_______________|  VIDEO       |_______________|  VIDEO (next line)

--___________   _____________________   ______________________
--           |_|                     |_|
--            B <-C-><----D----><-E->
--           <------------A--------->
--The Unit used below are pixels;  
--  B->Sync_cycle                   :H_sync_cycle
--  C->Back_porch                   :hori_back
--  D->Visable Area
--  E->Front porch                  :hori_front
--  A->horizontal line total length :hori_line
--Vertical :
--               ______________                 _____________
--              |              |               |          
--______________|  VIDEO       |_______________|  VIDEO (next frame)
--
--__________   _____________________   ______________________
--          |_|                     |_|
--           P <-Q-><----R----><-S->
--          <-----------O---------->
--The Unit used below are horizontal lines;  
--  P->Sync_cycle                   :V_sync_cycle
--  Q->Back_porch                   :vert_back
--  R->Visable Area
--  S->Front porch                  :vert_front
--  O->vertical line total length :vert_line

architecture rtl of video_sync_generator is

  -- == INTERNAL Signals ==
  signal h_cnt      : unsigned(log2(G_HORI_LINE) downto 0);  -- Horizontal Line Counter
  signal v_cnt      : unsigned(log2(G_VERT_LINE) downto 0);  -- Vertical Line Counter
  signal cHD        : std_logic;
  signal cVD        : std_logic;
  signal cDEN       : std_logic;
  signal hori_valid : std_logic;
  signal vert_valid : std_logic;

begin  -- architecture rtl

-- purpose: Horizontal Counter
  p_horiz_cnt : process (clk, rst_n) is
  begin  -- process p_horiz_cnt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      h_cnt <= (others => '0');
    elsif falling_edge(clk) then        -- falling clock edge
      if(h_cnt = G_HORI_LINE -1) then
        h_cnt <= (others => '0');
      else
        h_cnt <= h_cnt +1;
      end if;
    end if;
  end process p_horiz_cnt;

  -- purpose: Vertical counter
  p_verti_cnt : process (clk, rst_n) is
  begin  -- process p_verti_cnt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      v_cnt <= (others => '0');
    elsif falling_edge(clk) then        -- falling clock edge
      if(h_cnt = G_HORI_LINE -1 and v_cnt = G_VERT_LINE -1) then
        v_cnt <= (others => '0');
      else
        v_cnt <= v_cnt +1;
      end if;
    end if;
  end process p_verti_cnt;

  cHD <= '0' when (h_cnt < G_H_SYNCH_CYCLE) else '1';
  cVD <= '0' when (v_cnt < G_V_SYNC_CYCLE)  else '1';

  hori_valid <= '1' when (h_cnt < (G_HORI_LINE - G_HORI_FRONT) and h_cnt >= G_HORI_BACK) else '0';

  vert_valid <= '1' when (v_cnt < (G_VERT_LINE - G_VERT_FRONT) and v_cnt >= G_VERT_BACK) else '0';

  cDEN <= hori_valid and vert_valid;

-- purpose: Output synchronization
  p_output_sync : process (clk, rst_n) is
  begin  -- process p_output_sync
    if rst_n = '0' then                 -- asynchronous reset (active low)
      horiz_sync <= '0';
      vert_sync  <= '0';
      blank_n    <= '1';
    elsif falling_edge(clk) then        -- falling clock edge
      horiz_sync <= cHD;
      vert_sync  <= cVD;
      blank_n    <= cDEN;
    end if;

  end process p_output_sync;

end architecture rtl;
