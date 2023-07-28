-- purpose: p
-- type   : sequential
-- inputs : p, p, p
-- outputs: p
p: process (p, p) is
begin  -- process p
  if p = '0' then                       -- asynchronous reset (active low)
    p
      
  elsif p'event and p = '1' then        -- rising clock edge
    
  end if;
end process p;

-- purpose: fzegfrze

-- purpose: fdfsd
p: process (f, f) is
begin  -- process p
  if f = '0' then                       -- asynchronous reset (active low)
    
  elsif f'event and f = '1' then        -- rising clock edge
    
  end if;
end process p;


-- purpose: 
p: process (p, rqsr) is
begin  -- process p
  if rqsr = '0' then                    -- asynchronous reset (active low)
    
  elsif p'event and p = '1' then        -- rising clock edge
    
  end if;
end process p;


-- purpose: l

p: process (p, rsf) is
begin  -- process p
  if rsf = '0' then                     -- asynchronous reset (active low)
    
  elsif p'event and p = '1' then        -- rising clock edge
    
  end if;
end process p;



-- purpose: 
p: process (p, rs) is
begin  -- process p
  if rs = '0' then                      -- asynchronous reset (active low)
    
  elsif p'event and p = '1' then        -- rising clock edge
    
  end if;
end process p;


-- purpose: 
p: process (p, p) is
begin  -- process p
  if p = '0' then                       -- asynchronous reset (active low)
    
  elsif rising_edge(p) then             -- rising clock edge
    
  end if;
end process p;
