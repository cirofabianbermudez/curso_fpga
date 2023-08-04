// Author: Ciro Fabian Bermudez Marquez
// Name: reg_rst_en.v
//
// Description: Basic register with reset and enable

module reg_rst_en #(
  parameter Width = 8
) (
  input                  clk_i,
  input                  rst_i,
  input                  en_i,
  input      [Width-1:0] d_i,
  output reg [Width-1:0] q_o
);

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      q_o <= 0;
    else if (en_i)
      q_o <= d_i;
  end

endmodule