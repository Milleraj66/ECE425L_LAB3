`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: Reg_File16b
// Create Date: 10/20/2015 04:37:58 PM
// ECE425L LAB #3
// Purpose: 16x16 register file
//          TODO : Fix 16to1 MUX
//          TODO : Create 4to16 Decoder (using 3to8 Decoder module)
//          TODO : Add asyncronous reset to D_FF

//////////////////////////////////////////////////////////////////////////////////

//                (RegOut1(16b),RegOut2(16b),RegIn(16b),RegAddressA,RegAddressB,RegAddressC,EnableLW,ClearAll,Clock) 
module Reg_File16b(A,B,C,Aaddr,Baddr,Caddr,Load,Clear,Clk);
    output [15:0] A,B;
    input [15:0] C;
    input [3:0] Aaddr,Baddr,Caddr;
    input Load,Clear,Clk;
    wire [255:0] In, Out; // 16 input 16bit MUX in/out
    
    
    //***** 1. Instantiate 16, 16 bit registers
    //                                  Clock,AsyncReset,RegInput,RegOutput               
    Register16b         REG[15:0]      (Clk  ,reset     ,In      ,Out);
    
    //***** 2. Select the two registers to output using Aaddr & Baddr\
    // Wire each 16 bit reg into input of 1st 16bit mux. Using Aaddr as select. Output is 16bit out A
    // Wire each 16 bit reg into input of 2nd 16bit mux. Using Baddr as select. Output is 16bit out B
    
    //***** 3. Decode and load input register using Caddr and Load
    // Instatiate 4to8 Decoder using Caddr as input. Wire output to enable pin of each 16bit2to1mux
    // Wire input Load to select input of 2to1 Mux. If Load = 1, select input C. Else select input Regi output
    // Wire 16b input C and  16b Regi output to each 16bit2to1mux
    // Wire 16b output of 16bit2to1mux to Input of regi
    
    //***** 4. Clear input will asyncronously reset each register to zero
    // Wire input Clear to each Registers reset pin
        
endmodule
