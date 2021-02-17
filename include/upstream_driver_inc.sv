task upstream_driver::do_drive();
  vif.ustream_if.lane0_txdata <= req.rand_instruction;
  vif.ustream_if.txdetectrx <= 1;
  #1;
endtask

