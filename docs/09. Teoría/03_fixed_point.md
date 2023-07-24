# 03. Aritmética de punto fijo



## Complemento a 1
El complemento a 1 consiste en invertir todos los 1s por 0s y todos los 0s por 1s de todo el número binario. Ejemplo: $1010 1111$ y su complemento a 1 es $01010000$.

## Complemento a 2
El complemento a 2 consiste en realizar el complemento a 1 y posteriormente sumar un 1. Ejemplo: $1010 1111$ entonces su complemento a 2 se calcula primero ejecutando el complemento a 1, $0101 0000$ y sumando un 1 al resultado anterior obtenemos $0101 0001$

## Punto Fijo

Un número de punto fijo tiene la forma $A(a,b)$ donde $a$ es la parte entera, y $b$  es la parte fraccionaria. El número de bits que tienen $A(a,b)$ es $\text{nbits} = a+b+1$, de manera que es la suma de la parte entera más la parte fraccionaria más un bit de signo. El rango de números que se pueden representar es $[-2^{a}, 2^{a} - 2^{-b}]$. Esta representación trabaja con una lógica aritmética de complemento a 2.

| Número      | Representación | Valor en decimal | Rango            | Valor decimal sin signo |
| ----------- | -------------- | ---------------- | ---------------- | ----------------------- |
| `0000 1000` | $A(3,4)$       | 0.5              | $[-8.0, 7.9375]$ | 8                       |
| `0000 1100` | $A(3,4)$       | 0.75             | $[-8.0, 7.9375]$ | 12                      |
| `0111 0011` | $A(3,4)$       | 7.1875           | $[-8.0, 7.9375]$ | 115                     |
| `1001 0000` | $A(2,5)$       | -3.5             | $[-4.0,3.96875]$ | 144                     |
| `1001 0000` | $A(3,4)$       |  -7.0                | $[-8.0, 7.9375]$ | 144                     |
