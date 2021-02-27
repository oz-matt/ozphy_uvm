
`ifndef TOP_ENV_SV
`define TOP_ENV_SV

/* Define requester and completer ID of the component  */   
`define DW_VIP_PCIE_MAC1_REQ_ID               16'h0100
`define DW_VIP_PCIE_MAC1_CPL_ID               16'h0100
  
`define DW_VIP_PCIE_MAC2_REQ_ID               16'h0210
`define DW_VIP_PCIE_MAC2_CPL_ID               16'h0210

`include "pcie_virtual_sequencer.sv"
`include "cust_dw_vip_pcie_agent_configuration.sv"
`include "pcie_ds_txrx_sb_callbacks.sv"
`include "pcie_us_coverage_callbacks.sv"

typedef uvm_callbacks #(dw_vip_pcie_txrx_uvm, dw_vip_pcie_txrx_uvm_callbacks) dw_vip_pcie_txrx_uvm_callbacks_t;
typedef uvm_callbacks #(dw_vip_pcie_monitor_uvm,dw_vip_pcie_monitor_uvm_callbacks) dw_vip_pcie_monitor_uvm_callbacks_t;

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

  //top_config           m_config;
  
  dw_vip_pcie_agent                                  mac_if1_agent;
  dw_vip_pcie_agent                                  mac_if2_agent;
  
  cust_dw_vip_pcie_agent_configuration  mac_if1_agent_cfg;
  cust_dw_vip_pcie_agent_configuration  mac_if2_agent_cfg;

  pcie_virtual_sequencer                sequencer;
  
  pcie_ds_txrx_sb_callbacks  ds_mac_cb;
  pcie_us_coverage_callbacks  us_cov_cb;
  
  
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern task          run_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);

endclass : top_env 


function top_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void top_env::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In build_phase", UVM_HIGH)

    
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
  this.mac_if1_agent_cfg.txrx_cfg.m_enInterfaceType                  = dw_vip_pcie_configuration::MAC_PIPE8;
  this.mac_if1_agent_cfg.txrx_cfg.m_bvReqId                          = `DW_VIP_PCIE_MAC1_REQ_ID;
  this.mac_if1_agent_cfg.txrx_cfg.m_bvCplId                          = `DW_VIP_PCIE_MAC1_CPL_ID;
    
  //this.mac_if2_agent.monitor.cfg.m_bMonRegTracking = 1'b1; // Turn on config register tracking
  this.mac_if2_agent_cfg.txrx_cfg.m_enPosition                       = dw_vip_pcie_configuration::DOWNSTREAM;
  this.mac_if2_agent_cfg.txrx_cfg.m_enInterfaceType                  = dw_vip_pcie_configuration::MAC_PIPE8;
  this.mac_if2_agent_cfg.txrx_cfg.m_bvReqId                          = `DW_VIP_PCIE_MAC2_REQ_ID;
  this.mac_if2_agent_cfg.txrx_cfg.m_bvCplId                          = `DW_VIP_PCIE_MAC2_CPL_ID;
  this.mac_if2_agent_cfg.txrx_cfg.m_bMonRegTracking = `VMT_ENABLE;
  mac_if2_agent_cfg.copy_txrx_cfg_to_mon_cfg();
  mac_if1_agent_cfg.copy_txrx_cfg_to_mon_cfg();
    

    uvm_config_db#(dw_vip_pcie_agent_configuration)::set(this,"mac_if1_agent", "cfg",mac_if1_agent_cfg);
    uvm_config_db#(dw_vip_pcie_agent_configuration)::set(this,"mac_if2_agent", "cfg",mac_if2_agent_cfg);

    uvm_config_db#(int)::set(this,"mac_if1_agent", "enable_monitor",1);
    uvm_config_db#(int)::set(this,"mac_if2_agent", "enable_monitor",1);

  mac_if1_agent = dw_vip_pcie_agent::type_id::create("mac_if1_agent", this); 
  uvm_config_db#(bit)::set(this,"mac_if1_agent", "tlp_sequencer",1'b1);
  mac_if2_agent  = dw_vip_pcie_agent::type_id::create("mac_if2_agent", this);
  
  //this.mac_if2_agent.monitor.set_config_param( `VMT_DEFAULT_STREAM_ID,`DW_VIP_PCIE_MON_REG_TRACKING_PARAM, `VMT_ENABLE );
    
  sequencer  = pcie_virtual_sequencer::type_id::create("sequencer", this);
  
  `uvm_info("build_phase",  "Exiting ...", UVM_LOW)
    
    ds_mac_cb = new("ds_mac_cb");
    us_cov_cb = new();
    
    
    
    

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
    
    dw_vip_pcie_txrx_uvm_callbacks_t::add(mac_if2_agent.txrx, ds_mac_cb);
    dw_vip_pcie_monitor_uvm_callbacks_t::add(mac_if1_agent.monitor, us_cov_cb);
    
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

  int logID;
  
    `uvm_info("run_phase", "Entered ...",UVM_LOW)
    
     begin
     
       if (((mac_if1_agent_cfg.enable_monitor && mac_if1_agent.is_active == UVM_ACTIVE) || 
         (mac_if1_agent.is_active == UVM_PASSIVE)) && (mac_if1_agent.monitor != null)) begin
         mac_if1_agent.monitor.open_symbol_log("../logs/mac1_pcie_basic_sys_symbol.log", "w");
         mac_if1_agent.monitor.open_transaction_log("../logs/mac1_pcie_basic_sys_transaction.log", "w");
         mac_if1_agent.monitor.open_msg_log(`VMT_DEFAULT_STREAM_ID, "../logs/mac1_msgs.log", `VMT_MSG_LOG_MODE_OVR, logID);
         
	 mac_if1_agent.monitor.enable_msg_log(0, `VMT_MSG_ROUTE_ALL);
	 //mac_if1_agent.monitor.disable_msg_type(0,`VMT_MSG_ALL, `VMT_MSG_ROUTE_ALL);
	 mac_if1_agent.monitor.enable_msg_type(0,`VMT_MSG_ERROR, `VMT_MSG_ROUTE_ALL);
	 //mac_if1_agent.monitor.enable_msg_type(0,`PCIE_MSGID_DEVICE_NOT_COMPLIANT, `VMT_MSG_ROUTE_ALL);
       end

       if (((mac_if2_agent_cfg.enable_monitor && mac_if2_agent.is_active == UVM_ACTIVE) || 
         (mac_if2_agent.is_active == UVM_PASSIVE)) && (mac_if2_agent.monitor != null)) begin
         mac_if2_agent.monitor.open_symbol_log("../logs/mac2_pcie_basic_sys_symbol.log", "w");
         mac_if2_agent.monitor.open_transaction_log("../logs/mac2_pcie_basic_sys_transaction.log", "w");
         mac_if2_agent.monitor.dump_config_space("../logs/config.settings", "w");
       end
       
     end
     
    `uvm_info("run_phase", "Exiting ...",UVM_LOW)
    
    `uvm_info("wp", "wp header",UVM_HIGH)
  
  
  
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

function void top_env::report_phase(uvm_phase phase);

    `uvm_info("report_phase", "Entered ...",UVM_LOW)
    super.report_phase(phase);
      
    this.mac_if2_agent.monitor.dump_config_space("../logs/config.settings", "a");
    `uvm_info("report_phase", "Exiting ...",UVM_LOW)

endfunction : report_phase


`endif // TOP_ENV_SV

