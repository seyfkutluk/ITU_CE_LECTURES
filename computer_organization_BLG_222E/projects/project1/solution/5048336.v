`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2022 04:51:21 PM
// Design Name: 
// Module Name: modules
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ALUSystem(
    input[1:0] RF_OutASel,
    input[1:0] RF_OutBSel, 
    input[1:0] RF_FunSel,
    input[3:0] RF_RegSel,
    input[3:0] ALU_FunSel,
    input[1:0] ARF_OutCSel, 
    input[1:0] ARF_OutDSel, 
    input[1:0] ARF_FunSel,
    input[2:0] ARF_RegSel,
    input IR_LH,
    input IR_Enable,
    input[1:0] IR_Funsel,
    input Mem_WR,
    input Mem_CS,
    input[1:0] MuxASel,
    input[1:0] MuxBSel,
    input MuxCSel,
    input Clock
    );
    
    wire[7:0] AOut,BOut; //Register file out
    wire[7:0] ALUOut; //ALU out
    wire[3:0] ALUOutFlag; //ALU out flag
    wire[7:0] ARF_COut, Address; //ARF out
    wire[7:0] MemoryOut;
    wire[15:0] IROut;
    wire[7:0] MuxAOut, MuxBOut, MuxCOut;
//    wire [7:0] irout8;
//    assign irout8 = IROut[7:0];
    registerFile registerFile(MuxAOut, RF_OutASel, RF_OutBSel, RF_FunSel, RF_RegSel,Clock, AOut,BOut);
    muxc muxC(ARF_COut, AOut, MuxCSel, MuxCOut);
    alu ALU(MuxCOut, BOut, ALU_FunSel, ALUOut, ALUOutFlag);
    Memory MEM(Address, ALUOut, Mem_WR, Mem_CS,Clock,MemoryOut);
    addressRegisterFile ARF(MuxBOut, ARF_OutCSel, ARF_OutDSel, ARF_FunSel, ARF_RegSel, Clock,ARF_COut, Address);
    mux muxB(8'bxxxxxxxx,IROut[7:0], MemoryOut,ALUOut,MuxBSel,MuxBOut );
    registerIR IR(MemoryOut, IR_LH, IR_Enable, IR_Funsel, Clock, IROut);
    mux muxA(IROut[7:0], MemoryOut,ARF_COut,ALUOut,MuxASel,MuxAOut );

endmodule

module Memory(
    input wire[7:0] address,
    input wire[7:0] data,
    input wire wr,
    input wire cs,
    input wire clock,
    output reg[7:0] o
);

    reg[7:0] RAM_DATA[0:255];
    
    initial $readmemh("RAM.mem", RAM_DATA);
    
    always@(*) begin
        o = ~wr && ~cs ? RAM_DATA[address] : 8'hz;
    end
    
    always@(posedge clock) begin
        if(wr && ~cs) begin
            RAM_DATA[address] <= data;
        end
    end
endmodule


module funcRegister8( CLK, E, Din, Dout, FunSel);
    
    input CLK;
    input E;
    input [7:0] Din; // Data input for load
    output reg [7:0] Dout;
    input [1:0] FunSel;
        
    always @(posedge CLK) begin
        
        if(E) begin // Enable is on
            case(FunSel)
                2'b00: 
                    Dout <= Dout - 1; // decrement
                2'b01: 
                    Dout <= Dout + 1; // increment
                2'b10:
                    Dout <= Din; // load
                2'b11: 
                    Dout <= 8'b00000000; // clear
                default:
                    begin end
            endcase // switch case end
        end // if end
        
        else // Enable is off 
            Dout = Dout; // retain value
    end // always end
               
endmodule

module funcRegister16( CLK, E, Din, Dout, FunSel);
    
    input CLK;
    input E;
    input [15:0] Din; // Data input for load
    output reg [15:0] Dout;
    input [1:0] FunSel;
        
    always @(posedge CLK) begin
        
        if(E) begin // Enable is on
            case(FunSel)
                2'b00: 
                    Dout <= Dout - 1; // decrement
                2'b01: 
                    Dout <= Dout + 1; // increment
                2'b10:
                    Dout <= Din; // load
                2'b11: 
                    Dout <= 16'b0000000000000000; // clear
                default:
                    begin end
            endcase // switch case end
        end // if end
        
        else // Enable is off 
            Dout = Dout; // retain value
    end // always end
               
endmodule

module registerFile(Data_in, OutASel, OutBSel, FunSel, RegSel, CLK, Data_out_A, Data_out_B);
    
    input CLK;
    input [1:0] OutASel;
    input [1:0] OutBSel;
    input [1:0] FunSel;
    input [3:0] RegSel;
    input [7:0] Data_in; // Data input for load
    output wire [7:0] Data_out_A; // data out A
    output wire [7:0] Data_out_B; // data out B
    wire [7:0] temp0,temp1,temp2,temp3;
    
    funcRegister8 reg1 (CLK, ~RegSel[0], Data_in, temp0, FunSel);
    funcRegister8 reg2 (CLK,  ~RegSel[1], Data_in, temp1, FunSel);  
    funcRegister8 reg3 (CLK,  ~RegSel[2], Data_in, temp2, FunSel);  
    funcRegister8 reg4 (CLK,  ~RegSel[3], Data_in, temp3, FunSel);   
    
    mux MUX1(temp3, temp2, temp1, temp0, OutASel, Data_out_A);
    mux MUX2(temp3, temp2, temp1, temp0, OutBSel, Data_out_B);

endmodule

module addressRegisterFile(Data_in, OutCSel, OutDSel, FunSel, RegSel, CLK, Data_out_C, Data_out_D);
    input CLK;
    input [1:0] OutCSel;
    input [1:0] OutDSel;
    input [1:0] FunSel;
    input [2:0] RegSel;
    input [7:0] Data_in; // Data input for load
    output  [7:0] Data_out_C; // data out A
    output  [7:0] Data_out_D; // data out B
    wire [7:0] temp1, temp2, temp3;
    
    funcRegister8 PC (CLK, ~RegSel[0], Data_in, temp1, FunSel);
    funcRegister8 AR (CLK, ~RegSel[1], Data_in, temp2, FunSel);  
    funcRegister8 SP (CLK, ~RegSel[2], Data_in, temp3, FunSel); 
   
    mux MUX1(temp1, temp1,temp2,temp3, OutCSel, Data_out_C);
    mux MUX2(temp1, temp1,temp2,temp3, OutDSel, Data_out_D);
endmodule

module registerIR(IRin, LowHigh, Enable, FunSel, CLK, IRout);
    input [7:0] IRin;
    input LowHigh;
    input Enable;
    input [1:0] FunSel;
    input CLK;
    output reg [15:0] IRout;

    always @(posedge CLK) begin         
            if(Enable)
            begin // Enable is on
                case(FunSel)
                    2'b00: 
                        IRout <= IRout - 1; // decrement
                    2'b01: 
                        IRout <= IRout + 1; // increment
                    2'b10:
                    begin
                        if(LowHigh)
                            IRout[7:0] = IRin;
                        else
                            IRout[15:8] = IRin;
                    end
                    2'b11: 
                        IRout <= 16'b0000000000000000; // clear
                    default:
                        begin end
                endcase // switch case end
            end // if end
            
        end // always end
endmodule

module alu( input[7:0] A,input[7:0] B,input[3:0] FunSel,output[7:0] OutAlu, output[3:0] ZCNO ); 
    reg[7:0] outPut;
    reg[3:0] ZCNO1;
    reg[8:0] overflow;
    assign OutAlu = outPut;
    assign ZCNO = ZCNO1;
    wire C;
    assign C = ZCNO1[2];
    always@ (*)
    begin
        case(FunSel)
            4'b0000: begin outPut = A; end
            4'b0001: begin outPut = B; end
            4'b0010: begin outPut = ~A; end
            4'b0011: begin outPut = ~B; end
            4'b0100: begin
                        overflow = A+B;
                        outPut = overflow[7:0];
                        ZCNO1[2] = overflow[8];
                        if (A>0&&B<0) begin ZCNO1[0]= overflow[7] ? 1:0 ; end if (A<0&&B>0) begin ZCNO1[0]= overflow[7] ?  1:0; end else begin ZCNO1[0]=1; end
                        end
            4'b0101: begin     
                        if(A==1) begin overflow = A+B+C; end else begin overflow = A+B; end
                        outPut = overflow[7:0];
                        ZCNO1[2] = overflow[8];
                        if (A>0&&B<0) begin ZCNO1[0]= overflow[7] ? 1:0 ; end if (A<0&&B>0) begin ZCNO1[0]= overflow[7] ?  1:0; end else begin ZCNO1[0]=1; end
                        end
            4'b0110: begin
                        overflow = A+ ~B + 1;
                        outPut = overflow[7:0];
                        ZCNO1[2] = overflow[8];
                        if (A>0&&B<0) begin ZCNO1[0]= overflow[7] ? 1:0 ; end if (A<0&&B>0) begin ZCNO1[0]= overflow[7] ?  1:0; end else begin ZCNO1[0]=1; end
                        end
            4'b0111: begin
                        outPut = A&B;
                        end
            4'b1000: begin outPut = A|B; end
            4'b1001: begin outPut = A^B; end
            4'b1010: begin
                        outPut = {A[6:0],1'b0};
                        ZCNO1[2] = A[7];
                        end
            4'b1011: begin
                        outPut = {1'b0,A[7:1]};
                        ZCNO1[2] = A[0];
                        end
            4'b1100: begin  
                        outPut = {A[6:0],1'b0};
                        if(A[7]!=outPut[7])begin ZCNO1[0]=1; end else begin ZCNO1[0]=0;end 
                        end  
            4'b1101: begin outPut = {A[7],A[7:1]}; end
            4'b1110: begin  
                        outPut = {A[6:0],A[7]};
                        ZCNO1[2] = A[7];
                        if(A[7]!=outPut[7])begin ZCNO1[0] = 1; end else begin ZCNO1[0]=0;end
                        end
            4'b1111: begin  
                        outPut = {A[0],A[7:1]};
                        ZCNO1[2] = A[0];
                        if(A[7]!=outPut[7])begin ZCNO1[0] = 1; end else begin ZCNO1[0]=0;end
                        end                                                                               
        endcase
                        if(outPut==0) begin ZCNO1[3] = 1; end
                        if(outPut<0) begin ZCNO1[1] = 1; end else begin ZCNO1[1] = 0; end
    end
endmodule

module mux ( input [7:0] a, input [7:0] b, input [7:0] c, input [7:0] d, input [1:0] sel,output [7:0] out); 

 assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a); 

endmodule

module muxc ( 
input [7:0] a, 
input [7:0] b, 
input [0:0] sel,
output [7:0] out); 
    assign out=(sel)?b:a;
endmodule



