# Libros

## FPGA based CPU designs from the 90s, PART I, joe smith, Youtube

1. The art of digital design, an introduction to Top-Down Design - Franklin P. Prosser. David E.
2. Computer Architecture and Organization - John P. Hayes

## Coursera intro fpga design embedded systems

1. Rapid Prototyping of Digital Systems: SOPC Edition, by Hamblen, Hall and Furman; ISBN 9780387726700
2. Design Recipes for FPGAs Using Verilog and VHDL, 2nd Edition, by Peter Wilson;  ISBN 978-0-08-097129-2


1. History of Programmable Logic

2. CPLD, its architecture and performance

3. Introduce FPGA, constrast with CPLD and LUT makeup


A field programmable gate array (FPGA) is an integrated circuit designed to be configured by a customer or a designer after manufacturing - hence "field-programmable".

The FPGA configuration is generally specified using a hardware description language (HDL), similar to that used for an application-specific integrated circuit (ASIC).

FPGA use LUTs to create logic

Se puede construir cualquier cosa digital a partir de tres piezas sencillas: un cable, una puerta lógica y un registro (véase la Figura 1-1). Un registro recuerda una información hasta que se le pide que recuerde otra. Una puerta lógica realiza operaciones lógicas sencillas sobre las señales, y un cable conecta estas otras piezas.


PROM - Programmable Read Only Memory 
EPROM - Eraseable Programmable Read Only Memory 
PLAs - Programmable Logic Arrays
PALs - Programmable Array Logic
CPLDs -  Complex Programmable Logic Device
CLBs - Configurable Logic Blocks
LUTs - Look Up Tables
PLDs - Programmable Logic Devices
LAB - Logic Array Block
PIA - Programmable Interconnect Array

Hardwired
Prorammable Link
Not Connected


Condiguration Memory Choice affects Architecture

antifuse interconnects are highly reliable, but OTP and expensive

FLASH interconnects are highly reliable, reprogrammable, but more expensive than SRAM FPGAs

SRAM interconnects reprogrammable and highest density, lowest cost.
