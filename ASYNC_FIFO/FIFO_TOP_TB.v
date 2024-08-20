`timescale 1ns/1ps
module FIFO_TOP_TB #(
                      parameter  DATA_WIDTH = 8,
                                 FIFO_DEPTH = 8,
                                 ADDRESS_BITS  = 3
                    )();

                         reg                       W_CLK_TB,W_RST_TB,R_CLK_TB,R_RST_TB,WINC_TB,RINC_TB;
                         reg  [DATA_WIDTH - 1 : 0] W_DATA_TB;
                         wire                      W_FULL_TB,R_EMPTY_TB;
                         wire [DATA_WIDTH - 1 : 0] R_DATA_TB;

parameter W_clock_period = 10 ;
parameter R_clock_period = 25 ;

initial
  begin
    $fdumpfile("ASYNC_FIFO_WRITE.vcd")  ;
    $dumpvars; 

    INITIALIZTAION();
    W_RESET();
    
    #W_clock_period
       $display ("TEST CASE 1 TESTING W_FULL FLAG  before sending any DATA");
       VERIFY_NOT_W_FULL();
       W_DATA_TB = 17;
       WINC_TB = 1;
        #W_clock_period 
       WINC_TB = 0; 
    #(20*W_clock_period)
       Pass_Data(1,0,1);
    #W_clock_period  
       Pass_Data(1,0,2);
    #W_clock_period  
       Pass_Data(1,0,3);
    #W_clock_period  
       Pass_Data(1,0,4);
    #W_clock_period  
       Pass_Data(1,0,5);
    #W_clock_period  
       Pass_Data(1,0,6);
    #W_clock_period  
       Pass_Data(1,0,7);
    #W_clock_period  
       Pass_Data(1,0,8);
    //#W_clock_period  
    //   Pass_Data(1,0,9);
     #W_clock_period 
     $display ("TEST CASE 4 TESTING W_FULL FLAG after sending 8 DATA Byetes and not reciving any one of them ");
      WINC_TB = 0;   
    #(2*W_clock_period )
      VERIFY_W_FULL();  

     #W_clock_period 
       WINC_TB = 0;   


  end

  initial
  begin      
    $dumpvars; 
    $fdumpfile("ASYNC_FIFO_READ.vcd");
    INITIALIZTAION();
    R_RESET();
    
    #R_clock_period
       $display ("TEST CASE 2 TESTING R_EMPTY FLAG before sending any DATA ");
       VERIFY_EMPTY();
    #(2 * R_clock_period)
       $display ("TEST CASE 3 TESTING R_EMPTY FLAG after sending  DATA");
       VERIFY_NOT_EMPTY();
       RINC_TB = 0;
    #R_clock_period    
      $display ("TEST CASE 5 TESTING R_DATA at index zero in FIFO ");
       if(R_DATA_TB == 1)
       begin
        $display("Test_Case  is Succeeded with  R_DATA = %d   at Time ",R_DATA_TB,$time);
       end
      else
       begin
        $display("Test_Case  is Falled with R_DATA = %d   at Time ",R_DATA_TB,$time);
       end

       RINC_TB = 1;
    #(  R_clock_period )  
       RINC_TB = 0;

    
    $display ("TEST CASE 6 TESTING R_EMPTY FLAG after reading all  DATA");
    #R_clock_period  
       VERIFY_EMPTY();    

    #(R_clock_period*5)
      $stop ;


  end

 task W_RESET ;
    begin
       #(W_clock_period/2)  
           W_RST_TB = 1;
       #W_clock_period
           W_RST_TB = 0;
       #W_clock_period
           W_RST_TB = 1;
    end
 endtask

task R_RESET ;
    begin
       #(R_clock_period/2)  
           R_RST_TB = 1;
       #R_clock_period
           R_RST_TB = 0;
       #R_clock_period
           R_RST_TB = 1;
    end
 endtask


 task INITIALIZTAION ;
    begin
        W_CLK_TB        = 0;
        R_CLK_TB        = 0;
        W_RST_TB        = 1;
        R_RST_TB        = 1;
        WINC_TB         = 0;
        RINC_TB         = 0;
        W_DATA_TB       = 0;
    end
 endtask

 task Pass_Data ;

  input reg                   wenable,renable;
  input reg  [DATA_WIDTH-1:0] data;

    begin

        WINC_TB   = wenable;
        RINC_TB   = renable;
        W_DATA_TB = data;
       
    end
 endtask

task VERIFY_EMPTY ;
    begin
      if(R_EMPTY_TB == 1)
       begin
        $display("Test_Case  is Succeeded with R_EMPTY = %d   at Time ",R_EMPTY_TB,$time);
       end
      else
       begin
        $display("Test_Case  is Falled with R_EMPTY = %d   at Time ",R_EMPTY_TB,$time);
       end
    end
 endtask

 task VERIFY_NOT_EMPTY ;
    begin
      if(R_EMPTY_TB == 0)
       begin
        $display("Test_Case  is Succeeded with R_EMPTY = %d   at Time ",R_EMPTY_TB,$time);
       end
      else
       begin
        $display("Test_Case  is Falled with R_EMPTY = %d   at Time ",R_EMPTY_TB,$time);
       end
    end
 endtask

task VERIFY_NOT_W_FULL ;
    begin
      if(W_FULL_TB == 0)
       begin
        $display("Test_Case  is Succeeded with W_FULL = %d   at Time ",W_FULL_TB,$time);
       end
      else
       begin
        $display("Test_Case  is Falled with W_FULL = %d   at Time ",W_FULL_TB,$time);
       end
    end
 endtask

 task VERIFY_W_FULL ;
    begin
      if(W_FULL_TB == 1)
       begin
        $display("Test_Case  is Succeeded with W_FULL = %d   at Time ",W_FULL_TB,$time);
       end
      else
       begin
        $display("Test_Case  is Falled with W_FULL = %d   at Time ",W_FULL_TB,$time);
       end
    end
 endtask





always #(W_clock_period/2)     W_CLK_TB = ~W_CLK_TB ;
always #(R_clock_period/2)     R_CLK_TB = ~R_CLK_TB ;        


        FIFO_TOP  #(   .DATA_WIDTH_TOP(DATA_WIDTH),
                       .ADDRESS_BITS_TOP(ADDRESS_BITS),
                       .FIFO_DEPTH_TOP(FIFO_DEPTH))    DUT  

                                            (   
                                                .R_CLK(R_CLK_TB),
                                                .R_RST(R_RST_TB),
                                                .W_CLK(W_CLK_TB),
                                                .W_RST(W_RST_TB),
                                                .WINC(WINC_TB),
                                                .RINC(RINC_TB),
                                                .W_DATA(W_DATA_TB),
                                                .W_FULL(W_FULL_TB),
                                                .R_EMPTY(R_EMPTY_TB),
                                                .R_DATA(R_DATA_TB)
                                            );
   
endmodule

