// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module bi_demo #(
  parameter Width = 26
) (
  input  clk_i,
  input  rst_i,
  inout  bi_io,
  input  dir_i,
  output tick_o,
  output led_o,
  output check_o
);

  reg  [Width-1:0] cnt_q;
  wire [Width-1:0] cnt_d;
  
  assign cnt_d = cnt_q + 1;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      cnt_q <= 0;
    end else begin
      cnt_q <= cnt_d;
    end
  end

  assign bi_io = (dir_i) ? cnt_q[Width-1] : 1'bz;
  assign check_o = bi_io;

  assign tick_o = cnt_q[Width-1];
  assign led_o = cnt_q[Width-1];

endmodule