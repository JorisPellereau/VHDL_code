-- Entity declaration
entity hamming_5_16 is
  port (data_in     : in  std_logic_vector (15 downto 0);
        hamming_out : out std_logic_vector (4 downto 0));
end hamming_5_16;

-- Architecture declaration
architecture behavioral of hamming_5_16 is

-- Function declaration
  function calculate_parity (data : std_logic_vector) return std_logic is
    variable parity : std_logic;
  begin
    parity := '0';
    for i in data'range loop
      parity := parity xor data(i);
    end loop;
    return parity;
  end function;

-- Signal declarations
  signal s1, s2, s3, s4, s5 : std_logic;

begin

-- Parity bit calculation
  s1 <= calculate_parity(data_in(3 downto 0));
  s2 <= calculate_parity(data_in(7 downto 0));
  s3 <= calculate_parity(data_in(11 downto 0));
  s4 <= calculate_parity(data_in(15 downto 0));

-- Hamming code calculation
  s5 <= s1 xor s2 xor s3 xor s4;

-- Output assignment
  hamming_out(0) <= s1;
  hamming_out(1) <= s2;
  hamming_out(2) <= s3;
  hamming_out(3) <= s4;
  hamming_out(4) <= s5;

end behavioral;
