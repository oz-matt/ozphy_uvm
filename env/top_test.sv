
`ifndef TOP_TEST_SV
`define TOP_TEST_SV

`include "top_env.sv"
`include "cust_dw_vip_pcie_tlp_transaction.sv"
`include "simp_virt_seq.sv"

class top_test extends uvm_test;
  `uvm_component_utils(top_test)

  top_env m_env;
  
  UVM_FILE debugf;
  
  uvm_root root;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void start_of_simulation_phase(uvm_phase phase);
  extern function void final_phase(uvm_phase phase);
  
endclass : top_test


function top_test::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void top_test::build_phase(uvm_phase phase);

  //set_type_override_by_type(dw_vip_pcie_tlp_transaction::get_type() , cust_dw_vip_pcie_tlp_transaction::get_type());

  //uvm_config_db#(uvm_object_wrapper)::set(this,"m_env.macphy_if_agent.virt_sequencer.tlp_sequencer.configure_phase", "default_sequence", dw_vip_pcie_tlp_training_sequence::get_type());
  //uvm_config_db#(uvm_object_wrapper)::set(this,"m_env.macphy_if_agent.virt_sequencer.tlp_sequencer.configure_phase", "default_sequence", pcie_null_virtual_sequence::get_type());
  //uvm_config_db#(uvm_object_wrapper)::set(this,"m_env.sequencer.main_phase", "default_sequence", simp_virt_seq::get_type());
  //uvm_config_db#(uvm_object_wrapper)::set(this,"m_env.macphy_if_agent.virt_sequencer.tlp_sequencer.main_phase", "default_sequence", pcie_random_discrete_tlp_sequence::get_type());
  //uvm_config_db#(int unsigned)::set(this,"m_env.sequencer.simp_virt_seq", "sequence_length", 25);
    
  m_env = top_env::type_id::create("m_env", this);
  
endfunction : build_phase

function void top_test::start_of_simulation_phase(uvm_phase phase);
    `uvm_info("start_of_simulation_phase", "Entered ...",UVM_LOW)
    super.start_of_simulation_phase(phase);
      
debugf = $fopen("../logs/debug.log", "w");

root = uvm_root::get();

   root.set_report_default_file_hier(debugf);
   
  root.set_report_verbosity_level_hier(UVM_HIGH);
root.set_report_severity_id_action_hier(UVM_INFO, "wp", UVM_LOG);
root.set_report_severity_action_hier(UVM_WARNING, UVM_DISPLAY | UVM_LOG);
root.set_report_severity_action_hier(UVM_ERROR, UVM_DISPLAY | UVM_COUNT |  UVM_LOG);
root.set_report_severity_action_hier(UVM_FATAL, UVM_DISPLAY| UVM_EXIT | UVM_LOG );

    `uvm_info("start_of_simulation_phase", "Exiting ...",UVM_LOW)

endfunction : start_of_simulation_phase

function void top_test::final_phase(uvm_phase phase);
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
    
    $system("sed -i '/UVM_WARNING/d' ../logs/debug.log");
    $system("sed -i '/UVM_ERROR/d' ../logs/debug.log");
endfunction : final_phase
  

`endif

