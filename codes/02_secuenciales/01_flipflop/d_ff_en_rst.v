// Author: Ciro Fabian Bermudez Marquez
// Name: d_ff_en_rst.v
//
// Description: D flip flop with asynchronous reset and enable

module d_ff_en_rst (
  input  clk,  
  input  rst, 
  input  en,
  input  d,     
  output reg q      
);

  always @(posedge clk, posedge rst) begin   
    if (rst)   
      q <= 1'b0;    
    else if (en)
      q <= d;     
  end

endmodule