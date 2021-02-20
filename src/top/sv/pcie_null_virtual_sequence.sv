//=======================================================================
// 
// COPYRIGHT (C) 2011, 2012 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
// 
// ALL RIGHTS RESERVED
//=======================================================================

/**
 * Abstract:
 * The file contains the class extended from uvm_sequence. It is a no-operation sequence 
 * It has an empty virtual function body overriden as empty function.
*/

`ifndef GUARD_PCIE_NULL_VIRTUAL_SEQUENCE_SV
`define GUARD_PCIE_NULL_VIRTUAL_SEQUENCE_SV

class pcie_null_virtual_sequence extends uvm_sequence;

  /** UVM object utility macro */
  `uvm_object_utils(pcie_null_virtual_sequence)

  /** Class constructor */
  function new (string name = "pcie_null_virtual_sequence");
     super.new(name);
  endfunction : new

  /** Need an empty body function to override the warning from the UVM base class */
  virtual task body();
  endtask : body

endclass : pcie_null_virtual_sequence 

`endif // GUARD_PCIE_NULL_VIRTUAL_SEQUENCE_UVM_SV

