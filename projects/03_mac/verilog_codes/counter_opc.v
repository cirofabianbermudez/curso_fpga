module counter_opc #(
  parameter n = 6
) (
  input          clk_i,
  input          rst_i,
  input  [n-1:0] n_i,
  input    [1:0] opc_i,
  output [n-1:0] i_o,
  output         z_o
);
  
  reg [n-1:0] mux_out, i_out;
  
  always@(n_i, opc_i, i_out) begin
    case(opc_i)
      0:  mux_out = 0;
      1:  mux_out = i_out;
      2:  mux_out = i_out - 1;
      3:  mux_out = n_i;
      default : mux_out = 0;
    endcase
  end
  
  always@(posedge clk_i or posedge rst_i) begin
    if(rst_i)
      i_out <= 0;
    else
      i_out <= mux_out;          
  end
  
  assign i_o = i_out;
  assign z_o = (i_o == 1) ? 1:0;  
  
endmodule