//time_unit = 1us & time percision = 1ns
`timescale 1us/1ns

// testbench has no inputs or outputs
module ALU_TB ();

//declare testbench signals
reg               clock_tb ;            
reg   [15:0]      A_TB,B_TB ;
reg   [3:0]       ALU_FUNC_TB ;     
wire              Arith_flag_TB,Logic_flag_TB,CMP_flag_TB,Shift_flag_TB ;
wire  [15:0]      ALU_OUT_TB ;



//initial block
initial
 begin
  $dumpfile("ALU_RTL.vcd"); // waveforms in this file      
  $dumpvars;              // saves all waveforms   
  clock_tb = 1'b0;
  A_TB = 16'b0000000001010101;   
  B_TB = 16'b0000000010101010;     
  ALU_FUNC_TB = 4'b0000;  
  $display ("TEST CASE 1") ;  // test ADD Function   
  #10
  if ( ALU_OUT_TB == A_TB+B_TB&&Arith_flag_TB == 1)
    $display ("TEST CASE 1 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 1 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 2") ;  // test SUB priority
  #3 
   ALU_FUNC_TB = 4'b0001;
  #7
  if  ( ALU_OUT_TB == A_TB-B_TB&&Arith_flag_TB == 1)
    $display ("TEST CASE 2 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 2 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 3") ;  // test MULTIPLICATION 
  
 
  #3 
   ALU_FUNC_TB = 4'b0010;
  #7
  if ( ALU_OUT_TB == 16'b0011100001110010&&Arith_flag_TB == 1)
    $display ("TEST CASE 3 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 3 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 4") ;  // test DIVIDING   
   #3 
   ALU_FUNC_TB = 4'b0011;
  #7
  if ( ALU_OUT_TB == 16'b0&&Arith_flag_TB == 1)
    $display ("TEST CASE 4 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 4 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 5") ;  // test AND
   #3 
   ALU_FUNC_TB = 4'b0100;
  #7
  if ( ALU_OUT_TB == 16'b0&&Logic_flag_TB == 1)
    $display ("TEST CASE 5 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 5 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 6") ;  // test OR
  
   #3 
   ALU_FUNC_TB = 4'b0101;
  #7
  if ( ALU_OUT_TB == 16'b0000000011111111&&Logic_flag_TB == 1)
    $display ("TEST CASE 6 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 6 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 7") ;  // test NAND 
  #3 
   ALU_FUNC_TB = 4'b0110;
  #7
  if ( ALU_OUT_TB == 16'b1111111111111111&&Logic_flag_TB == 1)
    $display ("TEST CASE 7 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 7 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 8") ;  // test NOR 
   #3 
   ALU_FUNC_TB = 4'b0111;
  #7
  if ( ALU_OUT_TB == 16'b1111111100000000&&Logic_flag_TB == 1)
    $display ("TEST CASE 8 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 8 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 9") ;  // test XOR
   #3 
   ALU_FUNC_TB = 4'b1000;
  #7
  if  ( ALU_OUT_TB == 16'b0000000011111111&&Logic_flag_TB == 1)
    $display ("TEST CASE 9 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 9 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 10") ;  // test XNOR 
   #3 
   ALU_FUNC_TB = 4'b1001;
  #7
  if  ( ALU_OUT_TB == 16'b1111111100000000&&Logic_flag_TB == 1)
    $display ("TEST CASE 10 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 10 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 11") ;  // test CMP 
   #3 
   ALU_FUNC_TB = 4'b1010;
  #7
  if  ( ALU_OUT_TB == 16'b0&&CMP_flag_TB == 1)
    $display ("TEST CASE 11 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 11 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 12") ;  // test GREATER THAN 
   #3 
   ALU_FUNC_TB = 4'b1011;
  #7
  if ( ALU_OUT_TB == 16'b0&&CMP_flag_TB == 1)
    $display ("TEST CASE 12 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 12 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 13") ;  // test LESS THAN 
   #3 
   ALU_FUNC_TB = 4'b1100;
  #7
  if ( ALU_OUT_TB == 3&&CMP_flag_TB == 1)
    $display ("TEST CASE 13 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 13 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 14") ;  // test SHIFT right
   #3 
   ALU_FUNC_TB = 4'b1101;
  #7
  if ( ALU_OUT_TB == 16'b0000000000101010 &&Shift_flag_TB == 1)
    $display ("TEST CASE 14 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 14 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("TEST CASE 15") ;  // test SHIFT left
   #3 
   ALU_FUNC_TB = 4'b1110;
  #7
  if ( ALU_OUT_TB == 16'b0000000010101010&&Shift_flag_TB == 1)
    $display ("TEST CASE 15 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 15 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time); 
    $display ("TEST CASE 16") ;  // test NOP
   #3 
   ALU_FUNC_TB = 4'b1111;
  #7
  if ( ALU_OUT_TB == 16'b0)
    $display ("TEST CASE 16 is passed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);
  else
    $display ("TEST CASE 16 is failed with ALU_OUT value = %0h at simulation time",ALU_OUT_TB,$time);   
  $display ("DONE") ;  // THE PROJECT IS FINISHED
  #5 
  $stop;  //finished with simulation 
 end
// Clock Generator
always #5 clock_tb =!clock_tb  ;      // clock frequency 100 MHz


// Design instantiation

ALU_RTL DUT (
.CLK(clock_tb),            
.A(A_TB), 
.B(B_TB),   
.ALU_FUNC(ALU_FUNC_TB), 
.ALU_OUT(ALU_OUT_TB),    
.Arith_flag(Arith_flag_TB),
.CMP_flag(CMP_flag_TB),
.Shift_flag(Shift_flag_TB),
.Logic_flag(Logic_flag_TB)
);
endmodule