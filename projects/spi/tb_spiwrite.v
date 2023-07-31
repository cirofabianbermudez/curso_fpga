
`timescale 1 ns / 100 ps

module tb_spiwrite ();
	reg     clk_i;
	reg     rst_i;
	reg     str_i;
	reg     busy_i;
	wire    mosi_o;
	wire    dclk_o;
	wire    cs_o;
	wire    eow_o; 

	spi_write	DUT	(.clk_i(clk_i), .rst_i(rst_i), .str_i(str_i), .busy_i(busy_i), .mosi_o(mosi_o), .dclk_o(dclk_o), .cs_o(cs_o), .eow_o(eow_o));
	
	always #5 clk_i = ~clk_i;
		
	initial begin
		clk_i = 0;
		rst_i = 1;
		str_i = 0;
		busy_i = 1;
		
		#20
		rst_i = 0;
		
		#20
		busy_i = 0;
		
		#20
		str_i = 1;
		#20
		str_i = 0;
		
	end

endmodule
