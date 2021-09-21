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

// tesbenches
alu_tb.sv

// current testbench
-top alu_tb