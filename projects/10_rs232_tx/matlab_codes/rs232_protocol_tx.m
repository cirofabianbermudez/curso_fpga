%% Clean up
clear; close all; clc;

%% Open and setup COM port
com = "COM12";
baud = 9600;
fpga = serialport(com,baud,"Timeout",10,"Parity","none");

%% Read data
data = read(fpga,1,"uint8");
databin = dec2bin(data);
flush(fpga);

%% Close COM port
clear fpga;