`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: TB_Mux16bit_16to1
// Create Date: 10/20/2015 06:07:50 PM
// ECE425L LAB #3
// Purpose: Develope a Verilog structural model for a 16-bit 16-to-1 MUX
//          Test Bench
//////////////////////////////////////////////////////////////////////////////////

module TB_Mux16bit_16to1();
    // inputs
    reg E;
    reg [3:0] S;
    reg [15:0] X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15;
    // outputs
    wire [15:0] Z;
    
    // 1. Instatiate Mux module
    //                               Enable,Select(3b),Input0(16b_allIO),Input1,Input2,Input3,Input4,Input5,Input6,Input7, Output
    Mux16bit_16to1       MUX1        (E,S,X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,Z);
    
    // 2. Stimulus for test bench
    initial 
        begin
           E=1; S=0; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128; X8=256; X15 = 1000;
        #5 E=1; S=1; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128; X8=256; X15 = 1000;
        #5 E=1; S=2; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128; X8=256; X15 = 1000;
        #5 E=1; S=3; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128; X8=256; X15 = 1000;
        #5 E=1; S=4; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128; X8=256; X15 = 1000;
        #5 E=1; S=5; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128; X8=256; X15 = 1000;
        #5 E=1; S=6; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128; X8=256; X15 = 1000;
        #5 E=1; S=7; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128; X8=256; X15 = 1000;
        #5 E=1; S=7; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128; X8=256; X15 = 1000;
        #5 E=1; S=15; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128; X8=256; X15 = 1000;
        end
endmodule
