# Code Guidelines



## 1. Objetivos

Esta guía de estilo de codificación esta basada en [lowRISC Verilog Coding Style Guide](https://github.com/lowRISC/style-guides/blob/master/VerilogCodingStyle.md)[^1]. Esta guía tiene como objetivos:

- Promover la coherencia entre los proyectos de desarrollo de hardware.
- Aumentar la legibilidad del código.
- Promover las mejores prácticas.
- Aumentar el intercambio y la reutilización de código.
- Disminuir los errores de codificación.



## 2. Reglas

**No tabuladores**

No utilice tabuladores en ningún sitio. Utilizar espacios para sangrar o alinear el texto.



**Sin espacios finales**

Elimina los espacios en blanco al final de las líneas.



**Usar `begin` y `end` a menos que toda la declaración quepa en una sola línea.**

Sólo se puede omitir `begin` y `end` si toda una sentencia terminada en punto y coma cabe en una sola línea.

``` verilog linenums="1"
if (condition) begin
  foo = bar;
end else begin
  foo = bum;
end
```



**La sangría es de dos espacios por nivel.**

Utilice espacios para la sangría. No utilice tabuladores. Debe configurar su editor para que emita espacios cuando pulse la tecla de tabulación.



**Listas delimitadas por comas**

Para varios elementos en una línea, un espacio debe separar la coma y el carácter siguiente.



**Alineación tabular**

En general, se fomenta el uso de la alineación tabular.

```verilog linenums="1"
logic [7:0]  my_interface_data;
logic [15:0] my_interface_address;
logic        my_interface_enable;
logic        another_signal;
logic [7:0]  something_else;
```


**Comentarios**

Se prefieren los comentarios estilo C++ (`//` foo). También se pueden utilizar comentarios de estilo C (`/\* bar \*/`).



## 3. Plantilla básica

```verilog linenums="1"
// Author: Some Name
// Name: my_module.v
// 
// Description: Amazing code description

module my_module #(
  parameter Width = 80,
  parameter Height = 24
) (
  input              clk_i,
  input              rst_ni,
  input              req_valid_i,
  input  [Width-1:0] req_data_i,
  output             req_ready_o,
  ...
);

  logic [Width-1:0] req_data_masked;

  submodule u_submodule (
    .clk_i,
    .rst_ni,
    .req_valid_i,
    .req_data_i (req_data_masked),
    .req_ready_o(req_ready),
    ...
  );

  always_comb begin
    req_data_masked = req_data_i;
    case (fsm_state_q)
      ST_IDLE: begin
        req_data_masked = req_data_i & MASK_IDLE;
        ...
  end

  ...

endmodule
```




## 4. Referencias

[^1]: “style-guides/VerilogCodingStyle.md at master · lowRISC/style-guides”. <https://github.com/lowRISC/style-guides/blob/master/VerilogCodingStyle.md> (consultado el 20 de agosto de 2023).
[^2]: “Google C++ Style Guide”. <https://google.github.io/styleguide/cppguide.html> (consultado el 29 de agosto de 2023).