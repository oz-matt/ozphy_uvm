// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: upstream_if.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Thu Feb 18 07:48:09 2021
//=============================================================================
// Description: Signal interface for agent upstream
//=============================================================================

`ifndef UPSTREAM_IF_SV
`define UPSTREAM_IF_SV

interface upstream_if(); 

  timeunit      10ps;
  timeprecision 10ps;

  import verif_pkg::*;
  import upstream_pkg::*;

  pcie_basic_if ustream_if();

  // You can insert properties and assertions here

  // You can insert code here by setting if_inc_inside_interface in file upstream.tpl

endinterface : upstream_if

`endif // UPSTREAM_IF_SV

