// Author: Ciro Fabian Bermudez Marquez
// Name: d_ff.v
//
// Description: Basic D flip flop

module d_ff (
  input  clk,  
  input  d,     
  output reg q      
);

  always @(posedge clk) begin
    q <= d;     
  end

endmodule