--=======================================
--	Elsys Design
--	filename 	: pkg_functions.vhd
--	Author 		: Joris Pellereau
--	Created		: 03/12/2018
--=======================================


library ieee;
use ieee.std_logic_1164.all;

library tb_generic_lib;
use tb_generic_lib.pkg_constants.all;


package pkg_functions is

-- Fonctions
function count_arg(str : string)
return integer;

function lgth_cmd(str : string)
return integer;

function lgth_args(str : string)
return integer;

function size_args(str : string)
return tab_size_args;

function add_space(str : string; max_size : integer)
return string;

function str2time(str : string(1 to 2))
return time;

function str2int(str : string)
return integer;

function args_pos(nb_args : integer; args_size : tab_size_args)
return tab_pos_args;

function fill_tab_args(str : string; nb_args : integer; args_size : tab_size_args; args_pos : tab_pos_args)
return tab_arguments;

end pkg_functions;

package body pkg_functions is

	-- EXEMPLE : WFAD(222 us) => 2 arguments
	function count_arg(str : string) return integer IS		
		variable nb_arg		: integer := 0;
		variable i		: integer;
	begin	
		for i in 1 to str'length loop
			if(str(i) = ' ') then			-- Lecture espace
				nb_arg := nb_arg + 1;
			end if;
		end loop;		
		return nb_arg + 1;				-- NO space = 1 arg			
	end count_arg;	
	-- ========================================================		
			
	-- EXAMPLE : RDFILE(XXX YYY ZZ) => 6
	function lgth_cmd(str : string) return integer is
		variable i	: integer range 1 to str'length := 1;
	begin	
		while(str(i) /= '(') loop
			i := i + 1;
		end loop;
		return i - 1;					-- '(' pris en compte => i - 1
	end lgth_cmd;
	-- ========================================================
	
	
	-- EXAMPLE : TOTO(123 456) => retourne 7
	function lgth_args(str : string) return integer is
		variable i		: integer range 1 to str'length := 1;
		variable arg_size 	: integer := 0;		
	begin
		while (str(i) /= ')') loop			-- Detect la fin des arguments TOTO(XX XXXXX)			
			i := i + 1;
		end loop;
		arg_size := i - 1;				-- -1 => debut '('
		return arg_size;
	end lgth_args;
	-- ========================================================
	
	
	
	
	-- EXAMPLE : RDFL(TOTO 123 us) => (4, 3, 2)
	function size_args(str : string) return tab_size_args is
		variable argument_sizes : tab_size_args := (others => 0);		-- Init array
		variable nb_args 	: integer := count_arg(str);
		variable i 		: integer := lgth_cmd(str) + 1;			-- String indice, start a '(' position
		variable i_arg		: integer range 1 to nb_args := 1;
		variable cpt_str	: integer := 0;
	begin
		
		for i in (lgth_cmd(str) + 2) to str'length loop		
			if(str(i) /= ' ' and str(i) /= ')') then
				cpt_str := cpt_str + 1;				
			elsif(str(i) = ' ') then
				argument_sizes(i_arg) := cpt_str;
				i_arg := i_arg + 1;
				cpt_str := 0;
			elsif(str(i) = ')') then
				argument_sizes(i_arg) := cpt_str;
				exit;
			end if;						
		end loop;
		
		return argument_sizes;
	end size_args;	
	-- ========================================================
	
	-- EXAMPLE : str : "RDFL", max_size = 20 => (20 - RDFL'length) => string with 18 spaces
	function add_space(str : string; max_size : integer) return string is
		variable space_str	: string(1 to max_size - str'length);
		variable i		: integer;		
	begin
			--space_str(1) := ' ';
			for i in (1) to (max_size - str'length) loop
				space_str(i) := ' '; --:= space_str & ' ';
			end loop;
			report "nb_space : " & integer'IMAGE(space_str'length);
		return space_str;
	end add_space;
	-- ========================================================
	
	-- EXAMPLE : "us" => 1 us
	function str2time(str : string(1 to 2)) return time is
		variable time_unit	: time;
	begin
		case str is
	                  when "ps"   => time_unit := 1 ps;
	                  when "ns"   => time_unit := 1 ns;
	                  when "us"   => time_unit := 1 us;
	                  when "ms"   => time_unit := 1 ms;
	                  when others => NULL;
	        end case;
	       return time_unit;
	end str2time;
	-- ========================================================
	
	
	-- EXAMPLE : "556" => 556
	function str2int(str : string) return integer is	-- 4 DIGIT max
		variable value	: integer := 0;
		variable i	: integer := 0;
		variable init	: integer := 0;
	begin
		-- INIT
		if(str'length = 4) then
			init := 1000;
		elsif(str'length = 3) then
			init := 100;
		elsif(str'length = 2) then
			init := 10;
		elsif(str'length = 1) then
			init := 1;
		end if;
		
		for i in 1 to str'length loop
			case str(i) is
			      when '0'    => value := 0*init + value;
			      when '1'    => value := 1*init + value;
			      when '2'    => value := 2*init + value;
			      when '3'    => value := 3*init + value;
			      when '4'    => value := 4*init + value;
			      when '5'    => value := 5*init + value;
			      when '6'    => value := 6*init + value;
			      when '7'    => value := 7*init + value;
			      when '8'    => value := 8*init + value;
			      when '9'    => value := 9*init + value;
			      when others => value := 0;
			     end case;
			     init := init / 10;
		end loop;
		return value;
	end str2int;
	-- ============================================
	
	-- EXAMPLE (3, 2 , 4 , 1, 0...0) => (1, 5, 8, 13, 0...0)
	-- pos_args(1) := 1
	-- pos_args(2) := size_args(1) + 2
	-- ...
	-- pos_args(4) := size_args(1) + size_args(2) + size_args(3) + 4
	function args_pos(nb_args : integer; args_size : tab_size_args) return tab_pos_args is
		variable pos_args 	: tab_pos_args := (others => 0);
		variable i		: integer := 0;
		variable sum_pos 	: integer := 0;		-- sum of the position
	begin
		pos_args(1) := 1;				-- Position of the 1st arg
		sum_pos := args_size(1);
		for i in 2 to nb_args  loop
			pos_args(i) := i + sum_pos;
			sum_pos := sum_pos + args_size(i);
		end loop;
		return pos_args;
	end args_pos;
	


	function fill_tab_args(str : string; nb_args : integer; args_size : tab_size_args; args_pos : tab_pos_args) return tab_arguments is
			variable tab_arguments_v	: tab_arguments;				-- Array of arguments standardized
			variable i			: integer := 1;					-- counter of args
			variable str_v			: string(1 to max_arg_size) := (others => ' ');	-- temporary string to be copied in the tab_arguments_v(i)
			variable pos			: integer := 1;					-- position in the str
			variable j			: integer := 1;					-- size_args counter
	begin
		pos	:= 1;
		j 	:= 1;
		for i in 1 to nb_args loop
			while str(pos) /= ' ' loop
				if(j <= args_size(i)) then
					str_v(j) := str(pos);
					j := j + 1;
				end if;
				pos := pos + 1;
			end loop;
			j := 1;			-- RAZ counter
			pos := pos + 1;		-- Next args
			tab_arguments_v(i) := str_v;
			str_v(1 to max_arg_size) := (others => ' ');
			report "pos : " & integer'image(pos);
		end loop;

		return tab_arguments_v;
	end fill_tab_args;

end package body;
