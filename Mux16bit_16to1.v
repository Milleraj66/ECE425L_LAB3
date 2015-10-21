`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: Mux16bit_16to1
// Create Date: 10/20/2015 05:48:42 PM
// ECE425L LAB #3
// Purpose: Develope a Verilog structural model for a 16-bit 16-to-1 MUX

// Variables:
//          E : Enable Input
//          S : Selecting Input
//          X1 X0 : X0 is first 16-bit input
//                  X1 is second 16bit input
//          Z : 16-bit selected output

//////////////////////////////////////////////////////////////////////////////////

//                   Enable,Select(3b),Input1(16b_allIO,Input2,Input3,Input4,Input5,Input6,Input7,input8, Output
module Mux16bit_16to1(E,S,X,Z);
    input E;
    input [3:0] S;
    input [255:0] X;
    output [15:0] Z;
    wire [15:0] Z1, Z2;
    
    // Enable,Select(3b),Input1(16b_allIO,Input2,Input3,Input4,Input5,Input6,Input7,input8, Output
    Mux16bit_8to1       MUX1        (E,S[2:0],X[255:240],X[239:224],X[223:208],X[207:192],X[191:176],X[175:160],X[159:144],X[143:128],Z1);
    // Enable,Select(3b),Input1(16b_allIO,Input2,Input3,Input4,Input5,Input6,Input7,input8, Output
    Mux16bit_8to1       MUX2        (E,S[2:0],X[127:112],X[111:96],X[95:80],X[79:64],X[63:48],X[47:32],X[31:16],X[15:0],Z2);
    //                               Enable,Select,Input1,Input2,Output
    Mux16bit_2to1       MUX3        (E     ,   S[3]  , Z1   , Z2   , Z);    
endmodule

