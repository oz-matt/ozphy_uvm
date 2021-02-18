// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: upstream_seq_lib.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Thu Feb 18 07:48:09 2021
//=============================================================================
// Description: Sequence for agent upstream
//=============================================================================

`ifndef UPSTREAM_SEQ_LIB_SV
`define UPSTREAM_SEQ_LIB_SV

class upstream_default_seq extends uvm_sequence #(ustream_trans);

  `uvm_object_utils(upstream_default_seq)

  upstream_config  m_config;

  extern function new(string name = "");
  extern task body();

`ifndef UVM_POST_VERSION_1_1
  // Functions to support UVM 1.2 objection API in UVM 1.1
  extern function uvm_phase get_starting_phase();
  extern function void set_starting_phase(uvm_phase phase);
`endif

endclass : upstream_default_seq


function upstream_default_seq::new(string name = "");
  super.new(name);
endfunction : new


task upstream_default_seq::body();
  `uvm_info(get_type_name(), "Default sequence starting", UVM_HIGH)

  req = ustream_trans::type_id::create("req");
  start_item(req); 
  if ( !req.randomize() )
    `uvm_error(get_type_name(), "Failed to randomize transaction")
  finish_item(req); 

  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body


`ifndef UVM_POST_VERSION_1_1
function uvm_phase upstream_default_seq::get_starting_phase();
  return starting_phase;
endfunction: get_starting_phase


function void upstream_default_seq::set_starting_phase(uvm_phase phase);
  starting_phase = phase;
endfunction: set_starting_phase
`endif


// You can insert code here by setting agent_seq_inc in file upstream.tpl

`endif // UPSTREAM_SEQ_LIB_SV

