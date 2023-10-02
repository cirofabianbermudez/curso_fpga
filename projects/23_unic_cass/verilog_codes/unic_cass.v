// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module unic_cass #(
  parameter Width = 10
) ( 
  input        clk_i,
  input        rst_i,
  input        rx_i,
  output       tx_o,
  output [7:0] cnt_o,
  output       time_o
);

  wire       tick;
  wire       eor;
  wire       eot
  wire [7:0] rx_data;
  wire [7:0] cmd_buffer;
  //wire [1:0] cmd_decoded;
  wire       start_ramp;

  mod_n_counter #(
    .Width(6),
    .MaxVal(54)     // (100 * 10**(6)) / (115200 * 16)
  ) mod_mod_n_counter ( 
   .clk_i(clk_i),
   .rst_i(rst_i),
   .max_tick_o(tick)
  );

  receiver #(
    .Nbits(8),
    .Sticks(16)
  ) mod_receiver ( 
    .clk_i(clk_i),
    .rst_i(rst_i),
    .rx_i(rx_i),
    .tick_i(tick),
    .eor_o(eor),
    .dout_o(rx_data)
  );

  ff_buffer #(
    .Width(8)
  ) mod_ff_buffer ( 
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(eor),
    .clear_i(1'b0),
    .din_i(rx_data),
    .dout_o(cmd_buffer)
  );

  //cmd_decoder mod_cmd_decoder( 
  //  .buff_i(cmd_buffer),
  //  .opcode_o(cmd_decoded)
  //);

  transmitter #(
    .Nbits(8),
    .Sticks(16)
  ) mod_transmitter ( 
    .clk_i(clk_i),
    .rst_i(rst_i),
    .stt_i(),
    .tick_i(tick),
    .din_i(),
    .tx_o(tx_o),
    .eot_o()
  );

  ramp #(
    .Width(10)
  ) mod_ramp ( 
    .clk_i(clk_i),
    .rst_i(rst_i),
    .start_i(start_ramp),
    .cnt_o(cnt_o),
    .time_o(time_o),
    .time_10ms_o(),
    .time_1ms_o(),
    .eos_o(eos_o)
  );

  fsm_unic_cass #(
    .OpcodeBits(2)
  ) mod_fsm_unic_cass (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .opcode_i(cmd_decoded),
    .start_ramp_o(start_ramp),
    .start_sar_o()
  );

  fsm_sar #(
    .Width(10)
  ) (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .start_i(start_sar),
    .cmp_i(cmp_i),
    .result_o(),
    .dac_o(),
    .sample_o(),
    .eoc_o()
  );
endmodule
