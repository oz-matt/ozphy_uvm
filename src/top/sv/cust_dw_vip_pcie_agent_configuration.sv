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
 * This file contains the class cust_dw_vip_pcie_agent_configuration is used to
 * encapsulate all the configuration information.  It extends the pcie agent configuration 
 * and creates txrx and monitor configuration; It sets the appropriate fields 
 * like lanes, initial Ltssm state, max_payload size etc.
 * Here the user has customized the configuration parameters as per test case requirement.
 */

`ifndef GUARD_CUST_DW_VIP_PCIE_AGENT_CONFIGURATION_SV
`define GUARD_CUST_DW_VIP_PCIE_AGENT_CONFIGURATION_SV

class cust_dw_vip_pcie_agent_configuration extends dw_vip_pcie_agent_configuration;

  /* Define end address of Memory space emulated by endpoint */  
  `define DW_VIP_PCIE_MEM_END_ADDR             64'hFFFFFFFFFFFFFFFC
  
  /** UVM object utility macro */
  `uvm_object_utils(cust_dw_vip_pcie_agent_configuration)

  /** Class constructor */
  function new (string name = "cust_dw_vip_pcie_agent_configuration");
    super.new(name);

    txrx_cfg = new("txrx_cfg");

    monitor_cfg = new("monitor_cfg");

    txrx_cfg.m_bSupport8Lanes              = 1'b1;
    txrx_cfg.m_bScrambling                 = 1'b0;
    txrx_cfg.m_enInitialLtssmState         = dw_vip_pcie_configuration::DETECT;
    txrx_cfg.m_bLtssmFastTimeouts          = 1'b1;
    txrx_cfg.m_nPipeDetectRcvrTime         = 10;
    txrx_cfg.m_nPhyPipePollingEntryDelay   = 10;
    txrx_cfg.m_bBypassFcInit               = 1'b0;
    txrx_cfg.m_nNumMemCplAddrRanges        = 1;
    txrx_cfg.m_bvMemCplStartAddr[0]        = 0;
    txrx_cfg.m_bvMemCplEndAddr[0]          = `DW_VIP_PCIE_MEM_END_ADDR;
    txrx_cfg.m_nNumIoCplAddrRanges         = 1;
    txrx_cfg.m_nMaxPayloadSize             = 128;

    copy_txrx_cfg_to_mon_cfg();
  
  endfunction

  /** Copy txrx confgiuration to monitor configuration */
  function void copy_txrx_cfg_to_mon_cfg();
    this.monitor_cfg.copy(this.txrx_cfg);
  endfunction

endclass
`endif // GUARD_CUST_DW_VIP_PCIE_AGENT_CONFIGURATION_SV
