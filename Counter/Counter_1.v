/* 
1- This code we combine the sequential and combinational logic in the same always block
2- Using always block to implement zero flag logic
*/

module Down_Counter (

input     wire               clock,           
input     wire   [3:0]       in,
input     wire               latch,  
input     wire               dec,    
output    reg    [3:0]       counter, 
output    reg                zero  ) ;


always@(posedge clock) 
  begin      
     if (latch) 
       begin 
        counter <= in; 
       end     
    else if (dec && !zero) 
      begin 
        counter <= counter - 4'b0001; 
      end 
  end  

always @(*)
 begin
   if(counter == 4'b0)
    begin
     zero = 1'b1 ;
    end
   else
    begin
     zero = 1'b0 ;
    end
 end

  
endmodule