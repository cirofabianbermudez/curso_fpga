// Author: Ciro Fabian Bermudez Marquez
// Name: sipo_reg.v
//
// Description: Serial In Paralel Out Reg


module sipo_reg #(
  parameter Width = 8
) (
  input              clk_i,
  input              rst_i,
  input              d_i,  
  input              en_i,
  output [Width-1:0] q_o
);	

  reg  [Width-1:0] d_reg;
  wire [Width-1:0] mux_out;

  assign mux_out = (en_i) ? {d_reg[Width-2:0], d_i} : d_reg;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      d_reg <= 0;
    else
      d_reg <= d_mux;
  end

  assign q_o = d_reg;
  
endmodule
