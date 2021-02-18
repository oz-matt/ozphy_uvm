// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: top_th.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Thu Feb 18 07:48:09 2021
//=============================================================================
// Description: Test Harness
//=============================================================================

module top_th;

  timeunit      10ps;
  timeprecision 10ps;

  import verif_pkg::*;

  // Start of inlined include file generated_tb/tb/include/th_clk_rst.sv
    parameter simulation_cycle = 400;
    
    logic clk_upstream = 0;
    logic clk_downstream = 0;
    
    dw_vip_pcie_txrx_if pcie_mac_if();
    dw_vip_pcie_monitor_if pcie_mac_mon_if();
    dw_vip_pcie_txrx_vmt_sv_wrapper pcie_mac_txrx(pcie_mac_if);
    dw_vip_pcie_monitor_vmt_sv_wrapper pcie_mac_monitor(pcie_mac_mon_if);
    
    initial begin
      clk_upstream = 0;
      clk_downstream = 0;
      #(simulation_cycle);
      forever begin
        #(simulation_cycle/2);
        $display("clk1: %b, clk2: %b", clk_upstream, clk_downstream);
        clk_upstream = ~clk_upstream;
        clk_downstream = ~clk_downstream;
      end  
    end
    
      initial
      begin
        #10000;
        $finish();
      end  
  
    assign upstream_if_0.ustream_if.clk = clk_upstream;
    assign downstream_if_0.dstream_if.clk = clk_downstream;
    
    `ifdef WAVES
    initial 
    begin
      string wave_str = "`WAVES";
      if (!wave_str.compare("virsim") || !wave_str.compare("vcd"))
        $dumpvars;
      else
        $vcdpluson;
    end
    `endif
    
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

