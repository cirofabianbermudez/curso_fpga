module cordic #(
	parameter n = 32,
  parameter m = 4
)	(
	input          clk_i,
	input          rst_i,
	input          stc_i,
	input  [n-1:0] z0_i,
  output         eoc_o,
	output [n-1:0] xn_o,
	output [n-1:0] yn_o,
	output [n-1:0] zn_o
);
  
  // Counter outputs
	wire [m-1:0] addr;
  wire z;
  // FSM outputs
	wire sel, hab1, hab2, di;
	wire [1:0] opc;
  // Mux outputs
	wire [n-1:0] mux_out_x, mux_out_z, mux_out_y;
  // Rom output
  wire [n-1:0] rom_out;
  // Operaions outputs
  wire [n-1:0] opx, opy;
  // Register outputs
  wire [n-1:0] qx, qy, qz, qrom;
  // Register outputs iteration
  wire [n-1:0] qxn, qyn, qzn;
  // Shift register outputs
	wire [n-1:0] qxshift, qyshift;
  // Maximo numero de iteraciones
  localparam [m-1:0] iterations = 11;
  // Valores por defecto de x0 y y0
  localparam [n-1:0] x0 = 32'b00000000100110110111010011101101;
  localparam [n-1:0] y0 = 32'b00000000000000000000000000000000; 
  
  // Maquina de estados
  fsm_cordic mod_fsm_cordic ( .clk_i(clk_i), .rst_i(rst_i), .stc_i(stc_i), .z_i(z), .opc_o(opc), .hab1_o(hab1), .hab2_o(hab2), .sel_o(sel), .eoc_o(eoc_o) );
  
  // Contador para ROM y shift register
  counter	#(.n(m)) mod_counter ( .clk_i(clk_i), .rst_i(rst_i), .n_i(iterations), .opc_i(opc), .addr_o(addr), .z_o(z) );  
  
  // Signo de z
	assign di = qz[n-1];
	
	// z logic
	mux	   #(.n(n))       mod_mux_z      ( .in1_i(z0_i),  .in2_i(qzn),   .sel_i(sel),  .mux_o(mux_out_z)	);
	ff_hab #(.n(n))       mod_ff_hab_z   ( .clk_i(clk_i), .rst_i(rst_i),  .hab_i(hab1), .d_i(mux_out_z), .q_o(qz) );
	rom	   #(.n(n),.m(m)) mod_rom        ( .addr_i(addr),  .angulo_o(rom_out) );
	ff_hab #(.n(n))       mod_ff_hab_rom ( .clk_i(clk_i), .rst_i(rst_i),  .hab_i(hab1), .d_i(rom_out),   .q_o(qrom) );	
	op_z   #(.n(n))       mod_op_z       ( .z_i(qz),      .rom_i(qrom),   .d_i(di),     .op_o(qzn) );
  
  // x logic
	mux	      #(.n(n)) mod_mux_x       ( .in1_i(x0),    .in2_i(qxn),  .sel_i(sel),   .mux_o(mux_out_x)	);	
	ff_hab    #(.n(n)) mod_ff_hab_x    ( .clk_i(clk_i), .rst_i(rst_i), .hab_i(hab1),  .d_i(mux_out_x), .q_o(qx)	); 
  shift_reg #(.n(n)) mod_shift_reg_x ( .d_i(qx),      .addr_i(addr),   .q_o(qxshift) );
	op_x      #(.n(n)) mod_op_x	       ( .x_i(qx),      .y_i(qyshift), .d_i(di),      .op_o(opx) ); 
	ff_hab    #(.n(n)) mod_ff_hab_xn   ( .clk_i(clk_i), .rst_i(rst_i), .hab_i(hab2),  .d_i(opx),       .q_o(qxn) ); 
  
  // y logic
	mux	      #(.n(n)) mod_mux_y       ( .in1_i(y0),    .in2_i(qyn),  .sel_i(sel),  .mux_o(mux_out_y)	);	
	ff_hab    #(.n(n)) mod_ff_hab_y    ( .clk_i(clk_i), .rst_i(rst_i), .hab_i(hab1), .d_i(mux_out_y), .q_o(qy)	); 
  shift_reg #(.n(n)) mod_shift_reg_y ( .d_i(qy),      .addr_i(addr),   .q_o(qyshift) );
	op_y      #(.n(n)) mod_op_y	       ( .y_i(qy),      .x_i(qxshift), .d_i(di),     .op_o(opy) ); 
	ff_hab    #(.n(n)) mod_ff_hab_yn   ( .clk_i(clk_i), .rst_i(rst_i), .hab_i(hab2), .d_i(opy),       .q_o(qyn) );

  assign xn_o = qxn;
  assign yn_o = qyn;
  assign zn_o = qzn;

endmodule