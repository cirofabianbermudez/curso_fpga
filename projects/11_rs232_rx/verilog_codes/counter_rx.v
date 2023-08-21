// Author: Julisa Verdejo Palacios
// Name: counter_rx.v
//
// Description: Contador para llevar registro de los bits recibidos.

module counter_rx #(
  parameter Width = 4
) (
  input               rst_i,
  input               clk_i,
  input        [1:0]  opc_i,
  output [Width-1:0]  cnt_o
);

  reg [Width-1:0] mux_d, reg_q;

  always @(opc_i, reg_q) begin
    case (opc_i)
      2'b00 : mux_d = 0;
      2'b01 : mux_d = reg_q;
      2'b10 : mux_d = reg_q + 1;
      2'b11 : mux_d = reg_q;
      default : mux_d = 0;
    endcase
  end

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 0;
    else
      reg_q <= mux_d;
  end

  assign cnt_o = reg_q;

endmodule
