%% Clean up
clear; close all; clc;

%% Open and setup COM port
com = "COM12";
baud = 9600;
fpga = serialport(com,baud,"Timeout",10,"Parity","none");

%% Write data
value = 127;
write(fpga,value,"uint8");

%% Close COM port
clear fpga;