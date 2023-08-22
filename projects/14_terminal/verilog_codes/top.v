// Author: Julisa Verdejo Palacios
// Name: top.v
//
// Description: echo de recepcion y transmision

module top (
  input         rst_i,
  input         clk_i,
  input         rx_i,
  input         psel_i,
  output        pcheck_o,
  output        tx_o,
  output        eor_o,
  output        eot_o
);

  wire [7:0] data_rx;
  wire [7:0] buffer;
  wire       sttx;
  wire [1:0] fsmsel;
  wire       en;
  wire       clear;
  wire       stfsm;
  wire       eoy;
  wire       eoc;
  wire       sel;
  
  wire [7:0] data_yoye;
  wire [7:0] data_ciro;
  wire [7:0] data_mux;
  
  wire       sttx_yoye;
  wire       sttx_ciro;
  wire       sttx_mux;
  
  rs232_rx mod_rs232_rx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .rx_i(rx_i),
    .baud_i(15'd2603),
    .psel_i(psel_i),
    .dout_o(data_rx),
    .pcheck_o(pcheck_o),
    .eor_o(eor_o)
  );

  rs232_tx mod_rs232_tx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .sttx_i(sttx_mux),
    .d_i(data_mux),
    .baud_i(15'd10415),
    .psel_i(psel_i),
    .tx_o(tx_o),
    .eot_o(eot_o)
  );
  
  pipo_reg_buff #(.Width(8)) mod_pipo_reg_buff (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(en),
    .clear_i(clear),
    .din_i(data_rx),
    .dout_o(buffer)
  );
  
  cmd_decoder mod_cmd_decoder (
    .buff_i(buffer),
    .sel_o(sel),
    .fsmsel_o(fsmsel)
  );
  
  mux2_to_1 #(.Width(8)) mod_mux2_to_1_data (
    .in1_i(data_yoye),
    .in2_i(data_ciro),
    .sel_i(sel),
    .mux_o(data_mux)
  );
  
  mux2_to_1 #(.Width(1)) mod_mux2_to_1_sttx (
    .in1_i(sttx_yoye),
    .in2_i(sttx_ciro),
    .sel_i(sel),
    .mux_o(sttx_mux)
  );
  
  fsm_yoye mod_fsm_yoye (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .sty_i(fsmsel[0] & stfsm),
    .eot_i(eot_o),
    .sttx_o(sttx_yoye),
    .data_o(data_yoye),
    .eoy_o(eoy)    
  );
  
  fsm_ciro mod_fsm_ciro (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .stc_i(fsmsel[1] & stfsm),
    .eot_i(eot_o),
    .sttx_o(sttx_ciro),
    .data_o(data_ciro),
    .eoc_o(eoc)    
  );
  
  fsm_terminal mod_fsm_terminal (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .eor_i(eor_o),
    .eofsm_i(eoc & eoy),
    .en_o(en),
    .clear_o(clear),
    .stfsm_o(stfsm)
  );
  
endmodule