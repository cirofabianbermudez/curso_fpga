// Author: Ciro Fabian Bermudez Marquez
// Name: sipo_reg.v
//
// Description: Serial In Paralel Out Reg


module sipo_reg #(
  parameter Width = 8
) (
  input              clk,
  input              rst,
  input              d,  
  input              en,
  output [Width-1:0] q
);	

  reg  [Width-1:0] d_reg;
  wire [Width-1:0] mux_out;

  assign mux_out = en ? {d_reg[Width-2:0], d} : d_reg;

  always @(posedge clk, posedge rst) begin
    if (rst)
      d_reg <= 0;
    else
      d_reg <= d_mux;
  end

assign q = d_reg;
  
endmodule
