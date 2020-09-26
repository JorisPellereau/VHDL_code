# VHDL codes
Several VHDL files


## MAX7219
Libraries fo the control of the MAX7219 component
### lib_max7219_static
* **pkg_max7219_static.vhd** : Package with components of lib_max7219_static
* **max7219_ram_decod.vhd** : RAM command decoder
* **max7219_cmd_decod.vhd** : Top block


### lib_max7219_scroller
* **pkg_max7219_scroller.vhd** : Package with components of lib_max7219_scroller
* **max7219_scroller_if.vhd** : Scroller interface with MAX7219_IF block
* **max7219_ram2scroller.vhd** : Interface between MAX7219_SCROLLER_if and TDPRAM
* **max7219_ctrl.vhd** : Scroller Controller Top block


> MAX7219_SCROLLER_CTRL Block diagram :![MAX7219_CTRL block](/MAX7219/docs/images/pkg_max7219_scroller-max7219_scroller_ctrl.png)




### Others files
* **max7219_if.vhd** : physical interface with the MAX7219
* **max7219_ram_decod.vhd** : read data from a TDPRAM single clock and command the max7219_if block
