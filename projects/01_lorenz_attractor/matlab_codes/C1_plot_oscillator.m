clear; close all; clc;

data = load("../verilog_codes/lorenz_tb_output.txt");
x = data(:,1);
y = data(:,2);
z = data(:,3);

plot3(x,y,z); grid on; grid minor;
view(60,15);