// Author: Ciro Fabian Bermudez Marquez
// Name: d_ff_rst_sync.v
//
// Description: D flip flop with synchronous reset

module d_ff_rst_sync (
  input      clk_i,  
  input      rst_i, 
  input      d_i,     
  output reg q_o      
);

  always @(posedge clk_i) begin   
    if (rst_i)   
      q_o <= 1'b0;    
    else 
      q_o <= d_i;     
  end

endmodule