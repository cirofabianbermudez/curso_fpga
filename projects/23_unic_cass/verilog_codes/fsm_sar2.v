

module fsm_sar2 (
  input        clk,
  input        SOC,
  input        cmp,
  output [9:0] Q,
  output [9:0] D,
  output       EOC,
  output       sample
);

  reg [1:0] state; 
  reg [9:0] mask;
  reg [9:0] result;
  reg [9:0] qn;
  wire      EOCN;

  parameter sWait=0, sSample=1, sConv=2, sDone=3;

  always @(posedge clk) begin
    if (SOC) 
      state <= sWait;
    else case (state)
           sWait   : begin
                       state <= sSample;
                     end
           sSample : begin
                       state  <= sConv; 
                       mask   <= 10'b1000000000;
                       result <= 10'b0000000000;
                     end
           sConv   : begin    
                       if (cmp) 
                         result <= result | mask;
                       if (mask[0]) 
                         state <= sDone;
                       mask <= mask >> 1;
                     end
           sDone   : ;
         endcase
  end

  assign sample = state == sSample; 
  assign D = result | mask; 
  assign EOC = state == sDone;
  assign EOCN = state == sDone;
  assign Q = qn;
  
  always @(posedge EOCN) begin
    qn = result;
  end

endmodule