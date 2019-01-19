--=======================================
--	
--	filename 	: sequencer_generic.vhd
--	Author 		: Joris Pellereau
--	Created		: 03/12/2018
--=======================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library std;
use std.textio.all;


library tb_generic_lib;				-- Generic TB library
use tb_generic_lib.pkg_constants.all;	
use tb_generic_lib.pkg_functions.all;
use tb_generic_lib.pkg_tb_generic.all;


entity sequencer_generic is
	port(
		clk 		: in std_logic;
		status		: in std_logic_vector(nb_status - 1 downto 0);
		cmd_pulses 	: out std_logic_vector(nb_cmd_pulses - 1 downto 0);
		resets		: out std_logic_vector(nb_reset - 1 downto 0);
		stdl_out	: out std_logic_vector(nb_stdl - 1 downto 0)
	);
end sequencer_generic;



architecture behv of sequencer_generic is

file file_seq : text;

signal start_instr	: std_logic;

signal instr_tmp	: string(1 to max_cmd_size);			-- Instructions
signal args_tmp		: string(1 to max_arg_size);
signal nb_line_scenario : integer := 0;

signal start_cpt_line   : std_logic := '0';
signal start_open	: std_logic := '0';
signal rd_line		: std_logic := '0';
signal cpt_line		: integer := 0;

signal state : fsm_state := INIT;


-- == DONE signals
signal count_done 	: std_logic := '0';
signal open_done	: std_logic := '0';
signal done_readline	: std_logic := '0';
signal close_done	: std_logic := '0';

signal instr_done	: std_logic_vector(nb_cmd downto 0) := (others => '0');		-- EMpty line + nb command -1
signal instr_size_args 	: tab_size_args;						-- Sizes of the arguments
signal instr_length	: integer := 0;
signal arg_length	: integer := 0;
signal nb_args		: integer := 0;							-- number of arguments in the read instruction
signal pos_args		: tab_pos_args;							-- Position of each arguments in the String
signal tab_arguments_s	: tab_arguments := (others => (others => '0'));
signal resets_s		: std_logic_vector(nb_reset - 1 downto 0) := (others => '0');

begin

	-- == FSM_mng ==
	FSM_mng : 		process
			 	begin
			 		
			 		case state is
			 			WHEN INIT => 
			 					state <= S1;
			 			WHEN S1 => 
			 					start_cpt_line <= '1';
			 					if(count_done = '1') then			 					
			 						state <= S2;
			 					end if;
			 			WHEN S2 => 
			 					start_open <= '1';
			 					if(open_done = '1') then
			 						state <= S3;
			 					end if;
			 					
			 			when S3 =>	
			 					rd_line <= '1';				-- start readline
			 					if(done_readline = '1') then
			 						state <= S4;
			 						rd_line <= '0';
			 					end if;
			 			WHEN S4 =>	
			 					--wait until instr_done'event ;--and ;		-- Synchro fin d'instruction
			 					if(cpt_line < nb_line_scenario) then
			 						state <= S3;
			 					elsif(cpt_line = nb_line_scenario) then
			 						state <= S5;
			 					end if;
			 					wait until instr_done'event;
			 			WHEN S5 =>	
			 					--if(close_done = '1') then		 					
			 					
				 					state <= IDLE;			
				 				--end if;
			 			WHEN IDLE => 
			 					assert false report "End of test" severity failure;
			 			when others => NULL;
			 		end case;
			 		wait for 1 ns;
			 	end process;
	-- ===================================
			 	
	
	-- == CPt_line ==
	count_line :   	process(start_cpt_line, state)
				variable file_line	: line;
				variable string_tmp	: string(1 to 100);
				variable nb_line_scenario_var : integer := 0;
			begin	
				if(state = INIT) then
					string_tmp    	:= (others => NUL);
				elsif(rising_edge(start_cpt_line)) then
					file_open(file_seq, scenario_file, read_mode);		-- Open scenario
					while(not endfile(file_seq) ) loop
						readline(file_seq, file_line);
						read(file_line, string_tmp(1 to file_line'length));
						nb_line_scenario_var := nb_line_scenario_var + 1;
					end loop;
					nb_line_scenario <= nb_line_scenario_var;
					file_close(file_seq);
					count_done <= '1';
				end if;							
			end process;
	-- ============================
	
	
	-- == FILE OPEN/CLOSE ==
	op_cls_file_p : process(start_open, state)
			begin
				if(state = S5) then
					file_close(file_seq);
					close_done <= '1';
				elsif(rising_edge(start_open)) then
					file_open(file_seq, scenario_file, read_mode);		-- Open scenario
					open_done <= '1';
				end if;
			end process;
	-- ============================
	
	

	-- == SEQ ==
	seq_p : process(rd_line, state)
				variable file_line	: line;
				variable str_line	: string(1 to 200);
				variable lg_cmd		: integer;
				variable instr_tmp_v	: string(1 to max_cmd_size);
				variable args_tmp_v	: string(1 to max_arg_size);
				variable arg_length_v	: integer;
				variable i		: integer range 1 to nb_cmd := 1;
				variable start_instr_v	: std_logic := '0';
				variable nb_args_v	: integer := 0;
				variable pos_args_v	: tab_pos_args;
				variable instr_size_args_v 	: tab_size_args;
				variable tab_arguments_v	: tab_arguments;
		begin
			if(state = S4 or state = INIT) then
				done_readline 	<= '0';
				start_instr 	<= '0';
				start_instr_v	:= '0';
				instr_size_args <= (others => 0);
				nb_args		<= 0;
				pos_args	<= (others => 0);
			elsif(rising_edge(rd_line)) then
				if(cpt_line  < nb_line_scenario) then
					readline(file_seq, file_line);
					if(file_line'length > 0) then					-- Line NOT NULL
						read(file_line, str_line(1 to file_line'length));	-- Line to String
						lg_cmd 			:= lgth_cmd(str_line);			-- Get instr_length						
						instr_size_args_v	:= size_args(str_line);			-- Size of arguments
						instr_length		<= lgth_cmd(str_line);			-- Longueur cmd
						arg_length_v 		:= lgth_args(str_line);			-- Longueur Arguments
						nb_args_v		:= count_arg(str_line);			-- Count the number of arguments in the instruction
						pos_args_v		:= args_pos(nb_args_v, instr_size_args_v);	-- Return an array with the position of each arguments			
						instr_tmp_v 		:= str_line(1 to lg_cmd) & add_space(str_line(1 to lg_cmd), max_cmd_size);	-- Generation instruction en
						args_tmp_v 		:= str_line((lg_cmd + 2) to  (arg_length_v)) & add_space(str_line((lg_cmd + 2) to  (arg_length_v )), max_arg_size);
						tab_arguments_v		:= fill_tab_args(args_tmp_v, nb_args_v, instr_size_args_v, pos_args_v);											
						--report "INSTR_tmp_var : " & instr_tmp_v;		-- Display the command
						--report "ARG_tmp : " & args_tmp_v;			-- display arguments
						
						for i in 1 to nb_cmd loop				-- Test des instructions
							if(instr_tmp_v = instr_list(i).alias_cmd) then 	-- => Si on a la commande dans la liste
								start_instr_v := '1';
								--report "Instruction " & integer'IMAGE(i) & " : Match !!!";
							else	
								start_instr_v := '0';
								--report "Instruction " & integer'IMAGE(i) & " : /!\ DON'T Match /!\";							
							end if;
						end loop;
												
					else	-- Line NULL
						instr_tmp(1 to 10) <= "line_empty";													
						start_instr_v := '1';-- , '0' after 1 ps;	
						report "Line Empty";
					end if;					
					cpt_line <= cpt_line + 1;
					
				end if;
				start_instr <= '1'; --start_instr_v;
				instr_tmp 	<= instr_tmp_v;
				args_tmp	<= args_tmp_v;
				nb_args		<= nb_args_v;
				pos_args	<= pos_args_v;
				instr_size_args <= instr_size_args_v;
				tab_arguments_s <= tab_arguments_v;
				done_readline <= '1';
			end if;
		end process;
	-- =================================


	-- == INSTRUCTIONS PROCESS ==	
	empty_line :	process(start_instr)
			begin
				if(rising_edge(start_instr)) then
					if(instr_tmp(1 to 10) = "line_empty") then
						instr_done(0) <= '1', '0' after 1 ns;
					end if;
				end if;
			end process;	
	-- ====================================
		
	-- == SEQUENCER INSTR manage ==	
	-- WAIT_FOR(XX Ys) 
	WAIT_FOR_p :	process
				constant indice_instr 	: integer := 1;		-- Indice instruction modifiable
				variable number_v	: integer;
				variable arg1_size 	: integer;
				variable arg2_size	: integer;
				variable duree		: time;
			begin
				wait until start_instr'event and start_instr = '1';
					if(instr_tmp = seq_instr(indice_instr).alias_seq_instr) then
						arg1_size := instr_size_args(1);
						arg2_size := instr_size_args(2);
						--report "WAIT_FOR executed";
						--report "instr_tmp : " & instr_tmp(10 to 12);
						number_v 	:= str2int(args_tmp(1 to arg1_size));
						duree 		:= str2time(args_tmp((arg1_size + 2) to (arg1_size + 2 + 1)));
						wait for number_v*duree;
						instr_done(1) <= '1', '0' after 1 ns;		-- Instruction Done.
					end if;
					
			end process;
			
	-- RESET_GEN(...)		
	RST_gen_p :	process
				constant indice_instr 	: integer := 2;		-- Indice instruction modifiable
				variable number_v	: integer;
				variable arg1_size 	: integer;
				variable arg2_size	: integer;
				variable arg3_size 	: integer;
				variable arg4_size	: integer;
				variable duree		: time;
				variable i		: integer;
				variable j		: integer;
				variable pos_args_v	: tab_pos_args;
				variable str_tmp_v	: string(1 to max_arg_size);
			begin
				wait until start_instr'event and start_instr = '1';
				if(instr_tmp = seq_instr(indice_instr).alias_seq_instr) then
					report "Dans RESET_GEN !!!!";					
					i := 1;
					str_tmp_v := tab_arguments_s(3);
					while(str_tmp_v(i) /= ' ') loop		-- ' ' = space detect
						i := i + 1;
					end loop;
					i := i - 1;
					j := 1;
					for j in 1 to nb_reset loop
						if(str_tmp_v(1 to i) = RESETS_list(j).alias_STDL) then
							--resets <= (others => '0');
						end if;
					end loop;
					
					
					
					
					-- == RECUP number ==
					i := 1;
					str_tmp_v := tab_arguments_s(1);
					while(str_tmp_v(i) /= ' ') loop		-- ' ' = space detect
						i := i + 1;
					end loop;
					i := i - 1;			-- Pos in the string
					number_v := str2int(str_tmp_v(1 to i));

					-- == RECUP TIME
					str_tmp_v := tab_arguments_s(2);
					i := 1;
					while(str_tmp_v(i) /= ' ') loop
						i := i + 1;
					end loop;
					i := i - 1;
					duree := str2time(str_tmp_v(1 to i));
					resets_s(0) <= '0';
					wait for number_v*duree;			-- WAIT
					resets_s(0) <= '1';
					--resets_s(RESETS_list(j).indice) <= '1';
								--				
					instr_done(4) <= '1', '0' after 1 ns;
				end if;
			end process;
	
	resets <= resets_s;
			
			
	-- End of Test/scenario file
	End_test_p :	process
				constant indice_instr : integer := 3;		-- Indice instruction modifiable
			begin
				wait until start_instr'event and start_instr = '1';
					if(instr_tmp = seq_instr(indice_instr).alias_seq_instr) then				
						instr_done(3) <= '1', '0' after 1 ns;
					end if;
			end process;		

	-- ==============================================================================================
	-- ==============================================================================================	
	
	
	-- =========== CUSTOM INSTRUCTIONS ===============				
	SET_HIGH_LOW_p : 	process
				constant indice_instr 	: integer := 1;		-- Indice instruction modifiable
				variable	i 	: integer;
				variable 	j	: integer range 0 to nb_stdl - 1;
			begin
				wait until start_instr'event and start_instr = '1';
					if(instr_tmp = instr_list(1).alias_cmd) then
						report "Instruction FIND !";	
						for i in 1 to nb_args loop
							report "tab_arg_s(i) : " & tab_arguments_s(i) & ";";
							report "Constants : STDL_list(i).alias_STDL : " & STDL_list(i).alias_STDL & ";";
							for j in 1 to nb_stdl loop
								if(tab_arguments_s(i) = STDL_list(j).alias_STDL) then 	--"STATUS_EN                               ") then
									report "ARGUMENTS PRESENT DANS LA LSITE !!!!!!!";
									report "indice stdl : " & integer'image(STDL_list(j).indice);
									stdl_out(STDL_list(j).indice) <= '1';
								else
									report "argument non présent !!!!!";
								end if;
							end loop;
						end loop;
						instr_done(2) <= '1', '0' after 5 ns;		-- Instruction Done.
					elsif(instr_tmp = instr_list(2).alias_cmd) then								
						report "Instruction FIND !";	
						for i in 1 to nb_args loop
							report "tab_arg_s(i) : " & tab_arguments_s(i) & ";";
							report "Constants : STDL_list(i).alias_STDL : " & STDL_list(i).alias_STDL & ";";
							for j in 1 to nb_stdl loop
								if(tab_arguments_s(i) = STDL_list(j).alias_STDL) then 	--"STATUS_EN                               ") then
									report "ARGUMENTS PRESENT DANS LA LSITE !!!!!!!";
									report "indice stdl : " & integer'image(STDL_list(j).indice);
									stdl_out(STDL_list(j).indice) <= '0';
								else
									report "argument non présent !!!!!";
								end if;
							end loop;
						end loop;
						instr_done(2) <= '1', '0' after 5 ns;		-- Instruction Done.						
					end if;
				
			end process;	
		
		
	
		


	
	pulses_mng_p :	process
				variable i : integer;
				variable j : integer;
			begin
				wait until instr_tmp'event;						-- Si instruction dans la list => On pulse						
				for i in 0 to nb_cmd_pulses - 1 loop
					if(args_tmp(1 to 8) = cmd_pulses_list(i).alias_pulse) then
						cmd_pulses(i) <= '1', '0' after 1 ns;
					end if;
				end loop;
		
			end process;
	-- ====================================
	
	
	-- == INSTRUCTIONS MNG ==
	instr_6_p : 	process
				constant indice_instr : integer := 6;
				variable i : integer;
			begin
				wait until start_instr'event and start_instr = '1';
				if(instr_tmp = instr_list(indice_instr).alias_cmd) then											
												
						instr_done(indice_instr) <= '1', '0' after 1 ns;		-- Instruction Done.
				end if;
			end process;	

end behv;
