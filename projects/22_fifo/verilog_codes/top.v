// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module top #(
  parameter Width    = 8,  // number of bits in a word
  parameter AddrBits = 3   // number of address bits
) (
  input               clk_i,
  input               rst_i,
  input               wr_i,
  input               rd_i,
  input  [Width-1:0]  w_data_i,
  output [Width-1:0]  r_data_o,
  output              empty_o,
  output              full_o
);

  wire wr;
  wire rd;
  
  fifo #(
    .Width(Width), 
    .AddrBits(AddrBits)
  ) mod_fifo( 
    .clk_i(clk_i),
    .rst_i(rst_i),
    .wr_i(wr),
    .rd_i(rd),
    .w_data_i(w_data_i),
    .r_data_o(r_data_o),
    .empty_o(empty_o),
    .full_o(full_o)
  );


  debouncer mod_debouncer_read(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .sw_i(rd_i),
    .db_level_o(),
    .db_tick_o(rd)
  );
  
  debouncer mod_debouncer_write(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .sw_i(wr_i),
    .db_level_o(),
    .db_tick_o(wr)
  );

  
endmodule
