
agent_name = upstream
trans_item = ustream_trans

trans_var  = rand logic[31:0] rand_instruction;
trans_var  = rand logic[31:0] adc_data;

if_port = pcie_basic_if ustream_if();

driver_inc = upstream_driver_inc.sv inline
monitor_inc = upstream_monitor_inc.sv inline


