`timescale 1us/1ns
module DATA_SYNC_TB #(
   parameter  NUM_STAGES = 3,
              BUS_WIDTH  = 8
)();

reg                     CLK_TB,RST_TB,EN_TB;
reg  [BUS_WIDTH-1 : 0]  UNSYNC_BUS_TB;
wire                    enable_pulse_TB;
wire [BUS_WIDTH-1 : 0]  SYNC_BUS_TB;

parameter clock_period = 10;

initial
  begin
    $dumpfile("DATA_SYNC.vcd") ;       
    $dumpvars; 

    INITIALIZTAION();
    RESET();
    
    #clock_period
       $display ("TEST CASE 1 ");
       Pass_Data(1,8);
       VERIFY();
    #clock_period
       $display ("TEST CASE 2 ");
       Pass_Data(1,7);
       VERIFY();


    #(10*clock_period)
      $stop ;


  end

 task RESET ;
    begin
       #(clock_period/2)  
           RST_TB = 1;
       #clock_period
           RST_TB = 0;
       #clock_period
           RST_TB = 1;
    end
 endtask

 task INITIALIZTAION ;
    begin
        CLK_TB        = 0;
        RST_TB        = 1;
        EN_TB         = 0;
        UNSYNC_BUS_TB = 'b0;

    end
 endtask

 task Pass_Data ;

  input reg                  enable_tb;
  input reg  [BUS_WIDTH-1:0] data;

    begin

        EN_TB         = enable_tb;
        UNSYNC_BUS_TB = data;
      #(clock_period*(NUM_STAGES + 1))
         EN_TB         = 0; 
    end
 endtask

task VERIFY ;
    begin
      if(SYNC_BUS_TB == UNSYNC_BUS_TB)
       begin
        $display("Test_Case  is succeeded with SYNC_BUS_DATA = %d AND equal UNSYNC_BUS_DATA = %d and enable_pulse = %d  at Time ",SYNC_BUS_TB,UNSYNC_BUS_TB,enable_pulse_TB,$time);
       end
      else
       begin
        $display("Test_Case  is failed with SYNC_BUS_DATA = %d AND not equal UNSYNC_BUS_DATA = %d and enable_pulse = %d  at Time ",SYNC_BUS_TB,UNSYNC_BUS_TB,enable_pulse_TB,$time);
       end
    end
 endtask







always #(clock_period/2)     CLK_TB = ~CLK_TB ;


DATA_SYNC  #(.NUM_STAGES(NUM_STAGES),
             .BUS_WIDTH(BUS_WIDTH)) DUT  

                (.CLK(CLK_TB),
                 .RST(RST_TB),
                 .EN(EN_TB),
                 .UNSYNC_BUS(UNSYNC_BUS_TB),
                 .enable_pulse(enable_pulse_TB),
                 .SYNC_BUS(SYNC_BUS_TB)
                );
   
endmodule
