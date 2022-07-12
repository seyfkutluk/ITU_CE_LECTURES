`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2022 04:52:27 PM
// Design Name: 
// Module Name: test
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

module Project1Test();
    //Input Registers of ALUSystem
    reg[1:0] RF_OutASel; 
    reg[1:0] RF_OutBSel; 
    reg[1:0] RF_FunSel;
    reg[3:0] RF_RegSel;
    reg[3:0] ALU_FunSel;
    reg[1:0] ARF_OutCSel; 
    reg[1:0] ARF_OutDSel; 
    reg[1:0] ARF_FunSel;
    reg[2:0] ARF_RegSel;
    reg      IR_LH;
    reg      IR_Enable;
    reg[1:0]      IR_Funsel;
    reg      Mem_WR;
    reg      Mem_CS;
    reg[1:0] MuxASel;
    reg[1:0] MuxBSel;
    reg MuxCSel;
    reg      Clock;
    
    //Test Bench Connection of ALU System
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
    
    //Test Vector Variables
    reg [31:0] VectorNum, Errors, TotalLine; 
    reg [34:0] TestVectors[10000:0];
    reg Reset, Operation;
    
    //Clock Signal Generation
    always 
    begin
        Clock = 1; #5; Clock = 0; #5; // 10ns period
    end
    
    //Read Test Bench Values
    initial begin
        $readmemb("TestBench.mem", TestVectors); // Read vectors
        VectorNum = 0; Errors = 0; TotalLine=0; Reset=0;// Initialize
    end
    
    // Apply test vectors on rising edge of clock
    always @(posedge Clock)
    begin
        #1; 
        {Operation, RF_OutASel, RF_OutBSel, RF_FunSel, 
        RF_RegSel, ALU_FunSel, ARF_OutCSel, ARF_OutDSel, 
        ARF_FunSel, ARF_RegSel, IR_LH, IR_Enable, IR_Funsel, 
        Mem_WR, Mem_CS, MuxASel, MuxBSel, MuxCSel} = TestVectors[VectorNum];
    end
    
    // Check results on falling edge of clk
    always @(negedge Clock)
        if (~Reset) // skip during reset
        begin
            $display("");
            $display("");
            $display("Input Values:");
            $display("Operation: %b", Operation);
            $display("Register File: OutASel: %b, OutBSel: %b, FunSel: %b, Regsel: %b", RF_OutASel, RF_OutBSel, RF_FunSel, RF_RegSel);            
            $display("ALU FunSel: %b", ALU_FunSel);
            $display("Addres Register File: OutCSel: %b, OutDSel: %b, FunSel: %b, Regsel: %b", ARF_OutCSel, ARF_OutDSel, ARF_FunSel, ARF_RegSel);            
            $display("Instruction Register: LH: %b, Enable: %b, FunSel: %b", IR_LH, IR_Enable, IR_Funsel);            
            $display("Memory: WR: %b, CS: %b", Mem_WR, Mem_CS);
            $display("MuxASel: %b, MuxBSel: %b, MuxCSel: %b", MuxASel, MuxBSel, MuxCSel);
            
            $display("");
            $display("Ouput Values:");
            $display("Register File: AOut: %b, BOut: %b", _ALUSystem.AOut, _ALUSystem.BOut);            
            $display("ALUOut: %b, ALUOutFlag: %b, ALUOutFlags: Z:%b, C:%b, N:%b, O:%b,", _ALUSystem.ALUOut, _ALUSystem.ALUOutFlag, _ALUSystem.ALUOutFlag[3],_ALUSystem.ALUOutFlag[2],_ALUSystem.ALUOutFlag[1],_ALUSystem.ALUOutFlag[0]);
            $display("Address Register File: COut: %b, DOut (Address): %b", _ALUSystem.ARF_COut, _ALUSystem.Address);            
            $display("Memory Out: %b", _ALUSystem.MemoryOut);            
            $display("Instruction Register: IROut: %b", _ALUSystem.IROut);            
            $display("MuxAOut: %b, MuxBOut: %b, MuxCOut: %b", _ALUSystem.MuxAOut, _ALUSystem.MuxBOut, _ALUSystem.MuxCOut);
            
            // increment array index and read next testvector
            VectorNum = VectorNum + 1;
            if (TestVectors[VectorNum] === 35'bx)
            begin
                $display("%b tests completed.",
                VectorNum);
                $finish; // End simulation
            end
        end
endmodule

module register_8_bitTestBench();
    reg [0:0] E;
    reg [7:0] I;
    reg [1:0] FunSel;
    reg clock = 1;
    wire [7:0] Q;
always #5 clock = ~clock;
    funcRegister8 uut( .CLK(clock), .E(E), .Din(I), .Dout(Q), .FunSel(FunSel) );
        
initial begin
        #0
        FunSel = 2'b11; // load
        I =  8'b00000000; 
        E = 1;   
        #10
        FunSel = 2'b11; // load
        I =  8'b00000000; 
        E = 1;
        #20
        FunSel = 2'b10; // load
        I =  8'b00000010; 
        E = 1;
        #30
        FunSel = 2'b01; // load
        I =  8'b00000100; 
        E = 1;
        #40
        FunSel = 2'b00; // load
        I =  8'b00010000; 
        E = 1;      
end
endmodule

module register_16_bitTestBench();
    reg [0:0] E;
    reg [15:0] I;
    reg [1:0] FunSel;
    reg clock = 1;
    wire [15:0] Q;

always #5 clock = ~clock;
    funcRegister16 uut( .CLK(clock), .E(E), .Din(I), .Dout(Q), .FunSel(FunSel) );
        
initial begin
        #0
        FunSel = 2'b11; // load
        I =  8'b00000110; 
        E = 1;        
        #10
        FunSel = 2'b11; // load
        I =  8'b00000110; 
        E = 1;
        #20
        FunSel = 2'b10; // load
        I =  8'b00000010; 
        E = 1;
        #30
        FunSel = 2'b01; // load
        I =  8'b00000100; 
        E = 1;
        #40
        FunSel = 2'b00; // load
        I =  8'b00010000; 
        E = 1;     
end
endmodule

   
module IRregisterTestBench();

reg clock = 1;
reg enable;
reg lowHigh = 0;
reg  [7:0] Din;
wire [15:0] Dout;
reg [1:0] FunSel;

always #5 clock =~clock;
    registerIR uut( .CLK(clock), .Enable(enable), .LowHigh(lowHigh), .FunSel(FunSel), .IRin(Din), .IRout(Dout) );     
initial begin
        #10 FunSel = 2'b10; Din =  8'b00000000; lowHigh = 0; enable=1;
        #20 FunSel = 2'b11; Din =  8'b00000000; lowHigh = 0; enable=1;
        #30 FunSel = 2'b10; Din =  8'b00000110; lowHigh = 0; enable=1;
        #40 FunSel = 2'b11; Din =  8'b00110000; lowHigh = 0; enable=1;
        #50 FunSel = 2'b00; Din =  8'b11000000; lowHigh = 0; enable=1;

end
endmodule
    
module aluTestBench();
reg [7:0] A;
reg [7:0] B;
reg [3:0] FunSel;
wire  [7:0] OutAlu;
wire[3:0] ZCNO;
    alu uut( .A(A), .B(B), .FunSel(FunSel), .OutAlu(OutAlu), .ZCNO(ZCNO));
initial begin
        A =  8'b01111111; 
        B =  8'b01111111;       
        
        #0 FunSel = 4'b0100; // load        
        #10FunSel = 4'b0101; // load        
        #20 FunSel = 4'b0110; // load        
        #30 FunSel = 4'b0111; // load        
        #40 FunSel = 4'b0110; // load        
        #50 FunSel = 4'b0101; // load

end
endmodule

module register_fileTestBench();
    reg[7:0] I;
    reg[1:0] OutASel;
    reg[1:0] OutBSel;
    reg[1:0] FunSel;
    reg[3:0] RegSel;
    reg clock = 1;
    wire [7:0] OutA;
    wire [7:0] OutB;

always #5 clock = ~clock;
    registerFile uut(.Data_in(I), .OutASel(OutASel), .OutBSel(OutBSel),.FunSel(FunSel), .RegSel(RegSel), .CLK(clock), .Data_out_A(OutA), .Data_out_B(OutB) );
        
initial begin
        #0
        I =  8'b00000000; 
        OutASel =  2'b11;
        OutBSel =  2'b11;
        FunSel =  2'b11;
        RegSel =  4'b0000;  
             
        #10
        I =  8'b00000000; 
        OutASel =  2'b11;
        OutBSel =  2'b11;
        FunSel =  2'b11;
        RegSel =  4'b0000;
        
        #20
        I =  8'b00000010; 
        OutASel =  2'b01;
        OutBSel =  2'b01;
        FunSel =  2'b10;
        RegSel =  4'b1111;
        
        #30
        I =  8'b00000001; 
        OutASel =  2'b11;
        OutBSel =  2'b11;
        FunSel =  2'b01;
        RegSel =  4'b0000;
        
        #40
        I =  8'b00000001; 
        OutASel =  2'b11;
        OutBSel =  2'b11;
        FunSel =  2'b00;
        RegSel =  4'b1111;       
       
end
endmodule

module addressRegisterFileTestBench();  
    reg[7:0] I;
    reg[1:0] OutCSel;
    reg[1:0] OutDSel;
    reg[1:0] FunSel;
    reg[3:0] RegSel;
    reg clock = 1;
    wire [7:0] Data_out_C;
    wire [7:0] Data_out_D;

always #5 clock = ~clock;
    addressRegisterFile uut(.Data_in(I), .OutCSel(OutCSel), .OutDSel(OutDSel),.FunSel(FunSel), .RegSel(RegSel), .CLK(clock), .Data_out_C(Data_out_C), .Data_out_D(Data_out_D) );
        
initial begin

        #0
        I =  8'b00000000; 
        OutCSel =  2'b11;
        OutDSel =  2'b11;
        FunSel =  2'b11;
        RegSel =  4'b0000;  
             
        #10
        I =  8'b00000000; 
        OutCSel =  2'b11;
        OutDSel =  2'b11;
        FunSel =  2'b11;
        RegSel =  4'b0000;
        
        #20
        I =  8'b00000010; 
        OutCSel =  2'b01;
        OutDSel =  2'b01;
        FunSel =  2'b10;
        RegSel =  4'b1111;
        
        #30
        I =  8'b00000001; 
        OutCSel =  2'b11;
        OutDSel =  2'b11;
        FunSel =  2'b01;
        RegSel =  4'b0000;
        
        #40
        I =  8'b00000001; 
        OutCSel =  2'b11;
        OutDSel =  2'b11;
        FunSel =  2'b00;
        RegSel =  4'b1111;            
end
endmodule
   


