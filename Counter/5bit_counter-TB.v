
//time_unit = 1ns & time percision = 1ps
`timescale 1ns/1ps

// testbench has no inputs or outputs
module five_Counter_tb ();

//declare testbench signals
reg               clock_tb ;            
reg   [4:0]       in_tb ;
reg               load_tb ;  
reg               down_tb ; 
reg               up_tb ;   
wire              high_tb ;
wire              low_tb ;
wire   [4:0]      counter_tb ;



//initial block
initial
 begin
  $dumpfile("five_bit_counter.vcd"); // waveforms in this file      
  $dumpvars;              // saves all waveforms   
  clock_tb = 1'b0;   
  load_tb = 1'b1;   
  down_tb = 1'b0;  
  up_tb = 1'b0; 
  in_tb = 5'b10111;  
  $display ("TEST CASE 1") ;  // test load Function   
  #10
  if (counter_tb == 5'b10111)
    $display ("TEST CASE 1 is passed with counter value = %0h at simulation time",counter_tb,$time);
  else
    $display ("TEST CASE 1 is failed with counter value = %0h at simulation time",counter_tb,$time);   
  $display ("TEST CASE 2") ;  // test load priority
  #3 
  load_tb = 1'b1;     
  down_tb = 1'b1; 
  #7
  if (counter_tb == 5'b10111)
    $display ("TEST CASE 2 is passed with counter value = %0h at simulation time",counter_tb,$time);
  else
    $display ("TEST CASE 2 is failed with counter value = %0h at simulation time",counter_tb,$time);  
  $display ("TEST CASE 3") ;  // test down Function   
 
  #3
   load_tb = 1'b0;
   down_tb = 1'b1;
  #7
  if (counter_tb == 5'b10110)
    $display ("TEST CASE 3 is passed with counter value = %0h at simulation time",counter_tb,$time);
  else
    $display ("TEST CASE 3 is failed with counter value = %0h at simulation time",counter_tb,$time);    
  $display ("TEST CASE 4") ;  // test up Function   
  #3
   load_tb = 1'b1;    //to load the input in counter so we can check 
   down_tb = 1'b0;
  #10
   load_tb = 1'b0;
   up_tb = 1'b1;
  #7
  if (counter_tb == 5'b11000)
    $display ("TEST CASE 4 is passed with counter value = %0h at simulation time",counter_tb,$time);
  else
    $display ("TEST CASE 4 is failed with counter value = %0h at simulation time",counter_tb,$time);    
  $display ("TEST CASE 5") ;  // test down periorty 
  #3
   load_tb = 1'b1;    //to load the input in counter so we can check
   up_tb = 1'b0;
  #10
    load_tb = 1'b0;
    up_tb = 1'b1;
    down_tb = 1'b1;
  #7
  if (counter_tb == 5'b10110)
    $display ("TEST CASE 5 is passed with counter value = %0h at simulation time",counter_tb,$time);
  else
    $display ("TEST CASE 5 is failed with counter value = %0h at simulation time",counter_tb,$time);    
  $display ("TEST CASE 6") ;  // test low flag 
  
  #300
  if (counter_tb == 5'b0 && low_tb == 1'b1)
    $display ("TEST CASE 6 is passed with counter value = %0h at simulation time",counter_tb,$time);
  else
    $display ("TEST CASE 6 is failed with counter value = %0h at simulation time",counter_tb,$time); 
   $display ("TEST CASE 7") ;  // test high flag
  #3
    load_tb = 1'b0;
    up_tb = 1'b1;
    down_tb = 1'b0;
  #400
  if (counter_tb == 5'b11111 && high_tb == 1'b1)
    $display ("TEST CASE 7 is passed with counter value = %0h at simulation time",counter_tb,$time);
  else
    $display ("TEST CASE 7 is failed with counter value = %0h at simulation time",counter_tb,$time); 
   $display ("DONE") ;  // ALL UNDER CONTROL

  #5 
  $stop;  //finished with simulation 
 end
// Clock Generator
always #5 clock_tb =!clock_tb  ;      // clock frequency 100 MHz


// Design instantiation

five_bit_Counter DUT (
.clock(clock_tb),            
.in(in_tb), 
.load(load_tb),   
.down(down_tb), 
.up(up_tb), 
.counter(counter_tb),    
.low(low_tb),
.high(high_tb)
);
  
endmodule