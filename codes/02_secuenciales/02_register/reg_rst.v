// Author: Ciro Fabian Bermudez Marquez
// Name: reg_rst.v
//
// Description: Basic register with reset

module reg_rst #(
  parameter Width = 8
) (
  input                  clk,  
  input                  rst, 
  input      [Width-1:0] d,     
  output reg [Width-1:0] q      
);

  always @(posedge clk, posedge rst) begin   
    if (rst)   
      q <= 0;    
    else 
      q <= d;     
  end

endmodule