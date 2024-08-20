module five_bit_Counter (

input     wire               clock,           
input     wire   [4:0]       in,
input     wire               load,  
input     wire               up,    
input     wire               down,  
output    reg    [4:0]       counter, 
output    reg                high , 
output    reg                low ) ;


always@(posedge clock) 
  begin      
     if (load) 
       begin 
        counter <= in; 
       end     
    else if (down&&counter!=5'b00000) 
      begin 
        counter <= counter - 5'b00001; 
      end 
     else if (up&&counter!=5'b11111) 
      begin 
        counter <= counter + 5'b00001; 
      end 
     else
        begin  
         counter <= counter;
        end
   end  

always @(*)
 begin
   if(counter == 5'b0)
    begin
     low = 1'b1 ;
    end
   else
    begin
     low = 1'b0 ;
    end
   if(counter == 5'b11111)
    begin
     high = 1'b1 ;
    end
   else
    begin
     high = 1'b0 ;
    end
  end

  
endmodule
