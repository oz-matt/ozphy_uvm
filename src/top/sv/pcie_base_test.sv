//=======================================================================
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
//-----------------------------------------------------------------------

/**
 * Abstract:
 * This file creates a base test, which serves as the base class for the rest
 * of the tests in this environment.  This test sets up the default behavior
 * for the rest of the tests in this environment.
 *
 * 1. Instantiates and creates the environment class.
 * 2. Use type wide factory override to set cust_dw_vip_pcie_tlp_transaction
 *    as the default TLP transaction type
 * 3. Sets the MAC/PHY Transceiver Interface type
 * 4. Training sequence is configured for the configure phase of the tlp_sequencer.
 * 5. Sets the pcie_random_discrete_virtual_sequence in the main_phase of virtual 
      sequencer in the environment.
 * 6. Sets the default sequence length = 5.
 * 7. Sets the Pass/Fail criterion in the final_phase() using report_server. 
 */

`ifndef GUARD_PCIE_BASE_TEST_SV
`define GUARD_PCIE_BASE_TEST_SV

`include "pcie_basic_env.sv"
`include "cust_dw_vip_pcie_tlp_transaction.sv"
`include "pcie_random_discrete_virtual_sequence.sv"

class pcie_base_test extends uvm_test;

  /** UVM component utility macro */
  `uvm_component_utils(pcie_base_test)

  /** Instance of the environment */
  pcie_basic_env env;
  
  /** Custom PHY agent configuration handle */
  cust_dw_vip_pcie_agent_configuration phy_agent_cfg;
  
  /** Custom MAC agent configuration handle */
  cust_dw_vip_pcie_agent_configuration mac_agent_cfg;

  /** Class constructor */
  function new(string name = "pcie_base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)
    super.build_phase(phase);
    
    /** Create the phy agent cfg */
    phy_agent_cfg =cust_dw_vip_pcie_agent_configuration::type_id::create("phy_agent_cfg");
    
    /** Set the phy agent interface type to PHY_PIPE8 */
    this.phy_agent_cfg.txrx_cfg.m_enInterfaceType             = dw_vip_pcie_configuration::PHY_PIPE8;
    
    /** Create the mac agent cfg */
    mac_agent_cfg =cust_dw_vip_pcie_agent_configuration::type_id::create("mac_agent_cfg");
    
    /** Set the mac agent interface type to MAC_PIPE8 */
    this.mac_agent_cfg.txrx_cfg.m_enInterfaceType             = dw_vip_pcie_configuration::MAC_PIPE8;
    
    /** Copy the txrx cfg to the monitor cfg inside the mac agent */
    mac_agent_cfg.copy_txrx_cfg_to_mon_cfg();
    
    /** Set mac agent configuration in environment */
    uvm_config_db#(cust_dw_vip_pcie_agent_configuration)::set(this,"env", "mac_agent_cfg",mac_agent_cfg);

    /** Set phy agent configuration in environment */
    uvm_config_db#(cust_dw_vip_pcie_agent_configuration)::set(this,"env", "phy_agent_cfg",phy_agent_cfg);

    /** Factory override the base tlp transaction with the custom one */
    set_type_override_by_type(dw_vip_pcie_tlp_transaction::get_type() , cust_dw_vip_pcie_tlp_transaction::get_type());

    /** Apply training sequence to tlp sequencer
     *  Configure the tlp sequencer under virtual sequencer of PHY agent
     *  to run the training sequence available in the tlp sequence library
     *  during its configure_phase. It is mandatory to train the PCIe system
     *  using such a sequence.
     */
    uvm_config_db#(uvm_object_wrapper)::set(this,"env.vip_phy_agent.virt_sequencer.tlp_sequencer.configure_phase", "default_sequence", dw_vip_pcie_tlp_training_sequence::get_type());
    
    /** Apply the default sequence to Pcie virtual sequencer
     *  Configure the virtual sequencer to run a default virtual sequence, 
     *  during its main_phase. This sequence would in-turn run the random sequence
     *  in the tlp sequencer available in the virtual sequencer of PHY agent.
     *  Extended tests can disable this behavior in one of two ways:
     *   1) If using UVM 1.0 then this virtual sequence can be overriden with the
     *      pcie_null_virtual_sequence.
     *   2) If using UVM 1.1 then this virtual sequence can be overriden by configuring
     *      the default sequence of the main phase as 'null'.
     */
    uvm_config_db#(uvm_object_wrapper)::set(this,"env.sequencer.main_phase", "default_sequence", pcie_random_discrete_virtual_sequence::get_type());
    
    /** Configure the sequence length to generate 5 random TLP packets */
    uvm_config_db#(int unsigned)::set(this,"env.sequencer.pcie_random_discrete_virtual_sequence", "sequence_length", 5);
    
    /** Create the environment */
    env = pcie_basic_env::type_id::create("env", this);

    `uvm_info("build_phase", "Exiting ...", UVM_LOW)
  endfunction : build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("end_of_elaboration_phase", "Entered ...", UVM_LOW)
    uvm_top.print_topology();
    `uvm_info("end_of_elaboration_phase", "Exiting ...", UVM_LOW)
  endfunction : end_of_elaboration_phase

  /**
   * Calculate the pass or fail status for the test in the final phase method of the
   * test. If a UVM_FATAL, UVM_ERROR, or a UVM_WARNING message has been generated the
   * test will fail.
   */
  function void final_phase(uvm_phase phase);
    uvm_report_server svr;
    `uvm_info("final_phase", "Entered ...",UVM_LOW)

    super.final_phase(phase);

    svr = uvm_report_server::get_server();

    if (svr.get_severity_count(UVM_FATAL)||  
        svr.get_severity_count(UVM_ERROR)|| 
        svr.get_severity_count(UVM_WARNING))
      `uvm_info("final_phase", "\nSvtTestEpilog: Failed\n", UVM_LOW)
    else
      `uvm_info("final_phase", "\nSvtTestEpilog: Passed\n", UVM_LOW)

    `uvm_info("final_phase", "Exiting ...",UVM_LOW)
  endfunction : final_phase

endclass
`endif // GUARD_PCIE_BASE_TEST_SV
