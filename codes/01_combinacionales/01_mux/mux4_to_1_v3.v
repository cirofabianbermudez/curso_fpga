// Author: Guadalupe Alonso
// Name: mux4_to_1_v3.v
//
// Description: Third option of multiplexer 4 inputs 1 output

module mux4_to_1_v3 #(
  parameter Width = 32
) (
  input      [Width-1:0] in1_i,
  input      [Width-1:0] in2_i,
  input      [Width-1:0] in3_i,
  input      [Width-1:0] in4_i,
  input            [1:0] sel_i,
  output reg [Width-1:0] out_o
);

  always @(in1_i, in2_i, in3_i, in4_i, sel_i) begin
    case (sel_i)
      2'd0    : out_o = in1_i;
      2'd1    : out_o = in2_i;
      2'd2    : out_o = in3_i;
      2'd3    : out_o = in4_i;
      default : out_o = 0;
    endcase
  end

endmodule
