// Author: Ciro Fabian Bermudez Marquez
// Name: d_ff_rst.v
//
// Description: D flip flop with asynchronous reset

module d_ff_rst (
  input  clk,  
  input  rst, 
  input  d,     
  output reg q      
);

  always @(posedge clk, posedge rst) begin   
    if (rst)   
      q <= 1'b0;    
    else 
      q <= d;     
  end

endmodule