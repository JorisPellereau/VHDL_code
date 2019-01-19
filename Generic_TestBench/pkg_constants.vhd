--=======================================
--	
--	filename 	: pkg_constants.vhd
--	Author 		: Joris Pellereau
--	Created		: 03/12/2018
--=======================================

library ieee;
use ieee.std_logic_1164.all;

package pkg_constants is


-- == CONSTANTS ==
constant nb_file 		: integer := 2;
constant nb_status		: integer := 2;					-- Number of Status to the sequencer
constant nb_seq_instr		: integer := 3;					-- Number of Sequencer Instructions
constant nb_cmd			: integer := 6;					-- Number of command in the scenario file
constant nb_cmd_pulses		: integer := 4;					-- number of pulse_cmd outside the sequencer
constant nb_reset		: integer := 4;					-- number of resets
constant nb_stdl		: integer := 4;					-- Number of std_logic output (RST etc ..)

constant max_args		: integer := 10;				-- Number of arguments in command (Maximum)
constant max_cmd_size		: integer := 20;				-- Command string size
constant max_arg_size		: integer := 40;				-- String size between  (... ...) of the command
constant max_alias_cmd_size 	: integer := 9; 				-- Alias_cmd size
constant max_alias_def_size	: integer := 200;				-- Max string size for the description
constant max_cmd_pulses_size	: integer := 30;				-- Max size 
constant max_STDL_alias_size	: integer := 40;				-- Max alias Size for the STD_LOGIC (RESET ETC ...)
-- ===============


--  == NEW TYPES ==
type struct_seq_instr is record
	indice		: integer range 1 to nb_seq_instr;
	alias_seq_instr	: string(1 to max_cmd_size);
end record;

type struct_cmd is record
	indice		: integer range 1 to nb_cmd;				-- Indice command	
	alias_cmd	: string(1 to max_cmd_size);				-- Alias command
end record;

type struct_status is record
	alias_status		: string(1 to max_alias_cmd_size);		-- status_00 => status_99
	alias_definition 	: string(1 to max_alias_def_size); 
end record;

type struct_cmd_pulse is record
	indice		: integer range 0 to nb_cmd_pulses - 1;			-- cmd_pulses(0) cmd_pulses(1)...
	alias_pulse	: string(1 to 8);					-- pulse_00 => pulse_99
	alias_cmd_pulse	: string(1 to max_cmd_pulses_size);
end record; 

type struct_STDL is record
	indice		: integer range 0 to nb_stdl - 1;
	alias_STDL	: string(1 to max_STDL_alias_size);
end record;

type tab_seq_instr is array (1 to nb_seq_instr) of struct_seq_instr;

type tab_cmd is array (1 to nb_cmd) of struct_cmd;				-- ARRAY of Record

type fsm_state is (IDLE, INIT, S1, S2, S3, S4, S5);				-- States of Sequencer

type tab_status is array(0 to nb_status - 1) of struct_status;

type tab_cmd_pulses is array (0 to nb_cmd_pulses - 1) of struct_cmd_pulse;

type tab_STDL is array (1 to nb_stdl) of struct_STDL;				-- Array of strut STDL !! modif

type tab_size_args is array(1 to max_args) of integer;				-- Array of the size of each arguments

type tab_pos_args  is array(1 to max_args) of integer;				-- Array with the position in the strings of each arguments

type tab_arguments is array(1 to max_args) of string(1 to max_arg_size);


end pkg_constants;
