
`ifndef TOP_TEST_SV
`define TOP_TEST_SV

`include "cust_dw_vip_pcie_tlp_transaction.sv"

class top_test extends uvm_test;
  `uvm_component_utils(top_test)

  top_env m_env;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void final_phase(uvm_phase phase);
  
endclass : top_test


function top_test::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void top_test::build_phase(uvm_phase phase);

  set_type_override_by_type(dw_vip_pcie_tlp_transaction::get_type() , cust_dw_vip_pcie_tlp_transaction::get_type());

  uvm_config_db#(uvm_object_wrapper)::set(this,"m_env.mac_if1_agent.virt_sequencer.tlp_sequencer.configure_phase", "default_sequence", dw_vip_pcie_tlp_training_sequence::get_type());
  uvm_config_db#(uvm_object_wrapper)::set(this,"m_env.sequencer.main_phase", "default_sequence", pcie_random_discrete_virtual_sequence::get_type());
  uvm_config_db#(int unsigned)::set(this,"m_env.sequencer.pcie_random_discrete_virtual_sequence", "sequence_length", 5);
    
  m_env = top_env::type_id::create("m_env", this);

endfunction : build_phase

function void final_phase(uvm_phase phase);
    uvm_report_server svr;
    `uvm_info("final_phase", "Entered ...",UVM_LOW)

    super.final_phase(phase);

    svr = uvm_report_server::get_server();

    if (svr.get_severity_count(UVM_FATAL)||  
        svr.get_severity_count(UVM_ERROR)|| 
        svr.get_severity_count(UVM_WARNING))
      `uvm_info("final_phase", "\nSvtTestEpilog: Failed\n", UVM_LOW)
    else
      `uvm_info("final_phase", "\nSvtTestEpilog: Passed\n", UVM_LOW)

    `uvm_info("final_phase", "Exiting ...",UVM_LOW)
endfunction : final_phase
  

`endif

