module ff_hab #(
  parameter n = 60	
) (
  input	         clk_i,
  input	         rst_i,
  input	         hab_i,
  input	 [n-1:0] d_i,
  output [n-1:0] q_o
);

  reg [n-1:0] q_aux;
  
  always@(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      q_aux <= 0;
    else if (hab_i)
      q_aux <= d_i;
    else
      q_aux <= q_aux;	
  end

  assign q_o = q_aux;

endmodule