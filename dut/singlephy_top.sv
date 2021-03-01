
module singlephy_top(
  input[15:0] serial_in,
  output[15:0] serial_out,
  dw_vip_pcie_txrx_if dstream_if
  );
  
  ozphy ozp_idown(dstream_if, serial_out, serial_in);
  
endmodule

