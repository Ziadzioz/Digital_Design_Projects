module ALU (
             input wire                ALU_SRC,
             input wire        [31:0]  RD1,RD2,IMMEXT,
             input wire        [2:0]   ALU_CONTROL,
             output wire               ZERO,
             output reg signed [31:0]  ALU_RESULT
            );
             
                    reg signed  [31:0]  A,B;
      
      always @(*)
        begin
         
             A = RD1;

                if (ALU_SRC)
                begin
                    B = IMMEXT;
                end
                else
                begin
                    B = RD2;
                end
          
            case (ALU_CONTROL)
                3'b000:        ALU_RESULT = A + B; 
                3'b001:        ALU_RESULT = A - B;
                3'b011:        ALU_RESULT = A | B;
                3'b010:        ALU_RESULT = A & B;
                3'b111:        ALU_RESULT = A << B;
                3'b101:        ALU_RESULT = A >> B;
                default:       ALU_RESULT = A + B;
            endcase
         end
         
 assign   ZERO  = (A == B);

endmodule
