// Author: Ciro Fabian Bermudez Marquez
// Name: d_ff_rst_en_sync.v
//
// Description: D flip flop with synchronous reset and enable

module d_ff_rst_en_sync (
  input      clk_i,  
  input      rst_i, 
  input      en_i,
  input      d_i,     
  output reg q_o      
);

  always @(posedge clk_i) begin   
    if (rst_i)   
      q_o <= 1'b0;    
    else if (en_i)
      q_o <= d_i;     
  end

endmodule