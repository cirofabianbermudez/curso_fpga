// Author: Ciro Fabian Bermudez Marquez
// Name: counter.v
//
// Description: Free running binary counter

module counter #(
  parameter Width = 8
) (
  input              clk,
  input              rst,
  output             max_tick,
  output [Width-1:0] q
);

  reg  [Width-1:0] d_reg;
  wire [Width-1:0] sum;
  
  assign sum = d_reg + 1;
  assign max_tick = (d_reg == 2**Width-1) ? 1'b1 : 1'b0;

  always @(posedge clk, posedge rst) begin    
    if (reset) 
      d_reg <= 0;   
    else 
      d_reg <= sum;
  end
  
  assign q = d_reg;
  
endmodule