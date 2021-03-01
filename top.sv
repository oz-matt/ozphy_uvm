
`timescale 10 ps /10 ps

`include "pcie_basic_hdl_interconnect_sv_wrapper.sv"
`include "Pcie.uvm.pkg"

module top_tb;
import uvm_pkg::*;

/** Imported the PCIe package */
import dw_vip_pcie_uvm_pkg::*;

/** Include the testcase list */
`include "../tests/test_top.sv"
  
/**
 * Define clock period for system clock. It is set to 4 ns (400*10 ps (Time unit))
 * to represent 250 MHz clock expected by PCI Express VIP operating in GEN1 mode. 
 */
  parameter simulation_cycle = 400;
  parameter serdes_cycle = 40;

    logic clk_upstream = 0;
    logic clk_upstream_serial = 0;
    logic clk_downstream = 0;
    
    wire [15:0] macphy_serial_out;
    wire [15:0] macphy_serial_in;
  
    dw_vip_pcie_txrx_if pcie_macphy_serial_if1(); // combined mac+phy root complex
    dw_vip_pcie_txrx_if pcie_mac_if2(); // endpoint mac
    
    dw_vip_pcie_txrx_if pcie_phy_if2(); // pipe output of DUT
    
    dw_vip_pcie_monitor_if pcie_mac_mon_if2(); //monitor in phy pipe mode
    
    dw_vip_pcie_txrx_vmt_sv_wrapper pcie_macphy_serial_txrx(pcie_macphy_serial_if1);
    dw_vip_pcie_txrx_vmt_sv_wrapper pcie_mac_txrx(pcie_mac_if2);
    
    dw_vip_pcie_txrx_vmt_sv_wrapper pcie_phy2_txrx(pcie_phy_if2);
    
    dw_vip_pcie_monitor_vmt_sv_wrapper pcie_mac_monitor(pcie_mac_mon_if2);
    
    pcie_basic_hdl_interconnect_sv_wrapper hdl_interconnect2(pcie_mac_if2, pcie_phy_if2, pcie_mac_mon_if2);
    
    
    serdes macphy_serdes(
       .SerialClock    (clk_upstream_serial),
       .parallel_in0   (pcie_macphy_serial_if1.lane0_txdata[9:0]),
       .parallel_in1   (pcie_macphy_serial_if1.lane1_txdata[9:0]),
       .parallel_in2   (pcie_macphy_serial_if1.lane2_txdata[9:0]),
       .parallel_in3   (pcie_macphy_serial_if1.lane3_txdata[9:0]),
       .parallel_in4   (pcie_macphy_serial_if1.lane4_txdata[9:0]),
       .parallel_in5   (pcie_macphy_serial_if1.lane5_txdata[9:0]),
       .parallel_in6   (pcie_macphy_serial_if1.lane6_txdata[9:0]),
       .parallel_in7   (pcie_macphy_serial_if1.lane7_txdata[9:0]),
       .parallel_in8   (pcie_macphy_serial_if1.lane8_txdata[9:0]),
       .parallel_in9   (pcie_macphy_serial_if1.lane9_txdata[9:0]),
       .parallel_in10  (pcie_macphy_serial_if1.lane10_txdata[9:0]),
       .parallel_in11  (pcie_macphy_serial_if1.lane11_txdata[9:0]),
       .parallel_in12  (pcie_macphy_serial_if1.lane12_txdata[9:0]),
       .parallel_in13  (pcie_macphy_serial_if1.lane13_txdata[9:0]),
       .parallel_in14  (pcie_macphy_serial_if1.lane14_txdata[9:0]),
       .parallel_in15  (pcie_macphy_serial_if1.lane15_txdata[9:0]),
       .serial_out0    (macphy_serial_out[0]),
       .serial_out1    (macphy_serial_out[1]),
       .serial_out2    (macphy_serial_out[2]),
       .serial_out3    (macphy_serial_out[3]),
       .serial_out4    (macphy_serial_out[4]),
       .serial_out5    (macphy_serial_out[5]),
       .serial_out6    (macphy_serial_out[6]),
       .serial_out7    (macphy_serial_out[7]),
       .serial_out8    (macphy_serial_out[8]),
       .serial_out9    (macphy_serial_out[9]),
       .serial_out10   (macphy_serial_out[10]),
       .serial_out11   (macphy_serial_out[11]),
       .serial_out12   (macphy_serial_out[12]),
       .serial_out13   (macphy_serial_out[13]),
       .serial_out14   (macphy_serial_out[14]),
       .serial_out15   (macphy_serial_out[15]),

        .parallel_out0  (pcie_macphy_serial_if1.lane0_rxdata[9:0]),
	.parallel_out1  (pcie_macphy_serial_if1.lane1_rxdata[9:0]),
	.parallel_out2  (pcie_macphy_serial_if1.lane2_rxdata[9:0]),
	.parallel_out3  (pcie_macphy_serial_if1.lane3_rxdata[9:0]),
	.parallel_out4  (pcie_macphy_serial_if1.lane4_rxdata[9:0]),
	.parallel_out5  (pcie_macphy_serial_if1.lane5_rxdata[9:0]),
	.parallel_out6  (pcie_macphy_serial_if1.lane6_rxdata[9:0]),
	.parallel_out7  (pcie_macphy_serial_if1.lane7_rxdata[9:0]),
	.parallel_out8  (pcie_macphy_serial_if1.lane8_rxdata[9:0]),
	.parallel_out9  (pcie_macphy_serial_if1.lane9_rxdata[9:0]),
	.parallel_out10 (pcie_macphy_serial_if1.lane10_rxdata[9:0]),
	.parallel_out11 (pcie_macphy_serial_if1.lane11_rxdata[9:0]),
	.parallel_out12 (pcie_macphy_serial_if1.lane12_rxdata[9:0]),
	.parallel_out13 (pcie_macphy_serial_if1.lane13_rxdata[9:0]),
	.parallel_out14 (pcie_macphy_serial_if1.lane14_rxdata[9:0]),
	.parallel_out15 (pcie_macphy_serial_if1.lane15_rxdata[9:0]),
       .serial_in0    (macphy_serial_in[0]),
       .serial_in1    (macphy_serial_in[1]),
       .serial_in2    (macphy_serial_in[2]),
       .serial_in3    (macphy_serial_in[3]),
       .serial_in4    (macphy_serial_in[4]),
       .serial_in5    (macphy_serial_in[5]),
       .serial_in6    (macphy_serial_in[6]),
       .serial_in7    (macphy_serial_in[7]),
       .serial_in8    (macphy_serial_in[8]),
       .serial_in9    (macphy_serial_in[9]),
       .serial_in10   (macphy_serial_in[10]),
       .serial_in11   (macphy_serial_in[11]),
       .serial_in12   (macphy_serial_in[12]),
       .serial_in13   (macphy_serial_in[13]),
       .serial_in14   (macphy_serial_in[14]),
       .serial_in15   (macphy_serial_in[15])
      );
    
    
  singlephy_top dut (
    .serial_in(macphy_serial_out),
    .serial_out(macphy_serial_in),
    .dstream_if(pcie_phy_if2)
  );
  


    initial begin
      clk_upstream = 0;
      clk_downstream = 0;
      #(simulation_cycle);
      forever begin
        #(simulation_cycle/2);
        clk_upstream = ~clk_upstream;
        clk_downstream = ~clk_downstream;
      end  
    end
    


    initial begin
      clk_upstream_serial = 0;
      #(serdes_cycle);
      forever begin
        #(serdes_cycle/2);
        clk_upstream_serial = ~clk_upstream_serial;
      end  
    end
    

  initial begin
    $timeformat(-9, 1, "ns", 10);

    /** Connect the physical txrx and mon interfaces to the virtual ones */
    uvm_config_db#(virtual dw_vip_pcie_txrx_if)::set(uvm_root::get(),"uvm_test_top.m_env.macphy_if_agent", "txrx_if" ,pcie_macphy_serial_if1);
    uvm_config_db#(virtual dw_vip_pcie_txrx_if)::set(uvm_root::get(),"uvm_test_top.m_env.mac_if2_agent", "txrx_if" ,pcie_mac_if2);
    uvm_config_db#(virtual dw_vip_pcie_monitor_if)::set(uvm_root::get(),"uvm_test_top.m_env.mac_if2_agent", "monitor_if" ,pcie_mac_mon_if2);

   /** UVM Test phase initiator */

   //fork
     //begin
       run_test();   
     //end
     //begin
       //wps();
     //end
   //join_any
   
 end

/** Connect system clock */
  assign pcie_macphy_serial_if1.clk = clk_upstream;
  //assign pcie_phy_if1.clk = clk_upstream;

  assign pcie_mac_if2.clk = clk_downstream;
  assign pcie_phy_if2.clk = clk_downstream;
  //assign pcie_mac_mon_if1.clk = clk_upstream;
  assign pcie_mac_mon_if2.clk = clk_downstream;

/** Optionally dump the simulation variables for waveform display */
`ifdef WAVES
  initial 
  begin
    string wave_str = "`WAVES";
    if (!wave_str.compare("virsim") || !wave_str.compare("vcd"))
      $dumpvars;
    else
      /*
       * The vcdplus format is much more compact, but it is only available in
       * VCS and VCS-MX. Testbenches which are run in other Verilog environments
       * must at a minimum comment out or remove the following line.
       * They may wish to replace this entire block with a simple '$dumpvars' call.
       */
      $vcdpluson;
  end
`endif

//`include "watchpts.sv" // add the wps task

endmodule

