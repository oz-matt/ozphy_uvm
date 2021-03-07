
`ifndef GUARD_CONSTRAINED_TRAINING_SV
`define GUARD_CONSTRAINED_TRAINING_SV 

class constrained_training_sequence extends dw_vip_pcie_tlp_base_sequence;


        uvm_component comp;
        dw_vip_pcie_monitor_uvm mon;

  /** UVM object utility macro */
  `uvm_object_utils(constrained_training_sequence)
  `uvm_declare_p_sequencer(dw_vip_pcie_tlp_sequencer)
 
      dw_vip_pcie_tlp_transaction cfg_wr_xact;
      dw_vip_pcie_tlp_transaction cfg_rd_xact;
 
  /** Class constructor */
  function new (string name = "constrained_training_sequence");
     super.new(name);
  endfunction : new
 
  
  // body() - Stimulus input
  virtual task body();
  
    int bar0_trigger_val;
    //uvm_event_pool ev_pool = uvm_event_pool::get_global_pool();
    //uvm_event bar0_size_determined = ev_pool.get("bar0_size_determined");
    uvm_event bar0_size_determined = uvm_event_pool::get_global("bar0_size_determined");
    
    
    comp = uvm_top.find("*.m_env.mac_if2_agent.monitor"); // works in uvm1.1
        //comp = uvm_root::get().find("*.m_env.mac_if2_agent.monitor"); // works in uvm1.2
        $cast(mon, comp);
  
    mon.dump_config_space("../logs/config.settings", "a");
  
    uvm_report_info(this.get_name(), " Entering ...");
    
    generate_pcie_cfg_transaction (10'b0000000100, 32'hFFFF_FFFF, 0); // initial read to determine size of endpoint BAR0. Note bottom 4 bits of addr are always 0 so that endpoint can align to 16-bytes. This write of all 1s triggers the monitor to listen for the 1st CfgRd on this bar.
    generate_pcie_cfg_transaction (10'h001, 32'h0000_0007, 0);  // Write command and status register to enable Endpoint to send packet upstream
    generate_pcie_cfg_transaction (10'h004, 32'hFFFF_FF00, 0);  // Write in a fake response that will be read during the cfgrd. This will trigger the monitor to have the correct bar size. The response is: bit0=0=Mem space, bit1:2=0=32bit area, bit3=0=non-prefetchable
    generate_pcie_cfg_transaction (10'h004, 32'h0000_0000, 1); // Read the fake data (will trigger the monitor)
    
    //bar0_size_determined.wait_trigger();
    bar0_size_determined.wait_on();
    
    uvm_config_db#(int)::get(get_sequencer(), "", "bar0_trigger_val",  bar0_trigger_val);
    
    `uvm_info("wp", $sformatf("Got BAR0 reply: %X, size is %d bytes", bar0_trigger_val, (~(bar0_trigger_val & 32'hFFFFFFF0)) + 1), UVM_LOW);
    
    
      /* Write BAR0 to determine memory size */
      //generate_pcie_cfg_transaction (10'h004, 32'hFFFF_FFFF, 0);
 
    //mon.dump_config_space("../logs/config.settings", "a");
      /* Write command and status register to enable Endpoint to send packet upstream */
      //generate_pcie_cfg_transaction (10'h001, 32'h0000_0007, 0);
 
      //mon.dump_config_space("../logs/config.settings", "a");
      /* Configure BAR0 and BAR1 register as 64-bit memory space */
      //generate_pcie_cfg_transaction (10'h004, 32'hD000_0000, 0);
 
      /* BAR1 register setting */
      //generate_pcie_cfg_transaction (10'h005, 32'h8000_0000, 0);
 
      /* BAR2 - MEM 32 Space */
      //generate_pcie_cfg_transaction (10'h006, 32'h0100_0000, 0);
 
      /* BAR 4 - IO Space */
      //generate_pcie_cfg_transaction (10'h008, 32'h0001_0000, 0);
 
      /* Read BAR 0 - MEM 64 Space */
      //generate_pcie_cfg_transaction (10'h004, 32'h0000_0000, 1);
 
  //mon.dump_config_space("../logs/config.settings", "a");
      /* Read BAR 1 -  Space */
      //generate_pcie_cfg_transaction (10'h005, 32'h0000_0000, 1);
 
      /* Read BAR 2 - MEM 32 Space */
      //generate_pcie_cfg_transaction (10'h006, 32'h0000_0000, 1);
 
      /* Read BAR 4 - IO Space */
      //generate_pcie_cfg_transaction (10'h008, 32'h0000_0000, 1);
 
      /* Read Device Capabilities Register */
      //generate_pcie_cfg_transaction (10'h019, 32'h0000_0000, 1);
 
      /* Read Device Status and Control Register */
      //generate_pcie_cfg_transaction (10'h01A, 32'h0000_0000, 1);
 
      /* Write Device Status and Control Register */
      //generate_pcie_cfg_transaction (10'h01A, 32'h0000_0020, 0);
 
      /* Read Device Status and Control Register */
      //generate_pcie_cfg_transaction (10'h01A, 32'h0000_0000, 1);
 
    
   uvm_report_info(this.get_name(), " Exiting ...");
 
  endtask : body
 
  /**
   This method initiates configuration transactions.
   Argument descriptions:
 
   address      ->      10-bit register address of the register being read/written
                        into.
   data         ->      32-bit data for configuration writes. For a configuration
                        read a value 0 is sent.
   tr_type      ->      transaction type decides if its a config read or config write
                        value '0' - config write (CFG_WR_0)
                        value '1' - config read  (CFG_RD_0)
   */
  task generate_pcie_cfg_transaction(bit [9:0] address = 0, bit [31:0] data = 0, bit tr_type = 0);
  
    if(tr_type == 0) begin
      `uvm_create(cfg_wr_xact)
      
      cfg_wr_xact.m_enType = dw_vip_pcie_tlp_transaction::CFG_WR_0;
      cfg_wr_xact.m_bvLength                 = 1;
      cfg_wr_xact.m_bvPayloadSize            = 1;
      cfg_wr_xact.m_bvBusNum                 = 8'h02;
      cfg_wr_xact.m_bvDevNum                 = 5'h02;
      cfg_wr_xact.m_bvFuncNum                = 3'h0;
      cfg_wr_xact.m_bvFirstDWBE              = 4'hF;
      cfg_wr_xact.m_bTD                      = 1'b0;
 
      cfg_wr_xact.m_bvRegNum                 = address;
      cfg_wr_xact.m_bvvPayload[0]            = data;
 
      `uvm_send(cfg_wr_xact);
      
      //`uvm_info("wp", $sformatf("time: %d \r\n sent: %s", $time, cfg_wr_xact.sprint()), UVM_LOW);
  
      get_response(rsp);
      `uvm_info("wp", $sformatf("time: %d \r\n got: %s", $time, rsp.sprint()), UVM_LOW);
    end
    else begin
      `uvm_create(cfg_rd_xact)
      
      cfg_rd_xact.m_enType = dw_vip_pcie_tlp_transaction::CFG_RD_0;
      cfg_rd_xact.m_bvLength                 = 1;
      cfg_rd_xact.m_bvBusNum                 = 8'h02;
      cfg_rd_xact.m_bvDevNum                 = 5'h02;
      cfg_rd_xact.m_bvFuncNum                = 3'h0;
      cfg_rd_xact.m_bvRegNum                 = 10'h000;
      cfg_rd_xact.m_bvFirstDWBE              = 4'hF;
      cfg_rd_xact.m_bTD                      = 1'b0;

      cfg_rd_xact.m_bvRegNum                  = address;
      cfg_rd_xact.m_bvvPayload[0]             = data;
 
      `uvm_send(cfg_rd_xact);
   
      
     // `uvm_info("wp", $sformatf("time: %d \r\n sent: %s", $time, cfg_rd_xact.sprint()), UVM_LOW);
  
      get_response(rsp);
      
      //if(rsp.m_bvvPayload.exists(0)) dummy = rsp.m_bvvPayload[0];
      
      `uvm_info("wp", $sformatf("time: %d \r\n got: %s", $time, rsp.sprint()), UVM_LOW);
    end
  endtask : generate_pcie_cfg_transaction
 
endclass : constrained_training_sequence

`endif
