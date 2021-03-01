
task wps();

  integer tx_tlp_rcvd_watchpoint;
  integer watchpoint_handle;
  integer tlp_buffer_handle;
  integer status;
  integer type_int, addr_lsb_int, rid, len;

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
                                                             type_int);
      
      pcie_mac_monitor1.PCIE_MONITOR_VMT.get_buffer_attr_int(tlp_buffer_handle, 
                                                             `DW_VIP_PCIE_REQUESTER_ID_FIELD, 
                                                             rid);
      
      pcie_mac_monitor1.PCIE_MONITOR_VMT.get_buffer_attr_int(tlp_buffer_handle, 
                                                             `DW_VIP_PCIE_ADDRESS_31_0_FIELD, 
                                                             addr_lsb_int);
      
      pcie_mac_monitor1.PCIE_MONITOR_VMT.get_buffer_attr_int(tlp_buffer_handle, 
                                                             `DW_VIP_PCIE_LENGTH_FIELD , 
                                                             len);
      
      `uvm_info("wp", $sformatf("type: %s, rid: %X, addr_lsb_int:%X, len: %X, buffer handle: %d, time: %0d", get_packet_type_str(type_int), rid, addr_lsb_int, len, tlp_buffer_handle, $time),UVM_NONE);

    end
  end
endtask

function string get_packet_type_str(integer ptype);
  case (ptype)
    `DW_VIP_PCIE_CPL_D: 		      return "CPL_D";
    `DW_VIP_PCIE_MEM_RD:                      return "MEM_RD";
    `DW_VIP_PCIE_MEM_RD_LK:                   return "MEM_RD_LK";
    `DW_VIP_PCIE_MEM_WR:                      return "MEM_WR";
    `DW_VIP_PCIE_IO_RD:                       return "IO_RD";
    `DW_VIP_PCIE_IO_WR:                       return "IO_WR";
    `DW_VIP_PCIE_CFG_RD_0:                    return "CFG_RD_0";
    `DW_VIP_PCIE_CFG_WR_0:                    return "CFG_WR_0";
    `DW_VIP_PCIE_CFG_RD_1:                    return "CFG_RD_1";
    `DW_VIP_PCIE_CFG_WR_1:                    return "CFG_WR_1";
    `DW_VIP_PCIE_MSG:                         return "MSG";
    `DW_VIP_PCIE_MSG_D:                       return "MSG_D";
    `DW_VIP_PCIE_CPL:                         return "CPL";
    `DW_VIP_PCIE_CPL_D:                       return "CPL_D";
    `DW_VIP_PCIE_CPL_LK:                      return "CPL_LK";
    `DW_VIP_PCIE_CPL_D_LK:                    return "CPL_D_LK";
    `DW_VIP_PCIE_MEM_RD_32:                   return "MEM_RD_32";
    `DW_VIP_PCIE_MEM_RD_64:                   return "MEM_RD_64";
    `DW_VIP_PCIE_MEM_RD_LK_32:                return "MEM_RD_LK_32";
    `DW_VIP_PCIE_MEM_RD_LK_64:                return "MEM_RD_LK_64";
    `DW_VIP_PCIE_MEM_WR_32:                   return "MEM_WR_32";
    `DW_VIP_PCIE_MEM_WR_64:                   return "MEM_WR_64";
    `DW_VIP_PCIE_INV_PKT:                     return "INV_PKT";
  endcase
endfunction
  
