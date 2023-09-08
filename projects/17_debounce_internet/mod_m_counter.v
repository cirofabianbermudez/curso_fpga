// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module mod_m_counter #(
  parameter Width  = 4
) ( 
  input              clk_i,
  input              rst_i,
  input              en_i,
  output [Width-1:0] cnt_o
);

  reg  [Width-1:0] reg_q;
  wire [Width-1:0] reg_d;
  
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) 
      reg_q <= 0;
    else if (en_i)
      reg_q <= reg_d;
  end
  
  assign reg_d = reg_q + 1;
  assign cnt_o = reg_q;
  
endmodule