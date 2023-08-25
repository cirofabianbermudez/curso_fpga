clear; close all; clc;

% Filtro cuantizado
x = load("x_values_real.txt");
an = load("real_coef.txt");
yn = filter(an,1,x);

% Simulacion sin cuantizazar
load("A1_y_output.mat");
yn_sin_cuant = y1;

% Cargar simulacion de verilog
yn_p = load('tb_output.txt');

grosor = 1.2;
figure(1);
hold on;
plot(yn,'r',"DisplayName","Matlab cuantizado","LineWidth",grosor);
plot(yn_p,'b',"DisplayName","Verilog","LineWidth",grosor)
plot(yn_sin_cuant,'g',"DisplayName","Matlab sin cuantizar","LineWidth",grosor)
grid on; grid minor;
legend();

figure(2);
error = yn - yn_p;
plot(error);
grid on; grid minor;
fprintf("Error maximo = %f%%\n", max(abs(error))*100);

