//Aurhor: Guadalupe Alonso
//Name: mux4_1.v
//
//Multiplexer 4 inputs 1 output
module mux4_1 (
    parameter Width = 8
) (
    input  [Width-1:0] in1_i,
    input  [Width-1:0] in2_i,
    input  [Width-1:0] in3_i,
    input  [Width-1:0] in4_i,
    input  [1:0]       sel_i,
    output [Widht-1:0] ou1_o
);

    assign ou1_o = sel_i[1] ? (sel_i[0] ? in4_i : in3_i) : (sel_i[0] ? in2_i : in1_i);

endmodule