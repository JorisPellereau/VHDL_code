-------------------------------------------------------------------------------
-- Title      : WATCH MAX7219 Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : watch_max7219_ctrl.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-05-12
-- Last update: 2024-05-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-- Limitation : start shall be a pulse of one clk_sys clock period
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-05-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_top_watch;
use lib_top_watch.watch_pkg.all;

entity watch_max7219_ctrl is
  port (
    clk_sys   : in std_logic;           -- System Clock
    rst_n_sys : in std_logic;           -- Reset of clk_sys clock domain

    -- Control Interface
    init_sel    : in std_logic;            -- Framebuffer selection
    framebuffer : in t_framebuffer_array;  -- Framebuffer
    start       : in std_logic;            -- Start the transfert

    -- MAX7219 Interface
    max7219_done    : in  std_logic;                      -- MAX7219 DONE
    max7219_load_en : out std_logic;                      -- MAX7219 Load enable
    max7219_data    : out std_logic_vector(15 downto 0);  -- MAX7219 Data
    max7219_start   : out std_logic                       -- MAX7219 Start
    );
end entity watch_max7219_ctrl;

architecture rtl of watch_max7219_ctrl is

  -- == CONSTANTS ==
  constant C_MAX_CONFIG : unsigned(5 downto 0) := "01" & x"0";  -- Max value to read for the configuration
  constant C_MAX_DATA   : unsigned(5 downto 0) := "10" & x"F";  -- Max value for the data

  -- == INTERNAL Signals ==
  signal rd_ptr     : unsigned(5 downto 0);  -- Read pointer - Max value : 32
  signal max_rd_ptr : unsigned(5 downto 0);  -- Max read pointer value
  signal go         : std_logic;             -- First go

  signal start_int   : std_logic;                      -- Start internal
  signal load_en_int : std_logic;                      -- Load Enable Internal
  signal data_int    : std_logic_vector(15 downto 0);  -- Data internal

  signal load_en_comb : std_logic;      -- Enable Load enable - comb.

begin  -- architecture rtl


  -- purpose: MAX Read pointer selection
  p_max_rd_ptr_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_max_rd_ptr_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      max_rd_ptr <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On start : select the max rd ptr
      -- Config selection
      if(start = '1' and init_sel = '1') then
        max_rd_ptr <= C_MAX_CONFIG;

      -- Data selection
      elsif(start = '1' and init_sel = '0') then
        max_rd_ptr <= C_MAX_DATA;
      end if;

    end if;
  end process p_max_rd_ptr_mngt;

  -- purpose: Go management 
  p_go_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_go_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      go <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      if(start = '1') then
        go <= '1';
      else
        go <= '0';
      end if;

    end if;
  end process p_go_mngt;


  -- purpose: MAX7219 Interface management
  p_max7219_itf_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_max7219_itf_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      start_int   <= '0';
      load_en_int <= '0';
      data_int    <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Start the access on go or done until the max counter is not reach
      if(go = '1' or (max7219_done = '1' and rd_ptr < max_rd_ptr)) then
        start_int   <= '1';
        load_en_int <= load_en_comb;
        data_int    <= framebuffer(to_integer(rd_ptr));
      else
        start_int   <= '0';
        load_en_int <= '0';
        data_int    <= (others => '0');
      end if;

    end if;
  end process p_max7219_itf_mngt;

  -- purpose: Read Pointer Management 
  p_rd_ptr_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_rd_ptr_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      rd_ptr <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On start -> inc the counter
      if(start_int = '1') then

        if(rd_ptr = max_rd_ptr) then
          rd_ptr <= (others => '0');
        else
          rd_ptr <= rd_ptr + 1;         -- Inc. the counter by one
        end if;

      -- Reset the counter on external start
      elsif(start = '1') then
        rd_ptr <= (others => '0');
      end if;


    end if;
  end process p_rd_ptr_mngt;

  -- Enable to load the data every 4 MAX7219 Transaction
  load_en_comb <= '1' when rd_ptr(1 downto 0) = "11" else
                  '0';

  -- Output affectation
  max7219_start   <= start_int;
  max7219_data    <= data_int;
  max7219_load_en <= load_en_int;


end architecture rtl;
