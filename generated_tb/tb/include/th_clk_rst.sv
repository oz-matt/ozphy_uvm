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
  
