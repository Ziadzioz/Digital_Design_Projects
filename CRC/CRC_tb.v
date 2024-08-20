`timescale 1us/1ns

module CRC_tb();
reg         CLK_TB ;
reg         RST_TB ;
reg         ACTIVE_TB ;
reg         DATA_TB ;
wire        CRC_TB  ; 
wire        Valid_TB;


reg   [7:0] Test_Cases   [9:0] ;
reg   [7:0] the_output   [9:0] ;
 
integer num_case ;
integer i ;


initial 
 begin
 $dumpfile("CRC_REG.vcd") ;       
 $dumpvars; 

 $readmemh("DATA_h.txt", Test_Cases);
 $readmemh("Expec_Out_h.txt",the_output);

initialization () ;
Reset () ;


for(num_case=0; num_case<=9; num_case=num_case+1)
begin

main(Test_Cases[num_case]) ;
check(the_output[num_case],num_case) ;

end




 #100
 $finish ;
 
 end


/////initialization/// 
task initialization ;
begin
CLK_TB  = 1'b0 ;
RST_TB  = 1'b0 ;
ACTIVE_TB = 1'b0 ;
end
endtask

//////RST/////
task Reset ;
begin
RST_TB  = 1'b1 ;
#10
RST_TB  = 1'b0 ;
#10
RST_TB  = 1'b1 ;
end
endtask

//////main////
task main ; ////mhtagen nzabt hett al bit by bit bta3t al data 
input reg [7:0] input_data ;
begin

ACTIVE_TB = 1'b1 ;
for (i=0;i<=7;i=i+1)
begin
@(negedge CLK_TB)
DATA_TB  = input_data[i] ;
end
#10
ACTIVE_TB = 1'b0 ;
end
endtask

//check
task check ;
input reg  [7:0] THE_OUTPUT ; 
input integer    Oper_Num   ;
reg    [7:0]     gener_out  ;
integer j ;

begin 
ACTIVE_TB =1'b0 ;
for(j=0;j<=7;j=j+1)
begin
#10 
gener_out[j] = CRC_TB ;
end
if(gener_out == THE_OUTPUT)  
    begin
     $display("Test Case %d is succeeded",Oper_Num);
    end 
   else
    begin
     $display("Test Case %d is failed",Oper_Num);
    end


end

endtask


//clock
always #5 CLK_TB = ~CLK_TB ;

CRC_REG DUT (
.CLK(CLK_TB),
.RST(RST_TB),
.ACTIVE(ACTIVE_TB),
.Valid(Valid_TB),
.DATA(DATA_TB),   
.CRC(CRC_TB)
);


endmodule
