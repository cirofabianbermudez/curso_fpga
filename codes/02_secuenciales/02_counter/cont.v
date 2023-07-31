// Author: Guadalupe Alonso Contreras
// Name: cont.v
// Description: 4 Bits Counter

module cont(
  input            clk,
  input            reset,
  input            en,
  output reg [3:0] cnt
);

  always @(posedge clk or posedge reset) begin    
    if (reset) 
      cnt <= 4'd0;   
    else if (en)
      cnt <= cnt+1;
    else
      cnt <= cnt;
  end
endmodule