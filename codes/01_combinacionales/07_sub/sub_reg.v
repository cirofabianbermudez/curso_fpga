// Author: Ciro Fabian Bermudez Marquez
// Name: sub_reg.v
//
// Simple signed subtracter with output register

module sub_reg #(
  parameter Width = 32
) (
  input                         rst_i,
  input                         clk_i,
  input      signed [Width-1:0] a_i,
  input      signed [Width-1:0] b_i,
  output reg signed [Width-1:0] sub_o
);

  wire [Width-1:0] sub_w;
  assign sub_w = a_i - b_i;	

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin 
      sub_o <= 0;
    end else begin
      sub_o <= sub_w;
    end
  end  

endmodule
