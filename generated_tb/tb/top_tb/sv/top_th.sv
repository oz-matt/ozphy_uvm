// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: top_th.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Wed Feb 17 10:05:16 2021
//=============================================================================
// Description: Test Harness
//=============================================================================

module top_th;

  timeunit      1ns;
  timeprecision 1ps;


  // Start of inlined include file generated_tb/tb/include/th_clk_rst.sv
    logic clk_upstream = 0;
    logic clk_downstream = 0;
  
    always #10 clk_upstream = ~clk_upstream;
    always #10 clk_downstream = ~clk_downstream;
    
      initial
      begin
        clk_upstream = 0;
        clk_downstream = 0;
        #100;
        $finish();
      end  
  
    assign upstream_if_0.ustream_if.clk = clk_upstream;
    assign downstream_if_0.dstream_if.clk = clk_downstream;
    
  // End of inlined include file

  // Pin-level interfaces connected to DUT
  // You can remove interface instances by setting generate_interface_instance = no in the interface template file

  upstream_if    upstream_if_0 ();  
  downstream_if  downstream_if_0 ();

  phyb2b_top uut (
    .ustream_if(upstream_if_0.ustream_if),
    .dstream_if(downstream_if_0.dstream_if)
  );

endmodule

