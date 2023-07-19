clear; close all; clc;

data = load("../c_codes/output_chen_fixed.txt");
xn = data(:,1);
yn = data(:,2);
zn = data(:,3);

% figure(1);
% plot(xn,yn); grid on; grid minor;
% xlabel("xn"); ylabel("yn");
% 
% figure(2);
% plot(yn,zn); grid on; grid minor;
% xlabel("yn"); ylabel("zn");

figure(3);
plot(xn,zn); grid on; grid minor;
xlabel("xn"); ylabel("zn");

% figure(4);
% plot3(xn,yn,zn); grid on; grid minor;
% xlabel("xn"); ylabel("yn"); zlabel("zn");