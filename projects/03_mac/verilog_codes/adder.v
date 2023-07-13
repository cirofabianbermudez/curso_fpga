module adder #(
  parameter n = 60
) (
  input signed	[n-1:0] p_i,
  input signed	[n-1:0] q_i,
  output signed	[n-1:0] sum_o	
);
	
  assign sum_o = p_i + q_i;   

endmodule