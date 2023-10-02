// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module mod_n_counter #(
  parameter Width  = 9,
  parameter MaxVal = 325
) (
  input  clk_i,
  input  rst_i,
  output max_tick_o
);

  reg  [Width-1:0] reg_q;
  wire [Width-1:0] reg_d;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= { Width {1'b0} };
    else
      reg_q <= reg_d;
  end

  assign reg_d = (reg_q == (MaxVal-1)) ? { Width {1'b0} } : reg_q + 1'b1;
  assign max_tick_o = (reg_q == (MaxVal-1)) ? 1'b1 : 1'b0;

endmodule