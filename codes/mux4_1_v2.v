// Author: Guadalupe Alonso
// Name: mux4_1_v2.v
//
// Description: Second option of multiplexer 4 inputs 1 output

module mux4_1_v2 #(
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
    if (sel == 0) begin
      ou1 = in1;
    end else if (sel == 1) begin
      ou1 = in2; 
    end else if (sel == 2) begin
      ou1 = in3; 
    end else if (sel == 3) begin
      ou1 = in4; 
    end else begin 
      ou1 = 0;
    end
  end

endmodule
