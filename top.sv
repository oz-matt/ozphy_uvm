//=======================================================================
// COPYRIGHT (C) 2010, 2011, 2012 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

/**
 * Abstract:
 * Top level SystemVerilog testbench.
 * Notes
 *   PHY (Test Bench Device) - PcieTxrx representing the testbench (PIPE PHY interface)
 *   MAC (Device Under Test) - PcieTxrx representing the MAC (PIPE MAC interface)
 *   MON (Monitor)           - PcieMonitor tracking the MAC
 * This file declares module 'test_top'. The 'test_top' module instantiates two 
 * instances of the 'dw_vip_pcie_txrx_if' SystemVerilog interface for MAC and PHY 
 * sides of hdl_interconnect and an instance of 'dw_vip_pcie_monitor_if' for
 * MAC monitor.
 * The 'test_top' module also instantiates the hdl_interconnect wrapper passing 
 * both SystemVerilog interfaces.
 */

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

    logic clk_upstream = 0;
    logic clk_downstream = 0;
    
    
    
    dw_vip_pcie_txrx_if pcie_mac_if1();
    dw_vip_pcie_txrx_if pcie_mac_if2();
    
    dw_vip_pcie_txrx_if pcie_phy_if1();
    dw_vip_pcie_txrx_if pcie_phy_if2();
    
    dw_vip_pcie_monitor_if pcie_mac_mon_if1();
    dw_vip_pcie_monitor_if pcie_mac_mon_if2();
    
    dw_vip_pcie_txrx_vmt_sv_wrapper pcie_mac1_txrx(pcie_mac_if1);
    dw_vip_pcie_txrx_vmt_sv_wrapper pcie_mac2_txrx2(pcie_mac_if2);
    
    dw_vip_pcie_txrx_vmt_sv_wrapper pcie_phy1_txrx(pcie_phy_if1);
    dw_vip_pcie_txrx_vmt_sv_wrapper pcie_phy2_txrx2(pcie_phy_if2);
    
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
        clk_upstream = ~clk_upstream;
        clk_downstream = ~clk_downstream;
      end  
    end
    

  initial begin
    $timeformat(-9, 1, "ns", 10);

    /** Connect the physical txrx and mon interfaces to the virtual ones */
    uvm_config_db#(virtual dw_vip_pcie_txrx_if)::set(uvm_root::get(),"uvm_test_top.m_env.mac_if1_agent", "txrx_if" ,pcie_mac_if1);
    uvm_config_db#(virtual dw_vip_pcie_txrx_if)::set(uvm_root::get(),"uvm_test_top.m_env.mac_if2_agent", "txrx_if" ,pcie_mac_if2);
    uvm_config_db#(virtual dw_vip_pcie_monitor_if)::set(uvm_root::get(),"uvm_test_top.m_env.mac_if1_agent", "monitor_if" ,pcie_mac_mon_if1);
    uvm_config_db#(virtual dw_vip_pcie_monitor_if)::set(uvm_root::get(),"uvm_test_top.m_env.mac_if2_agent", "monitor_if" ,pcie_mac_mon_if2);

   /** UVM Test phase initiator */
   run_test();   
 end

/** Connect system clock */
  assign pcie_mac_if1.clk = clk_upstream;
  assign pcie_phy_if1.clk = clk_upstream;

  assign pcie_mac_if2.clk = clk_downstream;
  assign pcie_phy_if2.clk = clk_downstream;
  assign pcie_mac_mon_if1.clk = clk_upstream;
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
  
endmodule