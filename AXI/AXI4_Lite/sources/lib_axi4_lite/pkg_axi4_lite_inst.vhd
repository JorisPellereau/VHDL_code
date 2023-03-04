library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_axi4_lite;

package pkg_axi4_lite_inst is new lib_axi4_lite.pkg_axi4_lite
 generic map (
    G_AXI4_LITE_ADDR_WIDTH => 32, -- AXI4 ADDR Width
    G_AXI4_LITE_DATA_WIDTH => 32  -- AXI4 DATA Width
    );
