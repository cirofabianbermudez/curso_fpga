// Author: Julisa Verdejo Palacios
// Name: rs232_rx.v
//
// Description:

module rs232_rx (
  input         rst_i,
  input         clk_i,
  input         rx_i,
  input  [14:0] baud_i,
  input         psel_i,
  output  [7:0] dout_o,
  output        pcheck_o,
  output        eor_o
);

  // Habilitadores
  wire en_baud;
  wire en_sipo;
  wire en_cnt;
  wire en_pipo;
  
  // Banderas
  wire baud_flag;
  wire cnt_flag;
 
  // Selector de paridad
  wire [3:0] nbits;
  assign nbits = (psel_i) ? 4'd9 : 4'd8;
  
  // Direccionamiento de sipo
  wire [9:0] data_sipo;
  wire [7:0] data_rx;
  assign data_rx = (psel_i) ? data_sipo[8:1]: data_sipo[9:2];
  
  // Direccionamiento de paridad
  wire pcheck;
  wire parity;
  assign parity = (psel_i) ? pcheck : 1'b0; 

  counter_rx #(.Width(15)) mod_baud_clk (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(en_baud),
    .vmax_i(baud_i),
    .flag_o(baud_flag)
  );
  
  counter_rx #(.Width(4)) mod_counter_bits (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(en_cnt),
    .vmax_i(nbits),
    .flag_o(cnt_flag)
  );
  
  sipo_reg_rx #(.Width(10)) mod_sipo_reg_rx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .din_i(rx_i),
    .en_i(en_sipo),
    .dout_o(data_sipo)
  );
  
  parity_rx mod_parity_rx (
    .din_i(data_rx),
    .pbit_i(data_sipo[9]),
    .pcheck_o(pcheck)
  );
  
  pipo_reg_rx #(.Width(9)) mod_pipo_reg_rx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .din_i( {parity, data_rx} ),
    .en_i(en_pipo),
    .dout_o( { pcheck_o, dout_o} )
  );

  fsm_rx mod_fsm_rx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .rx_i(rx_i),
    .baud_flag_i(baud_flag),
    .cnt_flag_i(cnt_flag),
    .en_baud_o(en_baud),
    .en_sipo_o(en_sipo),
    .en_cnt_o(en_cnt),
    .en_pipo_o(en_pipo),  
    .eor_o(eor_o)
  );

endmodule