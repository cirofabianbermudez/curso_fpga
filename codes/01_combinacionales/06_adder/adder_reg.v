// Author: Ciro Fabian Bermudez Marquez
// Name: adder_reg.v
//
// Simple signed adder with output register

module adder_reg #(
  parameter Width = 32
) (
  input                         rst_i,
  input                         clk_i,
  input      signed [Width-1:0] a_i,
  input      signed [Width-1:0] b_i,
  output reg signed [Width-1:0] sum_o
);
  
  wire [Width-1:0] sum_w;
  assign sum_w = a_i + b_i;
  
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin 
      sum_o <= 0;
    end else begin
      sum_o <= sum_w;
    end
  end

endmodule
