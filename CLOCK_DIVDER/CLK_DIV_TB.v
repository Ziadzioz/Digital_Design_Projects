//time_unit = 1ns & time percision = 1ps
`timescale 1ns/1ps

module CLK_DIV_TB ();

//declare testbench signals
   reg          RST_EN_TB,I_REF_CLK_TB,CLK_EN_TB;
   reg  [7:0]   DIV_RATIO_TB;
   wire         O_DIV_CLK_TB ;

 

//initial block
initial
 begin
  $dumpfile("CLK_DIV.vcd"); // waveforms in this file      
  $dumpvars;                // saves all waveforms   

   #5  
         initialization(); 
         RESET();
       
               $display ("Test Case   test  Divde by 2 ");
               Pass_DATA (1,2);
               $display ("Test Case   Passed ");
   #400;

               $display ("Test Case   test  Divde by 3");
               Pass_DATA (1,3);
               $display ("Test Case   Passed ");
   #400;
               $display ("Test Case   test  Divde by 4");
               Pass_DATA (1,4);
               $display ("Test Case   Passed ");
   #400;
               RESET();
               $display ("Test Case   test  Divde by 5");
               Pass_DATA (1,5);
               $display ("Test Case   Passed ");
   #400;
               $display ("Test Case   test  Divde by 0");
               Pass_DATA (1,0);
               $display ("Test Case   Passed ");
   #400;
               $display ("Test Case   test  Divde by 1");
               Pass_DATA (1,1);
               $display ("Test Case   Passed ");
   #400;
    
   
   








  $stop;  //finished with simulation 
 end

task   initialization ;
     begin
             RST_EN_TB = 1;
             I_REF_CLK_TB = 0;
             CLK_EN_TB = 1;
             DIV_RATIO_TB = 2;
     end
endtask



task   RESET ;
      begin
        RST_EN_TB  = 1'b1 ;
     #10
        RST_EN_TB  = 1'b0 ;
     #10
        RST_EN_TB  = 1'b1 ;
      end
endtask 

task   Pass_DATA ;
 input reg       CLk_en; 
 input reg [7:0] div;

     begin
             CLK_EN_TB = CLk_en;
             DIV_RATIO_TB = div;
     end
 endtask




















// Clock Generator
always #10 I_REF_CLK_TB =!I_REF_CLK_TB  ;      // assume clock frequency 100 MHz


// Design instantiation

CLK_DIV DUT (
.RST_EN(RST_EN_TB),            
.I_REF_CLK(I_REF_CLK_TB), 
.CLK_EN(CLK_EN_TB),   
.DIV_RATIO(DIV_RATIO_TB), 
.O_DIV_CLK(O_DIV_CLK_TB)
);
  
endmodule