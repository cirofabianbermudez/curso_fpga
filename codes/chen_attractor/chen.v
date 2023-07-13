// Author: Guadalupe Alonso Contreras
// Name: chen.v
//
// Chen oscillator 32 bits A(11,20)

module chen #(
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
  wire [Width-1:0] a1,a2,a3,a4;   
  wire [Width-1:0] s1,s2,s3,s4;
  wire [Width-1:0] m1,m2,m3,m4,m5,m6,m7,m8,m9;
  wire [Width-1:0] xn, yn, zn;
  wire [Width-1:0] x0_rom, y0_rom, z0_rom;
  wire [Width-1:0] xn_retro, yn_retro, zn_retro;
  wire [Width-1:0] a_rom, b_rom, c_rom, h_rom;
  
//cu

//rom

//mux

//xn
sub #(Width) sub_1 (.a_i(yn), .b_i(xn), .sub_o(s1));
mult #(Width) mult_1 (.a_i(s1), .b_i(a), .mult_o(m1));
mult #(Width) mult_2 (.a_i(m1), .b_i(h_rom), .mult_o(m2));
adder #(Width) add_1 (.a_i(m2), .b_i(xn), .sum_o(a1));
flipflop3


//yn

//zn


endmodule
