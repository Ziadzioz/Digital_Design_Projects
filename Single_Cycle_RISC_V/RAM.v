module RAM (
             input wire               CLK,RST,MEM_W,
             input wire  [1:0]        RESULT_SRC,
             input wire  [31:0]       ALU_RESULT,RD2,PC,
             output reg  [31:0]       RESULT
           );
                     
                    reg  [31:0]       READ_DATA;
                    reg  [31:0]       MEM         [255:0];
                    integer           i;

            
            always @(posedge CLK or negedge RST)
                  begin
                    
                    if (!RST)
                      begin
                                  RESULT <= 0;
                         for (i = 0;i<256 ; i = i + 1)
                           begin
                                  MEM[i] <= 0;
                           end
                      end
                    else if (MEM_W)
                       begin
                             MEM[ALU_RESULT[9:2]] <= RD2;    
                       end
                  end

            always @(*)
              begin
                if (!MEM_W)
                   begin
                             READ_DATA = MEM[ALU_RESULT[9:2]];
                   end
                else
                    begin
                             READ_DATA = 0;
                    end
                
                case (RESULT_SRC)
                    2'b00:  RESULT = ALU_RESULT;
                    2'b01:  RESULT = READ_DATA;
                    2'b10:  RESULT = PC + 4;
                    default: RESULT = ALU_RESULT;
                endcase
                   
              end

endmodule
