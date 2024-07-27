-------------------------------------------------------------------------------
-- Title      : AXI ADDR
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi_addr.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-06-09
-- Last update: 2024-06-09
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI Address computation
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-06-09  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axi_addr is

  generic (
    G_ADDR_WIDTH : integer := 32;       -- ADDR Width
    G_DATA_WIDTH : integer := 32);      -- DATA Width

  port (
    last_addr : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Last addr
    size      : in  std_logic_vector(2 downto 0);                 -- AXI size
    burst     : in  std_logic_vector(1 downto 0);                 -- AXI burst
    len       : in  std_logic_vector(7 downto 0);                 -- AXI len
    next_addr : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0)   -- Next Addr
    );

end entity axi_addr;


architecture rtl of axi_addr is

  -- Clip the return integer to 12 if addr_with is greater than 12 bits
  -- else return addr_width
  function f_max_addr_width(addr_with : integer)
    return integer is
    variable v_addr_width : integer := 0;
  begin  -- function f_max_addr_width

    if(addr_width >= 12) then
      v_addr_width := 12;
    else
      v_addr_width := addr_width;
    end if;

    return v_addr_width;
  end function f_max_addr_width;

  -- == INTERNAL Signals ==
  signal increment      : std_logic_vector(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 0);  -- Increment
  signal wrap_mask      : std_logic_vector(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 0);  -- Wrap mask
  signal unaligned_addr : std_logic_vector(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 0);  -- Unaligned addr
  signal aligned_addr   : std_logic_vector(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 0);  -- Aligned addr
  signal crossblk_addr  : std_logic_vector(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 0);  -- Cross Block addr

begin  -- architecture rtl


  -- Logic for a data width of 8 bits
  g_data_width_8 : if(G_DATA_WIDTH = 0) generate

    -- For a data width of 8 bits -> increment is always 1
    increment <= std_logic_vector(to_unsigned(1, increment'length));
  end generate;


  -- Logic for a data width of 16 bits
  g_data_width_16 : if(G_DATA_WIDTH = 16) generate

    -- For a data width of 16 bits -> increment is 1 or 2 (1 byte or 2 bytes)
    increment <= std_logic_vector(to_unsigned(2, increment'length)) when size(0) = '1' else
                 std_logic_vector(to_unsigned(1, increment'length));
  end generate;

  -- Logic for a data width of 32 bits
  g_data_width_32 : if(G_DATA_WIDTH = 32) generate

    -- For a data 6 32 bits -> increment if 1, 2 or 4 bytes
    increment <= std_logic_vector(to_unsigned(4, increment'length)) when size(1) = '1' else
                 std_logic_vector(to_unsigned(2, increment'length)) when size(0) = '1' else
                 std_logic_vector(to_unsigned(1, increment'length));
  end generate;


  g_8_16 : if(G_DATA_WIDTH = 8 or G_DATA_WIDTH = 16) generate

    -- Generate the wrap mask
    wrap_mask <= std_logic_vector(to_unsigned(0, f_max_addr_width(G_ADDR_WIDTH) - 4)) & len(3 downto 1) & '1' when size(0) = '0' else
                 std_logic_vector(to_unsigned(0, f_max_addr_width(G_ADDR_WIDTH) - 3)) & len(3 downto 0) & '1';

    -- Generate the aligned addr
    aligned_addr <= last_addr(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 0) when burst = "00" else
                    unaligned_addr(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 1) & '0' when (burst /= "00" and size(0) = '1') else
                    unaligned_addr;

  end generate;

  g_32_64 : if(G_DATA_WIDTH = 32 or G_DATA_WIDTH = 64) generate

    -- Generate the wrap mask for 32 and 64 bits
    wrap_mask <= std_logic_vector(to_unsigned(0, f_max_addr_width(G_ADDR_WIDTH) - 4)) & len(3 downto 1) & '1' when size(1 downto 0) = "00" else
                 std_logic_vector(to_unsigned(0, f_max_addr_width(G_ADDR_WIDTH) - 3)) & len(3 downto 0) & '1'  when size(1 downto 0) = "01" else
                 std_logic_vector(to_unsigned(0, f_max_addr_width(G_ADDR_WIDTH) - 2)) & len(3 downto 0) & "01" when size(1 downto 0) = "10" else
                 std_logic_vector(to_unsigned(0, f_max_addr_width(G_ADDR_WIDTH) - 1)) & len(3 downto 0) & "001";

    -- Generate the aligned addr for 32 and 64 bits
    aligned_addr <= last_addr(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 0) when burst = "00" else
                    unaligned_addr                                                     when (burst /= "00" and size(1 downto 0) = "00") else
                    unaligned_addr(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 1) & '0'  when (burst /= "00" and size(1 downto 0) = "01") else
                    unaligned_addr(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 2) & "00" when (burst /= "00" and size(1 downto 0) = "10") else
                    unaligned_addr(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 3) & "000";


  end generate;


  -- Unaligned addr if the last addr + the increment
  unaligned_addr <= std_logic_vector(unsigned(last_addr) + unsigned(increment));


  -- Managed the wrap
  crossblk_addr <= ((last_addr(f_max_addr_width(G_ADDR_WIDTH) - 1 downto 0) and not(wrap_mask)) or (aligned_addr and wrap_mask)) when burst(1) = '1' else
                   aligned_addr;

  g_next_addr_sup_12bits : if(G_ADDR_WIDTH > 12) generate
    next_addr <= last_addr(G_ADDR_WIDTH - 1 downto 12) & crossblk_addr(11 downto 0);
  end generate;

  g_next_addr_lw_12_bits : if(G_ADDR_WIDTH <= 12) generate
    next_addr <= crossblk_addr(G_ADDR_WIDTH - 1 downto 0);
  end generate;



end architecture rtl;
