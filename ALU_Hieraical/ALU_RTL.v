module ALU_RTL (
  input wire [15:0] A,B ,
  input wire [3:0] ALU_FUNC,
  input wire CLK,
  output reg [15:0] ALU_OUT,
  output reg Arith_flag,Logic_flag,CMP_flag,Shift_flag
  );
  
  reg [15:0] ALU_INT;
  
  always@(*)
begin
  
  case(ALU_FUNC)
    
    4'b0000:ALU_INT=A+B;
    4'b0001:ALU_INT=A-B;
    4'b0010:ALU_INT=A*B;
    4'b0011:ALU_INT=A/B;
    4'b0100:ALU_INT=A&B;
    4'b0101:ALU_INT=A|B;
    4'b0110:ALU_INT=~(A&B);
    4'b0111:ALU_INT=~(A|B);
    4'b1000:ALU_INT=A^B;
    4'b1001:ALU_INT=~(A^B);
    4'b1010:  begin
        if (A==B)
          ALU_INT=1;
        else
ALU_INT=0;
      end
    4'b1011: begin
          if (A>B)
            ALU_INT=2;
          else
            ALU_INT=0;
        end
    4'b1100: begin
        if (A<B)
          ALU_INT=3;
        else
          ALU_INT=0;
      end
    4'b1101:ALU_INT=A >> 1;
    4'b1110:ALU_INT=A << 1;
    
    default:ALU_INT=16'b0;
endcase     
end

always @ (posedge CLK)
    
begin
  ALU_OUT<=ALU_INT;
end

always @ (*)
begin
if(ALU_FUNC==4'b0000||ALU_FUNC==4'b0001||ALU_FUNC==4'b0010||ALU_FUNC==4'b0011)
   Arith_flag=1;
 else
 Arith_flag=0;
 
  if(ALU_FUNC==4'b0100||ALU_FUNC==4'b0101||ALU_FUNC==4'b0110||ALU_FUNC==4'b0111||ALU_FUNC==4'b1000||ALU_FUNC==4'b1001)
   Logic_flag=1;
 else
 Logic_flag=0;
 
   if(ALU_FUNC==4'b1010||ALU_FUNC==4'b1011||ALU_FUNC==4'b1100)
   CMP_flag=1;
 else
 CMP_flag=0;
 
  if(ALU_FUNC==4'b1101||ALU_FUNC==4'b1110)
   Shift_flag=1;
 else
 Shift_flag=0;
 end
endmodule
