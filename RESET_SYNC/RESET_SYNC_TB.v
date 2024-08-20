`timescale 1us/1ns
module DATA_SYNC_TB #(
   parameter  NUM_STAGES = 4
                    )();

reg                     CLK_TB,RST_TB,EN_TB;
wire                    RST_SYNC_TB;


parameter clock_period = 10;

initial
  begin
    $dumpfile("RST_SYNC.vcd") ;       
    $dumpvars; 

    INITIALIZTAION();
    $display ("TEST CASE 1 testing assertion of the asynchronous reset ");
      #clock_period
        RESET();
        $display ("TEST CASE 2 testing de-assertion of the asynchronous reset");
      #clock_period
        Deassertion() ;
       


    #(10*clock_period)
      $stop ;


  end

 task RESET ;
    begin
       #(clock_period/2)  
           RST_TB = 1;
       #clock_period
           RST_TB = 0;
       #(clock_period/2)     
         if(RST_SYNC_TB == 0)
            begin
                $display("Test_Case  is succeeded and RST_SYNC = %d  at Time ",RST_SYNC_TB,$time);
            end
         else
            begin
                $display("Test_Case  is failed and RST_SYNC = %d  at Time ",RST_SYNC_TB,$time);
            end
    end
 endtask

 task Deassertion ;
    begin
       #(clock_period)  
           RST_TB = 1;
       #(clock_period*(NUM_STAGES+1)) 
         if(RST_SYNC_TB == 1)
            begin
                $display("Test_Case  is succeeded and RST_SYNC = %d  at Time ",RST_SYNC_TB,$time);
            end
         else
            begin
                $display("Test_Case  is failed and RST_SYNC = %d  at Time ",RST_SYNC_TB,$time);
            end
    end
 endtask

 task INITIALIZTAION ;
    begin
        CLK_TB        = 0;
        RST_TB        = 1;

    end
 endtask










always #(clock_period/2)     CLK_TB = ~CLK_TB ;


DATA_SYNC  #(.NUM_STAGES(NUM_STAGES)) DUT  
                                            (.CLK(CLK_TB),
                                            .RST(RST_TB),
                                            .RST_SYNC(RST_SYNC_TB)
                                            );
                            
endmodule
