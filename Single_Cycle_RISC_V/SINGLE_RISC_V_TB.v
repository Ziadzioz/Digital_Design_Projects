`timescale 1ns/1ps

module SINGLE_RISC_V_TB ();

                             reg                              CLK_TB,RST_TB,R_EN_TB,W_EN_TB;
                             reg           [31:0]             W_INSTRUCTION_TB;
                             reg           [4:0]              ADDRESS_TB;
                             wire          [31:0]             RD1_TB,RD2_TB,RESULT_TB;
                             wire signed   [31:0]             ALU_RESULT_TB;

                            parameter             CLK_PERIOD = 100;




initial 
         begin
            $dumpfile("SINGLE_RISC_V.vcd");
            $dumpvars;
             #(CLK_PERIOD/2)
            initialization();
            Reset();
            W_EN_TB = 1;
            $display("TESTING sw Instruction (sw x2, 4(x1)) Storing value inside REG2 = 2 into Location 1 in the Memory");
            WRITE_PROGRAM(32'b00000000001000001010001000100011,0);
            #CLK_PERIOD
            WRITE_PROGRAM(32'b00000000001000001000000110110011,1);
            #CLK_PERIOD
            WRITE_PROGRAM(32'b000000000101000001000001000010011,2);
            #CLK_PERIOD
            WRITE_PROGRAM(32'b00000000000000101010001110000011,3);
            #CLK_PERIOD
            WRITE_PROGRAM(32'b00000000000100001000000001100011,4);
            #CLK_PERIOD
            W_EN_TB = 0;
            R_EN_TB = 1;
            #(CLK_PERIOD)
              @(negedge CLK_TB)
              if(DUT.RAM.MEM[1] == 2 )
            $display("Test Case Passed and the Value stored in REG 2 = %d  at Time ",DUT.RAM.MEM[1],$time);
            else
            $display("Test Case Falled and the Value stored in REG 2 = %d  at Time ",DUT.RAM.MEM[1],$time);
         
            #(CLK_PERIOD)
            @(negedge CLK_TB)
             $display("TESTING R Instruction Add operation (add x3, x1, x2)  REG3 == 1 + 2 ") ;
             if( DUT.REG_FILE.REGESTERS[3] == 3 )
            $display("Test Case Passed and the Value stored in REG 3 = %d  at Time ",DUT.REG_FILE.REGESTERS[3],$time);
            else
            $display("Test Case Falled and the Value stored in REG 3 = %d  at Time ",DUT.REG_FILE.REGESTERS[3],$time);

            #(CLK_PERIOD)
            @(negedge CLK_TB)
             $display("TESTING I Instruction Addi operation (addi x4, x1, 10) REG4 == 1 + 10") ;
             if(DUT.REG_FILE.REGESTERS[4] == 11 )
            $display("Test Case Passed and the Value stored in REG 4 = %d  at Time ",DUT.REG_FILE.REGESTERS[4],$time);
            else
            $display("Test Case Falled and the Value stored in REG 4 = %d  at Time ",DUT.REG_FILE.REGESTERS[4],$time);

             #(CLK_PERIOD)
            @(negedge CLK_TB)
             $display("TESTING lw Instruction Load operation (lw x7, 4(x1)) loading From Location 1 in The Memory = 2  Into REG7") ;
             if(DUT.REG_FILE.REGESTERS[7] == 2 )
            $display("Test Case Passed and the Value stored in REG 7 = %d  at Time ",DUT.REG_FILE.REGESTERS[7],$time);
            else
            $display("Test Case Falled and the Value stored in REG 7 = %d  at Time ",DUT.REG_FILE.REGESTERS[7],$time);

            #(CLK_PERIOD)
             $display("TESTING BEQ Instruction  (beq x1, x1, label) Branching into label  ") ;
             if(DUT.PC_COUNTER.PC == DUT.PC_COUNTER.PC_TARGET )
            $display("Test Case Passed and the Value For PC = %d  at Time ",DUT.PC_COUNTER.PC,$time);
            else
            $display("Test Case Falled and the Value For PC = %d  at Time ",DUT.PC_COUNTER.PC,$time);
            R_EN_TB = 0;


 


#(3*CLK_PERIOD)
$stop ;
    
         end





/////initialization/// 
task initialization ;
begin
CLK_TB  = 1'b0 ;
RST_TB  = 1'b1 ;
R_EN_TB = 0;
W_EN_TB = 0;
W_INSTRUCTION_TB = 0;
ADDRESS_TB = 0;
end
endtask

//////RST/////
task Reset ;
begin
RST_TB  = 1'b1 ;
#CLK_PERIOD
RST_TB  = 1'b0 ;
#CLK_PERIOD
RST_TB  = 1'b1 ;
end
endtask

task WRITE_PROGRAM ;
  input reg [31:0]             inst;
  input reg [4:0]   ADDR;
  begin
    W_INSTRUCTION_TB = inst;
    ADDRESS_TB       = ADDR;
  end
endtask








always  #(CLK_PERIOD/2)    CLK_TB = ~CLK_TB ;

SINGLE_RISC_V_TOP   #(.ADDRESS_BITS(4)) DUT (
                                                       
                                                        .CLK(CLK_TB),
                                                        .RST(RST_TB),
                                                        .R_EN(R_EN_TB),
                                                        .W_EN(W_EN_TB),
                                                        .W_INSTRUCTION(W_INSTRUCTION_TB),
                                                        .ADDRESS(ADDRESS_TB),
                                                        .RD1(RD1_TB),
                                                        .RD2(RD2_TB),
                                                        .RESULT(RESULT_TB),
                                                        .ALU_RESULT(ALU_RESULT_TB)
                                                       );




    
endmodule
