//Author: Guadalupe Alonso
//Name: LUT1.v
//
//First option of Look Up Table

module LUT1(
    input A,
    input B,
    input C,
    input D,
    output x
);

    assign x=(~A & B & ~C) | (A & B & ~C) | (B & ~C & D);

endmodule