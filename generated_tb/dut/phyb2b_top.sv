
module phyb2b_top(
  pcie_basic_if ustream_if,
  pcie_basic_if dstream_if
  );
  
  wire [15:0] b10out;
  wire [15:0] b10in;
  
  ozphy ozp_iup(ustream_if, b10out, b10in);
  ozphy ozp_idown(dstream_if, b10in, b10out);
  
endmodule

