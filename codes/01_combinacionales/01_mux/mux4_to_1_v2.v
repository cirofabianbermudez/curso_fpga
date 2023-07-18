// Author: Guadalupe Alonso
// Name: mux4_to_1_v2.v
//
// Description: Multiplexer 4 inputs 1 output

module mux4_to_1_v2 #(
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
    if (sel_i == 0) begin
      out_o = in1_i;
    end else if (sel_i == 1) begin
      out_o = in2_i;
    end else if (sel_i == 2) begin
      out_o = in3_i;
    end else if (sel_i == 3) begin
      out_o = in4_i;
    end else begin 
      out_o = 0;
    end
  end

endmodule
