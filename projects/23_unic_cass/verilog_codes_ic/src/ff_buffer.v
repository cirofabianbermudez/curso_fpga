// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module ff_buffer #(
  parameter Width = 8
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
  assign mux2_d = (clear_i) ? { Width {1'b0} } : mux1;
   
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= { Width {1'b0} }; 
    else
      reg_q <= mux2_d;
  end   
  
  assign dout_o = reg_q;
  
endmodule
