# Create Groupe for DUT and sub instances
add wave -divider DUT

# Variables
set pattern_dut "/tb_top/i_dut/*";
set inst_top "/tb_top/i_dut/";
set inst_list [find instances -r $pattern_dut]; # Get Instances path
set ilist [list]; # Initialize an empty list to strip off the architecture names

lappend ilist $inst_top
# Remove Arch name of all path
foreach inst $inst_list {
  set ipath [lindex $inst 0]
  if {[string match $pattern_dut $ipath]} {
    lappend ilist $ipath
  }
}

foreach inst $ilist { 
  # Convert path to command
  set inst_split [split $inst /]
  set inst_join_group  [join $inst_split " -group "]
  
  set cmd [concat "add wave" $inst_join_group -group IN -in $inst/*]
  if {[catch {eval $cmd} cmd_error]} {
    puts "No Inputs port in $cmd"
  }

  set cmd [concat "add wave" $inst_join_group -group OUT -out $inst/*]
  if {[catch {eval $cmd} cmd_error]} {
    puts "No Ouputs port in $cmd"
  }
  
  set cmd [concat "add wave" $inst_join_group -group Internal -internal $inst/*]
  if {[catch {eval $cmd} cmd_error]} {
    puts "No internal signals in $cmd"
  }
}

puts "add_dut_waves done !"