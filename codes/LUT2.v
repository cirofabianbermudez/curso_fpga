//Author: Guadalupe Alonso
//Name: LUT2.v
//
//Second option of Look Up Table

module LUT2(
    input A,
    input B,
    input C,
    input D,
    output x
);

    and(c1,~A,B);
    and(c2,c1,~C);
    and(c3,A,B);
    and(c4,c3,~C);
    and(c5,B,~C);
    and(c6,c5,D);
    or(y,c2,c4,c6);

endmodule