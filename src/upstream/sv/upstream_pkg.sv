// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: upstream_pkg.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Thu Feb 18 07:48:09 2021
//=============================================================================
// Description: Package for agent upstream
//=============================================================================

package upstream_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import verif_pkg::*;

  `include "upstream_ustream_trans.sv"
  `include "upstream_config.sv"
  `include "upstream_driver.sv"
  `include "upstream_monitor.sv"
  `include "upstream_sequencer.sv"
  `include "upstream_coverage.sv"
  `include "upstream_agent.sv"
  `include "upstream_seq_lib.sv"

endpackage : upstream_pkg
