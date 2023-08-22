// Author: Julisa Verdejo Palacios
// Name: pipo_reg_buff.v
//
// Description: Registro con entrada y salida en paralelo con habilitacion.

module pipo_reg_buff #(
  parameter Width = 12
) ( 
  input              rst_i,
  input              clk_i,
  input              en_i,
  input              clear_i,
  input  [Width-1:0] din_i,
  output [Width-1:0] dout_o
);

  reg  [Width-1:0] reg_q;
  wire [Width-1:0] mux1;
  wire [Width-1:0] mux2_d;
  
  assign mux1 = (en_i) ? din_i : reg_q;
  assign mux2_d = (clear_i) ? 0 : mux1;
   
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 0; 
    else
      reg_q <= mux2_d;
  end   
  
  assign dout_o = reg_q;
  
endmodule