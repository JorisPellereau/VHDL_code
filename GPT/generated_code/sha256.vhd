-- chiffreur de données sur 32 bits avec protocole de chiffrement SHA-256
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sha256 is
  generic (
    -- la longueur du mot de hachage en bits
    HASH_LENGTH : positive := 256
    );
  port (
    clk  : in  std_logic;
    rst  : in  std_logic;
    -- entrées
    din  : in  std_logic_vector(31 downto 0);
    key  : in  std_logic_vector(31 downto 0);
    -- sorties
    dout : out std_logic_vector(HASH_LENGTH-1 downto 0)
    );
end sha256;

architecture behavioral of sha256 is
  -- constantes utilisées dans le processus de hachage
  constant K : array(0 to 63) of unsigned(32) := (
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000"
    );
  -- variables internes
  signal w      : array(0 to 63) of unsigned(32);
  signal h      : array(0 to 7) of unsigned(32);
  signal t1, t2 : unsigned(32);
begin
  -- processus de hachage
  process(clk, rst)
  begin
    if rst = '1' then
      -- initialisation des variables internes
      for i in 0 to 63 loop
        w(i) <= (others => '0');
      end loop;
      for i in 0 to 7 loop
        h(i) <= (others => '0');
      end loop;
      t1 <= (others => '0');
      t2 <= (others => '0');
    elsif rising_edge(clk) then
      -- préparation des mots de hachage
      for i in 0 to 15 loop
        w(i) <= din;
      end loop;
      for i in 16 to 63 loop
        t1 <= (w(i-15) xor w(i-16)) + w(i-7) + sigma
              1 + (w(i-15) srl 7) + (w(i-15) srl 18) + (w(i-15) srl 3);
        t2   <= (w(i-2) xor w(i-16)) + sigma0 + (w(i-2) srl 17) + (w(i-2) srl 19) + (w(i-2) srl 10);
        w(i) <= t1 + t2;
      end loop;
      -- initialisation des variables de hachage
      for i in 0 to 7 loop
        h(i) <= key(i);
      end loop;
      -- boucle principale de hachage
      for i in 0 to 63 loop
        t1   <= h(7) + Sigma1 + (h(4) and h(5)) + (h(4) and h(6)) + (h(5) and h(6)) + K(i) + w(i);
        t2   <= Sigma0 + (h(0) and h(1)) + (h(0) and h(2)) + (h(1) and h(2));
        h(7) <= h(6);
        h(6) <= h(5);
        h(5) <= h(4);
        h(4) <= h(3) + t1;
        h(3) <= h(2);
        h(2) <= h(1);
        h(1) <= h(0);
        h(0) <= t1 + t2;
      end loop;
      -- sortie du mot de hachage
      dout <= h(0) & h(1) & h(2) & h(3) & h(4) & h(5) & h(6) & h(7);
    end if;
  end process;
end behavioral;
