clear; close all; clc;

for i = 1:15
    fprintf("%2d : q_o = { {%2d{sign}} , d_i[n-1:%2d] }; \n", i, i, i);
end
