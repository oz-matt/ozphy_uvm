// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: downstream_monitor.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Wed Feb 17 10:05:16 2021
//=============================================================================
// Description: Monitor for downstream
//=============================================================================

`ifndef DOWNSTREAM_MONITOR_SV
`define DOWNSTREAM_MONITOR_SV

// You can insert code here by setting monitor_inc_before_class in file downstream.tpl

class downstream_monitor extends uvm_monitor;

  `uvm_component_utils(downstream_monitor)

  virtual downstream_if vif;

  downstream_config     m_config;

  uvm_analysis_port #(ustream_trans) analysis_port;

  extern function new(string name, uvm_component parent);

  // You can insert code here by setting monitor_inc_inside_class in file downstream.tpl

endclass : downstream_monitor 


function downstream_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new


// You can insert code here by setting monitor_inc_after_class in file downstream.tpl

`endif // DOWNSTREAM_MONITOR_SV

