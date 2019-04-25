library ieee;
use ieee.std_logic_1164.all;


package pkg_ws2812 is

  -- == NEW TYPES ==
  type mode is (mode_0, mode_1);        -- Modes d'envoie (0 ou 1)
  type fsm_t is (idle, sel, gen0, gen1, stop);

  component WS2812_mng is
    generic(T0H : integer := 18;
            T1H : integer := 35);
    port(clk, rst_n : in  std_logic;    -- Clock, reset
         start      : in  std_logic;    -- Démarrage trame
         led_config : in  std_logic_vector(23 downto 0);  -- Configuration de la trame RGB
         trame_done : out std_logic;    -- Info' trame envoyée
         d_out      : out std_logic  -- Sortie PWM, génère un 1 ou 0 suivant le WS2812
         );
  end component;


  function mode_sel(config_msb : in std_logic)
    return mode;


end package pkg_ws2812;


package body pkg_ws2812 is

  function mode_sel(config_msb : in std_logic)
    return mode is

    variable mode_trame : mode;

  begin

    if(config_msb = '1') then
      mode_trame := mode_1;
    else
      mode_trame := mode_0;
    end if;
    return mode_trame;
  end mode_sel;


end package body;
