-------------------------------------------------------------------------------
-- Title      : Register controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : reg_ctrl.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-08-23
-- Last update: 2019-08-23
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the register controller for the pinball project
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-08-23  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

entity reg_ctrl is

  generic (
    data_size : integer range 5 to 9 := 8);  -- Size of the data

  port (
    reset_n       : in  std_logic;      -- Active Low Asynchronous Reset
    clock_i       : in  std_logic;      -- System clock 
    rcvd_addr_reg : in  std_logic_vector(data_size - 1 downto 0);
    wdata_reg_i   : in  std_logic_vector(data_size - 1 downto 0);
    rw_reg_i      : in  std_logic;
    start_rw_i    : in  std_logic;
    data_valid_i  : in  std_logic;
    reg_addr_ok_o : out std_logic;
    rdata_reg_o   : out std_logic_vector(data_size - 1 downto 0));

end entity reg_ctrl;
