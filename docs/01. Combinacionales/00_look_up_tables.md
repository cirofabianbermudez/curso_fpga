# 00. Look Up Tables
## 1. Códigos

### 1.1. Ecuación booleana
``` verilog title="lut1.v" linenums="1"
module lut1(
  input A,
  input B,
  input C,
  input D,
  output X
);

  assign X = (~A & B & ~C) | (A & B & ~C) | (B & ~C & D);

endmodule
```

### 1.2. Diagrama esquemático
``` verilog title="lut2.v" linenums="1"
module lut2(
  input A,
  input B,
  input C,
  input D,
  output X
);

  wire c1;
  wire c2;
  wire c3;

  assign c1 = ~A & B & ~C;
  assign c2 = A & B & ~C;
  assign c3 = B & ~C & D;
  assign  X = c1 | c2 | c3;

endmodule
```

### 1.3. Primitivas de Verilog
Las compuertas pueden ser de más de dos entradas.
``` verilog title="lut3.v" linenums="1"
module lut3(
  input A,
  input B,
  input C,
  input D,
  output X
);

  and(c1,~A, B,~C);
  and(c2, A, B,~C);
  and(c3, B,~C, D);
  or(X,c1,c2,c3);

endmodule
```

### 1.4. Mintérminos
También se les conoce como suma de productos o SOP (Sum Of Products).
``` verilog title="lut4.v" linenums="1"
module lut4(
  input A,
  input B,
  input C,
  input D,
  output reg X
);

  always @(A,B,C,D) begin
    if ( (~A & ~B & ~C & ~D) | (A & B & C & D) | (A & ~B & ~C & D) ) begin
      X = 1;
    end else begin
      X = 0;
    end
  end

endmodule
```

## 2. Verificación
### 2.1. Testbench
``` verilog title="lut_tb.v" linenums="1"
`timescale 1ns / 100 ps
`include "lut1.v"

module lut_tb();
  // Definición de señales de entrada y salida
  reg A;
  reg B;
  reg C;
  reg D;
  wire X;

  // Instanciacion del modulo
  lut1 dut(.A(A), .B(B), .C(C), .D(D), .X(X));

  // Variables para archivo, iteraciones y tiempo
  integer write_data;
  integer i;
  time t;

  initial begin
    // Configuracion de archivos de salida
    write_data = $fopen("lut_tb_output.txt","w");
    
    // Salida de simulacion y variables de salida
    $dumpfile("lut_tb.vcd");
    $dumpvars(0,lut_tb);
    
    // Configuracion de formato de tiempo
    $timeformat(-9, 2, " ns", 10);

    // Simular todas las combinaciones posibles
    for (i = 0; i < 16; i++) begin
        {A,B,C,D} = i; #20; t = $time;
        $fdisplay(write_data,"Time = %t, {A,B,C,D} = %b, X = %b", t, {A,B,C,D}, X);
    end

    // Cerrar archivo de texto
    $fclose(write_data);

    // Terminar simulacion
    $display("Test completed");
    $finish;

  end

endmodule
```

### 2.2. Resultados
```plain title="lut_tb_output.txt" linenums="1"
Time =   20.00 ns, {A,B,C,D} = 0000, X = 1
Time =   40.00 ns, {A,B,C,D} = 0001, X = 0
Time =   60.00 ns, {A,B,C,D} = 0010, X = 0
Time =   80.00 ns, {A,B,C,D} = 0011, X = 0
Time =  100.00 ns, {A,B,C,D} = 0100, X = 0
Time =  120.00 ns, {A,B,C,D} = 0101, X = 0
Time =  140.00 ns, {A,B,C,D} = 0110, X = 0
Time =  160.00 ns, {A,B,C,D} = 0111, X = 0
Time =  180.00 ns, {A,B,C,D} = 1000, X = 0
Time =  200.00 ns, {A,B,C,D} = 1001, X = 1
Time =  220.00 ns, {A,B,C,D} = 1010, X = 0
Time =  240.00 ns, {A,B,C,D} = 1011, X = 0
Time =  260.00 ns, {A,B,C,D} = 1100, X = 0
Time =  280.00 ns, {A,B,C,D} = 1101, X = 0
Time =  300.00 ns, {A,B,C,D} = 1110, X = 0
Time =  320.00 ns, {A,B,C,D} = 1111, X = 1
```




## 4. Referencias
1. Russell, “Tutorial - Boolean Algebra using Look-Up Tables (LUTs)”, *Nandland*, el 9 de junio de 2022. [https://nandland.com/lesson-4-what-is-a-look-up-table-lut](https://nandland.com/lesson-4-what-is-a-look-up-table-lut) (consultado el 17 de julio de 2023).
2. “Quine–McCluskey algorithm”. [https://www.mathematik.uni-marburg.de/~thormae/lectures/ti1/code/qmc](https://www.mathematik.uni-marburg.de/~thormae/lectures/ti1/code/qmc) (consultado el 17 de julio de 2023).
3. “Gate Level Modeling”, ChipVerify. [https://www.chipverify.com/verilog/verilog-gate-level-modeling](https://www.chipverify.com/verilog/verilog-gate-level-modeling) (consultado el 17 de julio de 2023).
