// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module univ_counter #(
  parameter Width  = 3
) (
  input              clk_i,
  input              rst_i,
  input              en_i,
  input              up_i,
  output [Width-1:0] cnt_o,
  output             max_tick_o,
  output             min_tick_o
);

  reg  [Width-1:0] reg_q, reg_d;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= { Width {1'b0} };
    else
      reg_q <= reg_d;
  end

  always @(*) begin
    if (en_i & up_i)
      reg_d = reg_q + 1;
    else if (en_i & ~up_i)
      reg_d = reg_q - 1;
    else
      reg_d = reg_q;
  end

  assign cnt_o = reg_q;
  assign max_tick_o = (reg_q == (2**Width-1)) ? 1'b1 : 1'b0;
  assign min_tick_o = (reg_q == 0) ? 1'b1 : 1'b0; 

endmodule