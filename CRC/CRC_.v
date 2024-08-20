module  CRC_REG (
input  wire        ACTIVE , CLK , RST , DATA,
output reg         CRC  , 
output reg         Valid         
);

reg   [4:0] COUNTER ;
reg   [7:0] LFSR ;
wire        FeedBack ;
integer     N ;
wire COUNTER_done ;

parameter SEED  = 8'hD8  ;
parameter [7:0] taps = 8'b01000100 ; 

assign FeedBack = LFSR[0]^DATA ;
assign COUNTER_done = (COUNTER == 4'b1000)  ;



always@(posedge CLK or negedge RST)
begin 
  if(!RST)
  begin
COUNTER <= 4'b0 ;
  end
  else if (ACTIVE)
  begin
COUNTER <= 4'b0 ;
  end
  else if (!COUNTER_done)
  begin
    COUNTER <= COUNTER + 1'b1;
    end
end


always @(posedge CLK or negedge RST)
 begin
    if(!RST)
     begin    
       LFSR   <= SEED ;
       Valid  <= 1'b0 ;
       CRC    <= 1'b0 ;
     end
    else if (ACTIVE)
    begin
      LFSR <= {FeedBack,LFSR[7]^FeedBack,LFSR[6:4],LFSR[3]^FeedBack,LFSR[2:1]} ;
      Valid <= 1'b0 ;
      CRC    <= 1'b0 ;
    end
    else if (!ACTIVE && !COUNTER_done)
    begin
      Valid <= 1'b1 ;
      CRC     <= LFSR[0] ;
      LFSR[6] <= LFSR[7] ;
      LFSR[5] <= LFSR[6] ;
      LFSR[4] <= LFSR[5] ;
      LFSR[3] <= LFSR[4] ;
      LFSR[2] <= LFSR[3] ;
      LFSR[1] <= LFSR[2] ;
      LFSR[0] <= LFSR[1] ;
    end
    else
    CRC <= 1'b0 ;
    Valid <= 1'b0 ;
 end
 endmodule


     
      
      // for(N=0;N<=6;N=N+1)
      // begin 
       // LFSR[7] <= LFSR[0]^DATA ;
        //  if(taps[N]==0)
        //    LFSR[N] <= LFSR[N+1] ;
       //   else
       //     LFSR[N] <= LFSR[N+1]^(LFSR[0]^DATA) ;  
      // end   
   // end
  //  else if (COUNTER!=8 && !ACTIVE )
  //    begin
  //    Valid <=1'b1 ;
   //   CRC <= LFSR[0];
   //  for(N=0;N<=7;N=N+1) 
    //   begin
    //  CRC  <= LFSR[0] ; 
   //   LFSR[N] <= LFSR[N+1] ;
   //   COUNTER <= COUNTER+1 ;
   //    end
   //   end
   // else
   // begin
  //    Valid <= 1'b0;
 //     COUNTER <= 0;
 //   end
//end
    
   
//endmodule

