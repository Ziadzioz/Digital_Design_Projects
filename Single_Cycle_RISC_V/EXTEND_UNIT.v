module EXTEND_UNIT (
                    input wire  [1:0]              IMMSRC,
                    input wire  [31:0]             INSTRUCTION,
                    output reg  [31:0]             IMMEXT
                    );
    
    always @(*)
      begin
        
        case (IMMSRC)
            2'b00:     IMMEXT = {{20{INSTRUCTION[31]}},INSTRUCTION[31:20]} ; // I TYPE
            2'b01:     IMMEXT = {{20{INSTRUCTION[31]}},INSTRUCTION[31:25],INSTRUCTION[11:7]} ; // S TYPE
            2'b10:     IMMEXT = {{20{INSTRUCTION[31]}},INSTRUCTION[7],INSTRUCTION[30:25],INSTRUCTION[11:8],1'b0} ; // B TYPE
            2'b11:     IMMEXT = {{12{INSTRUCTION[31]}},INSTRUCTION[19:12],INSTRUCTION[20],INSTRUCTION[30:21],1'b0} ; // J TYPE 
        endcase
      end
      
endmodule
