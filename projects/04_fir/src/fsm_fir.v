module fsm_fir (
  input 		  clk_i,
  input 		  rst_i,
  input		    eof_i,
  output reg	ldx_o
);
	
	reg [1:0] present_state, next_state;
	
	always@(eof_i, present_state) begin
		present_state = next_state;
		case(present_state)
			0 : begin
					ldx_o = 0;
					if(eof_i)
						next_state = present_state;
					else
						next_state = 1;				
				end
			
			1 : begin
					ldx_o = 0;
					if(eof_i)
						next_state = 2;
					else
						next_state = present_state;
				end
			
			2 : begin
				ldx_o = 1;
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