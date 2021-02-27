#!/bin/sh
cd ../sim;
rm -rf ../logs ../coverage csrc/ simv.daidir/ simv.vdb ucli.key vcdplus.vcd vc_hdrs.h .vcdplus.vcd.uvm;
mkdir ../logs ../coverage;
vcs -l ../logs/compile.log +warn=noBCNACMBP -lca -debug_all -ntb_opts uvm  -full64  -sverilog +define+SVT_UVM_TECHNOLOGY=1 -ntb -ntb_opts rvm -ntb_opts vera_compat -reportstats -timescale=10ps/10ps /home/iclab608/vipe/include/sverilog/svt_uvm_pkg.svi +define+SVT_NTB_DEBUG +define+NO_VMM_UVM_INTEROP -ntb_opts config=c.config   +define+WAVES=\"dve\" +plusarg_save +vpdports -I -notice +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir /home/iclab608/vipe/include/vera+/home/iclab608/vipe/src/vera+/home/iclab608/ozphy_uvm/env+/home/iclab608/ozphy_uvm/hdl_interconnect +incdir+/home/iclab608/vipe/include/{verilog,svtb,sverilog} +incdir+/home/iclab608/vipe/src/sverilog/vcs +incdir+/home/iclab608/ozphy_uvm/{env,dut,hdl_interconnect,tests} -f ../dut/files.f ../top.sv +UVM_TESTNAME=top_test $* ;
./simv +UVM_TESTNAME=top_test -gui +rad +v2k +prof -l ../logs/simulate.log run -assert dumpoff +vpdfile+vcdplus.vcd -vcd vcdplus.vcd;
