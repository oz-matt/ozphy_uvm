//=======================================================================
// COPYRIGHT (C) 2011, 2012 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

/**
 * Abstract:
 * The file contains the class pcie_random_discrete_virtual_sequence extended 
 * from uvm_sequence. It is a virtual sequence that encapsulate the 
 * default sequence dw_vip_pcie_tlp_random_sequence and tie it to the virtual 
 * sequencer. It also, determines the sequence length of the underlying sequence.
 * It is started in the base test case on the virtual sequencer.
 *
 * Execution phase: main_phase
 * Sequencer: Virtual sequencer in PCIE Env
 */

`ifndef GUARD_PCIE_RANDOM_DISCRETE_VIRTUAL_SEQUENCE_SV
`define GUARD_PCIE_RANDOM_DISCRETE_VIRTUAL_SEQUENCE_SV

class pcie_random_discrete_virtual_sequence extends uvm_sequence;

  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }
  
  /** UVM object utility macro */
  `uvm_object_utils(pcie_random_discrete_virtual_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is pcie_virtual_sequencer */
  `uvm_declare_p_sequencer(pcie_virtual_sequencer)

  /** Class constructor */
  function new (string name = "pcie_random_discrete_virtual_sequence");
    super.new(name);
  endfunction

  /** Raise an objection if this is the parent sequence */
  virtual task pre_body();
    super.pre_body();
    if (starting_phase!=null) begin
      starting_phase.raise_objection(this);
    end
  endtask: pre_body

  virtual task body();
    bit status;
    int local_sequence_length;

    /** Instance of default sequence, to be started on the virtual sequencer. */
    dw_vip_pcie_tlp_random_sequence seq;
    
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    /**
     * Since the contained sequence and this one have the same property name, the
     * inline constraint was not able to resolve to the correct scope.  Therefore the
     * sequence length of the virtual sequencer is assigned to a local property which
     * is used in the constraint.
     */
    local_sequence_length = sequence_length;
   
    `uvm_do_on_with(seq , p_sequencer.phy_seqr.tlp_sequencer, {seq.sequence_length == local_sequence_length;})
    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask  

  /** Drop an objection if this is the parent sequence */
  virtual task post_body();
    super.post_body();
    if (starting_phase!=null) begin
      starting_phase.drop_objection(this);
    end
  endtask: post_body

endclass : pcie_random_discrete_virtual_sequence

`endif // GUARD_PCIE_RANDOM_DISCRETE_VIRTUAL_SEQUENCE_SV

