// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: upstream_config.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Thu Feb 18 07:48:09 2021
//=============================================================================
// Description: Configuration for agent upstream
//=============================================================================

`ifndef UPSTREAM_CONFIG_SV
`define UPSTREAM_CONFIG_SV

// You can insert code here by setting agent_config_inc_before_class in file upstream.tpl

class upstream_config extends uvm_object;

  // Do not register config class with the factory

  virtual upstream_if      vif;
                  
  uvm_active_passive_enum  is_active = UVM_ACTIVE;
  bit                      coverage_enable;       
  bit                      checks_enable;         

  // You can insert variables here by setting config_var in file upstream.tpl

  // You can remove new by setting agent_config_generate_methods_inside_class = no in file upstream.tpl

  extern function new(string name = "");

  // You can insert code here by setting agent_config_inc_inside_class in file upstream.tpl

endclass : upstream_config 


// You can remove new by setting agent_config_generate_methods_after_class = no in file upstream.tpl

function upstream_config::new(string name = "");
  super.new(name);
endfunction : new


// You can insert code here by setting agent_config_inc_after_class in file upstream.tpl

`endif // UPSTREAM_CONFIG_SV

