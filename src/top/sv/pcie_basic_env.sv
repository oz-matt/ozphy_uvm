//=======================================================================
//
//  COPYRIGHT (C) 2010, 2011, 2012 SYNOPSYS INC.
//  This software and the associated documentation are confidential and
//  proprietary to Synopsys, Inc. Your use or disclosure of this software
//  is subject to the terms and conditions of a written license agreement
//  between you, or your company, and Synopsys, Inc. In the event of
//  publications, the following notice is applicable:
// 
//  ALL RIGHTS RESERVED
// 
//  The entire notice above must be reproduced on all authorized copies.
// 
//-----------------------------------------------------------------------

`ifndef GUARD_PCIE_BASIC_ENV_SV
 `define GUARD_PCIE_BASIC_ENV_SV

/**
 Notes:
   MAC/mac- Device Under Test: The MAC is configured to have a MAC 
            interface that will connect directly to the PHY.
   PHY/phy- Test Bench Device: PHY is PCI Express VIP configured to 
            act as the PHY.

  
 Abstract:
 
 This file defines a basic test bench environment class pcie_basic_env, 
 which is derived from uvm_env. It implements the following virtual methods:
 new, build, connect and run phase

 This class contains an instance of 2 agents:
 vip_mac_agent - Configured as MAC, encapsulates MAC txrx and monitor
 vip_phy_agent - Configured as PHY, encapsulates PHY txrx
 Agent has a configuration handle of type dw_vip_pcie_agent_configuration. 
 The testcase needs to set the same for the agent
 
 Env also contains an virtual sequencer instance called sequencer, it is connected to
 agent level virtual sequencer called virt_sequencer, which encapsulates the tlp/dllp/os_sequencer. 
 Access to lower level seqr is thru virt_sequencer.[eg  virt_sequencer.tlp_sequencer]
 
 The simulation completes when all the sequences that are executing drop the phase 
 objection and all the UVM phases are executed. 
*/

/* Define requester and completer ID of the component behind PHY */   
`define DW_VIP_PCIE_PHY_REQ_ID               16'h0100
`define DW_VIP_PCIE_PHY_CPL_ID               16'h0100
  
/* Define requester and completer ID for the component with MAC interface */  
`define DW_VIP_PCIE_MAC_REQ_ID               16'h0210
`define DW_VIP_PCIE_MAC_CPL_ID               16'h0210
  
`include "pcie_virtual_sequencer.sv"
`include "cust_dw_vip_pcie_agent_configuration.sv"

/**
 Verification Environment
 */
class pcie_basic_env extends uvm_env ;

  /* Declare configuration objects for phy. */
  cust_dw_vip_pcie_agent_configuration  phy_agent_cfg;
  
  /* Declare configuration objects for mac. */
  cust_dw_vip_pcie_agent_configuration  mac_agent_cfg;
  
  /** Declare UVM VIP agent to abstract PHY txrx */
  dw_vip_pcie_agent                                  vip_phy_agent;
 
  /**
   Declare UVM VIP agent to abstract MAC txrx and monitor.
   Monitor watches the link between the PHY and MAC .
   */
  dw_vip_pcie_agent                                  vip_mac_agent;
  
  /** Declare the handle of the Virtual Sequencer */
  pcie_virtual_sequencer                sequencer;
  
  /** UVM object utility macro */
  `uvm_component_utils(pcie_basic_env)
  
  /* Creates an instance of the verification environment, with the specified name. */
  function new(string name = "pcie_basic_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction : new 

  /* Builds the verification environment. */
  virtual function void build_phase(uvm_phase phase);
  begin
    `uvm_info("build_phase", "Entered ...", UVM_LOW)
    super.build_phase(phase);
    
    if (!uvm_config_db#(cust_dw_vip_pcie_agent_configuration)::get(this,"","phy_agent_cfg",phy_agent_cfg)) begin
      `uvm_info("build_phase","Creating default configuration for phy agent",UVM_LOW)
      phy_agent_cfg = cust_dw_vip_pcie_agent_configuration::type_id::create("phy_agent_cfg");
    end  
    
    if (!uvm_config_db#(cust_dw_vip_pcie_agent_configuration)::get(this,"","mac_agent_cfg",mac_agent_cfg)) begin
      `uvm_info("build_phase","Creating default configuration for mac agent",UVM_LOW)
      mac_agent_cfg = cust_dw_vip_pcie_agent_configuration::type_id::create("mac_agent_cfg");
    end
    
    this.phy_agent_cfg.txrx_cfg.m_enPosition                       = dw_vip_pcie_configuration::UPSTREAM;
    this.phy_agent_cfg.txrx_cfg.m_bvReqId                          = `DW_VIP_PCIE_PHY_REQ_ID;
    this.phy_agent_cfg.txrx_cfg.m_bvCplId                          = `DW_VIP_PCIE_PHY_CPL_ID;
    
    this.mac_agent_cfg.txrx_cfg.m_enPosition                       = dw_vip_pcie_configuration::DOWNSTREAM;
    this.mac_agent_cfg.txrx_cfg.m_bvReqId                          = `DW_VIP_PCIE_MAC_REQ_ID;
    this.mac_agent_cfg.txrx_cfg.m_bvCplId                          = `DW_VIP_PCIE_MAC_CPL_ID;
   
    mac_agent_cfg.copy_txrx_cfg_to_mon_cfg();
    
    /** set config object for mac-txrx and mac-monitor abstracted under pcie agent (vip_mac_agent) */
    uvm_config_db#(dw_vip_pcie_agent_configuration)::set(this,"vip_mac_agent", "cfg",mac_agent_cfg);

    /** set config object for phy-txrx under pcie agent (vip_phy_agent) */
    uvm_config_db#(dw_vip_pcie_agent_configuration)::set(this,"vip_phy_agent", "cfg",phy_agent_cfg);
    
    /* disable the PHY monitor */
    uvm_config_db#(int)::set(this,"vip_phy_agent", "enable_monitor",0);

    /** Create the vip_phy_agent. This would also create txrx underneath */
    vip_phy_agent = dw_vip_pcie_agent::type_id::create("vip_phy_agent", this); 
    
    /**
     Select the tlp_sequencer inside the vip_phy_agent to be created and
     connected to the txrx inside the agent for this simulation.
     */
    uvm_config_db#(bit)::set(this,"vip_phy_agent", "tlp_sequencer",1'b1);
      
    /** Create the vip_mac_agent. This would also create txrx and monitor underneath */
    vip_mac_agent  = dw_vip_pcie_agent::type_id::create("vip_mac_agent", this);
    
    /** Construct the virtual sequencer */
    sequencer  = pcie_virtual_sequencer::type_id::create("sequencer", this);
    
    `uvm_info("build_phase",  "Exiting ...", UVM_LOW)
  end
  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("connect_phase", "Entered ...",UVM_LOW)
    super.connect_phase(phase);
      
    /** Connect the agent's sequencer handle to the virtual sequencer's handle */
    sequencer.phy_seqr = vip_phy_agent.virt_sequencer;
    `uvm_info("connect_phase", "Exiting ...",UVM_LOW)
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    `uvm_info("run_phase", "Entered ...",UVM_LOW)
    /* Enable generation of symbol log and transaction log by Monitor VIP */   
     begin
     
       if (((phy_agent_cfg.enable_monitor && vip_phy_agent.is_active == UVM_ACTIVE) || 
         (vip_phy_agent.is_active == UVM_PASSIVE)) && (vip_phy_agent.monitor != null)) begin
         /**
          Opens a symbol log file. The PCI Express Monitor VIP outputs PCI Express symbol
          data from each lane to this file. 
          Argument descriptions:
            "./pcie_basic_sys_symbol.log"      -> Name of the symbol log file.
            "w"                                -> Access Mode of the symbol log file (Truncate
                                                  or Create for writing), other mode possible is 
                                                  "a" (Append or Create for writing).
          */
         vip_phy_agent.monitor.open_symbol_log("./pcie_basic_sys_symbol.log", "w");
       
         /**
          Opens a transaction log file. The PCI Express Monitor VIP outputs PCI Express 
          transaction data to this file.
            "./pcie_basic_sys_transaction.log" -> Name of the symbol log file.
            "w"                                -> Access Mode of the symbol log file (Truncate
                                                  or Create for writing), other mode possible is 
                                                  "a" (Append or Create for writing).
        
          For complete description of Monitor VIP logging facilities refer "DesignWare PCI 
          Express Verification IP System Verilog User Manual."
          */
         vip_phy_agent.monitor.open_transaction_log("./pcie_basic_sys_transaction.log", "w");
       end

       if (((mac_agent_cfg.enable_monitor && vip_mac_agent.is_active == UVM_ACTIVE) || 
         (vip_mac_agent.is_active == UVM_PASSIVE)) && (vip_mac_agent.monitor != null)) begin
         /**
          Opens a symbol log file. The PCI Express Monitor VIP outputs PCI Express symbol
          data from each lane to this file. 
          Argument descriptions:
            "./pcie_basic_sys_symbol.log"      -> Name of the symbol log file.
            "w"                                -> Access Mode of the symbol log file (Truncate
                                                  or Create for writing), other mode possible is 
                                                  "a" (Append or Create for writing).
          */
         vip_mac_agent.monitor.open_symbol_log("./pcie_basic_sys_symbol.log", "w");
       
         /**
          Opens a transaction log file. The PCI Express Monitor VIP outputs PCI Express 
          transaction data to this file.
            "./pcie_basic_sys_transaction.log" -> Name of the symbol log file.
            "w"                                -> Access Mode of the symbol log file (Truncate
                                                  or Create for writing), other mode possible is 
                                                  "a" (Append or Create for writing).
        
          For complete description of Monitor VIP logging facilities refer "DesignWare PCI 
          Express Verification IP System Verilog User Manual."
          */
         vip_mac_agent.monitor.open_transaction_log("./pcie_basic_sys_transaction.log", "w");
       end
       
     end
    `uvm_info("run_phase", "Exiting ...",UVM_LOW)
  endtask
  
endclass : pcie_basic_env
`endif // GUARD_PCIE_BASIC_ENV_SV
