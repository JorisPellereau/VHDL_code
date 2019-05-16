library ieee;
use ieee.std_logic_1164.all;

library work;
use work.pkg_ws2812.all;


entity WS2812_mng is
  generic(T0H : integer := 18;
          T1H : integer := 35);
  port(clock      : in  std_logic;                      -- Input clock
       reset_n    : in  std_logic;                      -- Asynchronous reset
       start      : in  std_logic;                      -- Start a frame
       led_config : in  std_logic_vector(23 downto 0);  -- Led configuration
       frame_done : out std_logic;                      -- Frame terminated
       d_out      : out std_logic                       -- Serial output
       );
end WS2812_mng;


-------Achitecture--------

architecture arch_WS2812_mng of WS2812_mng is

-- Compteurs => T_clk = 20ns
--constant T0H                  : integer := 18;
--constant T1H                  : integer := 35;
  -- constant max_T   : integer := 63;
  -- constant T_reset : integer := 2500;   -- 50µs

  signal cpt_H : integer range 0 to max_T;

  -- Signal
  signal start_s  : std_logic;          -- Old start input
  signal start_re : std_logic;          -- Flag that indicates the RE of start

  signal next_state : fsm_t;            -- Next state
  signal cur_state  : fsm_t;            -- Current state

  signal led_config_s : std_logic_vector(23 downto 0);  -- Latch config
  signal fsm          : fsm_t;                          -- States of the FSM

  signal cnt_max_T : integer range 0 to max_T;  -- Counter that counts until Max_t

  signal cnt_24       : integer range 0 to 24;  -- Counter that counts the  number of bit to transmit
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
      if(fsm = idle) then
        start_s <= start_s;
      else
        start_s <= '0';
      end if;
    end if;
  end process p_start_re_manage;
  start_re <= start and not start_s;        -- RE detect


  -- purpose: This process latch the inputs during the RE of start
  p_inputs_latch : process (clock, reset_n) is
  begin  -- process p_inputs_latch
    if reset = '0' then                     -- asynchronous reset (active low)
      led_config_s <= (others => '0');
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(start_re = '1') then
        led_config_s <= led_config;
      end if;
    end if;
  end process p_inputs_latch;



  -- purpose: This process affects the next state 
  p_state_affect : process (clock, reset_n) is
  begin  -- process p_next_state_affect
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cur_state  <= idle;
      next_state <= idle;
    elsif clock'event and clock = '1' then  -- rising clock edge
      cur_state <= next_state;
    end if;
  end process p_next_state_affect;



  -- This process manages the states
  p_states_manage : process (clock, reset_n) is
  begin  -- process p_states_manage
    if reset = '0' then                 -- asynchronous reset (active low)

    elsif clock'event and clock = '1' then  -- rising clock edge
      case cur_state is
        when ilde =>
          if(start_re = '1') then
            next_state <= latch_inputs;
          else
            next_state <= cur_state;
          end if;

        when others => null;
      end case;
    end if;
  end process p_states_manage;




  -- purpose: This process generate a 0 
  p_gen_pwm : process (clock, reset_n) is
  begin  -- process p_gen_0
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_max_T <= 0;
      d_out_s   <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge

      if(fsm = gen0 or fsm = gen1) then
        cnt_max_T <= cnt_max_T + 1;
      else
        cnt_max_T <= 0;
      end if;

      if(fsm = gen0) then
        if(cnt_max_T <= T0H) then
          d_out_s <= '1';
        else
          d_out_s <= '0';
        end if;
      elsif(fsm = gen1) then
        if(cnt_max_T <= T1H) then
          d_out_s <= '1';
        else
          d_out_s <= '0';
        end if;
      else
        d_out_s <= '0';
      end if;
    end if;
  end process p_gen_0;


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
