// Author: Julisa Verdejo Palacios
// Name: clk_div_tick.v
//
// Description: Base de tiempo para single tick

module clk_div_tick #(
  parameter Width = 30
) (
  input              rst_i,
  input              clk_i,
  input              en_i,
  input  [Width-1:0] k_i,
  output             z_o
);

  reg  [Width-1:0] reg_q;
  wire [Width-1:0] mux1;
  wire [Width-1:0] mux2_d;
  wire             comp;

  assign mux1 = (en_i) ? reg_q - 1 : reg_q;
  assign mux2_d = (comp) ? k_i : mux1;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 0;
    else
      reg_q <= mux2_d;
  end

  assign comp = (reg_q == 0) ? 1'b1 : 1'b0;
  assign z_o = comp; 

endmodule