// Author: Ciro Fabian Bermudez Marquez
// Name: d_ff.v
//
// Description: Basic D flip flop

module d_ff (
  input      clk_i,  
  input      d_i,     
  output reg q_o      
);

  always @(posedge clk_i) begin
    q_o <= d_i;     
  end

endmodule