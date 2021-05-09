-------------------------------------------------------------------------------
-- Title      : Static RAM Manager
-- Project    : 
-------------------------------------------------------------------------------
-- File       : static_ram_mngr.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-07
-- Last update: 2021-05-09
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

    G_RAM_ADDR_WIDTH_STATIC : integer              := 8;  -- RAM STATIC ADDR WIDTH
    G_RAM_DATA_WIDTH_STATIC : integer              := 16;  -- RAM STATIC DATA WIDTH
    G_UART_DATA_WIDTH       : integer range 5 to 9 := 8  -- UART RAM Data WIDTH
    );

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous clock

    -- RAM STATIC I/F
    i_rdata_static : in  std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM RDATA
    o_me_static    : out std_logic;
    o_we_static    : out std_logic;     -- W/R command
    o_addr_static  : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- RAM ADDR
    o_wdata_static : out std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM DATA

    -- INIT Static Ram
    i_init_static_ram      : in  std_logic;
    o_init_static_ram_done : out std_logic;

    -- Load Static Ram
    i_load_static_ram      : in  std_logic;
    o_load_static_ram_done : out std_logic;


    i_rx_data : in std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0);
    i_rx_done : in std_logic

    );

end entity static_ram_mngr;



architecture behv of static_ram_mngr is

  -- INTERNAL SIGNALS
  signal s_wr_ptr : std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- Write Pointer

  signal s_init_ram_ongoing     : std_logic;
  signal s_init_static_ram_done : std_logic;

  signal s_load_static_ram_ongoing : std_logic;
  signal s_load_static_ram_done    : std_logic;

  signal s_me_static    : std_logic;
  signal s_we_static    : std_logic;
  signal s_wdata_static : std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);

  signal s_cnt_rx_data : integer range 0 to 129;  -- 128 + 1 Data received from UART
  signal s_cnt_2       : integer range 0 to 2;    -- Counter 2
  signal s_data_rdy    : std_logic;     -- Data ready to transmit to RAM


begin  -- architecture behv


  p_ram_mngt : process (clk, rst_n) is
  begin  -- process p_ram_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_init_ram_ongoing     <= '0';
      s_load_static_ram_ongoing <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_init_static_ram = '1') then
        s_init_ram_ongoing <= '1';

      elsif(s_init_static_ram_done = '1') then
        s_init_ram_ongoing <= '0';

      elsif(i_load_static_ram = '1') then
        s_load_static_ram_ongoing <= '1';

      elsif(s_load_static_ram_done = '1') then
        s_load_static_ram_ongoing <= '0';
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
      s_cnt_rx_data          <= 0;
      s_cnt_2                <= 0;
      s_data_rdy             <= '0';
      s_load_static_ram_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge


      -- INIT STATIC RAM MNGT
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
        s_init_static_ram_done <= '0';
      end if;


      -- LOAD STATIC RAM MNGT
      if(s_load_static_ram_ongoing = '1' and s_load_static_ram_done = '0') then


        if(s_cnt_rx_data = 0) then
          if(i_rx_done = '1') then
            s_wr_ptr      <= i_rx_data;          -- Get Start Pointer
            s_cnt_rx_data <= s_cnt_rx_data + 1;  -- Inc Internal Counter
          end if;

        elsif(s_cnt_rx_data > 0 and s_cnt_rx_data < 129) then

          if(i_rx_done = '1') then
            s_wdata_static(7 downto 0)  <= i_rx_data; -- BIG ENDIAN
            s_wdata_static(15 downto 8) <= s_wdata_static(7 downto 0);  -- shift

            if(s_cnt_2 < 2 - 1) then
              s_cnt_2 <= s_cnt_2 + 1;
            else
              s_data_rdy  <= '1';
              s_me_static <= '1';
              s_we_static <= '1';
              s_cnt_2     <= 0;
            end if;


            s_cnt_rx_data <= s_cnt_rx_data + 1;  -- Inc
          else
            s_data_rdy  <= '0';
            s_me_static <= '0';
            s_we_static <= '0';
          end if;

          if(s_data_rdy = '1') then
            s_wr_ptr <= unsigned(s_wr_ptr) + 1;
          end if;

        else
          s_load_static_ram_done <= '1';
          s_cnt_rx_data          <= 0;
          s_cnt_2                <= 0;
          s_data_rdy             <= '0';

        end if;

      else
        s_load_static_ram_done <= '0';

      end if;

    end if;
  end process p_ram_access_mngt;



  -- Outputs affectation
  o_me_static    <= s_me_static;
  o_we_static    <= s_we_static;
  o_addr_static  <= s_wr_ptr;           -- TBD en cas de read ?
  o_wdata_static <= s_wdata_static;

  o_init_static_ram_done <= s_init_static_ram_done;

  o_load_static_ram_done <= s_load_static_ram_done;

end architecture behv;
