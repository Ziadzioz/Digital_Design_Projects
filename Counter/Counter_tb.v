//time_unit = 1ns & time percision = 1ps
`timescale 1ns/1ps

// testbench has no inputs or outputs
module Down_Counter_tb ();

//declare testbench signals
reg               clock_tb ;            
reg   [3:0]       in_tb ;
reg               latch_tb ;  
reg               dec_tb ;    
wire              zero_tb ;
wire    [3:0]     counter_tb ;

//initial block
initial
 begin
  $dumpfile("count.vcd"); // waveforms in this file      
  $dumpvars;              // saves all waveforms   
  clock_tb = 1'b0;   
  latch_tb = 1'b0;   
  dec_tb = 1'b0;   
  in_tb = 4'b1010;  
  $display ("TEST CASE 1") ;  // test latch Function   
  #10
  latch_tb = 1'b1;  
  #10
  if (counter_tb == 4'b1010)
    $display ("TEST CASE 1 is passed with counter value = %0h at simulation time",counter_tb,$time);
  else
    $display ("TEST CASE 1 is failed with counter value = %0h at simulation time",counter_tb,$time);   
  $display ("TEST CASE 2") ;  // test latch priority 
  latch_tb = 1'b1;     
  dec_tb = 1; 
  #10
  if (counter_tb == 4'b1010)
    $display ("TEST CASE 2 is passed with counter value = %0h at simulation time",counter_tb,$time);
  else
    $display ("TEST CASE 2 is failed with counter value = %0h at simulation time",counter_tb,$time);  
  $display ("TEST CASE 3") ;  // test dec Function   
  latch_tb = 1'b0; 
  #30
  if (counter_tb == 4'b111)
    $display ("TEST CASE 3 is passed with counter value = %0h at simulation time",counter_tb,$time);
  else
    $display ("TEST CASE 3 is failed with counter value = %0h at simulation time",counter_tb,$time);    
  $display ("TEST CASE 4") ;  // test dec Function   
  latch_tb = 1'b0; 
  #80
  if (counter_tb == 4'b0 && zero_tb == 1'b1)
    $display ("TEST CASE 4 is passed with counter value = %0h at simulation time",counter_tb,$time);
  else
    $display ("TEST CASE 4 is failed with counter value = %0h at simulation time",counter_tb,$time); 
  #100 
  $stop;  //finished with simulation 
 end

// Clock Generator
always #5 clock_tb = ~clock_tb  ;      // clock frequency 100 MHz

// Design instantiation

Down_Counter DUT (
.clock(clock_tb),            
.in(in_tb), 
.latch(latch_tb),   
.dec(dec_tb), 
.counter(counter_tb),    
.zero(zero_tb)
);
  
endmodule