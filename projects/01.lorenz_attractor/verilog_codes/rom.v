// Author: Ciro Fabian Bermudez Marquez
// Name: rom.v
//
// ROM with all required values A(a , b ) = A(10,21)
module rom #(
   parameter Width = 32
) (
  output [Width-1:0] sigma_o,
  output [Width-1:0] beta_o,
  output [Width-1:0] rho_o,
	output [Width-1:0] h_o,
	output [Width-1:0] x0_o,
	output [Width-1:0] y0_o,
	output [Width-1:0] z0_o
);

  assign sigma_o = 32'b00000001010000000000000000000000; // 10.00000
	assign beta_o  = 32'b00000000010101010101010101010101; // 2.66667
	assign rho_o   = 32'b00000011100000000000000000000000; // 28.00000
	assign h_o     = 32'b00000000000000000010100011110101; // 0.00500
	assign x0_o    = 32'b00000000001000000000000000000000; // 1.00000
	assign y0_o    = 32'b00000000000000000000000000000000; // 0.00000
	assign z0_o    = 32'b00000000001000000000000000000000; // 1.00000
endmodule