// Author: Ciro Fabian Bermudez Marquez
// Name: piecewise_linear.v
//
//  piecewise linear 16 bits A(2,13)

module piecewise_linear #(
  parameter Width = 16
) (             
  input                rst_i,
  input                clk_i,
  input              start_i,
  output [7:0]        rand_o
);

  wire sel;
  wire en;
  wire [Width-1:0] abs1;  
  wire [Width-1:0] a1,a2,a3;   
  wire [Width-1:0] s1,s2,s3;
  wire [Width-1:0] m1,m2,m3,m4;
  wire [Width-1:0] xn, yn, zn;
  wire [Width-1:0] x0_rom, y0_rom, z0_rom;
  wire [Width-1:0] xn_retro, yn_retro, zn_retro;
  
  wire [7:0] rand_aux;
  
  // cu
  cu fsm (.rst_i(rst_i), .clk_i(clk_i), .start_i(start_i), .en_o(en), .sel_o(sel) );
  
  // rom
  rom #(.Width(Width)) param (.x0_o(x0_rom), .y0_o(y0_rom), .z0_o(z0_rom) );
  
  // mux   
  mux #(.Width(Width)) mux_x (.in1_i(x0_rom), .in2_i(xn_retro), .sel_i(sel), .mux_o(xn) );
  mux #(.Width(Width)) mux_y (.in1_i(y0_rom), .in2_i(yn_retro), .sel_i(sel), .mux_o(yn) );
  mux #(.Width(Width)) mux_z (.in1_i(z0_rom), .in2_i(zn_retro), .sel_i(sel), .mux_o(zn) );
  
  // xn
  scm_h                   mul_1 (.X(yn), .Y(m1) );
  adder  #(.Width(Width)) add_1 (.a_i(m1), .b_i(xn), .sum_o(a1) );
  ff_hab #(.Width(Width)) reg_x (.rst_i(rst_i), .clk_i(clk_i), .en_i(en), .d_i(a1), .q_o(xn_retro) );
  
  // yn
  scm_h                   mul_2 (.X(zn), .Y(m2) );
  adder  #(.Width(Width)) add_2 (.a_i(m2), .b_i(yn), .sum_o(a2) );
  ff_hab #(.Width(Width)) reg_y (.rst_i(rst_i), .clk_i(clk_i), .en_i(en), .d_i(a2), .q_o(yn_retro) );
  
  // zn
  abs    #(.Width(Width)) abs_1 (.x_i(xn), .abs_o(abs1));
  sub    #(.Width(Width)) sub_1 (.a_i(abs1), .b_i(16'b0010000000000000), .sub_o(s1) );
  sub    #(.Width(Width)) sub_2 (.a_i(s1), .b_i(yn), .sub_o(s2) );
  scm_a                   mul_3 (.X(zn), .Y(m3) );
  sub    #(.Width(Width)) sub_3 (.a_i(s2), .b_i(m3), .sub_o(s3) );
  scm_h                   mul_4 (.X(s3), .Y(m4) );
  adder  #(.Width(Width)) add_3 (.a_i(zn), .b_i(m4), .sum_o(a3) );
  ff_hab #(.Width(Width)) reg_z (.rst_i(rst_i), .clk_i(clk_i), .en_i(en), .d_i(a3), .q_o(zn_retro) );
  
  //assign xn_o = xn_retro;
  //assign yn_o = yn_retro;
  //assign zn_o = zn_retro;
  
  assign rand_aux[0] = xn_retro[0] ^  yn_retro[0] ^ zn_retro[0];
  assign rand_aux[1] = xn_retro[1] ^  yn_retro[1] ^ zn_retro[1];
  assign rand_aux[2] = xn_retro[2] ^  yn_retro[2] ^ zn_retro[2];
  assign rand_aux[3] = xn_retro[3] ^  yn_retro[3] ^ zn_retro[3];
  assign rand_aux[4] = xn_retro[4] ^  yn_retro[4] ^ zn_retro[4];
  assign rand_aux[5] = xn_retro[5] ^  yn_retro[5] ^ zn_retro[5];
  assign rand_aux[6] = xn_retro[6] ^  yn_retro[6] ^ zn_retro[6];
  assign rand_aux[7] = xn_retro[7] ^  yn_retro[7] ^ zn_retro[7];
  
  assign rand_o = rand_aux;
  
endmodule
