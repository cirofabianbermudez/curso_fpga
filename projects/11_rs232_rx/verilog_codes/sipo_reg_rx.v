// Author: Julisa Verdejo Palacios
// Name: sipo_reg_rx.v
//
// Description: Registro con entrada en serie y salida en paralelo con desplazamiento a la derecha.

module sipo_reg_rx #(
  parameter Width = 10
) (
  input              rst_i,
  input              clk_i,
  input              din_i,
  input              en_i,
  output [Width-1:0] dout_o
);

  reg  [Width-1:0] reg_q;
  wire [Width-1:0] mux_d;

  assign mux_d = (en_i) ? {din_i,reg_q[Width-1:1]} : reg_q;
  
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 0;
    else
      reg_q <= mux_d;
  end

  assign dout_o = reg_q;

endmodule
