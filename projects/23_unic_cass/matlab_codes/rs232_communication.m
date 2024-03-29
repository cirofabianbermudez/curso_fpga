%% Clean up
clear; close all; clc;

%% Open and setup COM port
com = "COM12";
baud = 115200;
fpga = serialport(com,baud,"Timeout",10,"Parity","none");

%% Write data
% tic
% for j = 1:100
%     for i = 0:255
%         value = i;
%         write(fpga,value,"uint8");
%         % pause(0.1);
%     end
% end

value = 0:255;
value = repmat(value,1,100);
tic
write(fpga,value,"uint8");

%% read data
% data = read(fpga,4,"uint8");
% data_char = char(data)
%% Close COM port
clear fpga;
toc