// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: downstream_if.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Thu Feb 18 07:48:09 2021
//=============================================================================
// Description: Signal interface for agent downstream
//=============================================================================

`ifndef DOWNSTREAM_IF_SV
`define DOWNSTREAM_IF_SV

interface downstream_if(); 

  timeunit      10ps;
  timeprecision 10ps;

  import verif_pkg::*;
  import downstream_pkg::*;

  pcie_basic_if dstream_if();

  // You can insert properties and assertions here

  // You can insert code here by setting if_inc_inside_interface in file downstream.tpl

endinterface : downstream_if

`endif // DOWNSTREAM_IF_SV

