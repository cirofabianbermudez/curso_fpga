clear; close all; clc;

iter = 15;
for i = 1:iter
    fprintf("%2d : q_o = { {%2d{sign}} , d_i[n-1: %2d] };\n",i,i,i);
end