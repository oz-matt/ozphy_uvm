#!/bin/sh
cd ../sim;
rm -rf csrc/ simv.vdb/ simv.daidir/ simv;
vcs -l compile.log -q +warn=noBCNACMBP -lca -debug_all -assert enable_diag -ntb_opts uvm -full64  -sverilog +define+SVT_UVM_TECHNOLOGY=1 \
-ntb -ntb_opts rvm -ntb_opts vera_compat -timescale=1ns/10ps /home/iclab608/vipe/include/sverilog/svt_uvm_pkg.svi +define+SVT_NTB_DEBUG +define+NO_VMM_UVM_INTEROP -ntb_opts config=c.config   +define+WAVES=\"dve\" +plusarg_save +vpdports -I -notice +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir /home/iclab608/vipe/include/vera+/home/iclab608/vipe/src/vera +incdir+/home/iclab608/vipe/include/{verilog,svtb,sverilog} +incdir+/home/iclab608/vipe/src/sverilog/vcs \
+incdir+../src/include \
+incdir+../src/upstream/sv \
+incdir+../src/downstream/sv \
+incdir+../src/top/sv \
+incdir+../src/top_test/sv \
+incdir+../src/top_tb/sv \
-F ../dut/files.f \
/home/iclab608/vipe/include/svtb/Pcie.uvm.pkg \
../src/include/pkg/verif_pkg.sv \
../src/upstream/sv/upstream_pkg.sv \
../src/upstream/sv/upstream_if.sv \
../src/downstream/sv/downstream_pkg.sv \
../src/downstream/sv/downstream_if.sv \
../src/top/sv/top_pkg.sv \
../src/top_test/sv/top_test_pkg.sv \
../src/top_tb/sv/top_th.sv \
../src/top_tb/sv/top_tb.sv \
+UVM_TESTNAME=top_test $* ;
./simv +UVM_TESTNAME=top_test -gui +rad +v2k +prof -l ./logs/simulate.log run -assert dumpoff +vpdfile+vcdplus.vcd -vcd vcdplus.vcd;
