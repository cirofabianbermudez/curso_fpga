// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module unic_cass #(
  parameter Width = 10
) ( 
  input              clk_i,
  input              rst_i,
  input              rx_i,
  input              cmp_i,
  output             tx_o,
  output [Width-1:0] cnt_o,
  output             time_o,
  output [Width-1:0] dac_o,
  output             sample_o,
  // Just for testing
  output             rnd_o
);

  // Baudrate signals
  wire       tick;

  // Receiver signals
  wire       eor;
  wire [7:0] rx_data;
  
  // Transmitter signals
  wire       start_tx;
  wire       eot;
  wire [7:0] cmd_buffer;
  //wire [1:0] cmd_decoded;

  // Ramp signals
  wire       start_ramp;
  wire       eoramp;
  wire       tick_10ms;
  wire       tick_1ms;

  // SAR signals
  wire             start_sar;
  wire             eosar;
  wire [Width-1:0] adc_result;

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

  transmitter #(
    .Nbits(8),
    .Sticks(16)
  ) mod_transmitter ( 
    .clk_i(clk_i),
    .rst_i(rst_i),
    .stt_i(start_tx),
    .tick_i(tick),
    .din_i(adc_result[Width-1:2]),
    .tx_o(tx_o),
    .eot_o(eot)
  );

  ramp #(
    .Width(Width)
  ) mod_ramp ( 
    .clk_i(clk_i),
    .rst_i(rst_i),
    .start_i(start_ramp),
    .cnt_o(cnt_o),
    .time_o(time_o),
    .tick_10ms_o(tick_10ms),
    .tick_1ms_o(tick_1ms),
    .eos_o(eoramp)
  );

  fsm_sar #(
    .Width(10)
  ) mod_fsm_sar (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .start_i(start_sar),
    .cmp_i(cmp_i),
    .result_o(adc_result),
    .dac_o(dac_o),
    .sample_o(sample_o),
    .eoc_o(eosar)
  );

  fsm_unic_cass #(
    .Width(8)
  ) mod_fsm_unic_cass (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .cmd_buffer_i(cmd_buffer),
    .eor_i(eor),
    .eot_i(eot),
    .eoramp_i(eoramp),
    .eosar_i(eosar),
    .tick_10ms_i(tick_10ms),
    .tick_1ms_i(tick_1ms),
    .start_tx_o(start_tx),
    .start_ramp_o(start_ramp),
    .start_sar_o(start_sar)
  );
  
  // Just for testing
  lfsr #(
    .Width(5)
   ) dut (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .en_i(1'b1),
    .q_o(),
    .rnd_o(rnd_o)
  );

endmodule
