// 64 bit version
-64

// options
// -nclibdirpath <path to xcelium.d>
-access rwc

// default timescale
-timescale 1ns/100ps

// include directory
-incdir ../src

// compile files
../src/rv_pkg.sv
../src/rv_alu.sv
../src/counter.sv
../src/regfile.sv
../src/rv_top.sv

// tesbenches
alu_tb.sv
counter_tb.sv
regfile_tb.sv
rv_top_tb.sv
DFFRAM.v

// current testbench (pass on command line)
// -top alu_tb
// -top counter_tb
// -top regfile_tb
// -top rv_top_tb