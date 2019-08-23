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

  signal check_on_s   : std_logic;      -- Start the check of the reg
  signal check_done_s : std_logic;      -- Check reg done
  signal array_reg    : t_array_reg;    -- Array of reg

  signal reg_addr_ok_o_s : std_logic;   -- Reg Addr find ok signal
  signal rdata_reg_o_s   : std_logic_vector(data_size - 1 downto 0);  -- Rdata

  signal data_valid_o_s  : std_logic;   -- data valid output
  signal data_valid_o_ss : std_logic;   -- Davalid intermediaire



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
        rcvd_addr_reg_i_s <= rcvd_addr_reg_i;
        wdata_reg_i_s     <= wdata_reg_i;
        rw_reg_i_s        <= rw_reg_i;
        check_on_s        <= '1';

      -- RAZ check_on_s & signals
      elsif(data_valid_o_s = '1') then
        rcvd_addr_reg_i_s <= (others => '0');
        wdata_reg_i_s     <= (others => '0');
        rw_reg_i_s        <= (others => '0');
        check_on_s        <= '0';
      end if;
    end if;
  end process p_latch_inputs;


  -- purpose: This process checks if the rcvd_addr_reg is in the list 
  p_check_reg : process (clock_i, reset_n) is
  begin  -- process p_check_reg
    if reset_n = '0' then               -- asynchronous reset (active low)
      reg_addr_ok_o_s <= '0';
      check_done_s    <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(check_on_s = '0') then
        reg_addr_ok_o_s <= '0';
        check_done_s    <= '0';
      else

        for i in 0 to C_MAX_REG - 1 loop
          if(rcvd_addr_reg_i_s = std_logic_vector(to_unsigned(i, rcvd_addr_reg_i_s'length))) then
            reg_addr_ok_o_s <= '1';
          else
            reg_addr_ok_o_s <= '0';
          end if;
        end loop;  -- i
        check_done_s <= '1';

      end if;
    end if;
  end process p_check_reg;
  reg_addr_ok_o <= reg_addr_ok_o_s;


  -- purpose: This process manages the RW in the reg if needed and data_valid
  p_rw_reg_mng : process (clock_i, reset_n) is
  begin  -- process p_rw_reg_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      rdata_reg_o_s   <= (others => '0');
      data_valid_o_s  <= '0';
      data_valid_o_ss <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge

      if(check_done_s = '1') then
        if(reg_addr_ok_o_s = '1') then  -- Rcvd addr in the list
          if(rw_reg_i_s = '1') then     -- Read case
            rdata_reg_o_s <= array_reg(to_integer(unsigned(rcvd_addr_reg_i_s)));
          else                          -- Write case
            array_reg(to_integer(unsigned(rcvd_addr_reg_i_s))) <= wdata_reg_i_s;
          end if;
          data_valid_o_ss <= '1';
          data_valid_o_s  <= data_valid_o_ss;
        end if;
      else
        rdata_reg_o_s   <= (others => '0');
        data_valid_o_s  <= '0';
        data_valid_o_ss <= '0';
      end if;

    end if;

  end process p_rw_reg_mng;
  rdata_reg_o  <= rdata_reg_o_s;
  data_valid_o <= data_valid_o_s;

end architecture arch_reg_ctrl;
