// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: upstream_driver.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Thu Feb 18 07:48:09 2021
//=============================================================================
// Description: Driver for upstream
//=============================================================================

`ifndef UPSTREAM_DRIVER_SV
`define UPSTREAM_DRIVER_SV

// You can insert code here by setting driver_inc_before_class in file upstream.tpl

class upstream_driver extends uvm_driver #(ustream_trans);

  `uvm_component_utils(upstream_driver)

  virtual upstream_if vif;

  upstream_config     m_config;

  extern function new(string name, uvm_component parent);

  // Methods run_phase and do_drive generated by setting driver_inc in file upstream.tpl
  extern task run_phase(uvm_phase phase);
  extern task do_drive();

  // You can insert code here by setting driver_inc_inside_class in file upstream.tpl

endclass : upstream_driver 


function upstream_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


task upstream_driver::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  forever
  begin
    seq_item_port.get_next_item(req);
      `uvm_info(get_type_name(), {"req item\n",req.sprint}, UVM_HIGH)
    do_drive();
    seq_item_port.item_done();
    # 10ns;
  end
endtask : run_phase


// Start of inlined include file generated_tb/tb/include/upstream_driver_inc.sv
task upstream_driver::do_drive();
  vif.ustream_if.lane0_txdata <= req.rand_instruction;
  vif.ustream_if.txdetectrx <= 1;
  #1;
endtask

// End of inlined include file

// You can insert code here by setting driver_inc_after_class in file upstream.tpl

`endif // UPSTREAM_DRIVER_SV

