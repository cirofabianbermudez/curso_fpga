// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module fifo #(
  parameter Width    = 9,  // number of bits in a word
  parameter AddrBits = 4   // number of address bits
) ( 
  input               clk_i,
  input               rst_i,
  input               wr_i,
  input               rd_i,
  input  [Width-1:0]  w_data_i,
  output [Width-1:0]  r_data_o;
  output              empty_o,
  output              full_o,
);

  reg    [Width-1:0] array_reg [2**AddrBits-1:0];          // register array
  reg [AddrBits-1:0] w_ptr_reg, w_ptr_next, w_ptr_succ;
  reg [AddrBits-1:0] r_ptr_reg, r_ptr_next, r_ptr_succ;
  reg                full_reg, full_next;
  reg                empty_reg, empty_next;
  wire               wr_en;

  // register file write operation
  always @(posedge clk_i, posedge rst_i) begin
    if (wr_en) begin
      array_reg[w_ptr_reg] <= w_data_i;
    end
  end

  // write enable only when FIFO is not full
  assign wr_en = wr_i & ~full_reg;

  // register file read operation
  assign r_data_o = array_reg[r_ptr_reg];

  // register for read and write pointers
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      w_ptr_reg <= 0;
      r_ptr_reg <= 0;
      full_reg  <= 1'b0;
      empty_reg <= 1'b1;
    end else begin
      w_ptr_reg <= w_ptr_next;
      r_ptr_reg <= r_ptr_next;
      full_reg  <= full_next;
      empty_reg <= empty_next;
    end
  end

  // next state logic for read and write pointers
  always @(*) begin
    // successive pointer values
    w_ptr_succ = w_ptr_reg + 1;
    r_ptr_succ = r_ptr_reg + 1;
    // default: keep old values
    w_ptr_next = w_ptr_reg;
    r_ptr_next = r_ptr_reg;
    full_next  = full_reg;
    empty_next = empty_reg;
    case ({wr_i, rd_i})
      // 2'00: no op
      2'b01 : begin // read
                if (~empty_reg) begin // not empty
                  r_ptr_next = r_ptr_succ
                  full_next = 1'b0;
                  if (r_ptr_succ == w_ptr_reg) begin
                    empty_next = 1'b1;
                  end
                end
              end
      2'b10 : begin // write
                if (~full_reg) begin
                  w_ptr_next = w_ptr_succ;
                  empty_next = 1'b0;
                  if (w_ptr_succ == r_ptr_reg) begin
                    full_next = 1'b1;
                  end
                end
              end
      2'b11 : begin // write and read
                w_ptr_next = w_ptr_succ;
                r_ptr_next = r_ptr_succ;
              end
    endcase
  end

  assign full_o  = full_reg;
  assign empty_o = empty_reg;

  
endmodule
