module SINGLE_RISC_V_TOP #(
                                                 parameter  ADDRESS_BITS = 4           
                          )(
                            input  wire                             CLK,RST,R_EN,W_EN,
                            input  wire          [31:0]             W_INSTRUCTION,
                            input  wire          [ADDRESS_BITS:0]   ADDRESS,
                            output wire          [31:0]             RD1,RD2,RESULT,
                            output wire signed   [31:0]             ALU_RESULT
                          );
                                  wire           ZERO,PCSRC;
                                  wire  [1:0]    IMMSRC;
                                  wire  [31:0]   PC,INSTRUCTION,IMMEXT;                         
                                  wire           MEM_W,ALU_SRC,REG_W;
                                  wire   [1:0]   RESULT_SRC;
                                  wire   [2:0]   ALU_CONTROL;



    PC_COUNTER PC_COUNTER                  (

                                            .CLK(CLK),
                                            .RST(RST),
                                            .R_EN(R_EN),
                                            .PCSRC(PCSRC),
                                            .IMMEXT(IMMEXT),
                                            .PC(PC)

                                            );

    
    ROM  #(.ADDRESS_BITS(ADDRESS_BITS)) ROM  (
                                             
                                             .W_EN(W_EN),
                                             .R_EN(R_EN),
                                             .W_INSTRUCTION(W_INSTRUCTION),
                                             .ADDRESS(ADDRESS),
                                             .PC(PC),
                                             .INSTRUCTION(INSTRUCTION)

                                            );

    CONTROL_UNIT            CONTROL_UNIT    (
                                              
                                              .ZERO(ZERO),
                                              .INSTRUCTION(INSTRUCTION),
                                              .MEM_W(MEM_W),
                                              .ALU_SRC(ALU_SRC),
                                              .REG_W(REG_W),
                                              .PCSRC(PCSRC),
                                              .IMMSRC(IMMSRC),
                                              .RESULT_SRC(RESULT_SRC),
                                              .ALU_CONTROL(ALU_CONTROL)

                                             );
    
    EXTEND_UNIT       EXTEND_UNIT            (
                                              
                                              .IMMSRC(IMMSRC),
                                              .INSTRUCTION(INSTRUCTION),
                                              .IMMEXT(IMMEXT)

                                              );
    
    ALU                  ALU                  (
                                               
                                               .ALU_SRC(ALU_SRC),
                                               .RD1(RD1),
                                               .RD2(RD2),
                                               .IMMEXT(IMMEXT),
                                               .ALU_CONTROL(ALU_CONTROL),
                                               .ZERO(ZERO),
                                               .ALU_RESULT(ALU_RESULT)

                                               );
    
    REG_FILE          REG_FILE                 (
                                                
                                                .CLK(CLK),
                                                .RST(RST),
                                                .REG_W(REG_W),
                                                .INSTRUCTION(INSTRUCTION),
                                                .RESULT(RESULT),
                                                .RD1(RD1),
                                                .RD2(RD2)

                                                );

    RAM               RAM                       (
                                                 
                                                 .CLK(CLK),
                                                 .RST(RST),
                                                 .MEM_W(MEM_W),
                                                 .RESULT_SRC(RESULT_SRC),
                                                 .ALU_RESULT(ALU_RESULT),
                                                 .RD2(RD2),
                                                 .PC(PC),
                                                 .RESULT(RESULT)

                                                  );
    
endmodule
