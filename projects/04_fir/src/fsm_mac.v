module fsm_mac (
	input            clk_i,
	input            rst_i,
	input            stf_i,
	input            z_i,
	output reg [1:0] opc_o,
	output reg [1:0] lda_o,
	output reg       ldr_o,
	output reg       eof_o
);
	
	reg [1:0] present_state, next_state;
	
	always@(stf_i, z_i, present_state) begin
		next_state = present_state;
		case(present_state)
		0 : begin
				opc_o = 3; lda_o = 0; ldr_o = 0; eof_o = 1;
				if(stf_i)
					next_state = 1;
				else
					next_state = present_state;		
			end
		
		1 : begin
				opc_o = 2; lda_o = 1; ldr_o = 0; eof_o = 0;
				if(z_i)
					next_state = 2;
				else
					next_state  =  present_state;
			end
		
		2 : begin
			opc_o = 0; lda_o = 0; ldr_o = 1; eof_o = 0;
			next_state = 0;			
			end
		
		default : begin
					opc_o = 0; lda_o = 0; ldr_o = 0; eof_o = 0;
					next_state = 0;
				 end		
		endcase		
	end	
	
	
	always@(posedge clk_i, posedge rst_i) begin
		if(rst_i)
			present_state <= 0;
		else
			present_state <= next_state;
	end
	
endmodule