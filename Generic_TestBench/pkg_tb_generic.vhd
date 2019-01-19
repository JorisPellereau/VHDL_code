--=======================================
--	
--	filename 	: pkg_tb_generic.vhd
--	Author 		: Joris Pellereau
--	Created		: 03/12/2018
--=======================================

library ieee;
use ieee.std_logic_1164.all;

library tb_generic_lib;
use tb_generic_lib.pkg_constants.all;
use tb_generic_lib.pkg_functions.all;

package pkg_tb_generic is

-- == FILES ==
constant scenario_file 	: string := "../../scenario.txt";			-- Scenario file PATH
--constant file_01 	: string := "in_D.txt";
--constant file_02 	: string := "in_K.txt";
-- ===========

-- == SEQUENCER INSTR ==
constant instr_seq1	: string := "WAIT_FOR";
constant instr_seq2 	: string := "RESET_GEN";
constant instr_seq3 	: string := "END_TEST";
-- =====================


-- == LIST INSTR ==
-- Custom test_bench instructions
constant instr1 	: string := "SET_HIGH";
constant instr2 	: string := "SET_LOW";
constant instr3 	: string := "XXXX";
constant instr4 	: string := "XXXX";
constant instr5 	: string := "XXXX";
constant instr6		: string := "YYYY";
-- ================

-- == STATUS LIST ==
constant status_00	: string := "YYYY";
constant status_01	: string := "YYYY";
-- =================

-- == CMD PULSE ==
constant pulse_00	: string := "XXXX";
constant pulse_01	: string := "XXXX";
constant pulse_02	: string := "XXXX";
constant pulse_03	: string := "XXXX";
-- ===============

-- == RESETS ==
constant RESET00	: string := "RST_N";
constant RESET01	: string := "RST_N1";
constant RESET02	: string := "RST_N2";
constant RESET03	: string := "RST_N3";

-- == OUT STDL ==
-- custom Standard Logic output 
constant STDL_00 	: string := "TOTO";
constant STDL_01 	: string := "STATUS_EN";
constant STDL_02	: string := "CMD_EN";
constant STDL_03	: string := "CMD_AGATE_VX";
-- ==============

-- == SEQUENCER INSTR TAB ==
constant seq_instr : tab_seq_instr := (
	1 => (1 , instr_seq1 & add_space(instr_seq1, max_cmd_size)),
	2 => (2 , instr_seq2 & add_space(instr_seq2, max_cmd_size)),
	3 => (3 , instr_seq3 & add_space(instr_seq3, max_cmd_size))
);


-- == INSTRUCTION TAB ==
constant instr_list : tab_cmd := (
	1 => (1 , instr1 & add_space(instr1, max_cmd_size)),
	2 => (2 , instr2 & add_space(instr2, max_cmd_size)),
	3 => (3 , instr3 & add_space(instr3, max_cmd_size)),
	4 => (4 , instr4 & add_space(instr4, max_cmd_size)),
	5 => (5 , instr5 & add_space(instr5, max_cmd_size)),
	6 => (6 , instr6 & add_space(instr6, max_cmd_size))
);
-- ====================

-- == STATUS LIST TAB ==
constant status_list : tab_status := (
	0 => ("status_00" , status_00 & add_space(status_00, max_alias_def_size)),
	1 => ("status_01" , status_01 & add_space(status_01, max_alias_def_size))
);
-- ====================

-- == CMD PULSES TAB ==
constant cmd_pulses_list : tab_cmd_pulses := (
	0 => (0 , "pulse_00" , pulse_00 & add_space(pulse_00, max_cmd_pulses_size)),
	1 => (1 , "pulse_01" , pulse_01 & add_space(pulse_01, max_cmd_pulses_size)),
	2 => (2 , "pulse_02" , pulse_02 & add_space(pulse_02, max_cmd_pulses_size)),
	3 => (3 , "pulse_03" , pulse_03 & add_space(pulse_03, max_cmd_pulses_size))
);
-- ====================

-- == RESET STDL TAB ==
constant RESETS_list : tab_STDL := (
	1 => (0 , RESET00 & add_space(RESET00 , max_STDL_alias_size)),
	2 => (1 , RESET01 & add_space(RESET01 , max_STDL_alias_size)),
	3 => (2 , RESET02 & add_space(RESET02 , max_STDL_alias_size)),
	4 => (3 , RESET03 & add_space(RESET03 , max_STDL_alias_size))
);

-- == CMD STD_LOGIC ==
constant STDL_list : tab_STDL := (
	1 => (0 , STDL_00 & add_space(STDL_00 , max_STDL_alias_size)),			-- Modif : max_STDL_alias_size => max_arg_size
	2 => (1 , STDL_01 & add_space(STDL_01 , max_STDL_alias_size)),
	3 => (2 , STDL_02 & add_space(STDL_02 , max_STDL_alias_size)),
	4 => (3 , STDL_03 & add_space(STDL_03 , max_STDL_alias_size))
);
-- ===================







end pkg_tb_generic;
