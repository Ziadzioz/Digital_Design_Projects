`timescale 1us/1ns

module Reg_file_TB ();
  reg CLK_TB,RST_TB,RD_EN_TB,WR_EN_TB;
  reg [2:0] Address_Reg_TB;
  reg [15:0] WR_DATA_TB;
  wire [15:0] RD_DATA_TB;
  
   initial
     begin
        $dumpfile("Reg_file.vcd");
        $dumpvars;
        CLK_TB = 0;
        RST_TB = 1;
        WR_EN_TB = 0;
        RD_EN_TB = 0;
        
        #3
          RST_TB = 0;   // To rest All Reg files
        #5
          RST_TB = 1;
        #5
          Address_Reg_TB = 3'b000;   // address of reg[0]
          RD_EN_TB = 1;
          $display ("Test Rest Function");
        #5
          if (RD_DATA_TB == 0)
            $display ("Test Case 1 is passed with value stored inside Reg[0] is =%0d at Time",RD_DATA_TB,$time);
          else
            $display ("Test Case 1 is falled with value stored inside Reg[0] is =%0d at Time",RD_DATA_TB,$time);
        #5
          Address_Reg_TB = 3'b000;   // address of reg[0]
          WR_EN_TB = 1;
          RD_EN_TB = 0;
          WR_DATA_TB = 16'b0000000000001111;
          $display ("Test wirte Function");
        #5
          if (RD_DATA_TB == 0)
            $display ("Test Case 2 is passed with value stored inside Reg[0] is =%0d at Time",RD_DATA_TB,$time);
          else
            $display ("Test Case 2 is falled with value stored inside Reg[0] is =%0d at Time",RD_DATA_TB,$time);
        #5
          Address_Reg_TB = 3'b000;   // address of reg[0]
          RD_EN_TB = 1;
          WR_EN_TB = 0;
          $display ("Test read Function");
        #5
          if (RD_DATA_TB == 16'b0000000000001111)
            $display ("Test Case 3 is passed with value stored inside Reg[0] is =%0d at Time",RD_DATA_TB,$time);
          else
            $display ("Test Case 3 is falled with value stored inside Reg[0] is =%0d at Time",RD_DATA_TB,$time);
        #5
          Address_Reg_TB = 3'b001;   // address of reg[1]
          WR_EN_TB = 1;
          RD_EN_TB = 0;
          WR_DATA_TB = 16'b1111111111111111;
          $display ("Test wirte Function");
        #5
          if (RD_DATA_TB == 16'b0000000000001111)
            $display ("Test Case 4 is passed with value stored inside Reg[0] is =%0d at Time",RD_DATA_TB,$time);
          else
            $display ("Test Case 4 is falled with value stored inside Reg[0] is =%0d at Time",RD_DATA_TB,$time);
        #5
          Address_Reg_TB = 3'b001;   // address of reg[1]
          RD_EN_TB = 1;
          WR_EN_TB = 0;
          $display ("Test read Function");
        #5
          if (RD_DATA_TB == 16'b1111111111111111)
            $display ("Test Case 5 is passed with value stored inside Reg[1] is =%0d at Time",RD_DATA_TB,$time);
          else
            $display ("Test Case 5 is falled with value stored inside Reg[1] is =%0d at Time",RD_DATA_TB,$time);
             
             $display ("DONE") ;  // THE PROJECT IS FINISHED
            
            #5
            $stop;
            
      end
            // Clock Generator
         always #5 CLK_TB =!CLK_TB  ;      // clock frequency 100 MHz
      
      Reg_file DUT (
                    .CLK(CLK_TB),
                    .RST(RST_TB),
                    .RD_EN(RD_EN_TB),
                    .WR_EN(WR_EN_TB),
                    .Address_Reg(Address_Reg_TB),
                    .WR_DATA(WR_DATA_TB),
                    .RD_DATA(RD_DATA_TB)
                    );

endmodule