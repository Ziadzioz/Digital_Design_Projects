module ROM #(
             parameter  ADDRESS_BITS = 4           
            ) (     
                    input  wire                     W_EN,R_EN,
                    input  wire  [31:0]             W_INSTRUCTION,
                    input  wire  [ADDRESS_BITS:0]   ADDRESS,
                    input  wire  [31:0]             PC,
                    output reg   [31:0]             INSTRUCTION
              );
                           reg   [31:0]             REG  [31:0];
                
                always @(*)
                  begin
                   
                   if (W_EN)
                     begin
                            REG [ADDRESS]  = W_INSTRUCTION;
                            INSTRUCTION     = 0;
                     end
                   else if (R_EN)
                     begin
                         
                            INSTRUCTION  = REG [PC >> 2];    
                     end
                    else
                      begin
                            REG [ADDRESS]  = 0;
                            INSTRUCTION     = 0;
                      end
                    end
endmodule
