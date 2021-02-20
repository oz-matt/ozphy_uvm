// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: downstream_config.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Thu Feb 18 07:48:09 2021
//=============================================================================
// Description: Configuration for agent downstream
//=============================================================================

`ifndef DOWNSTREAM_CONFIG_SV
`define DOWNSTREAM_CONFIG_SV

// You can insert code here by setting agent_config_inc_before_class in file downstream.tpl

class downstream_config extends uvm_object;

  // Do not register config class with the factory

  virtual downstream_mac_if      mac_vif;
  virtual downstream_phy_if      phy_vif;
                  
  uvm_active_passive_enum  is_active = UVM_ACTIVE;
  bit                      coverage_enable;       
  bit                      checks_enable;         

  // You can insert variables here by setting config_var in file downstream.tpl

  // You can remove new by setting agent_config_generate_methods_inside_class = no in file downstream.tpl

  extern function new(string name = "");

  // You can insert code here by setting agent_config_inc_inside_class in file downstream.tpl

endclass : downstream_config 


// You can remove new by setting agent_config_generate_methods_after_class = no in file downstream.tpl

function downstream_config::new(string name = "");
  super.new(name);
endfunction : new


// You can insert code here by setting agent_config_inc_after_class in file downstream.tpl

`endif // DOWNSTREAM_CONFIG_SV

