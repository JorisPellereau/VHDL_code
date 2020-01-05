-------------------------------------------------------------------------------
-- Title      : MAX7219 interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_interface.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-07-18
-- Last update: 2020-01-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the interface controler for 8x8 matrix
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-18  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_interface is

  port (
    clk            : in  std_logic;     -- System clock
    rst_n          : in  std_logic;     -- Asynchronous active low reset
    i_max7219_data : in  std_logic_vector(15 downto 0);  -- Data to send te the Max7219
    i_start        : in  std_logic;     -- Start the transaction
    i_en_load      : in  std_logic;     -- Enable the generation of o_load
    o_load_max7219 : out std_logic;     -- LOAD command
    o_data_max7219 : out std_logic;     -- DATA to send th
    o_clk_max7219  : out std_logic;     -- CLK
    o_max7219_done : out std_logic);    -- Frame done

end entity max7219_interface;



architecture arch_max7219_interface of max7219_interface is




begin  -- architecture arch_max7219_interface



end architecture arch_max7219_interface;
