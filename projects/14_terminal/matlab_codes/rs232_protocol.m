%% Clean up
clear; close all; clc;

%% Open and setup COM port
com = "COM12";
baud = 9600;
fpga = serialport(com,baud,"Timeout",10,"Parity","even");

%% Write data
value = 2;
write(fpga,value,"uint8");

%% read data
data = read(fpga,4,"uint8");
data_char = char(data)
%% Close COM port
clear fpga;