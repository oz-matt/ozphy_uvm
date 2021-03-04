//=======================================================================

`ifndef RANDOM_BASIC_TEST_SV
`define RANDOM_BASIC_TEST_SV

`include "cust_dw_vip_pcie_tlp_transaction.sv"
`include "simp_virt_seq.sv"

class random_basic_test extends top_test;
  `uvm_component_utils(random_basic_test)


function new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void build_phase(uvm_phase phase);
  super.build_phase(phase);

  set_type_override_by_type(dw_vip_pcie_tlp_transaction::get_type() , cust_dw_vip_pcie_tlp_transaction::get_type());

  uvm_config_db#(uvm_object_wrapper)::set(this,"m_env.macphy_if_agent.virt_sequencer.tlp_sequencer.configure_phase", "default_sequence", dw_vip_pcie_tlp_training_sequence::get_type());
  uvm_config_db#(uvm_object_wrapper)::set(this,"m_env.sequencer.main_phase", "default_sequence", simp_virt_seq::get_type());
  uvm_config_db#(int unsigned)::set(this,"m_env.sequencer.simp_virt_seq", "sequence_length", 25);
  
endfunction : build_phase

endclass : random_basic_test

`endif

