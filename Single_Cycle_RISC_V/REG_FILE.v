module REG_FILE (
                  input  wire             CLK,RST,REG_W,
                  input  wire   [31:0]    INSTRUCTION,RESULT,
                  output reg    [31:0]    RD1,RD2
                ); 
                         
                         reg    [31:0]    REGESTERS  [31:0];
                         wire   [4:0]     RS1,RS2;
                         integer          i;
                         
                
                always @(posedge CLK or negedge RST)
                  begin
                    
                    if (!RST)
                      begin
                        RD1 <= 0;
                        RD2 <= 0;

                         for (i = 0;i<32 ; i = i + 1)
                           begin
                                  REGESTERS[i] <= i;
                           end
                          
                      end
                    else if (REG_W)
                       begin
                             REGESTERS[INSTRUCTION[11:7]] <= RESULT;    
                       end
                  end
                 
                 always @(*)
                   begin
                    
                             RD1 = REGESTERS[RS1];
                             RD2 = REGESTERS[RS2];                            
                   end

assign   RS1 = INSTRUCTION[19:15];
assign   RS2 = INSTRUCTION[24:20];

endmodule
