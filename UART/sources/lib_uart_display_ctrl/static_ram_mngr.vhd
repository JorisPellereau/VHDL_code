-------------------------------------------------------------------------------
-- Title      : Static RAM Manager
-- Project    : 
-------------------------------------------------------------------------------
-- File       : static_ram_mngr.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-07
-- Last update: 2021-05-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-05-07  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_uart;
use lib_uart.pkg_uart.all;

library lib_uart_display_ctrl;
use lib_uart_display_ctrl.pkg_uart_max7219_display_ctrl.all;


entity static_ram_mngr is

  generic (

    G_RAM_ADDR_WIDTH_STATIC : integer := 8;    -- RAM STATIC ADDR WIDTH
    G_RAM_DATA_WIDTH_STATIC : integer := 16);  -- RAM STATIC DATA WIDTH

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous clock

    -- RAM STATIC I/F
    i_rdata_static : in  std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM RDATA
    o_me_static    : out std_logic;
    o_we_static    : out std_logic;     -- W/R command
    o_addr_static  : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- RAM ADDR
    o_wdata_static : out std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM DATA

    i_init_static_ram      : in  std_logic;
    o_init_static_ram_done : out std_logic

    );

end entity static_ram_mngr;



architecture behv of static_ram_mngr is

  -- INTERNAL SIGNALS
  signal s_wr_ptr : std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- Write Pointer

  signal s_init_ram_ongoing     : std_logic;
  signal s_init_static_ram_done : std_logic;

  signal s_me_static    : std_logic;
  signal s_we_static    : std_logic;
  signal s_wdata_static : std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);


begin  -- architecture behv


  p_ram_mngt : process (clk, rst_n) is
  begin  -- process p_ram_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_init_ram_ongoing <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_init_static_ram = '1') then
        s_init_ram_ongoing <= '1';

      elsif(s_init_static_ram_done = '1') then
        s_init_ram_ongoing <= '0';
      end if;

    end if;
  end process p_ram_mngt;



  p_ram_access_mngt : process (clk, rst_n) is
  begin  -- process p_ram_access_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_me_static            <= '0';
      s_we_static            <= '0';
      s_wdata_static         <= (others => '0');
      s_wr_ptr               <= x"00";
      s_init_static_ram_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_init_ram_ongoing = '1' and s_init_static_ram_done = '0') then


        if(s_me_static = '0') then
          s_me_static    <= '1';
          s_we_static    <= '1';
          s_wdata_static <= (others => '0');
        else
          if(s_wr_ptr < x"FF") then     -- TBD pas generic
            s_me_static    <= '1';
            s_we_static    <= '1';
            s_wdata_static <= (others => '0');
            s_wr_ptr       <= unsigned(s_wr_ptr) + 1;
          else
            s_init_static_ram_done <= '1';
          end if;

        end if;

      else
        s_me_static            <= '0';
        s_we_static            <= '0';
        s_wdata_static         <= (others => '0');
        s_wr_ptr               <= (others => '0');
        s_init_static_ram_done <= '0';
      end if;

    end if;
  end process p_ram_access_mngt;



  -- Outputs affectation
  o_me_static    <= s_me_static;
  o_we_static    <= s_we_static;
  o_addr_static  <= s_wr_ptr;
  o_wdata_static <= s_wdata_static;

  o_init_static_ram_done <= s_init_static_ram_done;

end architecture behv;
