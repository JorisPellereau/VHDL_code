-- Entity declaration
entity crc_16_12_5_1 is
  port (data_in : in  std_logic_vector (31 downto 0);
        crc_out : out std_logic_vector (4 downto 0));
end crc_16_12_5_1;

-- Architecture declaration
architecture behavioral of crc_16_12_5_1 is

-- Constants
  constant WIDTH      : integer                       := 32;
  constant POLYNOMIAL : std_logic_vector (4 downto 0) := "11011";

-- Signal declarations
  signal data_reg : std_logic_vector (WIDTH-1 downto 0) := (others => '0');

begin

-- Shift register
  process (data_in) is
  begin
    for i in data_reg'range loop
      if (i = 0) then
        data_reg(i) <= data_in(i) xor crc_out(4);
      else
        data_reg(i) <= data_reg(i-1);
      end if;
    end loop;
  end process;

-- CRC calculation
  crc_out <= data_reg(WIDTH-5 downto WIDTH-9) xor POLYNOMIAL;

end behavioral;
