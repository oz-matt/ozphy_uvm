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
//
//--------------------------------------------------------------------------

`ifndef CUST_DW_VIP_PCIE_TLP_TRANSACTION_SV
  `define CUST_DW_VIP_PCIE_TLP_TRANSACTION_SV 

/**
 * Abstract:
 * This file defines a class that represents a customized TLP transaction.
 * This class is extended from dw_vip_pcie_tlp_transaction class. The  
 * TLP sequencer uses this class as factory pattern to generate the TLP 
 * transactions. The default transaction instance of TLP sequencer
 * (which is based on dw_vip_pcie_tlp_transaction class) is replaced by
 * transaction instance of this class in env/pcie_base_test.sv file
 *
 * This class adds pre-defined constraints on:
 *  - Transaction weights
 *  - Requester ID
 *  - Target range for memory address space.
 *  . 
 */
    
class cust_dw_vip_pcie_tlp_transaction extends dw_vip_pcie_tlp_transaction;

  /** The following properties define distribution weights used to constraint m_enType */
  /** Distribution weight for 32-bit memory write requests */
  integer cmd_mem_WR32_wt      = 34;
  
  /** 34% of total sequence_items should be 32-bit memory read requests */
  /** Distribution weight for 32-bit memory read requests */
  integer cmd_mem_RD32_wt      = 34;
  
  /** Distribution weight for 64-bit memory write requests */
  integer cmd_mem_WR64_wt      = 16;
  
  /** Distribution weight for 64-bit memory read requests */
  integer cmd_mem_RD64_wt      = 16;

  /** UVM object utility macro */
  `uvm_object_utils(cust_dw_vip_pcie_tlp_transaction)
  
  /** Add a constraint for the sequence_item weights.  */
  constraint cust_distribution_enType
  {
      m_enType dist
      {
          MEM_WR_32           := cmd_mem_WR32_wt,
          MEM_RD_32           := cmd_mem_RD32_wt,
          MEM_WR_64           := cmd_mem_WR64_wt,
          MEM_RD_64           := cmd_mem_RD64_wt
      };
  }

  /** Add constraint on different sequence_item fields */
  constraint  valid_tlp_memory_requests 
  {
    /** Constraint on m_enType to limit TLP sequence_item types to memory requests */
    m_enType inside {  
                       MEM_RD_32,
                       MEM_RD_64,
                       MEM_WR_32,
                       MEM_WR_64
                       };

    /** Requester ID */
    m_bvRequesterId == `DW_VIP_PCIE_PHY_REQ_ID;  // 16'h0100
    

    /**
     For memory sequence_items length is restricted in the range 1 to 64 to keep
     simulation time short.
     */
      m_bvLength inside { [1 : 64] };
   
    /** Target memory address range */   
    if (m_enType == MEM_RD_32 || MEM_WR_32) 
    {
      m_bvAddr inside { [32'h0100_0000 : 32'h01FF_F000] };
    }
    else if (m_enType == MEM_RD_64 || m_enType == MEM_WR_64) 
    {
      m_bvAddr inside { [64'h0100_0000_0000_0000 : 64'h01FF_F000_0000_0000] };
    }
  }

function new(string name = "cust_dw_vip_pcie_tlp_transaction");
    super.new(name);
endfunction

endclass : cust_dw_vip_pcie_tlp_transaction
      
`endif /* CUST_DW_VIP_PCIE_TLP_TRANSACTION_SV */
