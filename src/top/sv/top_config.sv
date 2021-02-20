
`ifndef TOP_CONFIG_SV
`define TOP_CONFIG_SV

class top_config extends uvm_object;

  // Do not register config class with the factory

  virtual upstream_phy_if      upstream_phy_vif;  
  virtual upstream_mac_if      upstream_mac_vif;              
  virtual downstream_phy_if    downstream_phy_vif;               
  virtual downstream_mac_if    downstream_mac_vif;            

  uvm_active_passive_enum  is_active_upstream         = UVM_ACTIVE;
  uvm_active_passive_enum  is_active_downstream       = UVM_ACTIVE;

  bit                      checks_enable_upstream;    
  bit                      checks_enable_downstream;  

  bit                      coverage_enable_upstream;  
  bit                      coverage_enable_downstream;

  extern function new(string name = "");

endclass : top_config 


function top_config::new(string name = "");
  super.new(name);

endfunction : new

`endif // TOP_CONFIG_SV

