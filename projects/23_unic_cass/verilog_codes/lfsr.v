// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module lfsr #(
  parameter Width = 5
) (
  input              clk_i,
  input              rst_i,
  input              en_i,
  output [Width-1:0] q_o,
  output             rnd_o
);
  
  reg  [Width-1:0] reg_q;
  wire [Width-1:0] reg_d;
  wire             linear_func;
  
  assign linear_func = reg_q[0] ^~ reg_q[2]; 
  assign reg_d = (en_i) ? { linear_func, reg_q[Width-1:1] } : reg_q;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 5'd1;
    else
      reg_q <= reg_d ;
  end

  assign q_o = reg_q;
  assign rnd_o = reg_q[0];

endmodule