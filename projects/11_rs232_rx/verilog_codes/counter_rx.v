// Author: Julisa Verdejo Palacios
// Name: counter_rx.v
//
// Description: 

module counter_rx #(
  parameter Width = 15
) (
  input              rst_i,
  input              clk_i,
  input              en_i,
  input  [Width-1:0] vmax_i,
  output             flag_o
);
  
  reg  [Width-1:0] reg_q;
  wire [Width-1:0] mux1;
  wire [Width-1:0] mux2_d;
  wire             comp;

  assign mux2_d  = (en_i) ? mux1 : reg_q;
  assign mux1 = (comp) ? 0 : reg_q + 1;
  
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 0;
    else
      reg_q <= mux2_d;    
  end

  assign comp = (reg_q == vmax_i) ? 1'b1 : 1'b0;
  assign flag_o = comp;
  
endmodule
