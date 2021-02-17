#!/bin/sh
cd ../generated_tb/sim;
rm -rf csrc/ simv.vdb/ simv.daidir/ simv;
vcs +systemverilogext+.sv -sverilog -cm line+cond+fsm -covg_dump_range +acc +vpi +error+20 -lca -debug_all -assert enable_diag \
		+define+ASSERT_ON -y $VCS_HOME/packages/sva +libext+.v \
		+incdir+$VCS_HOME/packages/sva -P /opt/synopsys/Verdi_2014_03/share/PLI/VCS/LINUX64/novas.tab \
								/opt/synopsys/Verdi_2014_03/share/PLI/VCS/LINUX64/pli.a  -load libnovas.so:FSDBDumpCmd -full64 +libext+.v+.h+.vh+.vlib \
		-fsdb +vcs+vcdpluson -l comp.log -timescale=1ps/1ps -ntb_opts uvm-1.1 \
+incdir+../tb/include \
+incdir+../tb/upstream/sv \
+incdir+../tb/downstream/sv \
+incdir+../tb/top/sv \
+incdir+../tb/top_test/sv \
+incdir+../tb/top_tb/sv \
-F ../dut/files.f \
../tb/upstream/sv/upstream_pkg.sv \
../tb/upstream/sv/upstream_if.sv \
../tb/downstream/sv/downstream_pkg.sv \
../tb/downstream/sv/downstream_if.sv \
../tb/top/sv/top_pkg.sv \
../tb/top_test/sv/top_test_pkg.sv \
../tb/top_tb/sv/top_th.sv \
../tb/top_tb/sv/top_tb.sv \
-R +UVM_TESTNAME=top_test $* 
