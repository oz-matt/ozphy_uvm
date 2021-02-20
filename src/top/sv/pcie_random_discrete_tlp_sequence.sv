//--------------------------------------------------------------------------
// COPYRIGHT (C) 2010, 2011, 2012 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

/**
 * Abstract:
 * This file defines a class that the testbench uses to provides initiator
 * scenario information to the Pcie Phy agent present in the pcie_basic_env. 
 * This class defines a sequence in which it generates the request object randomly
 * and sends it using `uvm_do() UVM macro to the sequencer.
 */

`ifndef GUARD_PCIE_RANDOM_DISCRETE_TLP_SEQUENCE_SV
`define GUARD_PCIE_RANDOM_DISCRETE_TLP_SEQUENCE_SV


class pcie_random_discrete_tlp_sequence extends uvm_sequence #(dw_vip_pcie_tlp_transaction);

  /** UVM object utility macro */
  `uvm_object_utils(pcie_random_discrete_tlp_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is dw_vip_pcie_tlp_sequencer */
  `uvm_declare_p_sequencer(dw_vip_pcie_tlp_sequencer)
      
   /** Parameter that controls the number of Tlp transactions that would be generated */
    rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }
  /** Class constructor */
  function new (string name = "pcie_random_discrete_tlp_sequence");
     super.new(name);
  endfunction : new

  /** Raise an objection if this is the parent sequence */
  virtual task pre_body();
    super.pre_body();
    if (starting_phase!=null) begin
      starting_phase.raise_objection(this);
    end
  endtask: pre_body

  virtual task body();
    bit status;
    `uvm_info("body", "Entered ...",UVM_NONE);
    
    
    status = uvm_config_db#(int unsigned)::get(null,get_full_name(),"sequence_length",sequence_length);
    
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);
    repeat(sequence_length) begin 
      /** generate TLP Transaction **/
      `uvm_do(req)

      /** wait for response from driver */
      /* get_response(rsp);*/
    end
    `uvm_info("body", "Exiting ...",UVM_LOW);
  endtask : body

  /** Drop an objection if this is the parent sequence */
  virtual task post_body();
    super.post_body();
    if (starting_phase!=null) begin
      starting_phase.drop_objection(this);
    end
  endtask: post_body

endclass : pcie_random_discrete_tlp_sequence

`endif // GUARD_PCIE_RANDOM_DISCRETE_TLP_SEQUENCE_SV
