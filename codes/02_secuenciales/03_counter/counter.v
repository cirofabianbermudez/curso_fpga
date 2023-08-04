// Author: Ciro Fabian Bermudez Marquez
// Name: counter.v
//
// Description: Free running binary counter

module counter #(
  parameter Width = 8
) (
  input              clk_i,
  input              rst_i,
  output             max_tick_i,
  output [Width-1:0] q_o
);

  reg  [Width-1:0] reg_q;
  wire [Width-1:0] sum_d;
  
  assign sum_d = reg_q + 1;
  assign max_tick_i = (reg_q == 2**Width-1) ? 1'b1 : 1'b0;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) 
      reg_q <= 0;
    else 
      reg_q <= sum_d;
  end
  
  assign q_o = reg_q;
  
endmodule