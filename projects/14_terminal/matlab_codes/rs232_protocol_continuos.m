% Clean up
clear; close all; clc;

% Open and setup COM port
com = "COM12";
baud = 9600;
fpga = serialport(com,baud,"Timeout",10,"Parity","even");


while true
    prompt = "Enter a command: ";
    value = input(prompt);
    if (value == 0)
        fprintf("Exit.\n");
        break;
    end

    % Write data
    % value = 2;
    write(fpga,value,"uint8");

    % read data
    data = read(fpga,4,"uint8");
    data_char = char(data);
   fprintf(">> %s\n",data_char)
end

% Close COM port
clear fpga;