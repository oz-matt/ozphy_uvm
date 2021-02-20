
`ifndef TOP_ENV_SV
`define TOP_ENV_SV

/* Define requester and completer ID of the component behind PHY */   
`define DW_VIP_PCIE_MAC2_REQ_ID               16'h0100
`define DW_VIP_PCIE_MAC2_CPL_ID               16'h0100
  
/* Define requester and completer ID for the component with MAC interface */  
`define DW_VIP_PCIE_MAC1_REQ_ID               16'h0210
`define DW_VIP_PCIE_MAC1_CPL_ID               16'h0210

// You can insert code here by setting top_env_inc_before_class in file common.tpl

`include "pcie_virtual_sequencer.sv"
`include "cust_dw_vip_pcie_agent_configuration.sv"

class top_env extends uvm_env;

  `uvm_component_utils(top_env)

  extern function new(string name, uvm_component parent);


  // Child agents
  //upstream_config      m_upstream_config;    
  //upstream_agent       m_upstream_agent;     
  //upstream_coverage    m_upstream_coverage;  

  //downstream_config    m_downstream_config;  
  //downstream_agent     m_downstream_agent;   
  //downstream_coverage  m_downstream_coverage;

  top_config           m_config;
  
  dw_vip_pcie_agent                                  mac_if1_agent;
  dw_vip_pcie_agent                                  mac_if2_agent;
  
  cust_dw_vip_pcie_agent_configuration  mac_if1_agent_cfg;
  cust_dw_vip_pcie_agent_configuration  mac_if2_agent_cfg;

  pcie_virtual_sequencer                sequencer;
  
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern task          run_phase(uvm_phase phase);

endclass : top_env 


function top_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void top_env::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In build_phase", UVM_HIGH)

  if (!uvm_config_db #(top_config)::get(this, "", "config", m_config)) 
    `uvm_error(get_type_name(), "Unable to get top_config")
    
  // If test edits the custom mac configs, load them. Otherwise create() new empty ones.
  if (!uvm_config_db#(cust_dw_vip_pcie_agent_configuration)::get(this,"","mac_if1_agent_cfg",mac_if1_agent_cfg)) begin
    `uvm_info("build_phase","Creating default configuration for mac_if1_agent",UVM_LOW)
    mac_if1_agent_cfg = cust_dw_vip_pcie_agent_configuration::type_id::create("mac_if1_agent_cfg");
  end  
  if (!uvm_config_db#(cust_dw_vip_pcie_agent_configuration)::get(this,"","mac_if2_agent_cfg",mac_if2_agent_cfg)) begin
    `uvm_info("build_phase","Creating default configuration for mac_if2_agent",UVM_LOW)
    mac_if2_agent_cfg = cust_dw_vip_pcie_agent_configuration::type_id::create("mac_if2_agent_cfg");
  end
    
    
  this.mac_if1_agent_cfg.txrx_cfg.m_enPosition                       = dw_vip_pcie_configuration::UPSTREAM;
  this.mac_if1_agent_cfg.txrx_cfg.m_enInterfaceType                  = dw_vip_pcie_configuration::PHY_PIPE8;
  this.mac_if1_agent_cfg.txrx_cfg.m_bvReqId                          = `DW_VIP_PCIE_MAC1_REQ_ID;
  this.mac_if1_agent_cfg.txrx_cfg.m_bvCplId                          = `DW_VIP_PCIE_MAC1_CPL_ID;
    
  this.mac_if2_agent_cfg.txrx_cfg.m_enPosition                       = dw_vip_pcie_configuration::DOWNSTREAM;
  this.mac_if2_agent_cfg.txrx_cfg.m_enInterfaceType                  = dw_vip_pcie_configuration::PHY_PIPE8;
  this.mac_if2_agent_cfg.txrx_cfg.m_bvReqId                          = `DW_VIP_PCIE_MAC2_REQ_ID;
  this.mac_if2_agent_cfg.txrx_cfg.m_bvCplId                          = `DW_VIP_PCIE_MAC2_CPL_ID;
    
  mac_if1_agent_cfg.copy_txrx_cfg_to_mon_cfg();
  mac_if2_agent_cfg.copy_txrx_cfg_to_mon_cfg();
    
    
  mac_if1_agent = dw_vip_pcie_agent::type_id::create("mac_if1_agent", this); 
  uvm_config_db#(bit)::set(this,"mac_if1_agent", "tlp_sequencer",1'b1);
  mac_if2_agent  = dw_vip_pcie_agent::type_id::create("mac_if2_agent", this);
  
  sequencer  = pcie_virtual_sequencer::type_id::create("sequencer", this);
  
  `uvm_info("build_phase",  "Exiting ...", UVM_LOW)
    
    
    
    
    
    

  /*m_upstream_config                 = new("m_upstream_config");         
  m_upstream_config.mac_vif             = m_config.upstream_mac_vif;    
  m_upstream_config.phy_vif             = m_config.upstream_phy_vif;            
  m_upstream_config.is_active       = m_config.is_active_upstream;      
  m_upstream_config.checks_enable   = m_config.checks_enable_upstream;  
  m_upstream_config.coverage_enable = m_config.coverage_enable_upstream;
  
  uvm_config_db #(upstream_config)::set(this, "m_upstream_agent", "config", m_upstream_config);
  if (m_upstream_config.is_active == UVM_ACTIVE )
    uvm_config_db #(upstream_config)::set(this, "m_upstream_agent.m_sequencer", "config", m_upstream_config);
  uvm_config_db #(upstream_config)::set(this, "m_upstream_coverage", "config", m_upstream_config);

  m_downstream_config                 = new("m_downstream_config");    
 
  m_downstream_config.mac_vif             = m_config.downstream_mac_vif;    
  m_downstream_config.phy_vif             = m_config.downstream_phy_vif;   
  m_downstream_config.is_active       = m_config.is_active_downstream;      
  m_downstream_config.checks_enable   = m_config.checks_enable_downstream;  
  m_downstream_config.coverage_enable = m_config.coverage_enable_downstream;

  uvm_config_db #(downstream_config)::set(this, "m_downstream_agent", "config", m_downstream_config);
  if (m_downstream_config.is_active == UVM_ACTIVE )
    uvm_config_db #(downstream_config)::set(this, "m_downstream_agent.m_sequencer", "config", m_downstream_config);
  uvm_config_db #(downstream_config)::set(this, "m_downstream_coverage", "config", m_downstream_config);


  //m_upstream_agent      = upstream_agent     ::type_id::create("m_upstream_agent", this);
  m_upstream_coverage   = upstream_coverage  ::type_id::create("m_upstream_coverage", this);

 // m_downstream_agent    = downstream_agent   ::type_id::create("m_downstream_agent", this);
  m_downstream_coverage = downstream_coverage::type_id::create("m_downstream_coverage", this);
*/
  // You can insert code here by setting top_env_append_to_build_phase in file common.tpl

endfunction : build_phase


function void top_env::connect_phase(uvm_phase phase);
 // m_upstream_agent.analysis_port.connect(m_upstream_coverage.analysis_export);

 // m_downstream_agent.analysis_port.connect(m_downstream_coverage.analysis_export);

    `uvm_info("connect_phase", "Entered ...",UVM_LOW)
    super.connect_phase(phase);
      
    sequencer.mac1_seqr = mac_if1_agent.virt_sequencer;
    `uvm_info("connect_phase", "Exiting ...",UVM_LOW)

endfunction : connect_phase


function void top_env::end_of_elaboration_phase(uvm_phase phase);
  uvm_factory factory = uvm_factory::get();
  `uvm_info(get_type_name(), "Information printed from top_env::end_of_elaboration_phase method", UVM_MEDIUM)
  `uvm_info(get_type_name(), $sformatf("Verbosity threshold is %d", get_report_verbosity_level()), UVM_MEDIUM)
  uvm_top.print_topology();
  factory.print();
endfunction : end_of_elaboration_phase


task top_env::run_phase(uvm_phase phase);

    `uvm_info("run_phase", "Entered ...",UVM_LOW)
    
     begin
     
       if (((mac_if1_agent_cfg.enable_monitor && mac_if1_agent.is_active == UVM_ACTIVE) || 
         (mac_if1_agent.is_active == UVM_PASSIVE)) && (mac_if1_agent.monitor != null)) begin
         mac_if1_agent.monitor.open_symbol_log("./mac1_pcie_basic_sys_symbol.log", "w");
         mac_if1_agent.monitor.open_transaction_log("./mac1_pcie_basic_sys_transaction.log", "w");
       end

       if (((mac_if2_agent_cfg.enable_monitor && mac_if2_agent.is_active == UVM_ACTIVE) || 
         (mac_if2_agent.is_active == UVM_PASSIVE)) && (mac_if2_agent.monitor != null)) begin
         mac_if2_agent.monitor.open_symbol_log("./mac2_pcie_basic_sys_symbol.log", "w");
         mac_if2_agent.monitor.open_transaction_log("./mac2_pcie_basic_sys_transaction.log", "w");
       end
       
     end
     
    `uvm_info("run_phase", "Exiting ...",UVM_LOW)
    
  
  
  
  /*top_default_seq vseq;
  vseq = top_default_seq::type_id::create("vseq");
  vseq.set_item_context(null, null);
  if ( !vseq.randomize() )
    `uvm_fatal(get_type_name(), "Failed to randomize virtual sequence")
  //vseq.m_upstream_agent   = m_upstream_agent;  
  //vseq.m_downstream_agent = m_downstream_agent;
  vseq.m_config           = m_config;          
  vseq.set_starting_phase(phase);
  vseq.start(null);
*/
endtask : run_phase


// You can insert code here by setting top_env_inc_after_class in file common.tpl

`endif // TOP_ENV_SV

