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
    reset_n : in std_logic;             -- Active Low Asynchronous Reset
    clock_i : in std_logic;             -- System clock

    -- Addr Reg to RW from the UART command
    rcvd_addr_reg_i : in  std_logic_vector(data_size - 1 downto 0);
    -- Write data for the Write command
    wdata_reg_i     : in  std_logic_vector(data_size - 1 downto 0);
    -- RW command
    rw_reg_i        : in  std_logic;
    -- Start the RW command
    start_rw_i      : in  std_logic;
    -- Data valid
    data_valid_o    : out std_logic;
    -- Reg addr present in the list
    reg_addr_ok_o   : out std_logic;
    -- Read data from the correct Addr reg
    rdata_reg_o     : out std_logic_vector(data_size - 1 downto 0));

end entity reg_ctrl;

architecture arch_reg_ctrl of reg_ctrl is

  -- CONSTANTS
  constant C_MAX_REG : integer := 5;    -- Number Max of register

  -- NEW TYPES
  type t_array_reg is array (0 to C_MAX_REG - 1) of std_logic_vector(data_size - 1 downto 0);

  -- INTERNAL SIGNALS
  signal start_rw_i_s      : std_logic;  -- Old start_rw_i
  signal start_rw_i_r_edge : std_logic;  -- Rising edge of start_rw_i

  signal rcvd_addr_reg_i_s : std_logic_vector(data_size - 1 downto 0);
  signal wdata_reg_i_s     : std_logic_vector(data_size - 1 downto 0);
  signal rw_reg_i_s        : std_logic;

  signal check_on_s : std_logic;        -- Start the check of the reg
  signal array_reg  : t_array_reg;      -- Array of reg

begin  -- architecture arch_reg_ctrl

  -- purpose: This process manages the REdge of the inputs
  p_r_edge_mng : process (clock_i, reset_n) is
  begin  -- process p_r_edge_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      start_rw_i_s <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      start_rw_i_s <= start_rw_i;
    end if;
  end process p_r_edge_mng;
  start_rw_i_r_edge <= start_rw_i and not start_rw_i_s;


  -- purpose: This process latches the inputs 
  p_latch_inputs : process (clock_i, reset_n) is
  begin  -- process p_latch_inputs
    if reset_n = '0' then               -- asynchronous reset (active low)
      rcvd_addr_reg_i_s <= (others => '0');
      wdata_reg_i_s     <= (others => '0');
      rw_reg_i_s        <= (others => '0');
      check_on_s        <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(start_rw_i_r_edge = '1') then
        rcvd_addr_reg_s <= rcvd_addr_reg_i;
        wdata_reg_i_s   <= wdata_reg_i;
        rw_reg_i_s      <= rw_reg_i;
        check_on_s      <= '1';
      end if;
    end if;
  end process p_latch_inputs;


  -- purpose: This process checks if the rcvd_addr_reg is in the list 
  p_check_reg : process (clock_i, reset_n) is
  begin  -- process p_check_reg
    if reset_n = '0' then               -- asynchronous reset (active low)

    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(check_on_s = '0') then
        
      else
        
      end if;
    end if;
  end process p_check_reg;


end architecture arch_reg_ctrl;
