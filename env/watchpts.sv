
task wps();

  integer tx_tlp_rcvd_watchpoint;
  integer watchpoint_handle;
  integer tlp_buffer_handle;
  integer status;
  integer int_value;

  @(posedge clk_downstream) // Wait for simulation to start
    
  pcie_mac_monitor1.PCIE_MONITOR_VMT.create_watchpoint(`VMT_MESSAGE_ID, 
                                                       `PCIE_MSGID_DEVICE_NOT_COMPLIANT, 
                                                       tx_tlp_rcvd_watchpoint);
  
  forever begin
  
    pcie_mac_monitor1.PCIE_MONITOR_VMT.watch_for(tx_tlp_rcvd_watchpoint, 
                                                 watchpoint_handle);
    
    pcie_mac_monitor1.PCIE_MONITOR_VMT.get_watchpoint_data_int(watchpoint_handle, 
                                                               `PCIE_MSGID_DEVICE_NOT_COMPLIANT_ARG_BUF_HANDLE, 
                                                               tlp_buffer_handle, 
                                                               status);
                                                               
    if (status == `VMT_INVALID_HANDLE) begin
      `uvm_info("wp", "VMT INVALID!",UVM_NONE);
    end
    else begin
      pcie_mac_monitor1.PCIE_MONITOR_VMT.get_buffer_attr_int(tlp_buffer_handle, 
                                                             `DW_VIP_PCIE_TLP_TYPE, 
                                                             int_value);
      if (int_value === `DW_VIP_PCIE_CPL_D) begin
      `uvm_info("wp", $sformatf("type: %0d, buffer handle: %d, time: %0d", int_value, tlp_buffer_handle, $realtime),UVM_NONE);
      end
      else begin 
      `uvm_info("wp", $sformatf("type: %0d, buffer handle: %d, time: %0d", int_value, tlp_buffer_handle, $realtime),UVM_NONE);
      end
    end
  end
endtask
  
