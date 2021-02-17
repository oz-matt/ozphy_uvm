// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: downstream_driver.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Wed Feb 17 10:05:16 2021
//=============================================================================
// Description: Driver for downstream
//=============================================================================

`ifndef DOWNSTREAM_DRIVER_SV
`define DOWNSTREAM_DRIVER_SV

// You can insert code here by setting driver_inc_before_class in file downstream.tpl

class downstream_driver extends uvm_driver #(ustream_trans);

  `uvm_component_utils(downstream_driver)

  virtual downstream_if vif;

  downstream_config     m_config;

  extern function new(string name, uvm_component parent);

  // You can insert code here by setting driver_inc_inside_class in file downstream.tpl

endclass : downstream_driver 


function downstream_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


// You can insert code here by setting driver_inc_after_class in file downstream.tpl

`endif // DOWNSTREAM_DRIVER_SV

