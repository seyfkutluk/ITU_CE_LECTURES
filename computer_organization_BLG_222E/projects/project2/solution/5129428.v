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

//module controlUnit(
//    input[15:0] instructionRegister,
//    input[3:0] zcno,
//    input reset,
//    input[3:0] clockCycle,// new addressRegisterFileTestBench
    
    
module testCU();
    reg[15:0] instructionRegister;
    reg[3:0] zcno;
    reg[3:0] clockCycle;// new wire
    
    wire[1:0] RF_OutASel; 
    wire[1:0] RF_OutBSel; 
    wire[1:0] RF_FunSel;
    wire[3:0] RF_RegSel;
    wire[3:0] ALU_FunSel;
    wire[1:0] ARF_OutCSel; 
    wire[1:0] ARF_OutDSel; 
    wire[1:0] ARF_FunSel;
    wire[2:0] ARF_RegSel;
    wire      IR_LH;
    wire      IR_Enable;
    wire[1:0]      IR_Funsel;
    wire      Mem_WR;
    wire      Mem_CS;
    wire[1:0] MuxASel;
    wire[1:0] MuxBSel;
    wire MuxCSel;
    wire reset;


    controlUnit UUT (.instructionRegister(instructionRegister), 
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
    
    initial begin
        #0
        instructionRegister = 16'b0001010000000000; // load
        zcno =  4'b0000; 
        clockCycle = 2;   
   
end
endmodule

module testCPU();

    reg Clock;
    wire [7:0] PC, AR, SP, R1, R2, R3, R4;
    wire [15:0] IR;
    wire [3:0] clockCycle2;

    CPU UUT (.Clock(Clock), .PC(PC), .AR(AR), .SP(SP), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .IR(IR), .clockCycle2(clockCycle2));

    always 
    begin
        Clock = 1; #5; Clock = 0; #5; // 10ns period
    end
    integer index;
     always @(posedge Clock)
     begin

                 $display("");$display("");$display("");
                 $display("Input Values:");
//               $display("Register File: OutASel: %d, OutBSel: %d, FunSel: %d, Regsel: %d", RF_OutASel, RF_OutBSel, RF_FunSel, RF_RegSel);
                 $display("RF_OutASel, %b", UUT._ALUSystem.RF_OutASel);
                 $display("RF_OutBSel, , %b", UUT._ALUSystem.RF_OutBSel);
                 $display("RF_FunSel,, %b", UUT._ALUSystem.RF_FunSel,);
                 $display("RF_RegSel,, %b", UUT._ALUSystem.RF_RegSel);
                 $display("ALU_FunSel,, %b", UUT._ALUSystem.ALU_FunSel);
                 $display("ARF_OutCSel, , %b", UUT._ALUSystem.ARF_OutCSel);
                 $display("ARF_OutDSel, , %b", UUT._ALUSystem.ARF_OutDSel);
                 $display("ARF_FunSel,, , %b", UUT._ALUSystem.ARF_FunSel);
                 $display("ARF_RegSel,, , %b", UUT._ALUSystem.ARF_RegSel);
                 $display("IR_LH,,, , %b", UUT._ALUSystem.IR_LH);
                 $display("IR_Enable,,, , %b", UUT._ALUSystem.IR_Enable);
                 $display("IR_Funsel,,, , %b", UUT._ALUSystem.IR_Funsel);
                 $display("Mem_WR,,, , %b", UUT._ALUSystem.Mem_WR);
                 $display("Mem_CS,,,, , %b", UUT._ALUSystem.Mem_CS);
                 $display("MuxASel,,,, , %b", UUT._ALUSystem.MuxASel);
                 $display("MuxBSel,,,, , %b", UUT._ALUSystem.MuxBSel);
                 $display("MuxCSel,,,,, , %b", UUT._ALUSystem.MuxCSel);
   
//                 $display("IRLH control unit %b", UUT.controlunit.IR_LH);
//                 $display("RFREGEsel control unit %b", UUT.controlunit.RF_RegSel);
//                 $display("RFFUNsel control unit %b", UUT.controlunit.RF_FunSel);
//                 $display("Instruction Register %b", UUT.instructionRegister);
//               $display("Addres Register File: OutCSel: %d, OutDSel: %d, FunSel: %d, Regsel: %d", ARF_OutCSel, ARF_OutDSel, ARF_FunSel, ARF_RegSel);
//               $display("Instruction Register: LH: %d, Enable: %d, FunSel: %d", IR_LH, IR_Enable, IR_Funsel);
                 
//               $display("MuxASel: %d, MuxBSel: %d, MuxCSel: %d", MuxASel, MuxBSel, MuxCSel);

               $display("");$display("");$display("");
               $display("AOut %b", UUT._ALUSystem.AOut);
               $display("BOut %b", UUT._ALUSystem.BOut);
               $display("ALUOut;  %b", UUT._ALUSystem.ALUOut);
               $display("ALUOutFlag;  %b", UUT._ALUSystem.ALUOutFlag);
               $display("ARF_COut,  %b", UUT._ALUSystem.ARF_COut);
               $display("Address;  %b", UUT._ALUSystem.Address);
               $display("MemoryOut; %b", UUT._ALUSystem.MemoryOut);
               $display("IROut;; %b", UUT._ALUSystem.IROut);
               $display("MuxAOut, ; %b", UUT._ALUSystem.MuxAOut);
               $display("MuxAOut, ; %b", UUT._ALUSystem.MuxAOut);
               $display("MuxBOut, , ; %b", UUT._ALUSystem.MuxBOut);
               $display("MuxCOut;, ; %b", UUT._ALUSystem.MuxCOut);
               $display("Clockcycle;, ; %b", UUT.controlunit.clockCycle);
               $display("Reset;, ; %b", UUT.controlunit.reset);
               //$display("Memory;, ; %b", UUT._ALUSystem.MEM.RAM_DATA);
               for(index=0;index<=255;index = index+1)
               begin
                $display("Memory Out: INDEX: %d, %x", index, UUT._ALUSystem.MEM.RAM_DATA[index]);
               end
               
       
               
               
//               $display("R1;, ; %b", UUT._ALUSystem.RF.R);
//               $display("R2;, ; %b", UUT._ALUSystem.ARF.SP);
//               $display("R3;, ; %b", UUT._ALUSystem.ARF.SP);
//               $display("R4;, ; %b", UUT._ALUSystem.ARF.SP);
               
               


                $display("##############################################");

//               $display("ALu A File: Aout: %d, Bout: %d", UUT._ALUSystem.AOut, UUT._ALUSystem.BOut);
//               $display("Aluout: %d", UUT._ALUSystem.ALUOut);
//               $display("Memout: %d",UUT._ALUSystem.MemoryOut);
//               $display("Address Register File: COut: %d, DOut (Address): %d", UUT._ALUSystem.ARF_FunSel, UUT._ALUSystem.Address);
//               $display("Address Register File: COut: %d, DOut (Address): %d", UUT._ALUSystem.ARF_FunSel, UUT._ALUSystem.Address);
//               $display("Address Register File: COut: %d, DOut (Address): %d", UUT._ALUSystem.ARF_FunSel, UUT._ALUSystem.Address);
//               $display("Address Register File: COut: %d, DOut (Address): %d", UUT._ALUSystem.ARF_FunSel, UUT._ALUSystem.Address);
//               $display("Address Register File: COut: %d, DOut (Address): %d", UUT._ALUSystem.ARF_FunSel, UUT._ALUSystem.Address);
//               $display("Memory Out: %b", _ALUSystem.MemoryOut);
//               $display("Instruction Register: IROut: %d", UUT._ALUSystem.IROut);
//               $display("MuxAOut: %d, MuxBOut: %d, MuxCOut: %d", _ALUSystem.MuxAOut, _ALUSystem.MuxBOut, _ALUSystem.MuxCOut);
               //Check Functions
    end

endmodule

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
    
    //Output Check
    reg Check_AOut;	reg [7:0] AOut;	reg Check_BOut;	
    reg [7:0] BOut;	reg Check_ALUOut;	reg [7:0] ALUOut;	
    reg Check_ALUOutFlag;	reg [3:0] ALUOutFlag;	
    reg Check_Z;	reg Z;	reg Check_C;	reg C;	
    reg Check_N;	reg N;	reg Check_O;	reg O;	
    reg Check_ARF_COut;	reg [7:0] ARF_COut;	reg Check_Address;	
    reg [7:0] Address;	reg Check_MemoryOut;	reg [7:0] MemoryOut;	
    reg Check_IROut;	reg [15:0] IROut;	reg Check_MuxAOut;	
    reg [7:0] MuxAOut;	reg Check_MuxBOut;	reg [7:0] MuxBOut;	
    reg Check_MuxCOut;	reg [7:0] MuxCOut;
    reg [7:0] TotalError=0, TotalLine=0, LineError=0, LineCheck=0; 
        
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
    reg [31:0] VectorNum; 
    reg [145:0] TestVectors[200:0];
    reg Reset, Operation;
    
    //Clock Signal Generation
    always 
    begin
        Clock = 1; #5; Clock = 0; #5; // 10ns period
    end
    
    //Read Test Bench Values
    initial begin
        $readmemb("TestBench.mem", TestVectors); // Read vectors
        VectorNum = 0; Reset=0;// Initialize
    end
    
    // Apply test vectors on rising edge of clock
    always @(posedge Clock)
    begin
        #1; 
        {Operation, RF_OutASel, RF_OutBSel, RF_FunSel, 
        RF_RegSel, ALU_FunSel, ARF_OutCSel, ARF_OutDSel, 
        ARF_FunSel, ARF_RegSel, IR_LH, IR_Enable, IR_Funsel, 
        Mem_WR, Mem_CS, MuxASel, MuxBSel, MuxCSel, 
        Check_AOut, 	AOut, 	Check_BOut, 	BOut, 	
        Check_ALUOut, 	ALUOut, 	Check_ALUOutFlag, 	ALUOutFlag,
        Check_Z, 	Z, 	Check_C, 	C, 	Check_N,
        N, 	Check_O, 	O, 	Check_ARF_COut, 	ARF_COut,
        Check_Address, 	Address, 	Check_MemoryOut, 	MemoryOut, 	
        Check_IROut, 	IROut, 	Check_MuxAOut, 	MuxAOut, 	
        Check_MuxBOut, 	MuxBOut, 	Check_MuxCOut, 	MuxCOut} = TestVectors[VectorNum];
    end
    // Check results on falling edge of clk
    always @(negedge Clock)
        if (~Reset) // skip during reset
        begin
            
        
            $display("Input Values:");
            $display("Operation: %d", Operation);
            $display("Register File: OutASel: %d, OutBSel: %d, FunSel: %d, Regsel: %d", RF_OutASel, RF_OutBSel, RF_FunSel, RF_RegSel);            
            $display("ALU FunSel: %d", ALU_FunSel);
            $display("Addres Register File: OutCSel: %d, OutDSel: %d, FunSel: %d, Regsel: %d", ARF_OutCSel, ARF_OutDSel, ARF_FunSel, ARF_RegSel);            
            $display("Instruction Register: LH: %d, Enable: %d, FunSel: %d", IR_LH, IR_Enable, IR_Funsel);            
            $display("Memory: WR: %d, CS: %d", Mem_WR, Mem_CS);
            $display("MuxASel: %d, MuxBSel: %d, MuxCSel: %d", MuxASel, MuxBSel, MuxCSel);
            
            $display("");
            $display("Ouput Values:");
            $display("Register File: AOut: %d, BOut: %d", _ALUSystem.AOut, _ALUSystem.BOut);            
            $display("ALUOut: %d, ALUOutFlag: %b, ALUOutFlags: Z:%d, C:%d, N:%d, O:%d,", _ALUSystem.ALUOut, _ALUSystem.ALUOutFlag, _ALUSystem.ALUOutFlag[3],_ALUSystem.ALUOutFlag[2],_ALUSystem.ALUOutFlag[1],_ALUSystem.ALUOutFlag[0]);
            $display("Address Register File: COut: %d, DOut (Address): %d", _ALUSystem.ARF_COut, _ALUSystem.Address);            
            
            $display("Memory Out: %b", _ALUSystem.MemoryOut);
            
                        
            $display("Instruction Register: IROut: %d", _ALUSystem.IROut);            
            $display("MuxAOut: %d, MuxBOut: %d, MuxCOut: %d", _ALUSystem.MuxAOut, _ALUSystem.MuxBOut, _ALUSystem.MuxCOut);
            //Check Functions
            if (Operation)
            begin
                TotalLine=TotalLine+1;
                LineError=0;
                LineCheck=0;
                $display("##############################################");

                
                $display("%d Line Check Started To Test",TotalLine);
                //CheckAOut
                if(Check_AOut)
                begin
                    LineCheck=LineCheck+1;
                    if(AOut!=_ALUSystem.AOut)
                    begin
                        $display("AOut Error: Expected: %d, Actual: %d",AOut,_ALUSystem.AOut);
                        LineError=LineError+1;
                    end
                end
                
                //CheckBOut
                if(Check_BOut)
                begin
                    LineCheck=LineCheck+1;
                    if(BOut!=_ALUSystem.BOut)
                    begin
                        $display("BOut Error: Expected: %d, Actual: %d",BOut,_ALUSystem.BOut);
                        LineError=LineError+1;
                    end
                end
                
                
                //CheckALUOut
                if(Check_ALUOut)
                begin
                    LineCheck=LineCheck+1;
                    if(ALUOut!=_ALUSystem.ALUOut)
                    begin
                        $display("ALUOut Error: Expected: %d, Actual: %d",ALUOut,_ALUSystem.ALUOut);
                        LineError=LineError+1;
                    end
                end
                
                //CheckALUOut
                if(Check_ALUOutFlag)
                begin
                    LineCheck=LineCheck+1;
                    if(ALUOutFlag!=_ALUSystem.ALUOutFlag)
                    begin
                        $display("ALUOutFlag Error: Expected: %d, Actual: %d",ALUOutFlag,_ALUSystem.ALUOutFlag);
                        LineError=LineError+1;
                    end
                end
                
                //Check_Z
                if(Check_Z)
                begin
                    LineCheck=LineCheck+1;
                    if(Z!=_ALUSystem.ALUOutFlag[3])
                    begin
                        $display("Z Flag Error: Expected: %d, Actual: %d",Z,_ALUSystem.ALUOutFlag[3]);
                        LineError=LineError+1;
                    end
                end
                
                //Check_C
                if(Check_C)
                begin
                    LineCheck=LineCheck+1;
                    if(C!=_ALUSystem.ALUOutFlag[2])
                    begin
                        $display("C Flag Error: Expected: %d, Actual: %d",C,_ALUSystem.ALUOutFlag[2]);
                        LineError=LineError+1;
                    end
                end
                
                //Check_N
                if(Check_N)
                begin
                    LineCheck=LineCheck+1;
                    if(N!=_ALUSystem.ALUOutFlag[1])
                    begin
                        $display("N Flag Error: Expected: %d, Actual: %d",N,_ALUSystem.ALUOutFlag[1]);
                        LineError=LineError+1;
                    end
                end
                
                //Check_O
                if(Check_O)
                begin
                    LineCheck=LineCheck+1;
                    if(O!=_ALUSystem.ALUOutFlag[0])
                    begin
                        $display("O Flag Error: Expected: %d, Actual: %d",O,_ALUSystem.ALUOutFlag[0]);
                        LineError=LineError+1;
                    end
                end
                
                //Check_ARF_COut
                if(Check_ARF_COut)
                begin
                    LineCheck=LineCheck+1;
                    if(ARF_COut!=_ALUSystem.ARF_COut)
                    begin
                        $display("ARF_COut Error: Expected: %d, Actual: %d",ARF_COut,_ALUSystem.ARF_COut);
                        LineError=LineError+1;
                    end
                end
                
                //Check_Address
                if(Check_Address)
                begin
                    LineCheck=LineCheck+1;
                    if(Address!=_ALUSystem.Address)
                    begin
                        $display("Address Error: Expected: %d, Actual: %d",Address,_ALUSystem.Address);
                        LineError=LineError+1;
                    end
                end
                
                //Check_MemoryOut
                if(Check_MemoryOut)
                begin
                    LineCheck=LineCheck+1;
                    if(MemoryOut!=_ALUSystem.MemoryOut)
                    begin
                        $display("MemoryOut Error: Expected: %d, Actual: %d",MemoryOut,_ALUSystem.MemoryOut);
                        LineError=LineError+1;
                    end
                end
                
                
                //Check_IROut
                if(Check_IROut)
                begin
                    LineCheck=LineCheck+1;
                    if(IROut!=_ALUSystem.IROut)
                    begin
                        $display("IROut Error: Expected: %d, Actual: %d",IROut,_ALUSystem.IROut);
                        LineError=LineError+1;
                    end
                end
                    
                //Check_MuxAOut
                if(Check_MuxAOut)
                begin
                    LineCheck=LineCheck+1;
                    if(MuxAOut!=_ALUSystem.MuxAOut)
                    begin
                        $display("MuxAOut Error: Expected: %d, Actual: %d",MuxAOut,_ALUSystem.MuxAOut);
                        LineError=LineError+1;
                    end
                end 
                
                //Check_MuxBOut
                if(Check_MuxBOut)
                begin
                    LineCheck=LineCheck+1;
                    if(MuxBOut!=_ALUSystem.MuxBOut)
                    begin
                        $display("MuxBOut Error: Expected: %d, Actual: %d",MuxBOut,_ALUSystem.MuxBOut);
                        LineError=LineError+1;
                    end
                end   
                
                //Check_MuxCOut
                if(Check_MuxCOut)
                begin
                    LineCheck=LineCheck+1;
                    if(MuxCOut!=_ALUSystem.MuxCOut)
                    begin
                        $display("MuxCOut Error: Expected: %d, Actual: %d",MuxCOut,_ALUSystem.MuxCOut);
                        LineError=LineError+1;
                    end
                end 
                           
                
                $display("");
                //Check All Messages
                if(LineError>8'd0)
                begin
                     TotalError=TotalError+1;
                     $display("LineError: %d/%d, Total Error: %d/%d",LineError, LineCheck,TotalError,TotalLine);
                end
                else
                begin
                     $display("Line passed the test");
                end
                $display("##############################################");
            end
            
            
            // increment array index and read next testvector
            VectorNum = VectorNum + 1;
            if (TestVectors[VectorNum] === 146'bx)
            begin
                $display("%d tests completed with %d errors.",
                VectorNum, TotalError);
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
        B =  8'b01011111;       
        
        #0 FunSel = 4'd0;   
        #10 FunSel = 4'd1;     
        #10 FunSel = 4'd2;     
        #10 FunSel = 4'd3;      
        #10 FunSel = 4'd4;     
        #10 FunSel = 4'd5; 
        #10 FunSel = 4'd6;   
        #10 FunSel = 4'd7;     
        #10 FunSel = 4'd8;     
        #10 FunSel = 4'd9;      
        #10 FunSel = 4'd10;     
        #10 FunSel = 4'd11; 
        #10 FunSel = 4'd12;      
        #10 FunSel = 4'd13;     
        #10 FunSel = 4'd14; 
        #10 FunSel = 4'd15;      

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


        OutDSel =  2'b00;
        OutCSel =  2'b00;
        FunSel =  2'b11;
        RegSel =  3'b000;  
             
        #20
//        I =  8'b00000000; 
//        OutCSel =  2'b11;
//        OutDSel =  2'b11;
//        FunSel =  2'b11;
//        RegSel =  4'b0000;
        OutDSel =  2'b00;
        OutCSel =  2'b00;
        FunSel =  2'b11;
        RegSel =  3'b000;    
        
        #20
//        I =  8'b00000010; 
//        OutCSel =  2'b01;
//        OutDSel =  2'b01;
//        FunSel =  2'b10;
//        RegSel =  4'b1111;
        OutDSel =  2'b00;
        FunSel =  2'b01;
        RegSel =  3'b000;  
        
        #40
//        I =  8'b00000001; 
//        OutCSel =  2'b11;
//        OutDSel =  2'b11;
//        FunSel =  2'b01;
//        RegSel =  4'b0000;
        OutDSel =  2'b00;
        FunSel =  2'b01;
        RegSel =  3'b000;  
        
        #60
        I =  8'b00000001; 
        OutCSel =  2'b11;
        OutDSel =  2'b11;
        FunSel =  2'b00;
        RegSel =  4'b1111;            
end
endmodule

module testsequentelCounter();
    reg clk;
    reg reset;
    wire [3:0] count;    
      //define input and ouput ports

    sequentialCounter UUT (.clk(clk),.reset(reset),.count(count));
    initial begin reset=0; end
    always 
    begin
        clk = 1; #5; clk = 0; #5; // 10ns period
    end
    initial begin #20 reset=1; end

endmodule
