clear; close all; clc;

%  Simulacion  en punto flotante en C
% data = load("../c_codes/output_lorenz_float.txt");

%  Simulacion en punto fijo
% data = load("../c_codes/output_lorenz_fixed.txt");

% Simulacion de verilog
data = load("../verilog_codes/piecewise_linear_tb_output.txt");

x = data(:,1);
y = data(:,2);
z = data(:,3);

f1 = figure(1);
set(f1, 'Position', [0, 0, 560, 420]);
plot(x,y,'k');
grid on; grid minor;
xlabel("$x$",'Interpreter','latex');
ylabel("$y$",'Interpreter','latex');
title('$x-y$','Interpreter','latex'); 
set(gca,'TickLabelInterpreter','latex', 'FontSize', 12);

f2 = figure(2);
set(f2, 'Position', [0, 350, 560, 420]);
plot(y,z,'k');
grid on; grid minor;
xlabel("$y$",'Interpreter','latex');
ylabel("$z$",'Interpreter','latex');
title('$y-z$','Interpreter','latex'); 
set(gca,'TickLabelInterpreter','latex', 'FontSize', 12);

f3 = figure(3);
set(f3, 'Position', [550, 0, 560, 420]);
plot(x,z,'k');
grid on; grid minor;
xlabel("$x$",'Interpreter','latex');
ylabel("$z$",'Interpreter','latex');
title('$x-z$','Interpreter','latex'); 
set(gca,'TickLabelInterpreter','latex', 'FontSize', 12);

f4 = figure(4);
set(f4, 'Position', [550, 350, 560, 420]);
plot3(x,y,z,'k'); view(40,15);
grid on; grid minor;
xlabel("$x$",'Interpreter','latex');
ylabel("$y$",'Interpreter','latex');
zlabel("$z$",'Interpreter','latex');
title('$x-y-z$','Interpreter','latex'); 
set(gca,'TickLabelInterpreter','latex', 'FontSize', 12);

% plot3(x,y,z); grid on; grid minor;
% view(60,15);