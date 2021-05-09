-------------------------------------------------------------------------------
-- Title      : Matrix config Manager
-- Project    : 
-------------------------------------------------------------------------------
-- File       : matrix_config_mngr.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-09
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
-- 2021-05-09  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_uart;
use lib_uart.pkg_uart.all;

library lib_uart_display_ctrl;
use lib_uart_display_ctrl.pkg_uart_max7219_display_ctrl.all;


entity matrix_config_mngr is

  generic (
    G_UART_DATA_WIDTH : integer range 5 to 9 := 8  -- UART RAM Data WIDTH
    );
  port (
    clk   : in std_logic;                          -- Clock
    rst_n : in std_logic;                          -- Asunchronous Reset

    i_load_config      : in  std_logic;  -- Load Config. Command
    o_load_config_done : out std_logic;  --Load Config. Command done

    i_update_config      : in  std_logic;  -- New config Command    
    o_update_config_done : out std_logic;  -- Config. Done

    o_display_test : out std_logic;     -- Display test config.
    o_decod_mode   : out std_logic_vector(7 downto 0);
    o_intensity    : out std_logic_vector(7 downto 0);
    o_scan_limit   : out std_logic_vector(7 downto 0);
    o_shutdown     : out std_logic_vector(7 downto 0);

    -- RX UART I/F
    i_rx_data : in std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0);
    i_rx_done : in std_logic
    );

end entity matrix_config_mngr;

architecture behv of matrix_config_mngr is

begin  -- architecture behv






end architecture behv;
