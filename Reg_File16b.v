`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: Reg_File16b
// Create Date: 10/20/2015 04:37:58 PM
// Edit Date: 10/27/2015 Arthur J. Miller
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
    wire [15:0] Zdec;    //output of decoder 
    
    
    //***** 1. Instantiate 16, 16 bit registers
    //                                  Clock,AsyncReset,RegInput,RegOutput               
    //Register16b         REG[15:0]      (Clk  ,reset     ,In      ,Out);
    Register16b         REG0           (Clk  ,Clear     ,In[15:0]      ,Out[15:0]);
    Register16b         REG1           (Clk  ,Clear     ,In[31:16]      ,Out[31:16]);
    Register16b         REG2           (Clk  ,Clear     ,In[47:32]      ,Out[47:32]);
    Register16b         REG3           (Clk  ,Clear     ,In[63:48]      ,Out[63:48]);
    Register16b         REG4           (Clk  ,Clear     ,In[79:64]      ,Out[79:64]);
    Register16b         REG5           (Clk  ,Clear     ,In[95:80]      ,Out[95:80]);
    Register16b         REG6           (Clk  ,Clear     ,In[111:96]      ,Out[111:96]);
    Register16b         REG7           (Clk  ,Clear     ,In[127:112]      ,Out[127:112] );
    Register16b         REG8           (Clk  ,Clear     ,In[143:128]     ,Out[143:128]);
    Register16b         REG9           (Clk  ,Clear     ,In[159:144]      ,Out[159:144]);
    Register16b         REG10           (Clk  ,Clear     ,In[175:160]      ,Out[175:160]);
    Register16b         REG11           (Clk  ,Clear     ,In[191:176]     ,Out[191:176]);
    Register16b         REG12           (Clk  ,Clear     ,In[207:192]      ,Out[207:192]);
    Register16b         REG13           (Clk  ,Clear     ,In[223:208]      ,Out[223:208]);
    Register16b         REG14           (Clk  ,Clear     ,In[239:224]      ,Out[239:224]);
    Register16b         REG15           (Clk  ,Clear     ,In[255:240]      ,Out[255:240]);
    // Enable,Select(3b),Input1(16b_allIO,Input2,Input3,Input4,Input5,Input6,Input7,input8, Output 
    //27     Mux16bit_8to1       MUX1        (E,S[2:0],X[255:240],X[239:224],X[223:208],X[207:192],X[191:176],X[175:160],X[159:144],X[143:128],Z1); 
    //28     // Enable,Select(3b),Input1(16b_allIO,Input2,Input3,Input4,Input5,Input6,Input7,input8, Output 
    //29     Mux16bit_8to1       MUX2        (E,S[2:0],X[127:112],X[111:96],X[95:80],X[79:64],X[63:48],X[47:32],X[31:16],X[15:0],Z2); 
    //30     //                               Enable,Select,Input1,Input2,Output 

    //***** 2. Select the two registers to output using Aaddr & Baddr\
    // Wire each 16 bit reg into input of 1st 16bit mux. Using Aaddr as select. Output is 16bit out A
    //                               Enable,Select(3b),Input0(16b_allIO),Input1,Input2,Input3,Input4,Input5,Input6,Input7, Output
    Mux16bit_16to1       MUX1        (1,Aaddr,Out[15:0],Out[31:16],Out[47:32],Out[63:48],Out[79:64],Out[95:80],Out[111:96],Out[127:112],Out[143:128],Out[159:144],Out[175:160],Out[191:176],Out[207:192],Out[223:208],Out[239:224],Out[255:240],A);
    // Wire each 16 bit reg into input of 2nd 16bit mux. Using Baddr as select. Output is 16bit out B
    //                               Enable,Select(3b),Input0(16b_allIO),Input1,Input2,Input3,Input4,Input5,Input6,Input7, Output
    Mux16bit_16to1       MUX2        (1,Baddr,Out[15:0],Out[31:16],Out[47:32],Out[63:48],Out[79:64],Out[95:80],Out[111:96],Out[127:112],Out[143:128],Out[159:144],Out[175:160],Out[191:176],Out[207:192],Out[223:208],Out[239:224],Out[255:240],B);
    
    //***** 3. Decode and load input register using Caddr and Load
    // Instatiate 4to16 Decoder using Caddr as input. Wire output to enable pin of each 16bit2to1mux
    //                                         Enable,Input(4b),Output(16b)                
    Decoder_4to16         DECODER1            (Load     ,Caddr        ,Zdec);
    // Wire input Load to select input of 2to1 Mux. If Load = 1, select input C. Else select input Regi output
    // Wire 16b input C and  16b Regi output to each 16bit2to1mux
    // Wire 16b output of 16bit2to1mux to Input of regi
    //                                          Enable,Select,Input1,Input0,Output
    Mux16bit_2to1          MUX_0               (1     ,Zdec[0]  , Out[15:0]   , C   , In[15:0]);
    Mux16bit_2to1          MUX_1               (1     ,Zdec[1]  , Out[31:16]   , C   , In[31:16]);
    Mux16bit_2to1          MUX_2               (1     ,Zdec[2]  , Out[47:32]   , C   , In[47:32]);
    Mux16bit_2to1          MUX_3               (1     ,Zdec[3]  , Out[63:48]   , C   , In[63:48]);
    Mux16bit_2to1          MUX_4               (1     ,Zdec[4]  , Out[79:64]   , C   , In[79:64]);
    Mux16bit_2to1          MUX_5               (1     ,Zdec[5]  , Out[95:80]   , C   , In[95:80]);
    Mux16bit_2to1          MUX_6               (1     ,Zdec[6]  , Out[111:96]   , C   , In[111:96]);
    Mux16bit_2to1          MUX_7               (1     ,Zdec[7]  , Out[127:112]   , C   , In[127:112]);
    Mux16bit_2to1          MUX_8               (1     ,Zdec[8]  , Out[143:128]   , C   , In[143:128]);
    Mux16bit_2to1          MUX_9               (1     ,Zdec[9]  , Out[159:144]   , C   , In[159:144]);
    Mux16bit_2to1          MUX_10               (1     ,Zdec[10]  , Out[175:160]   , C   , In[175:160]);
    Mux16bit_2to1          MUX_11               (1     ,Zdec[11]  , Out[191:176]   , C   , In[191:176]);
    Mux16bit_2to1          MUX_12               (1     ,Zdec[12]  , Out[207:192]   , C   , In[207:192]);
    Mux16bit_2to1          MUX_13               (1     ,Zdec[13]  , Out[223:208]   , C   , In[223:208]);
    Mux16bit_2to1          MUX_14               (1     ,Zdec[14]  , Out[239:224]   , C   , In[239:224]);
    Mux16bit_2to1          MUX_15               (1     ,Zdec[15]  , Out[255:240]   , C   , In[255:240]);
    
        
endmodule
