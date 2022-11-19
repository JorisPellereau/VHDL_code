library ieee;
use ieee.std_logic_1164.all;

package pkg_utils is

  -- == Computes log2(i_int) and return an int ==
  function log2 (i_int : integer)       -- Input integer
    return integer;

end package pkg_utils;

package body pkg_utils is

  -- == Computes log2(i_int) and return an int ==
  function log2 (i_int : integer)       -- Input integer
    return integer is
    variable i : integer range 0 to 32 := 0;  -- Counter
  begin
    
    -- Integer on MAX 32 Bits
    for i in 0 to 32 loop
      if(2**i_data < i_int) then
        i := i + 1; Inc
      end if;
    end loop;  -- i
    return i
  end function log2;

end package body pkg_utils;
