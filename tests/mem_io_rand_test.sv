//=======================================================================

`ifndef MEM_IO_RAND_TEST_SV
`define MEM_IO_RAND_TEST_SV

`include "mem_io_rand_seq_item.sv"
`include "simp_virt_seq.sv"
`include "constrained_training.sv"

class mem_io_rand_test extends top_test;
  `uvm_component_utils(mem_io_rand_test)


function new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void build_phase(uvm_phase phase);
  super.build_phase(phase);

  set_type_override_by_type(dw_vip_pcie_tlp_transaction::get_type(), mem_io_rand_seq_item::get_type());

  uvm_config_db#(uvm_object_wrapper)::set(this,"m_env.macphy_if_agent.virt_sequencer.tlp_sequencer.configure_phase", "default_sequence", constrained_training_sequence::get_type());
  uvm_config_db#(uvm_object_wrapper)::set(this,"m_env.sequencer.main_phase", "default_sequence", simp_virt_seq::get_type());

  uvm_config_db#(int unsigned)::set(this,"m_env.sequencer.simp_virt_seq", "sequence_length", `SEQLEN);
  
endfunction : build_phase

endclass : mem_io_rand_test

`endif

