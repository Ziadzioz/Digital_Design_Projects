module PC_COUNTER (
                    input  wire          CLK,RST,R_EN,
                    input  wire          PCSRC,
                    input  wire  [31:0]  IMMEXT,
                    output reg   [31:0]  PC
                   );

                   wire  [31:0]  PC_TARGET;
                   reg   [31:0]  pc;
    
    always @(posedge CLK or negedge RST )
      begin
        if(!RST)
          begin
                 pc  <= 0;
          end
        else if (R_EN)
          begin
                 case (PCSRC)
                    1'b0: pc    <= pc + 4;
                    1'b1: pc    <= PC_TARGET;
                 endcase
          end
       end
always @(*)
  begin
    if (R_EN)
      begin
        if(pc != 0)
        PC = pc - 4;
        else
        PC = 0;
       end
    else
        PC = 0;
       
   end
assign  PC_TARGET = PC + IMMEXT ;

endmodule
