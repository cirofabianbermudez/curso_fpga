// Author: Ciro Fabian Bermudez Marquez
// Name: ff_hab.v
//
// Simple flip-flop with asynchronous Reset and Enable
module ff_hab #(
  parameter Width = 32
) (
  input                  rst_i,
  input                  clk_i,
  input                  en_i,
  input      [Width-1:0] d_i,
  output reg [Width-1:0] q_o 
);

  wire [Width-1:0] mux_out;

  assign mux_out = en_i ? d_i : q_o ;
	
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin 
      q_o <= 0;
    end else begin
      q_o <= mux_out;
    end
  end
	
endmodule
