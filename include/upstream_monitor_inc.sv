task upstream_monitor::do_mon;
  forever @(vif.ustream_if.clk)
  begin
    m_trans.rand_instruction <= vif.ustream_if.lane0_txdata;
    `uvm_info(get_type_name(), $sformatf("txdata0: %X", vif.ustream_if.lane0_txdata), UVM_MEDIUM);
  end
endtask

