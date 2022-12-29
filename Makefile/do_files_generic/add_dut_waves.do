# Create Groupe for DUT and sub instances
#
# Args:
# $1 -> testbench_top inst name (Ex: top_hdl)
# $2 -> DUT Name (Ex: i_dut)
#
# Exemple : do /home/linux-jp/Documents/GitHub/VHDL_code/Makefile/do_files_generic/add_dut_waves.do tb_top i_dut

add wave -divider DUT; # Add Divider

# Variables
#set tb_top_inst /tb_top;
set pattern_dut [concat /$1/$2/*];              # Create PATH
set inst_top [concat /$1/$2/];                  # Create DUT TOP Inst
set inst_list [find instances -r $pattern_dut]; # Get Instances path
set ilist [list];                               # Initialize an empty list to strip off the architecture names

lappend ilist $inst_top;
# Remove Arch name of all path
foreach inst $inst_list {
  set ipath [lindex $inst 0]
  if {[string match $pattern_dut $ipath]} {
    lappend ilist $ipath
  }
}

foreach inst $ilist {
  # Remove /tb_top path
  set inst2 [regsub $1 $inst ""]; # Remove Testbench TOP Inst

  # Convert path to command
  set inst_split [split $inst2 /]

  set inst_join_group  [join $inst_split " -group "]
  
  set cmd [concat "add wave" $inst_join_group -group Inputs -in $inst/*]

  if {[catch {eval $cmd} cmd_error]} {
    puts "No Inputs port in $cmd"
  }

  set cmd [concat "add wave" $inst_join_group -group Outputs -out $inst/*]
  if {[catch {eval $cmd} cmd_error]} {
    puts "No Ouputs port in $cmd"
  }

  set cmd [concat "add wave" $inst_join_group -group InOuts -inout $inst/*]
  if {[catch {eval $cmd} cmd_error]} {
    puts "No Inout port in $cmd"
  }
  
  set cmd [concat "add wave" $inst_join_group -group Internal -internal $inst/*]
  if {[catch {eval $cmd} cmd_error]} {
    puts "No internal signals in $cmd"
  }
}

puts "add_dut_waves done !"
