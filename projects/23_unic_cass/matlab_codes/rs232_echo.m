%% Clean up
clear; close all; clc;

%% Open and setup COM port
com = "COM12";
baud = 115200;
fpga = serialport(com,baud,"Timeout",10,"Parity","none");

%% Test
% fileID = fopen('test.txt','w');
fileID = 1;

word_vector = 0:255;
word_vector = repmat(word_vector,1,1);
for i = word_vector % [65:90 97:122]
    % Write data
    value = i;
    write(fpga,value,"uint8");    
    % Read data
    data = read(fpga,1,"uint8");
    data_char = char(data);
    fprintf(fileID,">>> %3d \t",data);
    test = (value == data);
    if (test)
        fprintf(fileID,"TEST PASSED\n");
    else
        fprintf(fileID,"ERROR\n");
        break;
    end
end

%  Close file is not the standard output
if (fileID ~= 1)
    fclose(fileID);
end

%% Close COM port
clear fpga;