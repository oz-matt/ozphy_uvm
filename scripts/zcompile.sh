#!/bin/sh
cd ../generated_tb/sim;
rm -rf csrc/ simv.vdb/ simv.daidir/ simv;
vcs -l compile.log -q +warn=noBCNACMBP -lca -debug_all -assert enable_diag -ntb_opts uvm -full64  -sverilog -timescale=1ns/10ps \
+incdir+../tb/include \
+incdir+../tb/upstream/sv \
+incdir+../tb/downstream/sv \
+incdir+../tb/top/sv \
+incdir+../tb/top_test/sv \
+incdir+../tb/top_tb/sv \
-F ../dut/files.f \
../tb/include/pkg/verif_pkg.sv \
../tb/upstream/sv/upstream_pkg.sv \
../tb/upstream/sv/upstream_if.sv \
../tb/downstream/sv/downstream_pkg.sv \
../tb/downstream/sv/downstream_if.sv \
../tb/top/sv/top_pkg.sv \
../tb/top_test/sv/top_test_pkg.sv \
../tb/top_tb/sv/top_th.sv \
../tb/top_tb/sv/top_tb.sv \
-R +UVM_TESTNAME=top_test $* ;
