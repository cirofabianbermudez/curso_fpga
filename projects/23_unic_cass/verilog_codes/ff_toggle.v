// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module ff_toggle  (
  input  clk_i,
  input  rst_i,
  input  en_i,
  output q_o
);

  reg  reg_q;
  wire reg_d;

  assign reg_d = (en_i) ? ~reg_q : reg_q;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 1'b0;
    else
      reg_q <= reg_d;
  end

  assign q_o = reg_q;

endmodule