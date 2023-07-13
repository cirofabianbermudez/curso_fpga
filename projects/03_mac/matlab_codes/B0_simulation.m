clear; close all; clc;

x = [-1.5, -1, 0, 1, 1.5, 2];
a = [2.5, 3, 3.5, 4, 4.5, 5];

x = flip(x);
a = flip(a);
acum = 0;
for i = 1:numel(x)
    acum = acum + x(i)*a(i);
    fprintf("%2d : x = %6.3f\ta = %6.3f\tR = %6.3f\n",i,x(i),a(i),acum)
end
