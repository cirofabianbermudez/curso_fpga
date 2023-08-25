module fsm_cordic (
	input            clk_i,
	input            rst_i,
	input            stc_i,
	input            z_i,
	output reg [1:0] opc_o,
	output reg       hab1_o,
  output reg       hab2_o,
  output reg       sel_o,
	output reg       eoc_o
);
	
  localparam [3:0] s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5;
  
	reg [3:0] present_state, next_state;
	
	always @(stc_i, z_i, present_state) begin
		next_state = present_state;
		case (present_state)
		s0 : begin                            // Esperar por stc y direccionar mux a condicion inicial
           {sel_o, opc_o, hab1_o, hab2_o, eoc_o} = 6'b000001;
				   if(stc_i)
             next_state = s1;
				   else
             next_state = present_state;		
			   end
         
    s1 : begin                            // Habilitar primeros flipflops
           {sel_o, opc_o, hab1_o, hab2_o, eoc_o} = 6'b001100;
           next_state = s2;	
         end
         
    s2 : begin                            // Habilitar segundos flipflops
           {sel_o, opc_o, hab1_o, hab2_o, eoc_o} = 6'b001010;
           next_state = s3;	
         end

		s3 : begin                            // Aumentar contador y direccionar mux a retro
           {sel_o, opc_o, hab1_o, hab2_o, eoc_o} = 6'b110000;
           next_state = s4;			
			   end
         
    s4 : begin                            // Habilitar primeros flipflops
           {sel_o, opc_o, hab1_o, hab2_o, eoc_o} = 6'b101100;
           next_state = s5;	
         end
         
    s5 : begin                            // Habilitar segundos flipflops y comprueba la bandera del contador
           {sel_o, opc_o, hab1_o, hab2_o, eoc_o} = 6'b101010;
           if(z_i)
             next_state = s0;
				   else
             next_state = s3;		
         end
		default : begin
					next_state = s0;
				 end		
		endcase		
	end	
	
	always@(posedge clk_i, posedge rst_i) begin
		if(rst_i)
			present_state <= s0;
		else
			present_state <= next_state;
	end
	
endmodule