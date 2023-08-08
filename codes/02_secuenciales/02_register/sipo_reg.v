// Author: Julisa Verdejo Palacios
// Name: sipo_reg.v
//
// Description: Serial In - Parallel Out register

module sipo_reg #(
  parameter Width = 8
) (
  input              clk_i,
  input              rst_i,
  input              d_i,  
  input              en_i,
  output [Width-1:0] q_o
);	

  reg  [Width-1:0] reg_q;
  wire [Width-1:0] mux_d;

  assign mux_d = (en_i) ? {reg_q[Width-2:0], d_i} : reg_q;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 0;
    else
      reg_q <= mux_d;
  end

  assign q_o = reg_q;
  
endmodule
