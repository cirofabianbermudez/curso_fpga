module fir (
  input 			  clk_i,
  input 			  rst_i,
  input			    stf_i,
  input  [17:0]	xn_i,
  output [17:0]	y_o,
  output			  eof_o
);
	
	wire [5:0] i, n, s;
	wire eof, ldx;
	wire [17:0] x;
	wire [35:0] an;
	wire [17:0] x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20;
	
	flip_flop_hab	#(.n(18))	mod_ff1	(			
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(xn_i),
		.q_o(x1)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff2	(
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x1),
		.q_o(x2)		
	);

	flip_flop_hab	#(.n(18))	mod_ff3	(	
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x2),
		.q_o(x3)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff4	(	
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x3),
		.q_o(x4)		
	); 
	
	flip_flop_hab	#(.n(18))	mod_ff5	(
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x4),
		.q_o(x5)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff6	(	
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x5),
		.q_o(x6)		
	);	
	
	flip_flop_hab	#(.n(18))	mod_ff7	(			
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x6),
		.q_o(x7)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff8	(		
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x7),
		.q_o(x8)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff9	(		
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x8),
		.q_o(x9)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff10 (				
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x9),
		.q_o(x10)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff11 (	
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x10),
		.q_o(x11)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff12 (		
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x11),
		.q_o(x12)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff13 (		
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x12),
		.q_o(x13)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff14 (		
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x13),
		.q_o(x14)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff15 (	
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x14),
		.q_o(x15)		
	);	
	
	flip_flop_hab	#(.n(18))	mod_ff16 ( 	
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x15),
		.q_o(x16)		
	);	
	
	flip_flop_hab	#(.n(18))	mod_ff17 (	
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x16),
		.q_o(x17)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff18 (
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x17),
		.q_o(x18)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff19	(
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x18),
		.q_o(x19)		
	);
	
	flip_flop_hab	#(.n(18))	mod_ff20 (	
		.clk_i,
		.rst_i,
		.hab_i(ldx),
		.d_i(x19),
		.q_o(x20)		
	);	
	
	mux_reg	#(.n(18)) mod_mux	(		
		.x0_i(xn_i),
		.x1_i(x1),
		.x2_i(x2),
		.x3_i(x3),
		.x4_i(x4),  
		.x5_i(x5),
		.x6_i(x6),  
		.x7_i(x7),
		.x8_i(x8),  
		.x9_i(x9),
		.x10_i(x10), 
		.x11_i(x11), 
		.x12_i(x12),
		.x13_i(x13),
		.x14_i(x14), 
		.x15_i(x15),
		.x16_i(x16),
		.x17_i(x17),
		.x18_i(x18),
		.x19_i(x19),
		.x20_i(x20),
		.i_i(i),
		.x_o(x)
	);
	
	assign s = 6'b100001;
	assign n = 6'b010100;  
	
	top_mac	mod_mac	(
		.clk_i,
		.rst_i,
		.stf_i,
		.x_i(x),
		.a_i(an),
		.n_i(n),
		.s_i(s),
		.y_o,
		.i_o(i),
		.eof_o(eof)	
	);		
	
	fsm_reg	mod_fsm_reg	(
		.clk_i,
		.rst_i,
		.eof_i(eof),
		.ldx_o(ldx)	
	);
	
	coeficientes	mod_coeficientes (
		.i_i(i),
		.an_o(an)	
	);
	
	assign eof_o = eof;
endmodule