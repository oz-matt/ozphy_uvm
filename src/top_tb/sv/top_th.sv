
module top_th;

  timeunit      10ps;
  timeprecision 10ps;

  import verif_pkg::*;
  
    parameter simulation_cycle = 400;
    
    logic clk_upstream = 0;
    logic clk_downstream = 0;
    
    
    
    dw_vip_pcie_txrx_if pcie_mac_if1();
    dw_vip_pcie_txrx_if pcie_mac_if2();
    
    dw_vip_pcie_txrx_if pcie_phy_if1();
    dw_vip_pcie_txrx_if pcie_phy_if2();
    
    dw_vip_pcie_monitor_if pcie_mac_mon_if1();
    dw_vip_pcie_monitor_if pcie_mac_mon_if2();
    
    dw_vip_pcie_txrx_vmt_sv_wrapper pcie_mac_txrx(pcie_mac_if1);
    dw_vip_pcie_txrx_vmt_sv_wrapper pcie_mac_txrx2(pcie_mac_if2);
    
    dw_vip_pcie_monitor_vmt_sv_wrapper pcie_mac_monitor1(pcie_mac_mon_if1);
    dw_vip_pcie_monitor_vmt_sv_wrapper pcie_mac_monitor2(pcie_mac_mon_if2);
    
    pcie_basic_hdl_interconnect_sv_wrapper hdl_interconnect1(pcie_mac_if1, pcie_phy_if1, pcie_mac_mon_if1);
    pcie_basic_hdl_interconnect_sv_wrapper hdl_interconnect2(pcie_mac_if2, pcie_phy_if2, pcie_mac_mon_if2);
    
  phyb2b_top dut (
    .ustream_if(pcie_phy_if1),
    .dstream_if(pcie_phy_if2)
  );

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
  

  assign pcie_mac_if1.clk = clk_upstream;
  assign pcie_phy_if1.clk = clk_upstream;

  assign pcie_mac_if2.clk = clk_downstream;
  assign pcie_phy_if2.clk = clk_downstream;
    
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

endmodule

