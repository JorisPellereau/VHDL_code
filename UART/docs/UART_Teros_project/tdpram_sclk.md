# Entity: tdpram_sclk
## Diagram
![Diagram](tdpram_sclk.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name | Type    | Value | Description |
| ------------ | ------- | ----- | ----------- |
| G_ADDR_WIDTH | integer | 8     |             |
| G_DATA_WIDTH | integer | 8     |             |
### Table 1.2 Ports
| Port name | Direction | Type                                        | Description |
| --------- | --------- | ------------------------------------------- | ----------- |
| clk       | in        | std_logic                                   |             |
| i_me_a    | in        | std_logic                                   |             |
| i_we_a    | in        | std_logic                                   |             |
| i_addr_a  | in        | std_logic_vector(G_ADDR_WIDTH - 1 downto 0) |             |
| i_wdata_a | in        | std_logic_vector(G_DATA_WIDTH - 1 downto 0) |             |
| o_rdata_a | out       | std_logic_vector(G_DATA_WIDTH - 1 downto 0) |             |
| i_me_b    | in        | std_logic                                   |             |
| i_we_b    | in        | std_logic                                   |             |
| i_addr_b  | in        | std_logic_vector(G_ADDR_WIDTH - 1 downto 0) |             |
| i_wdata_b | in        | std_logic_vector(G_DATA_WIDTH - 1 downto 0) |             |
| o_rdata_b | out       | std_logic_vector(G_DATA_WIDTH - 1 downto 0) |             |
## Signals, constants and types
### Types
| Name     | Type | Description |
| -------- | ---- | ----------- |
| t_memory |      |             |
## Processes
- **p_port_a**: ***( clk )***

- **p_port_b**: ***( clk )***

