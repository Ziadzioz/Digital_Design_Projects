module CONTROL_UNIT (
                        input  wire                     ZERO,
                        input  wire  [31:0]             INSTRUCTION,
                        output reg                      MEM_W,ALU_SRC,REG_W,
                        output wire                     PCSRC,
                        output reg   [1:0]              IMMSRC,RESULT_SRC,
                        output reg   [2:0]              ALU_CONTROL
                     );
                       
                               reg                      BRANCH,JUMB,R_TYPE;
                               wire    [6:0]            OPCODE;
                               reg     [1:0]            ALU_OP;



          always @(*)
             begin
                             JUMB       = 0;
                             BRANCH     = 0;
                             R_TYPE     = 0;
                             RESULT_SRC = 2'b00;
                             MEM_W      = 0;
                             REG_W      = 0;
                             ALU_SRC    = 0;
                             IMMSRC     = 2'b00;
                             ALU_OP     = 2'b00;

            case (OPCODE)
                7'b0000011:   // lw INSTRUCTION
                            begin

                             JUMB       = 0;
                             BRANCH     = 0;
                             R_TYPE     = 0;
                             RESULT_SRC = 2'b01;
                             MEM_W      = 0;
                             REG_W      = 1;
                             ALU_SRC    = 1;
                             IMMSRC     = 2'b00;
                             ALU_OP     = 2'b00;

                            end

                 7'b0100011:  // sw INSTRUCTION
                            begin

                             JUMB       = 0;
                             BRANCH     = 0;
                             R_TYPE     = 0;
                             RESULT_SRC = 2'b00;  // DONT CARE
                             MEM_W      = 1;
                             REG_W      = 0;
                             ALU_SRC    = 1;
                             IMMSRC     = 2'b01;
                             ALU_OP     = 2'b00;

                            end

                 7'b0110011:  // R  INSTRUCTION
                            begin

                             JUMB       = 0;
                             BRANCH     = 0;
                             R_TYPE     = 1;
                             RESULT_SRC = 2'b00;  
                             MEM_W      = 0;
                             REG_W      = 1;
                             ALU_SRC    = 0;
                             IMMSRC     = 2'b00; // DONT CARE
                             ALU_OP     = 2'b10;

                            end

                 7'b1100011:  // BEQ  INSTRUCTION
                            begin

                             JUMB       = 0;    
                             BRANCH     = 1;
                             R_TYPE     = 0;
                             RESULT_SRC = 2'b00;     // DONT CARE
                             MEM_W      = 0;     
                             REG_W      = 0;
                             ALU_SRC    = 0;
                             IMMSRC     = 2'b10; 
                             ALU_OP     = 2'b01;

                            end

                 7'b0010011:   // I  INSTRUCTION
                            begin

                             JUMB       = 0;
                             BRANCH     = 0;
                             R_TYPE     = 0;
                             RESULT_SRC = 2'b00;
                             MEM_W      = 0;
                             REG_W      = 1;
                             ALU_SRC    = 1;
                             IMMSRC     = 2'b00;
                             ALU_OP     = 2'b10;

                            end

                 7'b1101111:   // JAL  INSTRUCTION
                            begin

                             JUMB       = 1;
                             BRANCH     = 0;
                             R_TYPE     = 0;
                             RESULT_SRC = 2'b10;
                             MEM_W      = 0;
                             REG_W      = 1;
                             ALU_SRC    = 0;       //DONT CARE
                             IMMSRC     = 2'b11;
                             ALU_OP     = 2'b00;   //DONT CARE

                            end

                default:   
                          begin
                             JUMB       = 0;
                             BRANCH     = 0;
                             R_TYPE     = 0;
                             RESULT_SRC = 2'b00;
                             MEM_W      = 0;
                             REG_W      = 0;
                             ALU_SRC    = 0;
                             IMMSRC     = 2'b00;
                             ALU_OP     = 2'b00;
                           end
            endcase

            case (ALU_OP)
                2'b00: ALU_CONTROL = 3'b000;  // ADD OPERATION for lw && sw INSTRUCTIONS
                2'b01: ALU_CONTROL = 3'b001;  // SUB OPERATION for BEQ INSTRUCTION       
                2'b10: 
                       begin
                        if(R_TYPE)
                            begin
                                    if (INSTRUCTION[30])
                                      begin
                                               if (INSTRUCTION[14:12] == 0)
                                                 begin
                                                       ALU_CONTROL = 3'b001;  // SUB OPERATION for R INSTRUCTION
                                                 end
                                              else
                                                begin
                                                       ALU_CONTROL = 3'b000; 
                                                 end
                                      end 

                                    else
                                      begin
                                               case (INSTRUCTION[14:12])
                                                3'b000: ALU_CONTROL = 3'b000;  // ADD OPERATION for R INSTRUCTION
                                                3'b001: ALU_CONTROL = 3'b111;  // SLL OPERATION for R INSTRUCTION
                                                3'b101: ALU_CONTROL = 3'b101;  // SRL OPERATION for R INSTRUCTION
                                                3'b110: ALU_CONTROL = 3'b011;  // OR  OPERATION for R INSTRUCTION
                                                3'b111: ALU_CONTROL = 3'b010;  // AND OPERATION for R INSTRUCTION
                                                default:ALU_CONTROL = 3'b000;  
                                               endcase
                                      end
                            end
                        else
                            begin
                                              case (INSTRUCTION[14:12])
                                                3'b000: ALU_CONTROL = 3'b000;  // ADD OPERATION for I INSTRUCTION
                                                3'b110: ALU_CONTROL = 3'b011;  // OR  OPERATION for I INSTRUCTION
                                                3'b111: ALU_CONTROL = 3'b010;  // AND OPERATION for I INSTRUCTION
                                                default:ALU_CONTROL = 3'b000;  
                                               endcase
                            end
                       end   

                default: ALU_CONTROL = 3'b000;
            endcase
        end

assign    OPCODE = INSTRUCTION[6:0];
assign    PCSRC  = ((ZERO && BRANCH)||(JUMB));

endmodule
