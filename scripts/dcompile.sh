#!/bin/sh
cd ../generated_tb/sim;
rm -rf csrc/ simv.vdb/ simv.daidir/ simv;
vcs -l compile.log -q +warn=noBCNACMBP -lca -debug_all -assert enable_diag -ntb_opts uvm -full64  -sverilog +define+SVT_UVM_TECHNOLOGY=1 \
-ntb -ntb_opts rvm -ntb_opts vera_compat -timescale=1ns/10ps /home/iclab608/vipe/include/sverilog/svt_uvm_pkg.svi +define+SVT_NTB_DEBUG +define+NO_VMM_UVM_INTEROP -ntb_opts config=c.config   +define+WAVES=\"dve\" +plusarg_save +vpdports -I -notice +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir /home/iclab608/vipe/include/vera+/home/iclab608/vipe/src/vera+/home/iclab608/vipe/examples/svtb/pcie/tb_pcie_uvm_basic_sys/env+/home/iclab608/vipe/examples/svtb/pcie/tb_pcie_uvm_basic_sys/hdl_interconnect +incdir+/home/iclab608/vipe/include/{verilog,svtb,sverilog} +incdir+/home/iclab608/vipe/src/sverilog/vcs +incdir+/home/iclab608/vipe/examples/svtb/pcie/tb_pcie_uvm_basic_sys/{../env,env,dut,hdl_interconnect,tests} \
+incdir+../tb/include \
+incdir+../tb/upstream/sv \
+incdir+../tb/downstream/sv \
+incdir+../tb/top/sv \
+incdir+../tb/top_test/sv \
+incdir+../tb/top_tb/sv \
-F ../dut/files.f \
/home/iclab608/vipe/include/svtb/Pcie.uvm.pkg \
../tb/include/pkg/verif_pkg.sv \
../tb/upstream/sv/upstream_pkg.sv \
../tb/upstream/sv/upstream_if.sv \
../tb/downstream/sv/downstream_pkg.sv \
../tb/downstream/sv/downstream_if.sv \
../tb/top/sv/top_pkg.sv \
../tb/top_test/sv/top_test_pkg.sv \
../tb/top_tb/sv/top_th.sv \
../tb/top_tb/sv/top_tb.sv \
+UVM_TESTNAME=top_test $* ;
./simv +UVM_TESTNAME=top_test -gui +rad +v2k +prof -l ./logs/simulate.log run -assert dumpoff +vpdfile+vcdplus.vcd -vcd vcdplus.vcd;
