module mux21_to_1 #(
  parameter n = 18
)	(
  input      [n-1:0] x0_i,
  input      [n-1:0] x1_i,
  input      [n-1:0] x2_i,
  input      [n-1:0] x3_i,
  input      [n-1:0] x4_i,
  input      [n-1:0] x5_i,
  input      [n-1:0] x6_i,
  input      [n-1:0] x7_i,
  input      [n-1:0] x8_i,
  input      [n-1:0] x9_i,
  input      [n-1:0] x10_i,
  input      [n-1:0] x11_i,
  input      [n-1:0] x12_i,
  input      [n-1:0] x13_i,
  input      [n-1:0] x14_i,
  input      [n-1:0] x15_i,
  input      [n-1:0] x16_i,
  input      [n-1:0] x17_i,
  input      [n-1:0] x18_i,
  input      [n-1:0] x19_i,
  input      [n-1:0] x20_i,
  input        [5:0] sel_i,
  output reg [n-1:0] out_o
);
	
	always @(*) begin
		case(sel_i)			
			 0 : out_o = x0_i;
       1 : out_o = x1_i;
       2 : out_o = x2_i;
       3 : out_o = x3_i;
       4 : out_o = x4_i;
       5 : out_o = x5_i;
       6 : out_o = x6_i;
       7 : out_o = x7_i;
       8 : out_o = x8_i;
       9 : out_o = x9_i;
      10 : out_o = x10_i;
      11 : out_o = x11_i;
      12 : out_o = x12_i;
      13 : out_o = x13_i;
      14 : out_o = x14_i;
      15 : out_o = x15_i;
      16 : out_o = x16_i;
      17 : out_o = x17_i;
      18 : out_o = x18_i;
      19 : out_o = x19_i;
      20 : out_o = x20_i; 
			default : out_o = 0;			
		endcase
  end	
endmodule