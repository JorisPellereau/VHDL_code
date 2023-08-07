project_new synth_blocks -overwrite
#create_revision TOTO

# Set Pin Standard
#set_io_assignment 30 -name dout -io_standard LVTTL
#set_io_assignment 30 -name OUTPUT_PIN_LOAD -io_standard LVCMOS
#set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to dout

#set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to dout
# Set Pin Location
set_location_assignment PIN_AB28 -to rst_n
set_location_assignment PIN_AC28 -to din
set_location_assignment PIN_Y2 -to clk
set_location_assignment PIN_G19 -to dout

set_location_assignment PIN_AC27 -to in_a
set_location_assignment PIN_AD27 -to in_b
set_location_assignment PIN_F19 -to out_c

set_location_assignment PIN_E19 -to out_d

# PULL UP DOWN
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to din
#set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to clk

set_instance_assignment -name IO_STANDARD "2.5-V" -to dout
# STRENGTH
# XXMA ou MIN or MAX
#set_instance_assignment -name CURRENT_STRENGTH_NEW MIN -to dout

# SLEW RATE
# set programmable slew rate to q1
#set_instance_assignment -name SLEW_RATE 1 -to dout


# Set FAST_INPUT_REGSITER to input d1
#set_instance_assignment -name FAST_INPUT_REGISTER ON -to d1

# Set FAST_OUTPUT_REGSITER to output q1
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to dout

export_assignments
project_close
