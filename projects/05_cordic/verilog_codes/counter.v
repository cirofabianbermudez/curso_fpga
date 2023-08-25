module counter #(
	parameter n = 4
)	(
	input          clk_i,
	input          rst_i,
	input  [n-1:0] n_i,
	input    [1:0] opc_i,
	output [n-1:0] addr_o,
	output         z_o
);
	
	reg [n-1:0] mux_out, addr_q;
	
	always @(opc_i, addr_q) begin
		case(opc_i)
			0:	mux_out = 0;
			1:	mux_out = addr_q;
			2:	mux_out = addr_q + 1;
			default : mux_out = 0;
		endcase
	end
	
	always @(posedge clk_i, posedge rst_i) begin
		if(rst_i)
			addr_q <= 0;
		else
			addr_q <= mux_out;					
	end
	
	assign addr_o = addr_q;
	assign z_o = (addr_q == n_i) ? 1 : 0;	
	
endmodule