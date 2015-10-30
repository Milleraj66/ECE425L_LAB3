`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: TB_Reg_File16b
// Create Date: 10/27/2015 06:37:50 PM
// ECE425L LAB #3
// Purpose: Testbench for 16x16bit Register File

//      TODO: Simulation output shows all of A,B as Red X
//////////////////////////////////////////////////////////////////////////////////

module TB_Reg_File16b();
    wire [15:0] A,B;
    reg [15:0] C;
    reg [3:0] Aaddr,Baddr,Caddr;
    reg Load,Clear,Clk;
    //                              (RegOut1(16b),RegOut2(16b),RegIn(16b),RegAddressA,RegAddressB,RegAddressC,EnableLW,ClearAll,Clock) 
    Reg_File16b         REGFILE     (A,B,C,Aaddr,Baddr,Caddr,Load,Clear,Clk);
    
    //Testbench Stimulus
    initial 
        begin
        Clk = 0; 
        
        #5 Clk = 1; C=5;Aaddr=0;Baddr=1;Caddr=0;Load=1;Clear=1;
        Clk = 0;
        #5 Clk = 1; C=6;Aaddr=0;Baddr=1;Caddr=1;Load=1;Clear=1;
        Clk = 0;
        #5 Clk = 1; C=7;Aaddr=0;Baddr=1;Caddr=0;Load=0;Clear=1;
        Clk = 0;
        
        #5 Clk = 1; C=1;Aaddr=0;Baddr=2;Caddr=3;Load=1;Clear=1;
        Clk = 0;
        #5 Clk = 1; C=2;Aaddr=0;Baddr=2;Caddr=3;Load=1;Clear=1;
        Clk = 0;
        #5 Clk = 1; C=3;Aaddr=0;Baddr=2;Caddr=3;Load=0;Clear=1;
        Clk = 0;
        #5 Clear=1;
        end
endmodule
