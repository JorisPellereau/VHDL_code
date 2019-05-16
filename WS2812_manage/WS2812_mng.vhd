library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;


entity WS2812_mng is
  generic(T0H : integer := T0H;
          T0L : integer := T0L;
          T1H : integer := T1H;
          T1L : integer := T1L
          );
  port(clock      : in  std_logic;                      -- Input clock
       reset_n    : in  std_logic;                      -- Asynchronous reset
       start      : in  std_logic;                      -- Start a frame
       led_config : in  std_logic_vector(23 downto 0);  -- Led configuration
       frame_done : out std_logic;                      -- Frame terminated
       d_out      : out std_logic                       -- Serial output
       );
end WS2812_mng;

architecture arch_WS2812_mng of WS2812_mng is

  -- CONSTANTS
  constant max_T0 : integer := T0H + T0L;  -- Max duration of the 0 logical
  constant max_T1 : integer := T1H + T1L;  -- Max duration of the 1 logical

  -- Signals
  signal start_s  : std_logic;          -- Old start input
  signal start_re : std_logic;          -- Flag that indicates the RE of start

  signal en_gen0 : std_logic;           -- Enable the 0 generation
  signal en_gen1 : std_logic;           -- Enable the 1 generation

  signal gen0_done : std_logic;         -- Logical 0 generated
  signal gen1_done : std_logic;         -- Logical 1 generated

  signal gen0_done_old : std_logic;     -- Logical 0 generated old
  signal gen1_done_old : std_logic;     -- Logical 1 generated old

  signal gen0_done_re : std_logic;      -- Rising edge of gen0_done
  signal gen1_done_re : std_logic;      -- Rising edge of gen1_done

  signal gen0_out : std_logic;          -- gen0 output
  signal gen1_out : std_logic;          -- gen1 output

  signal cnt_gen0 : integer range 0 to max_T0;  -- Counter for the gen0
  signal cnt_gen1 : integer range 0 to max_T1;  -- Counter or the gen1

  signal cnt_reset : integer range 0 to T_reset;  -- Counters for the reset between 2 frames

  signal led_config_s : std_logic_vector(23 downto 0);  -- Latch config
  signal fsm          : fsm_t;                          -- States of the FSM

  signal cnt_24 : integer range 0 to 23;  -- deCounter that counts the  number of bit to transmit

  signal d_out_s        : std_logic;    -- To output
  signal frame_done_s   : std_logic;    -- Frame done
  signal frame_done_out : std_logic;    -- Frame done to output

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
    if reset_n = '0' then                   -- asynchronous reset (active low)
      led_config_s <= (others => '0');
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(start_re = '1') then
        led_config_s <= led_config;
      end if;
    end if;
  end process p_inputs_latch;

  -- purpose: This process manages the FSM on the system
  p_fsm_mng : process (clock, reset_n) is
  begin  -- process p_fsm_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      fsm <= idle;
    elsif clock'event and clock = '1' then  -- rising clock edge
      case fsm is
        when idle =>
          if(start_re = '1') then
            fsm <= gen_frame;
          end if;
        when gen_frame =>
          if(frame_done_s = '1') then
            fsm <= gen_reset;
          end if;
        when gen_reset =>
          if(frame_done_out = '1') then
            fsm <= idle;
          end if;
        when others => null;
      end case;
    end if;
  end process p_fsm_mng;


  -- purpose: This process counts from 23 to 0 
  p_counter24 : process (clock, reset_n) is
  begin  -- process p_counter24
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_24       <= 23;
      frame_done_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(gen0_done_re = '1' or gen1_done_re = '1') then
        if(cnt_24 > 0) then
          cnt_24       <= cnt_24 - 1;       -- Dec cnt
          frame_done_s <= '0';
        else
          cnt_24       <= 23;               -- Init cnt
          frame_done_s <= '1';
        end if;
      elsif(fsm = idle or fsm = gen_reset) then
        frame_done_s <= '0';                -- RAZ
      end if;
    end if;
  end process p_counter24;

  en_gen0 <= '1' when led_config_s(cnt_24) = '0' and fsm = gen_frame else '0';  -- and fsm = gen_frame else
  -- '0' when fsm = idle or fsm = gen_reset;

  en_gen1 <= '1' when led_config_s(cnt_24) = '1' and fsm = gen_frame else '0';  -- and fsm = gen_frame else
  -- '0' when fsm = idle or fsm = gen_reset;


  -- purpose: This process generates the logical 0 
  p_gen0 : process (clock, reset_n) is
  begin  -- process p_gen0
    if reset_n = '0' then                   -- asynchronous reset (active low)
      gen0_out  <= '0';                     -- PWM output
      cnt_gen0  <= 0;                       -- Init counter
      gen0_done <= '0';                     -- Flag done
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(en_gen0 = '1') then

        if(cnt_gen0 < max_T0) then
          cnt_gen0  <= cnt_gen0 + 1;
          gen0_done <= '0';
        else
          cnt_gen0  <= 0;               -- RAZ cnt
          gen0_done <= '1';
        end if;

        if(cnt_gen0 < T0H) then
          gen0_out <= '1';
        else
          gen0_out <= '0';
        end if;

      else
        cnt_gen0  <= 0;                 -- RAZ cnt
        gen0_out  <= '0';               -- RAZ output
        gen0_done <= '0';               -- Raz flag
      end if;
    end if;
  end process p_gen0;

  -- purpose: This process generates the logical 1 
  p_gen1 : process (clock, reset_n) is
  begin  -- process p_gen0
    if reset_n = '0' then                   -- asynchronous reset (active low)
      gen1_out  <= '0';                     -- PWM output
      cnt_gen1  <= 0;                       -- Init counter
      gen1_done <= '0';                     -- RAZ flag
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(en_gen1 = '1') then

        if(cnt_gen1 < max_T1) then
          cnt_gen1  <= cnt_gen1 + 1;
          gen1_done <= '0';
        else
          cnt_gen1  <= 0;               -- RAZ cnt
          gen1_done <= '1';             -- Set flag
        end if;

        if(cnt_gen1 < T1H) then
          gen1_out <= '1';
        else
          gen1_out <= '0';
        end if;

      else
        cnt_gen1  <= 0;                 -- RAZ cnt
        gen1_out  <= '0';               -- RAZ output
        gen1_done <= '0';               -- RAZ flag
      end if;
    end if;
  end process p_gen1;


  -- purpose: This process detects the RE of the gen_done signals
  p_gen_done_detect : process (clock, reset_n) is
  begin  -- process p_gen_done_detect
    if reset_n = '0' then                   -- asynchronous reset (active low)
      gen0_done_old <= '0';
      gen1_done_old <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      gen0_done_old <= gen0_done;
      gen1_done_old <= gen1_done;
    end if;
  end process p_gen_done_detect;

  -- Detect Rising edge
  gen0_done_re <= gen0_done and not gen0_done_old;
  gen1_done_re <= gen1_done and not gen1_done_old;

  -- Outputs affectation
  d_out_s <= gen0_out when en_gen0 = '1'else   -- and fsm = gen_frame else
             gen1_out when en_gen1 = '1' else  -- and fsm = gen_frame else
             '0';  --      when fsm = gen_reset or fsm = idle;  -- Default : '0'

  d_out <= d_out_s;


  -- purpose: This process generates the reset after sending a frame 
  p_reset_gen : process (clock, reset_n) is
  begin  -- process p_reset_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_reset      <= 0;
      frame_done_out <= '1';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(fsm = gen_reset) then
        if(cnt_reset < T_reset) then
          cnt_reset      <= cnt_reset + 1;
          frame_done_out <= '0';
        else
          cnt_reset      <= 0;
          frame_done_out <= '1';
        end if;
      elsif(fsm = gen_frame) then
        frame_done_out <= '0';
        cnt_reset      <= 0;
      elsif(fsm = idle) then
        frame_done_out <= '1';
        cnt_reset      <= 0;
      end if;
    end if;
  end process p_reset_gen;

  frame_done <= frame_done_out;         -- Output affectation
end arch_WS2812_mng;
