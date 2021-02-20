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

`ifndef GUARD_PCIE_VIRTUAL_SEQUENCER_SV
`define GUARD_PCIE_VIRTUAL_SEQUENCER_SV

/**
 * This class is Virtual Sequencer class, which basically encapsulates the 
 * PHY and MAC sequencers and allows a fine grain control over the user's
 * stimulus application to the selective sequencer.
 */
class pcie_virtual_sequencer extends uvm_sequencer;

  /** Instance of phy sequencer */
  dw_vip_pcie_virtual_sequencer phy_seqr;

  /** Instance of mac sequencer */
  dw_vip_pcie_virtual_sequencer mac_seqr;
  
  /** Class constructor */
  function new (string name = "pcie_virtual_sequencer", uvm_component parent = null);
    super.new(name,parent);
  endfunction

  /** UVM component utility macro */
  `uvm_component_utils(pcie_virtual_sequencer)

endclass
`endif // GUARD_PCIE_VIRTUAL_SEQUENCER_SV
