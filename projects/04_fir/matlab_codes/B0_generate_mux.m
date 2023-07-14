clear; close all; clc;

% Generar codigo input
for i = 0:20
    fprintf("input      [n-1:0] x%d_i,\n",i);
end

% Generar codigo case
for i = 0:20
    fprintf("%2d : out_o = x%d_i;\n",i,i);
end