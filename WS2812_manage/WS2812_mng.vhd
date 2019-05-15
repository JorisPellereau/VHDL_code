library ieee;
use ieee.std_logic_1164.all;

library work;
use work.pkg_ws2812.all;


entity WS2812_mng is
  generic(T0H : integer := 18;
          T1H : integer := 35);
  port(clock      : in  std_logic;
       reset_n    : in  std_logic;      -- Clock, reset
       start      : in  std_logic;      -- Démarrage trame
       led_config : in  std_logic_vector(23 downto 0);  -- Configuration de la trame RGB
       trame_done : out std_logic;      -- Info' trame envoyée
       d_out      : out std_logic  -- Sortie PWM, génère un 1 ou 0 suivant le WS2812
       );
end WS2812_mng;


-------Achitecture--------

architecture arch_WS2812_mng of WS2812_mng is

-- Compteurs => T_clk = 20ns
--constant T0H                  : integer := 18;
--constant T1H                  : integer := 35;
  constant max_T   : integer := 63;
  constant T_reset : integer := 2500;   -- 50µs
  signal cpt_H     : integer range 0 to max_T;

  -- Signal
  signal start_s  : std_logic;          -- Old start input
  signal start_re : std_logic;          -- Flag that indicates the RE of start

  signal next_state : fsm_t;            -- Next state
  signal cur_state  : fsm_t;            -- Current state

  signal led_config_s : std_logic_vector(23 downto 0);
  signal fsm          : fsm_t;
  signal cnt_24       : integer range 0 to 24;
  signal tick_24      : std_logic;
  signal d_out_s      : std_logic;
  signal gen_done     : std_logic;
  signal trame_done_s : std_logic;

begin


  -- purpose: This process detect the rising edge of the start input 
  p_start_re_manage : process (clock, reset_n) is
  begin  -- process p_start_re_manage
    if reset_n = '0' then                   -- asynchronous reset (active low)
      start_s <= '0';                       -- Init to '0'
    elsif clock'event and clock = '1' then  -- rising clock edge

    end if;
  end process p_start_re_manage;


  -- purpose: This process affects the next state 
  p_next_state_affect : process (clock, reset_n) is
  begin  -- process p_next_state_affect
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cur_state  <= idle;
      next_state <= idle;
    elsif clock'event and clock = '1' then  -- rising clock edge
      next_state <= cur_state;
    end if;
  end process p_next_state_affect;


  -- This process manages the states
  p_states_manage : process (clock, reset_n) is
  begin  -- process p_states_manage
    if reset = '0' then                 -- asynchronous reset (active low)

    elsif clock'event and clock = '1' then  -- rising clock edge
      case cur_state is
        when ilde =>;

        when others => null;
      end case;
    end if;
  end process p_states_manage;




  -- == FSM Manage ==
  -- fsm_mng_p : process(clk, rst_n)
  -- begin
  --   if(rst_n = '0') then
  --     fsm          <= idle;             -- RAZ FSM
  --     trame_done_s <= '0';
  --   elsif(rising_edge(clk)) then
  --     case fsm is
  --       when idle =>
  --         trame_done_s <= '0';
  --         if(start = '1') then
  --           led_config_s <= led_config;
  --           fsm          <= sel;
  --         end if;
  --       when sel =>
  --         if(cnt_24 < 24) then
  --           if(led_config_s(cnt_24) = '0') then
  --             fsm <= gen0;
  --           elsif(led_config_s(cnt_24) = '1') then
  --             fsm <= gen1;
  --           end if;
  --         elsif(cnt_24 = 24) then
  --           fsm <= stop;
  --         end if;
  --       when gen0 =>
  --         if(gen_done = '1') then
  --           fsm <= sel;
  --         end if;
  --       when gen1 =>
  --         if(gen_done = '1') then
  --           fsm <= sel;
  --         end if;
  --       when stop =>
  --         trame_done_s <= '1';
  --         fsm          <= idle;
  --       when others => null;
  --     end case;
  --   end if;
  -- end process;
  -- trame_done <= trame_done_s;

  -- == SEL manage ==
  -- counter 24
  --
  -- sel_mng_p : process(clk, rst_n)
  -- begin
  --   if(rst_n = '0') then
  --     cnt_24  <= 0;
  --     tick_24 <= '0';
  --   elsif(rising_edge(clk)) then
  --     if(fsm = sel) then
  --       if(cnt_24 < 24) then
  --         cnt_24  <= cnt_24 + 1;
  --         tick_24 <= '0';
  --       else
  --         cnt_24  <= 0;
  --         tick_24 <= '1';
  --       end if;
  --     else
  --       tick_24 <= '0';
  --     end if;
  --   end if;
  -- end process;







  -- == OUTPUT GENERATION ==                            
  -- d_out_gen_p : process(clk, rst_n)
  -- begin
  --   if(rst_n = '0') then
  --     d_out_s  <= '0';
  --     gen_done <= '0';
  --     cpt_H    <= 0;
  --   elsif(rising_edge(clk)) then
  --     if(fsm = gen0) then
  --       if(cpt_H < max_T) then
  --         cpt_H    <= cpt_H + 1;
  --         gen_done <= '0';
  --       else
  --         gen_done <= '1';
  --         cpt_H    <= 0;
  --       end if;

  --       if(cpt_H < T0H) then
  --         d_out_s <= '1';
  --       else
  --         d_out_s <= '0';
  --       end if;
  --     elsif(fsm = gen1) then
  --       if(cpt_H < max_T) then
  --         cpt_H    <= cpt_H + 1;
  --         gen_done <= '0';
  --       else
  --         gen_done <= '1';
  --         cpt_H    <= 0;
  --       end if;

  --       if(cpt_H < T1H) then
  --         d_out_s <= '1';
  --       else
  --         d_out_s <= '0';
  --       end if;
  --     else
  --       d_out_s <= '0';
  --     end if;
  --   end if;
  -- end process;
  -- d_out <= d_out_s;






end arch_WS2812_mng;
