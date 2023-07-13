module ff_opc #(
  parameter n = 60
) (
  input	         clk_i,
  input	         rst_i,
  input	   [1:0] hab_i,
  input	 [n-1:0] d_i,
  output [n-1:0] q_o
);

  reg [n-1:0] q_aux, mux_out;
	
  always@(d_i, hab_i) begin
    case(hab_i)
      0 : mux_out = 0;
      1 : mux_out = d_i;
      default : mux_out = 0;
    endcase		
  end

  always@(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      q_aux <= 0;
    else
      q_aux <= mux_out;
  end

  assign q_o = q_aux;

endmodule