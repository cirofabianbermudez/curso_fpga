// Author: Guadalupe Alonso
// Name: mux4_1_v3.v
//
// Description: Third option of multiplexer 4 inputs 1 output

module mux4_1_v3 #(
  parameter Width = 32
) (
  input      [Width-1:0] in1,
  input      [Width-1:0] in2,
  input      [Width-1:0] in3,
  input      [Width-1:0] in4,
  input            [1:0] sel,
  output reg [Width-1:0] ou1
);

  always @(in1,in2,in3,in4,sel) begin
    case (sel)
      2'd0   : ou1 = in1;
      2'd1   : ou1 = in2;
      2'd2   : ou1 = in3;
      2'd3   : ou1 = in4;
      default: ou1 = 0;
    endcase
  end

endmodule
