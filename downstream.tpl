
agent_name = downstream
trans_item = ustream_trans

trans_var  = rand logic[31:0] rand_instruction;
trans_var  = rand logic[31:0] adc_data;

if_port = pcie_basic_if dstream_if();


