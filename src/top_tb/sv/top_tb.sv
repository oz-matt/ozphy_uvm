// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: top_tb.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Thu Feb 18 07:48:09 2021
//=============================================================================
// Description: Testbench
//=============================================================================
`include "pcie_basic_hdl_interconnect_sv_wrapper.sv"
`include "Pcie.uvm.pkg"
module top_tb;

  timeunit      10ps;
  timeprecision 10ps;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  //import verif_pkg::*;
  import dw_vip_pcie_uvm_pkg::*;
  import top_test_pkg::*;
  import top_pkg::top_config;

  top_config top_env_config;

  top_th th();


  initial
  begin
    // You can insert code here by setting tb_prepend_to_initial in file common.tpl

    // Create and populate top-level configuration object
    top_env_config = new("top_env_config");
    if ( !top_env_config.randomize() )
      `uvm_error("top_tb", "Failed to randomize top-level configuration object" )

    top_env_config.upstream_phy_vif           = th.pcie_phy_if1;  
    top_env_config.upstream_mac_vif           = th.pcie_mac_if1;  
    top_env_config.is_active_upstream         = UVM_ACTIVE;        
    top_env_config.checks_enable_upstream     = 1;                 
    top_env_config.coverage_enable_upstream   = 1;                 

    top_env_config.downstream_phy_vif         = th.pcie_phy_if2;
    top_env_config.downstream_mac_vif         = th.pcie_mac_if2;
    top_env_config.is_active_downstream       = UVM_ACTIVE;        
    top_env_config.checks_enable_downstream   = 1;                 
    top_env_config.coverage_enable_downstream = 1;                 


    uvm_config_db #(top_config)::set(null, "uvm_test_top", "config", top_env_config);
    uvm_config_db #(top_config)::set(null, "uvm_test_top.m_env", "config", top_env_config);

    // You can insert code here by setting tb_inc_before_run_test in file common.tpl

    run_test();
  end

endmodule

