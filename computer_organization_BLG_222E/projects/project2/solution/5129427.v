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

    registerFile registerFile(MuxAOut, RF_OutASel, RF_OutBSel, RF_FunSel, RF_RegSel,Clock, AOut,BOut);
    muxc muxC(ARF_COut, AOut, MuxCSel, MuxCOut);
    alu ALU(MuxCOut, BOut, ALU_FunSel, ALUOut, ALUOutFlag);
    Memory MEM(Address, ALUOut, Mem_WR, Mem_CS,Clock,MemoryOut);
    addressRegisterFile ARF(MuxBOut, ARF_OutCSel, ARF_OutDSel, ARF_FunSel, ARF_RegSel, Clock,ARF_COut, Address);
    mux muxB(8'bxxxxxxxx ,IROut[7:0], MemoryOut ,ALUOut,MuxBSel,MuxBOut);
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
    output reg [7:0] Dout=0;
    input [1:0] FunSel;

    always @(posedge CLK) begin
        //$display("FunSel register  %d",FunSel);
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

    funcRegister8 reg1 (CLK, ~RegSel[3], Data_in, temp0, FunSel);
    funcRegister8 reg2 (CLK,  ~RegSel[2], Data_in, temp1, FunSel);
    funcRegister8 reg3 (CLK,  ~RegSel[1], Data_in, temp2, FunSel);
    funcRegister8 reg4 (CLK,  ~RegSel[0], Data_in, temp3, FunSel);

    mux MUX1( temp0,temp1, temp2, temp3, OutASel, Data_out_A);
    mux MUX2( temp0,temp1, temp2, temp3,  OutBSel, Data_out_B);

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

    funcRegister8 PC (CLK, ~RegSel[2], Data_in, temp1, FunSel);
    funcRegister8 AR (CLK, ~RegSel[1], Data_in, temp2, FunSel);
    funcRegister8 SP (CLK, ~RegSel[0], Data_in, temp3, FunSel);

    mux MUX1( temp1, temp1,temp2, temp3, OutCSel, Data_out_C);
    mux MUX2( temp1, temp1,temp2, temp3, OutDSel, Data_out_D);
endmodule

module registerIR(IRin, LowHigh, Enable, FunSel, CLK, IRout);
    input [7:0] IRin;
    input LowHigh;
    input Enable;
    input [1:0] FunSel;
    input CLK;
    output reg [15:0] IRout;

    always @(negedge CLK) begin
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
        if(outPut==0) begin ZCNO1[3] = 1; end else begin ZCNO1[3]=0; end
        if(outPut[7]==1) begin ZCNO1[1] = 1; end else begin ZCNO1[1] = 0; end
    end
endmodule

module mux ( input [7:0] a, input [7:0] b, input [7:0] c, input [7:0] d, input [1:0] sel,output [7:0] out);

    assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);

endmodule

module muxc (
    input [7:0] a,
    input [7:0] b,
    input  sel,
    output [7:0] out);
    assign out=(sel)?b:a;
endmodule

module sequentialCounter(clk,reset,count);
    //define input and ouput ports
    input clk,reset;
    output reg signed [3:0] count=-1;

    //always block will be executed at each and every positive edge of the clock
    always@(posedge clk)

    begin
        $display("Input Values: %d", count );
        if(reset) //Set Counter to Zero
            count <= 0;
        else //count down
            count <= count + 1;
    end
endmodule

module controlUnit(
    input [15:0] instructionRegister,
    output reg [3:0] zcno,
    input [3:0] clockCycle,
    output  reg[1:0] RF_OutASel,
    output reg[1:0] RF_OutBSel,
    output reg[1:0] RF_FunSel,
    output reg[3:0] RF_RegSel,
    output reg[3:0] ALU_FunSel,
    output reg[1:0] ARF_OutCSel,
    output reg[1:0] ARF_OutDSel,
    output reg[1:0] ARF_FunSel,
    output reg[2:0] ARF_RegSel,
    output reg IR_LH,
    output reg IR_Enable,
    output reg[1:0] IR_Funsel,
    output reg Mem_WR, // ?
    output reg Mem_CS, // ?,
    output reg[1:0] MuxASel,
    output reg[1:0] MuxBSel,
    output reg MuxCSel,
    output reg reset

);
    wire [3:0] opcodeCU;
    assign opcodeCU = instructionRegister[15:12];

    wire adressingModeCU;
    assign adressingModeCU = instructionRegister[10];

    wire [1:0] regselCU;
    assign regselCU = instructionRegister[9:8];

    wire [1:0] adressCU;
    assign adressCU = instructionRegister[7:0];

    wire [3:0] destreg;
    assign destreg = instructionRegister[11:8];

    wire [3:0] srcreg1;
    assign srcreg1 = instructionRegister[7:4];

    wire [3:0] srcreg2;
    assign srcreg2 = instructionRegister[3:0];

    reg [3:0] ALU_Decode; // Used for AND, OR, ADD operations
    reg [3:0] RF_RegSel_Decode; // Used in LD operation
    
    //reg Z = 1'b1;
    wire Z,C,N,O;
    assign Z = zcno[3];
    assign C = zcno[2];
    assign N = zcno[1];
    assign O = zcno[0];

    always @(*)
    begin
    // fetch part of the system
        if(clockCycle==3'b000) begin 
            RF_RegSel=4'b1111;
            RF_FunSel=2'b11;
            ARF_OutDSel=2'b00;
            ARF_RegSel=3'b011;
            ARF_FunSel=2'b01;
            Mem_WR=0;
            Mem_CS=0;
            IR_Enable=1;
            IR_Funsel=2'b10;
            IR_LH=1;
            reset=0;
        end

        if(clockCycle==3'b001) begin
            RF_RegSel=4'b1111;
            RF_FunSel=2'b11;
            ARF_OutDSel=2'b00;
            ARF_RegSel=3'b011;
            ARF_FunSel=2'b01;
            Mem_WR=0;
            Mem_CS=0;
            IR_Enable=1;
            IR_Funsel=2'b10;
            IR_LH=0;
            reset=0;
        end
    end
    
    always @(*)
    begin
        if(opcodeCU==4'b0001) begin // For load operation
            case(regselCU)
                2'b00: begin
                    RF_RegSel_Decode = 4'b0111;
                end
                2'b01: begin
                    RF_RegSel_Decode = 4'b1011;
                end
                2'b10: begin
                    RF_RegSel_Decode = 4'b1101;
                end
                2'b11: begin
                    RF_RegSel_Decode = 4'b1110;
                end
            endcase
        end
        else if(opcodeCU == 4'b0100)
            ALU_Decode = 4'b0111;
        else if(opcodeCU == 4'b0101)
            ALU_Decode = 4'b1000;
        else if(opcodeCU == 4'b0111)
            ALU_Decode = 4'b0100;
    end

    always @(*)
    begin
        reset = 0;
        
        case(opcodeCU)
            4'b0000: begin // BRA 
                if(clockCycle==2 && adressingModeCU==1'b1) begin
                    $display("BRA");
                    MuxBSel = 2'b01;
                    ARF_RegSel = 3'b011;
                    ARF_FunSel = 2'b10;
                    Mem_CS = 2'b1;
                    IR_Enable = 1'b0;
                    RF_RegSel = 4'b1111;
                    reset=1;
                end
                else if(clockCycle==2 && adressingModeCU==1'b0) begin
                    //reset=1;
                end            
            end

            4'b0001: begin // LD
                if(clockCycle==2 && adressingModeCU==1'b0) begin
                    $display("LD");
                    MuxASel = 2'b01; //memory output
                    ARF_OutDSel = 2'b10;
                    Mem_WR = 1'b0;
                    Mem_CS = 1'b0;
                    ARF_RegSel = 3'b111;
                    IR_Enable = 1'b0;
                    RF_FunSel = 2'b10;
                    RF_RegSel = RF_RegSel_Decode;
                    reset = 1;
                end
                if(clockCycle==2 && adressingModeCU==1'b1) begin
                    $display("LD");
                    MuxASel = 2'b00; // IR out address part
                    Mem_CS = 1'b1;
                    ARF_RegSel = 3'b111;
                    IR_Enable = 1'b0;
                    RF_FunSel = 2'b10;
                    RF_RegSel = RF_RegSel_Decode;
                    reset = 1;
                end            
            end

            4'b0010: begin // ST
                if(clockCycle==2 && adressingModeCU==1'b0) begin
                    $display("ST");
                    MuxCSel = 1'b1;
                    
                    RF_OutASel = regselCU;
                    
                    ARF_OutDSel = 2'b10; // AR Register
                    Mem_WR = 1'b1;
                    Mem_CS = 1'b0;
                    ARF_RegSel = 3'b111;
                    IR_Enable = 1'b0;
                    RF_RegSel = 3'b111;
                    ALU_FunSel=4'b0000;
                    reset=1;
                end
                if(clockCycle==2 && adressingModeCU==1'b1) begin
                    reset=1;
                end            
            end
            
            4'b0011: begin // MOV
                if(clockCycle == 2) begin
                    $display("MOV operation");
                    if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b00) begin // ARF => ARF
                        ARF_OutCSel = srcreg1[1:0];
                        MuxCSel = 1'b0;
                        ALU_FunSel = 4'b0000; // Just pass the srcreg1 value
                        MuxBSel = 2'b11;
                        ARF_FunSel = 2'b10;
                        
                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        IR_Enable = 0;
                        RF_RegSel = 4'b1111;
                        Mem_CS = 1'b1;
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b01) begin // ARF TO RF
                        ARF_OutCSel = srcreg1[1:0];
                        MuxASel = 2'b10;
                        RF_FunSel = 2'b10;
                        // no need for ALU
                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        IR_Enable = 0;
                        Mem_CS = 1'b1;
                        ARF_RegSel = 4'b1111;
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b00) begin // RF to ARF
                        MuxCSel = 1'b1;
                        MuxBSel =  2'b11;
                        RF_OutASel = srcreg1[1:0];
                        ARF_FunSel = 2'b10;
                        ALU_FunSel = 4'b0000;
                            
                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        reset = 1;
                        IR_Enable = 0;
                        RF_RegSel = 4'b1111;
                        Mem_CS = 1'b1;

                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b01) begin // RF to RF
                        MuxCSel = 1'b1;
                        MuxASel = 2'b11;
                        RF_OutASel = srcreg1[1:0];
                        Mem_CS = 1'b1;

                        ARF_RegSel = 4'b1111;
                        reset = 1;
                        IR_Enable = 0;

                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        RF_FunSel = 2'b10;
                        ALU_FunSel = 4'b0000;
                    end
                end
            end
    
            4'b0100, 4'b0101, 4'b0111: // AND, OR, ADD operations
            begin // AND OPERATION
                if(clockCycle == 2) begin
                    if(destreg[3:2] == 2'b00 && srcreg1[3:2] == 2'b01 && srcreg2[3:2] == 2'b01) begin // ARF <= RF (operation) RF 
                        // Only one clock cycle is enough for this part
                        RF_OutASel = srcreg1[1:0];
                        RF_OutBSel = srcreg2[1:0];
                        
                        MuxCSel = 1'b1;
                        ALU_FunSel = ALU_Decode; // SRCREG1 AND SRCREG2
                        
                        MuxBSel = 2'b11;
                        
                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;
                        
                        ARF_FunSel = 2'b10; // Load operation
                        
                        RF_RegSel = 4'b1111;
                        Mem_CS = 1'b1;
                        IR_Enable = 1'b0;
                        reset = 1;
                    end
                    else if(destreg[3:2] == 2'b01 && srcreg1[3:2] == 2'b01 && srcreg2[3:2] == 2'b01) begin // RF <= RF & RF
                    // Only one clock cycle is enough for this part
                        RF_OutASel = srcreg1[1:0];
                        RF_OutBSel = srcreg2[1:0];
                        MuxCSel = 2'b1;
                        
                        ALU_FunSel = ALU_Decode; // SRCREG1 AND SRCREG2
                        
                        MuxASel = 2'b11;
                        
                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;
                        
                        RF_FunSel = 2'b10;
                        
                        Mem_CS = 1'b1;
                        ARF_RegSel = 3'b111;
                        IR_Enable = 1'b0;
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b00 && srcreg2[3:2] == 2'b01) begin // ARF or RF <= ARF & RF
                        
                        ARF_OutCSel = srcreg1[1:0];
                        MuxCSel = 1'b0;
                        RF_OutBSel = srcreg2[1:0];
                        
                        ALU_FunSel = ALU_Decode; // SRCREG1 (operation) SRCREG2
                        Mem_CS = 1'b1;
                        IR_Enable = 0;      
                        
                        if(destreg[3:2] == 2'b00) begin
                            // destination is ARF, no need for RF
                            RF_RegSel = 4'b1111;
                            MuxBSel = 2'b11;
                            ARF_FunSel = 2'b10;
                            
                            if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                                ARF_RegSel = 3'b011;
                            if(destreg[1:0] == 2'b10)
                                ARF_RegSel = 3'b101;
                            if(destreg[1:0] == 2'b11)
                                ARF_RegSel = 3'b110;
                        end
                        else if(destreg[3:2] == 2'b01) begin
                            // destination is RF, no need for ARF
                            ARF_RegSel = 3'b111;
                            RF_FunSel = 2'b10;
                            MuxASel = 2'b11;
                            
                            if(destreg[1:0] == 2'b00)
                                RF_RegSel = 4'b0111;
                            if(destreg[1:0] == 2'b01)
                                RF_RegSel = 4'b1011;
                            if(destreg[1:0] == 2'b10)
                                RF_RegSel = 4'b1101;
                            if(destreg[1:0] == 2'b11)
                                RF_RegSel = 4'b1110;
                        end
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b00 && srcreg2[3:2] == 2'b00) begin // ARF/RF <= ARF & ARF
                    // In first clock cycle load register file with the value
                    // of ARF
                        ARF_OutCSel = srcreg1[1:0];
                        MuxASel = 2'b10;
                        RF_RegSel = 4'b0111; // opening first register to store ARF C Out
                        RF_FunSel = 2'b10; // Load Operation
                        
                        ARF_RegSel = 3'b111; // Closing ARF
                        IR_Enable = 0;
                        Mem_CS = 1'b1;
                    end
                    else if(srcreg1[3:2] == 2'b01 && srcreg2[3:2] == 2'b00) begin // ARF or RF <= RF & ARF
                         ARF_OutCSel = srcreg2[1:0];
                         MuxCSel = 1'b0;
                         RF_OutBSel = srcreg1[1:0];
                         
                         ALU_FunSel = ALU_Decode;
                         Mem_CS = 1'b1;
                         IR_Enable = 0;     
                         
                         if(destreg[3:2] == 2'b00) begin
                             // destination is ARF, no need for RF
                             RF_RegSel = 4'b1111;
                             MuxBSel = 2'b11;
                             ARF_FunSel = 2'b10;
                             
                             if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                                 ARF_RegSel = 3'b011;
                             if(destreg[1:0] == 2'b10)
                                 ARF_RegSel = 3'b101;
                             if(destreg[1:0] == 2'b11)
                                 ARF_RegSel = 3'b110;
                         end
                         else if(destreg[3:2] == 2'b01) begin
                            ARF_RegSel = 3'b111;
                            MuxASel = 2'b11;
                            RF_FunSel = 2'b10;
                            
                            if(destreg[1:0] == 2'b00)
                                RF_RegSel = 4'b0111;
                            if(destreg[1:0] == 2'b01)
                                RF_RegSel = 4'b1011;
                            if(destreg[1:0] == 2'b10)
                                RF_RegSel = 4'b1101;
                            if(destreg[1:0] == 2'b11)
                                RF_RegSel = 4'b1110;
                         end
                         
                         reset = 1;
                    end
                end
                else if(clockCycle == 3) begin
                    if(srcreg1[3:2] == 2'b00 && srcreg2[3:2] == 2'b00) begin // ARF (OP) ARF
                        // In first clock cycle load register file with the value
                        // of ARF
                        ARF_OutCSel = srcreg2[1:0];
                        MuxCSel = 2'b0;
                        ALU_FunSel = ALU_Decode; // SRCREG1 operation SRCREG2
                        RF_OutBSel = 2'b00; // we transferred srcreg1 to clock cycle happened before
                        
                        if(destreg[3:2] == 2'b00) begin
                        // if dest reg is in ARF
                            MuxBSel = 2'b11; // Alu Out
                            ARF_FunSel = 2'b10; // Load operation
                            
                            if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                                ARF_RegSel = 3'b011;
                            if(destreg[1:0] == 2'b10)
                                ARF_RegSel = 3'b101;
                            if(destreg[1:0] == 2'b11)
                                ARF_RegSel = 3'b110;
                            
                        end
                        else if(destreg[3:2] == 2'b01) begin
                        // if dest reg is in RF
                            MuxASel = 2'b11; // ALU Out
                            RF_FunSel = 2'b10; // Load operation
                            
                            if(destreg[1:0] == 2'b00)
                                RF_RegSel = 4'b0111;
                            if(destreg[1:0] == 2'b01)
                                RF_RegSel = 4'b1011;
                            if(destreg[1:0] == 2'b10)
                                RF_RegSel = 4'b1101;
                            if(destreg[1:0] == 2'b11)
                                RF_RegSel = 4'b1110;
                        end
                        
                        reset = 1;
                    end
                end
            end
            
            4'b0110: begin // NOT
                if(clockCycle == 2) begin
                    $display("NOT operation");
                    if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b00) begin // ARF to ARF
                        ARF_OutCSel = srcreg1[1:0];
                        MuxCSel = 1'b0;
                        ALU_FunSel = 4'b0010; // NOT operation
                        MuxBSel = 2'b11;
                        Mem_CS = 1'b1;

                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        IR_Enable = 0;
                        RF_RegSel = 4'b1111;
                        ARF_FunSel = 2'b10;
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b01) begin // ARF TO RF
                        ARF_OutCSel = srcreg1[1:0];
                        MuxCSel = 1'b0;
                        ALU_FunSel = 4'b0010; // NOT operation
                        MuxASel = 2'b11;
                        Mem_CS = 1'b1;
                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        IR_Enable = 0;
                        RF_FunSel = 2'b10;
                        ARF_RegSel = 4'b1111;
                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b00) begin // RF to ARF
                        MuxCSel = 1'b1;
                        MuxBSel =  2'b11;
                        RF_OutASel = srcreg1[1:0];
                        Mem_CS = 1'b1;

                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        reset = 1;
                        IR_Enable = 0;
                        RF_RegSel = 4'b1111;

                        ARF_FunSel = 2'b10;
                        ALU_FunSel = 4'b0010; // NOT operation
                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b01) begin // RF to RF
                        MuxCSel = 1'b1;
                        MuxASel = 2'b11;
                        RF_OutASel = srcreg1[1:0];
                        Mem_CS = 1'b1;

                        ARF_RegSel = 4'b1111;
                        reset = 1;
                        IR_Enable = 0;

                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        RF_FunSel = 2'b10;
                        ALU_FunSel = 4'b0010;

                    end
                end
            end
            
            4'b1000: begin // SUB OPERATION
                if(clockCycle == 2) begin
                    $display("SUB OPERATION");
                    if(destreg[3:2] == 2'b00 && srcreg1[3:2] == 2'b01 && srcreg2[3:2] == 2'b01) begin // ARF <= RF - RF
                        // Only one clock cycle is enough for this part
                        RF_RegSel = 4'b1111;
                        RF_OutASel = srcreg2[1:0];
                        RF_OutBSel = srcreg1[1:0];
                               
                        MuxCSel = 1'b1;
                        ALU_FunSel = 4'b0110; //4'b0111; // SRCREG2 - SRCREG1
                               
                        MuxBSel = 2'b11;
                               
                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;
                               
                        ARF_FunSel = 2'b10; // Load operation
                               
                        Mem_CS = 1'b1;
                        IR_Enable = 1'b0;
                        reset = 1;
                    end
                    else if(destreg[3:2] == 2'b01 && srcreg1[3:2] == 2'b01 && srcreg2[3:2] == 2'b01) begin // RF <= RF & RF
                    // Only one clock cycle is enough for this part
                               
                        RF_OutASel = srcreg2[1:0];
                        RF_OutBSel = srcreg1[1:0];
                               
                        ALU_FunSel = 4'b0110; //4'b0111; // SRCREG1 AND SRCREG2
                               
                        MuxASel = 2'b11;
                               
                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;
                               
                        RF_FunSel = 2'b10;
                        
                        Mem_CS = 1'b1;
                        ARF_RegSel = 3'b111;
                        IR_Enable = 1'b0;
                        reset = 1;     
                    end
                    else if(srcreg1[3:2] == 2'b00 && srcreg2[3:2] == 2'b01) begin // ARF or RF <= ARF & RF
                        ARF_OutCSel = srcreg1[1:0];
                        MuxASel = 2'b10;
                        RF_OutASel = srcreg2[1:0];
                        RF_FunSel = 2'b10;
                                                
                        if(srcreg2[1:0] == 2'b00)
                            RF_RegSel = 4'b1011;
                        
                        if(srcreg2[1:0] != 2'b00)
                            RF_RegSel = 4'b0111;
                            
                        Mem_CS = 1'b1;
                        IR_Enable = 0;      
                     end          
                    else if(srcreg1[3:2] == 2'b00 && srcreg2[3:2] == 2'b00) begin // ARF/RF <= ARF - ARF
                    // In first clock cycle load register file with the value
                    // of ARF
                        ARF_OutCSel = srcreg1[1:0];
                        MuxASel = 2'b10;
                        RF_RegSel = 4'b0111;
                        RF_FunSel = 2'b10;
                               
                        ARF_RegSel = 3'b111;
                        IR_Enable = 0;
                        Mem_CS = 1'b1;
                      end
                    else if(srcreg1[3:2] == 2'b01 && srcreg2[3:2] == 2'b00) begin // ARF or RF <= ARF - RF
                        ARF_OutCSel = srcreg2[1:0];
                        MuxCSel = 1'b0;
                        RF_OutBSel = srcreg1[1:0];
                        
                        ALU_FunSel = 4'b0110;
                        Mem_CS = 1'b1;
                        IR_Enable = 0;      
                        
                        if(destreg[3:2] == 2'b00) begin
                            // destination is ARF, no need for RF
                            RF_RegSel = 4'b1111;
                            MuxBSel = 2'b11;
                            ARF_FunSel = 2'b10;
                            
                            if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                                ARF_RegSel = 3'b011;
                            if(destreg[1:0] == 2'b10)
                                ARF_RegSel = 3'b101;
                            if(destreg[1:0] == 2'b11)
                                ARF_RegSel = 3'b110;
                        end
                        else if(destreg[3:2] == 2'b01) begin
                        // if dest reg is in RF
                            MuxASel = 2'b11; // ALU Out
                            RF_FunSel = 2'b10; // Load operation
                            
                            if(destreg[1:0] == 2'b00)
                                RF_RegSel = 4'b0111;
                            if(destreg[1:0] == 2'b01)
                                RF_RegSel = 4'b1011;
                            if(destreg[1:0] == 2'b10)
                                RF_RegSel = 4'b1101;
                            if(destreg[1:0] == 2'b11)
                                RF_RegSel = 4'b1110;
                        end
                        
                        reset = 1;
                    end
                end
                else if(clockCycle == 3) begin
                    if(srcreg1[3:2] == 2'b00 && srcreg2[3:2] == 2'b01) begin // RF/ ARF <= RF - ARF
                        RF_OutASel = srcreg2[1:0];
                            
                        if(srcreg2[1:0] == 2'b00)
                            RF_OutBSel = 2'b01;
                        if(srcreg1[1:0] != 2'b00)
                            RF_OutBSel = 2'b00;
                        
                        MuxCSel = 1'b1;
                        ALU_FunSel = 4'b0110;
                        
                        if(destreg[1:0] == 2'b00) begin
                        // ARF'ye yollama
                            MuxBSel = 2'b11;
                            ARF_FunSel = 2'b10;
                            
                            if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                                ARF_RegSel = 3'b011;
                            if(destreg[1:0] == 2'b10)
                                ARF_RegSel = 3'b101;
                            if(destreg[1:0] == 2'b11)
                                ARF_RegSel = 3'b110;
                        end
                        if(destreg[1:0] == 2'b01) begin
                            MuxASel = 2'b11;
                            RF_FunSel = 2'b10;
                        
                            if(destreg[1:0] == 2'b00)
                                RF_RegSel = 4'b0111;
                            if(destreg[1:0] == 2'b01)
                                RF_RegSel = 4'b1011;
                            if(destreg[1:0] == 2'b10)
                                RF_RegSel = 4'b1101;
                            if(destreg[1:0] == 2'b11)
                                RF_RegSel = 4'b1110;
                        end
                        
                        reset = 1;
                    end
                    if(srcreg1[3:2] == 2'b00 && srcreg2[3:2] == 2'b00) begin
                    // In first clock cycle load register file with the value
                    // of ARF
                        RF_OutBSel = 2'b00;
                        ARF_OutCSel = srcreg2[1:0];
                        MuxCSel = 2'b0;
                        ALU_FunSel = 4'b0110; // SRCREG2 - SRCREG1
                                       
                        if(destreg[3:2] == 2'b00) begin
                        // if dest reg is in ARF
                            MuxBSel = 2'b11;
                            ARF_FunSel = 2'b10;
                                       
                            if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                                ARF_RegSel = 3'b011;
                            if(destreg[1:0] == 2'b10)
                                ARF_RegSel = 3'b101;
                            if(destreg[1:0] == 2'b11)
                                ARF_RegSel = 3'b110;
                                        
                        end
                        else if(destreg[3:2] == 2'b01) begin
                        // if dest reg is in RF
                            MuxASel = 2'b11;
                            RF_FunSel = 2'b10;
                            
                            if(destreg[1:0] == 2'b00)
                                RF_RegSel = 4'b0111;
                            if(destreg[1:0] == 2'b01)
                                RF_RegSel = 4'b1011;
                            if(destreg[1:0] == 2'b10)
                                RF_RegSel = 4'b1101;
                            if(destreg[1:0] == 2'b11)
                                RF_RegSel = 4'b1110;
                        end
                        reset = 1;
                    end
                end
            end

            4'b1100: begin // PSH
                if(clockCycle==2) begin
                    $display("PSH");
                    ALU_FunSel = 4'b0000;
                    RF_OutASel = regselCU; 
                    RF_RegSel = 4'b1111;
                    ARF_FunSel=2'b00; //decrement SP
                    ARF_RegSel=3'b110;
                    ARF_OutDSel=2'b11;
                    Mem_CS=1'b1;
                    Mem_WR=1'b0;
                    reset=1;
                    IR_Enable=0;
                end
            end

            4'b1011: begin // PULL
                if(clockCycle==2) begin
                    $display("PULL");
                    RF_RegSel=4'b1111;
                    ARF_FunSel=2'b01;
                    ARF_RegSel=3'b110;
                    ARF_OutDSel=2'b11;
                    Mem_CS=1'b1;
                    reset=0;
                    IR_Enable=0;
                end

                if(clockCycle==3) begin
                    $display("PULL");
                    if(destreg[1:0] == 2'b00)
                        RF_RegSel = 4'b0111;
                    if(destreg[1:0] == 2'b01)
                        RF_RegSel = 4'b1011;
                    if(destreg[1:0] == 2'b10)
                        RF_RegSel = 4'b1101;
                    if(destreg[1:0] == 2'b11)
                        RF_RegSel = 4'b1110;

                    RF_FunSel=2'b10;
                    ARF_FunSel=2'b01;
                    ARF_RegSel=3'b111;
                    ARF_OutDSel=2'b11;
                    Mem_CS=1'b0;
                    Mem_WR=1'b0;
                    MuxASel=2'b10;
                    reset=1;
                    IR_Enable=0;
                end
            end

            4'b1001: begin // LSR
                if(clockCycle == 2) begin
                    $display("LSR operation");
                    if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b00) begin // ARF to ARF
                        ARF_OutCSel = srcreg1[1:0];
                        MuxCSel = 1'b0;
                        ALU_FunSel = 4'b1011; // LSR operation
                        MuxBSel = 2'b11;
                        Mem_CS = 1'b1;

                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        IR_Enable = 0;
                        RF_RegSel = 4'b1111;
                        ARF_FunSel = 2'b10;
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b01) begin // ARF TO RF
                        ARF_OutCSel = srcreg1[1:0];
                        MuxCSel = 1'b0;
                        ALU_FunSel = 4'b1011;
                        MuxASel = 2'b11;
                        Mem_CS = 1'b1;
                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        IR_Enable = 0;
                        RF_FunSel = 2'b10;
                        ARF_RegSel = 4'b1111;
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b00) begin // RF to ARF
                        MuxCSel = 1'b1;
                        MuxBSel =  2'b11;
                        RF_OutASel = srcreg1[1:0];
                        Mem_CS = 1'b1;

                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        reset = 1;
                        IR_Enable = 0;
                        RF_RegSel = 4'b1111;

                        ARF_FunSel = 2'b10;
                        ALU_FunSel = 4'b1011;
                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b01) begin // RF to RF
                        MuxCSel = 1'b1;
                        MuxASel = 2'b11;
                        RF_OutASel = srcreg1[1:0];
                        Mem_CS = 1'b1;

                        ARF_RegSel = 4'b1111;
                        reset = 1;
                        IR_Enable = 0;

                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        RF_FunSel = 2'b10;
                        ALU_FunSel = 4'b1011;

                    end
                end
            end

            4'b1010: begin // LSL
                if(clockCycle == 2) begin
                    $display("LSL operation");
                    if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b00) begin // ARF to ARF
                        ARF_OutCSel = srcreg1[1:0];
                        MuxCSel = 1'b0;
                        ALU_FunSel = 4'b1010; // LSL operation
                        MuxBSel = 2'b11;
                        Mem_CS = 1'b1;

                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        IR_Enable = 0;
                        RF_RegSel = 4'b1111;
                        ARF_FunSel = 2'b10;
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b01) begin // ARF TO RF
                        ARF_OutCSel = srcreg1[1:0];
                        MuxCSel = 1'b0;
                        ALU_FunSel = 4'b1010;
                        MuxASel = 2'b11;
                        Mem_CS = 1'b1;
                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        IR_Enable = 0;
                        RF_FunSel = 2'b10;
                        ARF_RegSel = 4'b1111;
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b00) begin // RF to ARF
                        MuxBSel =  2'b11;
                        RF_OutASel = srcreg1[1:0];
                        Mem_CS = 1'b1;

                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        reset = 1;
                        IR_Enable = 0;
                        RF_RegSel = 4'b1111;

                        ARF_FunSel = 2'b10;
                        ALU_FunSel = 4'b1010;
                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b01) begin // RF to RF
                        MuxCSel = 1'b1;
                        MuxASel = 2'b11;
                        RF_OutASel = srcreg1[1:0];
                        Mem_CS = 1'b1;

                        ARF_RegSel = 4'b1111;
                        reset = 1;
                        IR_Enable = 0;

                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        RF_FunSel = 2'b10;
                        ALU_FunSel = 4'b1010;

                    end
                end
            end

            4'b1101: begin // INC
                if(clockCycle == 2) begin
                    if(srcreg1[3:2] == 2'b00) begin // ARF to ARF or RF
                        $display("Increment operation starting with ARF to");
                        // C out equals to srcreg1 + 1
                        
                        RF_RegSel = 4'b1111; // disabled register file registers
                        IR_Enable = 0;
                        Mem_CS = 1'b1;
                        // Enabling srcreg1 for increment operation
                        if(srcreg1[1:0] == 2'b00 || srcreg1[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(srcreg1[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(srcreg1[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        ARF_FunSel = 2'b01; // Increment operation
                        ARF_OutCSel = srcreg1[1:0];
                        
                    end
                    else if(srcreg1[3:2] == 2'b01) begin // RF to ARF or RF
                        $display("Increment operation starting with RF to");
                        // Increment register in RF
                        RF_OutASel = srcreg1[1:0];
                        ARF_RegSel = 4'b1111;
                        IR_Enable = 0;
                        Mem_CS = 1'b1;

                        if(srcreg1[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(srcreg1[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(srcreg1[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(srcreg1[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        RF_FunSel = 2'b01; //Increment Operation
                    end
                end
                else if(clockCycle == 3) begin
                    if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b00) begin // ARF to ARF
                        MuxCSel = 1'b0;
                        ALU_FunSel = 4'b0000;
                        MuxBSel = 2'b11;
                        // enabling destination register in ARF
                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                            // Loading destination register in ARF
                        ARF_FunSel = 2'b10;

                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b01) begin // ARF to RF
                        
                        MuxASel = 2'b10;

                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        RF_FunSel = 2'b10;
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b00) begin // RF to ARF
                        MuxCSel = 1'b1;
                        ALU_FunSel = 4'b0000;
                        MuxBSel = 2'b11;

                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        ARF_FunSel = 2'b10; // Loading the incremented value
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b01) begin // RF to RF
                        MuxCSel = 1'b1;
                        ALU_FunSel = 4'b0000;

                        MuxASel = 2'b11;

                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        RF_FunSel = 2'b10; // Load value
                        reset = 1;
                    end
                end
            end

            4'b1110: begin // DEC
                if(clockCycle == 2) begin
                    if(srcreg1[3:2] == 2'b00) begin //&& destreg[3:2] == 2'b00) begin // ARF to ARF or RF
                        $display("DEC operation starting with ARF to");
                        // C out equals to srcreg1 - 1
                        ARF_OutCSel = srcreg1[1:0];
                        RF_RegSel = 4'b1111; // disabled register file registers
                        IR_Enable = 0;
                        Mem_CS = 1'b1;
                        // Enabling srcreg1 for increment operation
                        if(srcreg1[1:0] == 2'b00 || srcreg1[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(srcreg1[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(srcreg1[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        ARF_FunSel = 2'b00; // Increment operation
                    end
                    else if(srcreg1[3:2] == 2'b01) begin // RF to ARF or RF
                        $display("Increment operation starting with RF to");
                        // Increment register in RF
                        RF_OutASel = srcreg1[1:0];
                        ARF_RegSel = 4'b1111;
                        IR_Enable = 0;
                        Mem_CS = 1'b1;

                        if(srcreg1[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(srcreg1[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(srcreg1[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(srcreg1[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        RF_FunSel = 2'b00; //Increment Operation

                    end
                end
                else if(clockCycle == 3) begin
                    if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b00) begin // ARF to ARF
                        $display("increment operation 3.clock cycle");
                        MuxCSel = 1'b0;
                        ALU_FunSel = 4'b0000;
                        MuxBSel = 2'b11;
                        // enabling destination register in ARF
                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                            // Loading destination register in ARF
                        ARF_FunSel = 2'b10;

                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b00 && destreg[3:2] == 2'b01) begin // ARF to RF
                        $display("increment operation 3.clock cycle ARF to RF");
                        MuxASel = 2'b10;

                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        RF_FunSel = 2'b10;
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b00) begin // RF to ARF
                        $display("Increment 3.clock cycle RF to ARF");
                        MuxCSel = 1'b1;
                        ALU_FunSel = 4'b0000;
                        // ALUnun clock'a bagli olmadigindan emin miyiz?
                        MuxBSel = 2'b11;

                        if(destreg[1:0] == 2'b00 || destreg[1:0] == 2'b01)
                            ARF_RegSel = 3'b011;
                        if(destreg[1:0] == 2'b10)
                            ARF_RegSel = 3'b101;
                        if(destreg[1:0] == 2'b11)
                            ARF_RegSel = 3'b110;

                        ARF_FunSel = 2'b10; // Loading the incremented value
                        reset = 1;
                    end
                    else if(srcreg1[3:2] == 2'b01 && destreg[3:2] == 2'b01) begin // RF to RF
                        $display("Increment 3.clock cycle RF to RF");
                        MuxCSel = 1'b1;
                        ALU_FunSel = 4'b0000;

                        MuxASel = 2'b11;

                        if(destreg[1:0] == 2'b00)
                            RF_RegSel = 4'b0111;
                        if(destreg[1:0] == 2'b01)
                            RF_RegSel = 4'b1011;
                        if(destreg[1:0] == 2'b10)
                            RF_RegSel = 4'b1101;
                        if(destreg[1:0] == 2'b11)
                            RF_RegSel = 4'b1110;

                        RF_FunSel = 2'b10; // Load value
                        reset = 1;
                    end
                end
            end

            4'b1111: begin // BNE
//                $display("z degeri : %b", Z);
//                $display("addressing mode %b", adressingModeCU);
//                assign Z = 1'b1;
                if(clockCycle == 2 && adressingModeCU==1'b1 && Z==1'b0) begin
                    $display("BNE");
                    MuxBSel = 2'b01;
                    ARF_RegSel = 3'b011;
                    ARF_FunSel = 2'b10;
                    Mem_CS = 2'b1;
                    IR_Enable = 1'b0;
                    RF_RegSel = 4'b1111;
                    reset=1;
                end
                else if(clockCycle==2 && (adressingModeCU==1'b0 || Z==1'b1)) begin
                    reset=1;
                end
            end
                
        endcase
    end
endmodule

module CPU(
    input Clock,
    output PC,output AR,output SP, output R1, output R2,  output R3, output R4, output IR, output clockCycle2
);

    wire [15:0] instructionRegister;
    wire [3:0] zcno;
    wire [3:0] clockCycle;
    wire [1:0] RF_OutASel;
    wire [1:0] RF_OutBSel;
    wire [1:0] RF_FunSel;
    wire [3:0] RF_RegSel;
    wire [3:0] ALU_FunSel;
    wire [1:0] ARF_OutCSel;
    wire [1:0] ARF_OutDSel;
    wire [1:0] ARF_FunSel;
    wire [2:0] ARF_RegSel;
    wire  IR_LH;
    wire  IR_Enable;
    wire [1:0] IR_Funsel;
    wire  Mem_WR;
    wire  Mem_CS;
    wire [1:0] MuxASel;
    wire [1:0] MuxBSel;
    wire  MuxCSel;
    wire  reset;

    sequentialCounter counter(.clk(Clock), .reset(reset), .count(clockCycle));

    controlUnit controlunit(.instructionRegister(instructionRegister),
        .zcno(zcno),
        .clockCycle(clockCycle),
        .RF_OutASel(RF_OutASel),
        .RF_OutBSel(RF_OutBSel),
        .RF_FunSel(RF_FunSel),
        .RF_RegSel(RF_RegSel),
        .ALU_FunSel(ALU_FunSel),
        .ARF_OutCSel(ARF_OutCSel),
        .ARF_OutDSel(ARF_OutDSel),
        .ARF_FunSel(ARF_FunSel),
        .ARF_RegSel(ARF_RegSel),
        .IR_LH(IR_LH),
        .IR_Enable(IR_Enable),
        .IR_Funsel(IR_Funsel),
        .Mem_WR(Mem_WR),
        .Mem_CS(Mem_CS),
        .MuxASel(MuxASel),
        .MuxBSel(MuxBSel),
        .MuxCSel(MuxCSel),
        .reset(reset) );

    ALUSystem _ALUSystem(
        .RF_OutASel(RF_OutASel),
        .RF_OutBSel(RF_OutBSel),
        .RF_FunSel(RF_FunSel),
        .RF_RegSel(RF_RegSel),
        .ALU_FunSel(ALU_FunSel),
        .ARF_OutCSel(ARF_OutCSel),
        .ARF_OutDSel(ARF_OutDSel),
        .ARF_FunSel(ARF_FunSel),
        .ARF_RegSel(ARF_RegSel),
        .IR_LH(IR_LH),
        .IR_Enable(IR_Enable),
        .IR_Funsel(IR_Funsel),
        .Mem_WR(Mem_WR),
        .Mem_CS(Mem_CS),
        .MuxASel(MuxASel),
        .MuxBSel(MuxBSel),
        .MuxCSel(MuxCSel),
        .Clock(Clock)
    );

    assign instructionRegister = _ALUSystem.IROut;
    
    wire[7:0]  PC;
    assign PC = _ALUSystem.ARF.temp1;
    wire[7:0]  AR;
    assign AR = _ALUSystem.ARF.temp2;
    wire[7:0]  SP ;
    assign SP= _ALUSystem.ARF.temp3 ;
    
        
        
    wire[7:0]  R1;
    assign R1 = _ALUSystem.registerFile.temp0;
    wire[7:0]  R2;
    assign R2 = _ALUSystem.registerFile.temp1;
    wire[7:0]  R3;
    assign R3 = _ALUSystem.registerFile.temp2 ;    
    wire[7:0]  R4;
    assign R4 = _ALUSystem.registerFile.temp3;
        
    reg [15:0] IR;
    
    reg [3:0] clockCycle2;
    always@(*)
    begin
        assign IR = controlunit.instructionRegister;
        assign clockCycle2 = clockCycle;
    end

endmodule
