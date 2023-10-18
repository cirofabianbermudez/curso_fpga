// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module clk_div #(
  parameter Width  = 8,
  parameter MaxVal = 16
) (
  input  clk_i,
  input  rst_i,
  output square_o
);

  reg  [Width-1:0] reg_q;
  wire [Width-1:0] reg_d;
  wire max_tick;
  
  reg  reg_ff_q;
  wire reg_ff_d;

  // Counter logic
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= { Width {1'b0} };
    else
      reg_q <= reg_d;
  end

  assign reg_d = (reg_q == (MaxVal-1)) ? { Width {1'b0} } : reg_q + 1'b1;
  assign max_tick = (reg_q == (MaxVal-1)) ? 1'b1 : 1'b0;
  
  // ff_toogle logic

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_ff_q <= 1'b0;
    else
      reg_ff_q <= reg_ff_d;
  end
  
  assign reg_ff_d = (max_tick) ? ~reg_ff_q : reg_ff_q;
  assign square_o = reg_ff_q;

endmodule