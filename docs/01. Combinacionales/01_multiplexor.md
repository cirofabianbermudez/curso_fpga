# 01. Multiplexor

## 1. Códigos

### 1.1 Multiplexor 2 a 1 de n bits
``` verilog title="mux2_to_1.v" linenums="1"
module mux2_to_1 #(
  parameter Width = 32
) (
  input  [Width-1:0] in1_i,
  input  [Width-1:0] in2_i,
  input              sel_i,
  output [Width-1:0] mux_o
);

  assign mux_o = sel_i ? in2_i : in1_i;

endmodule
```

### 1.1 Multiplexor 4 a 1 de n bits



``` verilog title="mux4_to_1.v" linenums="1"
module mux4_to_1 #(
  parameter Width = 32
) (
  input      [Width-1:0] in1_i,
  input      [Width-1:0] in2_i,
  input      [Width-1:0] in3_i,
  input      [Width-1:0] in4_i,
  input            [1:0] sel_i,
  output reg [Width-1:0] out_o
);

  always @(in1_i, in2_i, in3_i, in4_i, sel_i) begin
    case (sel_i)
      2'b00   : out_o = in1_i;
      2'b01   : out_o = in2_i;
      2'b10   : out_o = in3_i;
      2'b00   : out_o = in4_i;
      default : out_o = 0;
    endcase
  end

endmodule
```

``` verilog title="mux256_to_1.v" linenums="1"
module mux256_to_1 (
  input  [255:0] in_i,
  input    [7:0] sel_i,
  output         out_o
);

  assign out_o = in_i[sel_i];

endmodule
```

## 2. Verficación


## Referencias
+ _Circuitos combinacionales. Introducción. | ELEC02.- Circuitos combinacionales MSI._ (s/f). Recuperado el 10 de julio de 2023, de [https://ikastaroak.ulhi.net/edu/es/IEA/ELEC/ELEC02/es_IEA_ELEC02_Contenidos/website_5_circuitos_combinacionales_introduccin.html](https://ikastaroak.ulhi.net/edu/es/IEA/ELEC/ELEC02/es_IEA_ELEC02_Contenidos/website_5_circuitos_combinacionales_introduccin.html)
