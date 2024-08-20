`timescale 1us/1ns

module Reg_file_TB    #(
                    parameter DATA_WIDTH    = 8,
                              ADDRESS_BITS  = 3)();
  reg CLK_TB,RST_TB,R_REG_EN_TB,W_REG_EN_TB;
  wire                        R_DATA_VALID;
  reg [3:0] REG_ADDRESS_TB;
  reg [7:0] W_REG_DATA_TB;
  wire [7:0] R_REG_DATA_TB,REG0,REG1,REG2,REG3;
  
   initial
     begin
        $dumpfile("Reg_file.vcd");
        $dumpvars;
        CLK_TB = 0;
        RST_TB = 1;
        W_REG_EN_TB = 0;
        R_REG_EN_TB = 0;
        
        #3
          RST_TB = 0;   // To rest All Reg files
        #5
          RST_TB = 1;
        #5
          REG_ADDRESS_TB = 3'b010;   // address of reg[0]
          R_REG_EN_TB = 1;
          $display ("Test Rest Function");
        #5
          if (R_REG_DATA_TB == 8'b10000010)
            $display ("Test Case 1 is passed with value stored inside Reg[0] is =%0d at Time",R_REG_DATA_TB,$time);
          else
            $display ("Test Case 1 is falled with value stored inside Reg[0] is =%0d at Time",R_REG_DATA_TB,$time);
        #5
          REG_ADDRESS_TB = 3'b111;   // address of reg[0]
          W_REG_EN_TB = 1;
          R_REG_EN_TB = 0;
          W_REG_DATA_TB = 8'b00001111;
          $display ("Test wirte Function");
        #5
          if (R_REG_DATA_TB == 0)
            $display ("Test Case 2 is passed with value stored inside Reg[0] is =%0d at Time",R_REG_DATA_TB,$time);
          else
            $display ("Test Case 2 is falled with value stored inside Reg[0] is =%0d at Time",R_REG_DATA_TB,$time);
        #5
          REG_ADDRESS_TB = 3'b111;   // address of reg[0]
          R_REG_EN_TB = 1;
          W_REG_EN_TB = 0;
          $display ("Test read Function");
        #5
          if (R_REG_DATA_TB == 16'b00001111)
            $display ("Test Case 3 is passed with value stored inside Reg[0] is =%0d at Time",R_REG_DATA_TB,$time);
          else
            $display ("Test Case 3 is falled with value stored inside Reg[0] is =%0d at Time",R_REG_DATA_TB,$time);
        #5
          REG_ADDRESS_TB = 3'b001;   // address of reg[1]
          W_REG_EN_TB = 1;
          R_REG_EN_TB = 0;
          W_REG_DATA_TB = 16'b1111111111111111;
          $display ("Test wirte Function");
        #5
          if (R_REG_DATA_TB == 16'b0000000000001111)
            $display ("Test Case 4 is passed with value stored inside Reg[0] is =%0d at Time",R_REG_DATA_TB,$time);
          else
            $display ("Test Case 4 is falled with value stored inside Reg[0] is =%0d at Time",R_REG_DATA_TB,$time);
        #5
          REG_ADDRESS_TB = 3'b001;   // address of reg[1]
          R_REG_EN_TB = 1;
          W_REG_EN_TB = 0;
          $display ("Test read Function");
        #5
          if (R_REG_DATA_TB == 16'b1111111111111111)
            $display ("Test Case 5 is passed with value stored inside Reg[1] is =%0d at Time",R_REG_DATA_TB,$time);
          else
            $display ("Test Case 5 is falled with value stored inside Reg[1] is =%0d at Time",R_REG_DATA_TB,$time);
             
             $display ("DONE") ;  // THE PROJECT IS FINISHED
            
            #5
            $stop;
            
      end
            // Clock Generator
         always #5 CLK_TB =!CLK_TB  ;      // clock frequency 100 MHz
      
      Reg_file               #(
                              .DATA_WIDTH(8),
                              .ADDRESS_BITS(3)) DUT (
                    .CLK(CLK_TB),
                    .RST(RST_TB),
                    .R_REG_EN(R_REG_EN_TB),
                    .W_REG_EN(W_REG_EN_TB),
                    .REG_ADDRESS(REG_ADDRESS_TB),
                    .W_REG_DATA(W_REG_DATA_TB),
                    .R_REG_DATA(R_REG_DATA_TB),
                    .R_DATA_VALID(R_DATA_VALID),
                    .REG0(REG0),
                    .REG1(REG1),
                    .REG2(REG2),
                    .REG3(REG3)
                    );

endmodule