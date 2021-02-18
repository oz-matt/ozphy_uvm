// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: downstream_pkg.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Thu Feb 18 07:48:09 2021
//=============================================================================
// Description: Package for agent downstream
//=============================================================================

package downstream_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import verif_pkg::*;

  `include "downstream_ustream_trans.sv"
  `include "downstream_config.sv"
  `include "downstream_driver.sv"
  `include "downstream_monitor.sv"
  `include "downstream_sequencer.sv"
  `include "downstream_coverage.sv"
  `include "downstream_agent.sv"
  `include "downstream_seq_lib.sv"

endpackage : downstream_pkg
