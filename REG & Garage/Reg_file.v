module Reg_file (
  input wire CLK,RST,RD_EN,WR_EN,
  input wire [2:0] Address_Reg,
  input wire [15:0] WR_DATA,
  output reg [15:0] RD_DATA
  );
  
  reg [15:0] Reg_file [7:0];
  
  always @(posedge CLK or negedge RST)
    begin
      if (!RST)
       begin
        Reg_file[0] <= 0;
        Reg_file[1] <= 0;
        Reg_file[2] <= 0;
        Reg_file[3] <= 0;
        Reg_file[4] <= 0;
        Reg_file[5] <= 0;
        Reg_file[6] <= 0;
        Reg_file[7] <= 0;
       end
     else
       begin
       if ((!RD_EN)&&WR_EN)
         begin
           case (Address_Reg)
             000: Reg_file[0] <= WR_DATA;
             001: Reg_file[1] <= WR_DATA;
             010: Reg_file[2] <= WR_DATA;
             011: Reg_file[3] <= WR_DATA;
             100: Reg_file[4] <= WR_DATA;
             101: Reg_file[5] <= WR_DATA;
             110: Reg_file[6] <= WR_DATA;
             111: Reg_file[7] <= WR_DATA;
           endcase
         end
       else if (RD_EN&&(!WR_EN))
         begin
           case (Address_Reg)
             000: RD_DATA <= Reg_file[0];
             001: RD_DATA <= Reg_file[1];
             010: RD_DATA <= Reg_file[2];
             011: RD_DATA <= Reg_file[3];
             100: RD_DATA <= Reg_file[4];
             101: RD_DATA <= Reg_file[5];
             110: RD_DATA <= Reg_file[6];
             111: RD_DATA <= Reg_file[7];
           endcase
         end
       else
         RD_DATA <= 0;
      end
     end
   endmodule
         
         
         
             
             
             
             
             
             
             
             
             
             
             
          
