// Author: Guadalupe Alonso Contreras
// Name: rossler.v
//
// Rossler oscillator 32 bits A(11,20)

`include "adder.v"
`include "sub.v"
`include "mult.v"
`include "mux.v"
`include "rom.v"
`include "cu.v"
`include "ff_hab.v"

module rossler #(
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
  wire [Width-1:0] a1,a2,a3,a4,a5;   
  wire [Width-1:0] s1,s2;
  wire [Width-1:0] m1,m2,m3,m4,m5;
  wire [Width-1:0] xn, yn, zn;
  wire [Width-1:0] x0_rom, y0_rom, z0_rom;
  wire [Width-1:0] xn_retro, yn_retro, zn_retro;
  wire [Width-1:0] a_rom, b_rom, c_rom, h_rom;
  
  // cu
  cu fsm (.rst_i(rst_i), .clk_i(clk_i), .start_i(start_i), .en_o(en), .sel_o(sel) );
  
  // rom
  rom #(.Width(Width)) param (.a_o(a_rom), .b_o(b_rom), .c_o(c_rom), .h_o(h_rom), .x0_o(x0_rom), .y0_o(y0_rom), .z0_o(z0_rom) );
  
  // mux   
  mux #(.Width(Width)) mux_x (.in1_i(x0_rom), .in2_i(xn_retro), .sel_i(sel), .mux_o(xn));
  mux #(.Width(Width)) mux_y (.in1_i(y0_rom), .in2_i(yn_retro), .sel_i(sel), .mux_o(yn));
  mux #(.Width(Width)) mux_z (.in1_i(z0_rom), .in2_i(zn_retro), .sel_i(sel), .mux_o(zn));
  
  //xn
  adder  #(.Width(Width)) add_1  (.a_i(yn), .b_i(zn), .sum_o(a1));
  mult   #(.Width(Width)) mult_1 (.a_i(a1), .b_i(h_rom), .mult_o(m1));
  sub    #(.Width(Width)) sub_1  (.a_i(m1), .b_i(xn), .sub_o(s1));
  ff_hab #(.Width(Width)) reg_1  (.rst_i(rst_i), .clk_i(clk_i), .en_i(en), .d_i(s1), .q_o(xn_retro));

  //yn
  mult   #(.Width(Width)) mult_2 (.a_i(a_rom), .b_i(yn), .mult_o(m2));
  adder  #(.Width(Width)) add_2  (.a_i(m2), .b_i(xn), .sum_o(a2));
  mult   #(.Width(Width)) mult_3 (.a_i(a2), .b_i(h_rom), .mult_o(m3));
  adder  #(.Width(Width)) add_3  (.a_i(m3), .b_i(yn), .sum_o(a3));
  ff_hab #(.Width(Width)) reg_2  (.rst_i(rst_i), .clk_i(clk_i), .en_i(en), .d_i(a3), .q_o(yn_retro));

  //zn
  sub    #(.Width(Width)) sub_2  (.a_i(xn), .b_i(c_rom), .sub_o(s2));
  mult   #(.Width(Width)) mult_4 (.a_i(s2), .b_i(zn), .mult_o(m4));
  adder  #(.Width(Width)) add_4  (.a_i(m4), .b_i(b_rom), .sum_o(a4));
  mult   #(.Width(Width)) mult_5 (.a_i(a4), .b_i(h_rom), .mult_o(m5));
  adder  #(.Width(Width)) add_5  (.a_i(m5), .b_i(zn), .sum_o(a5));
  ff_hab #(.Width(Width)) reg_3  (.rst_i(rst_i), .clk_i(clk_i), .en_i(en), .d_i(a5), .q_o(zn_retro));

  assign xn_o = xn_retro;
  assign yn_o = yn_retro;
  assign zn_o = zn_retro;

endmodule
