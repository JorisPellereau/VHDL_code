-------------------------------------------------------------------------------
-- Title      : MAX7219 Interface selector
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_if_sel.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-10-04
-- Last update: 2021-05-11
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 I/F Selector
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-10-04  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity max7219_if_sel is
  generic (

    -- MAX7219 STATIC CTRL GENERICS
    G_RAM_ADDR_WIDTH_STATIC : integer := 8;   -- RAM ADDR WITH
    G_RAM_DATA_WIDTH_STATIC : integer := 16;  -- RAM DATA WIDTH

    -- MAX7219 SCROLLER CTRL GENERICS
    G_RAM_ADDR_WIDTH_SCROLLER : integer := 8;   -- RAM ADDR WITH
    G_RAM_DATA_WIDTH_SCROLLER : integer := 8);  -- RAM DATA WIDTH
  port(
    clk   : in std_logic;                       -- Clock
    rst_n : in std_logic;                       -- Asynchronous clock

    -- Input selection
    i_static_dyn : in std_logic;        -- Input selection

    --
    i_new_config_val : in  std_logic;
    o_new_config_val : out std_logic;

    -- STATIC I/O
    i_start_static : in  std_logic;
    o_start_static : out std_logic;




    -- SCROLLER I/O
    i_start_scroll           : in std_logic;  -- Valid - Start Scroller
    i_ram_start_ptr_scroller : in std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM START PTR
    i_msg_length_scroller    : in std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- Message Length    
    i_max_tempo_cnt_scroller : in std_logic_vector(31 downto 0);  -- Scroller Tempo

    o_start_scroll           : out std_logic;
    o_ram_start_ptr_scroller : out std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM START PTR
    o_msg_length_scroller    : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- Message Length    
    o_max_tempo_cnt_scroller : out std_logic_vector(31 downto 0);  -- Scroller Tempo




    -- MAX7219 Config IF
    i_config_done               : in  std_logic;
    i_max7219_if_start_config   : in  std_logic;
    i_max7219_if_en_load_config : in  std_logic;
    i_max7219_if_data_config    : in  std_logic_vector(15 downto 0);
    o_max7219_if_done_config    : out std_logic;

    -- MAX7219 Static IF
    i_static_busy               : in  std_logic;
    i_max7219_if_start_static   : in  std_logic;
    i_max7219_if_en_load_static : in  std_logic;
    i_max7219_if_data_static    : in  std_logic_vector(15 downto 0);
    o_max7219_if_done_static    : out std_logic;

    -- MAX7219 Dynamic IF
    i_scroller_busy              : in  std_logic;
    i_max7219_if_start_dynamic   : in  std_logic;
    i_max7219_if_en_load_dynamic : in  std_logic;
    i_max7219_if_data_dynamic    : in  std_logic_vector(15 downto 0);
    o_max7219_if_done_dynamic    : out std_logic;

    -- MAX7219_if I/F
    i_max7219_if_done    : in  std_logic;
    o_max7219_if_start   : out std_logic;
    o_max7219_if_en_load : out std_logic;
    o_max7219_if_data    : out std_logic_vector(15 downto 0)


    );

end entity max7219_if_sel;


architecture behv of max7219_if_sel is

  -- INTERNAL SIGNALS
  signal s_config_sel : std_logic;
  signal s_static_sel : std_logic;
  signal s_dyn_sel    : std_logic;

  signal s_start_scroll : std_logic;
  signal s_start_static : std_logic;
  signal s_start_config : std_logic;

  signal s_new_config : std_logic;

begin  -- architecture behv

  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start_config <= '0';
      s_start_static <= '0';
      s_start_scroll <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_start_config <= i_new_config_val;
      s_start_static <= i_start_static;
      s_start_scroll <= i_start_scroll;
    end if;
  end process p_latch_inputs;


  p_start_mngt : process (clk, rst_n) is
  begin  -- process p_start_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)

      o_new_config_val <= '0';
      s_new_config     <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Start Config MNGT
      if(i_new_config_val = '1' and s_start_config = '0') then
        if(i_static_busy = '0' and i_scroller_busy = '0' and i_config_done = '1') then
          s_new_config <= '1';
        end if;

      -- Start STATIC
      elsif(i_start_static = '1' and s_start_static = '0') then
        if(i_static_busy = '0' and i_scroller_busy = '0' and i_config_done = '1') then

        end if;
      end if;

      if(s_config_sel = '1' and s_new_config = '1') then
        o_new_config_val <= '1';
      elsif(s_new_config = '0') then
        o_new_config_val <= '0';
      end if;

      -- Release after config done
      if(i_config_done = '0') then
        s_new_config <= '0';
      end if;

    end if;
  end process p_start_mngt;



  -- purpose: MUX between MAX7219 I/F Management
  p_mux_sel_mngt : process (clk, rst_n) is
  begin  -- process p_mux_sel_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_max7219_if_start        <= '0';
      o_max7219_if_en_load      <= '0';
      o_max7219_if_data         <= (others => '0');
      o_max7219_if_done_config  <= '0';
      o_max7219_if_done_static  <= '0';
      o_max7219_if_done_dynamic <= '0';
      s_config_sel              <= '0';
      s_static_sel              <= '0';
      s_dyn_sel                 <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- By default : Route to Config
      if(i_config_done = '0' or s_new_config = '1') then
        o_max7219_if_start       <= i_max7219_if_start_config;
        o_max7219_if_en_load     <= i_max7219_if_en_load_config;
        o_max7219_if_data        <= i_max7219_if_data_config;
        o_max7219_if_done_config <= i_max7219_if_done;
        s_config_sel             <= '1';
        s_static_sel             <= '0';
        s_dyn_sel                <= '0';

      -- Config. Terminated
      else
        s_config_sel <= '0';
        if(i_static_dyn = '0') then
          o_max7219_if_start       <= i_max7219_if_start_static;
          o_max7219_if_en_load     <= i_max7219_if_en_load_static;
          o_max7219_if_data        <= i_max7219_if_data_static;
          o_max7219_if_done_static <= i_max7219_if_done;
          s_static_sel             <= '1';
          s_dyn_sel                <= '0';
        else
          o_max7219_if_start        <= i_max7219_if_start_dynamic;
          o_max7219_if_en_load      <= i_max7219_if_en_load_dynamic;
          o_max7219_if_data         <= i_max7219_if_data_dynamic;
          o_max7219_if_done_dynamic <= i_max7219_if_done;
          s_static_sel              <= '0';
          s_dyn_sel                 <= '1';
        end if;
      end if;

    end if;
  end process p_mux_sel_mngt;


end architecture behv;
