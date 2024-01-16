-------------------------------------------------------------------------------
-- Title      : Slave Selection Decoder
-- Project    : 
-------------------------------------------------------------------------------
-- File       : slave_sel_decoder.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-11
-- Last update: 2024-01-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Slave selection decoder - Transform a selection of one slave into an unsigned value
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-11  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity slave_sel_decoder is

  generic (
    G_SLAVE_NB : integer range 2 to 16 := 2);                          -- Number of slave
  port (
    sel_idx_bit_comb : in  std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Slave index selection,  one bit into G_SLAVE_NB
    sel_idx_comb     : out std_logic_vector(log2(G_SLAVE_NB) - 1 downto 0)
    );

end entity slave_sel_decoder;

architecture rtl of slave_sel_decoder is

begin  -- architecture rtl

  -- Addr Decode for 2 Slaves
  g_addr_decode_2_slaves : if(G_SLAVE_NB = 2) generate
    sel_idx_comb(0) <= sel_idx_bit_comb(1) and (not sel_idx_bit_comb(0));
    sel_idx_comb(1) <= '0';
  end generate;

  -- Addr Decode for 3 Slaves
  g_addr_decode_3_slaves : if(G_SLAVE_NB = 3) generate
    sel_idx_comb(0) <= (not sel_idx_bit_comb(2)) and sel_idx_bit_comb(1) and (not sel_idx_bit_comb(0));
    sel_idx_comb(1) <= sel_idx_bit_comb(2) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0));
  end generate;

  -- Addr Decode for 4 Slaves 
  g_addr_decode_4_slaves : if(G_SLAVE_NB = 4) generate
    sel_idx_comb(0) <= ((not sel_idx_bit_comb(3)) and (not sel_idx_bit_comb(2)) and sel_idx_bit_comb(1) and (not sel_idx_bit_comb(0))) or
                       (sel_idx_bit_comb(3) and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0)));
    sel_idx_comb(1) <= (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0));
  end generate;

  -- Addr Decode for 5 Slaves
  g_addr_decode_5_slaves : if(G_SLAVE_NB = 5) generate
    sel_idx_comb(0) <= ((not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(3)) and (not sel_idx_bit_comb(2))
                        and sel_idx_bit_comb(1) and (not sel_idx_bit_comb(0))) or
                       (sel_idx_bit_comb(3) and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1))
                        and (not sel_idx_bit_comb(0)));
    sel_idx_comb(1) <= (not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0));
    sel_idx_comb(2) <= sel_idx_bit_comb(4) and (not sel_idx_bit_comb(3)) and (not sel_idx_bit_comb(2))
                       and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0));
  end generate;

  -- Addr Decode for 6 Slaves
  g_addr_decode_6_slaves : if(G_SLAVE_NB = 6) generate
    sel_idx_comb(0) <= ((not sel_idx_bit_comb(5)) and (not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(3)) and (not sel_idx_bit_comb(2)) and sel_idx_bit_comb(1) and (not sel_idx_bit_comb(0))) or
                       ((not sel_idx_bit_comb(5)) and (not sel_idx_bit_comb(4)) and sel_idx_bit_comb(3) and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0))) or
                       (sel_idx_bit_comb(5) and (not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(3)) and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0)));

    sel_idx_comb(1) <= ((not sel_idx_bit_comb(5)) and (not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(3)) and sel_idx_bit_comb(2) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0))) or
                       ((not sel_idx_bit_comb(5)) and (not sel_idx_bit_comb(4)) and sel_idx_bit_comb(3) and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0)));


    sel_idx_comb(2) <= ((not sel_idx_bit_comb(5)) and sel_idx_bit_comb(4) and (not sel_idx_bit_comb(3)) and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0))) or
                       (sel_idx_bit_comb(5) and (not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(3)) and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0)));
  end generate;

  -- Addr Decode for 7 Slaves
  g_addr_decode_7_slaves : if(G_SLAVE_NB = 7) generate

    sel_idx_comb(0) <= ((not sel_idx_bit_comb(5)) and (not sel_idx_bit_comb(4)) and sel_idx_bit_comb(3) and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0))) or
                       (sel_idx_bit_comb(5) and (not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(3)) and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0))) or
                       ((not sel_idx_bit_comb(5)) and (not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(3)) and (not sel_idx_bit_comb(2)) and sel_idx_bit_comb(1) and (not sel_idx_bit_comb(0)));


    sel_idx_comb(1) <= ((not sel_idx_bit_comb(6)) and (not sel_idx_bit_comb(5)) and (not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(3))
                        and sel_idx_bit_comb(2) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0))) or

                       ((not sel_idx_bit_comb(6)) and (not sel_idx_bit_comb(5)) and (not sel_idx_bit_comb(4)) and sel_idx_bit_comb(3)
                        and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0))) or

                       (sel_idx_bit_comb(6) and (not sel_idx_bit_comb(5)) and (not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(3))
                        and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0)));


    sel_idx_comb(2) <= ((not sel_idx_bit_comb(6)) and sel_idx_bit_comb(5) and (not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(3))
                        and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0))) or

                       (sel_idx_bit_comb(6) and (not sel_idx_bit_comb(5)) and (not sel_idx_bit_comb(4)) and (not sel_idx_bit_comb(3))
                        and (not sel_idx_bit_comb(2)) and (not sel_idx_bit_comb(1)) and (not sel_idx_bit_comb(0)));

  end generate;

end architecture rtl;
