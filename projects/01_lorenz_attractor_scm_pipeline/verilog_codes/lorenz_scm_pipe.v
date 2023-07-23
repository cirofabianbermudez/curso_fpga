// Author: Ciro Fabian Bermudez Marquez
// Name: lorenz.v
//
// Lorenz oscillator 32 bits A(9,22)

`include "adder.v"
`include "sub.v"
`include "mult.v"
`include "mux.v"
`include "rom.v"
`include "cu.v"
`include "ff_hab.v"
`include "scm_sigma.v"
`include "scm_rho.v"
`include "scm_beta.v"
`include "scm_h.v"


module lorenz_scm_pipe #(
  parameter Width = 32
) (             
  input                rst_i,
  input                clk_i,
  input              start_i,
  output [Width-1:0]    xn_o,
  output [Width-1:0]    yn_o,
  output [Width-1:0]    zn_o
);

  wire sel;
  wire en;
  wire [Width-1:0] a1,a2,a3;   
  wire [Width-1:0] s1,s2,s3,s4;
  wire [Width-1:0] m1,m2,m3,m4,m5,m6,m7;
  wire [Width-1:0] xn, yn, zn;
  wire [Width-1:0] x0_rom, y0_rom, z0_rom;
  wire [Width-1:0] xn_retro, yn_retro, zn_retro;
  wire [Width-1:0] sigma_rom, beta_rom, rho_rom, h_rom;
  
  // cu
  cu fsm (.rst_i(rst_i), .clk_i(clk_i), .start_i(start_i), .en_o(en), .sel_o(sel) );
  
  // rom
  rom #(.Width(Width)) param (.sigma_o(sigma_rom), .beta_o(beta_rom), .rho_o(rho_rom), .h_o(h_rom), .x0_o(x0_rom), .y0_o(y0_rom), .z0_o(z0_rom) );
  
  // mux   
  mux #(.Width(Width)) mux_x (.in1_i(x0_rom), .in2_i(xn_retro), .sel_i(sel), .mux_o(xn) );
  mux #(.Width(Width)) mux_y (.in1_i(y0_rom), .in2_i(yn_retro), .sel_i(sel), .mux_o(yn) );
  mux #(.Width(Width)) mux_z (.in1_i(z0_rom), .in2_i(zn_retro), .sel_i(sel), .mux_o(zn) );
  
  // xn
  sub    #(.Width(Width)) sub_2 (.rst_i(rst_i), .clk_i(clk_i), .a_i(yn), .b_i(xn), .sub_o(s2) );
  //mult   #(.Width(Width)) mul_4 (.a_i(s2), .b_i(sigma_rom), .mult_o(m4) );
  scm_sigma               mul_4 (.X(s2), .Y(m4) );
  //mult   #(.Width(Width)) mul_5 (.a_i(m4), .b_i(h_rom), .mult_o(m5) );
  scm_h                    mul_5 (.X(m4), .Y(m5) );
  adder  #(.Width(Width)) add_1 (.rst_i(rst_i), .clk_i(clk_i), .a_i(m5), .b_i(xn), .sum_o(a1) );
  ff_hab #(.Width(Width)) reg_x (.rst_i(rst_i), .clk_i(clk_i), .en_i(en), .d_i(a1), .q_o(xn_retro) );
  
  // yn
  sub    #(.Width(Width)) sub_1 (.rst_i(rst_i), .clk_i(clk_i), .a_i(rho_rom), .b_i(zn), .sub_o(s1) );
  mult   #(.Width(Width)) mul_1 (.rst_i(rst_i), .clk_i(clk_i), .a_i(s1), .b_i(xn), .mult_o(m1) );
  sub    #(.Width(Width)) sub_3 (.rst_i(rst_i), .clk_i(clk_i), .a_i(m1), .b_i(yn), .sub_o(s3) );
  //mult   #(.Width(Width)) mul_6 (.a_i(s3), .b_i(h_rom), .mult_o(m6) );
  scm_h                   mul_6 (.X(s3), .Y(m6) );
  adder  #(.Width(Width)) add_2 (.rst_i(rst_i), .clk_i(clk_i), .a_i(m6), .b_i(yn), .sum_o(a2) );
  ff_hab #(.Width(Width)) reg_y (.rst_i(rst_i), .clk_i(clk_i), .en_i(en), .d_i(a2), .q_o(yn_retro) );
  
  // zn
  mult   #(.Width(Width)) mul_2 (.rst_i(rst_i), .clk_i(clk_i), .a_i(yn), .b_i(xn), .mult_o(m2) );
  //mult   #(.Width(Width)) mul_3 (.a_i(beta_rom), .b_i(zn), .mult_o(m3) );
  scm_beta                mul_3 (.X(zn), .Y(m3) );
  sub    #(.Width(Width)) sub_4 (.rst_i(rst_i), .clk_i(clk_i), .a_i(m2), .b_i(m3), .sub_o(s4) );
  //mult   #(.Width(Width)) mul_7 (.a_i(s4), .b_i(h_rom), .mult_o(m7) );
  scm_h                   mul_7 (.X(s4), .Y(m7) );
  adder  #(.Width(Width)) add_3 (.rst_i(rst_i), .clk_i(clk_i), .a_i(m7), .b_i(zn), .sum_o(a3) );
  ff_hab #(.Width(Width)) reg_z (.rst_i(rst_i), .clk_i(clk_i), .en_i(en), .d_i(a3), .q_o(zn_retro) );
  
  assign xn_o = xn_retro;
  assign yn_o = yn_retro;
  assign zn_o = zn_retro;
  
  // adder  #(Width) add_n (.a_i(), .b_i(), .sum_o() );
  // sub    #(Width) sub_n (.a_i(), .b_i(), .sub_o() );
  // mult   #(Width) mul_n (.a_i(), .b_i(), .mult_o() );
  // ff_hab #(Width) reg_n (.rst_i(), .clk_i(), .en_i(), .d_i(), .q_o() );

endmodule
