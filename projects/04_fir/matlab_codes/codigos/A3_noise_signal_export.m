clear; close all; clc;

load A1_x_values.mat;
x_values = x;

file = fopen("x_values.txt", "w");
file2 = fopen("x_values_real.txt", "w");

check = zeros(1,201);
for i = 1:numel(x_values)
    res = d2b(18, 15, x_values(i));
    check(i) = b2d(18, 15, res);
    fprintf(file,'%s\n',res);
    fprintf("%3d: %20.17f\n",i,check(i));
    fprintf(file2,'%20.17f\n',check(i));
end

fclose(file);
fclose(file2);

% Conversion flotante a punto fijo
function f = d2b(nbits, b, value)    
    aux = value*2^b;
    aux2 = fix(aux);     
    r = dec2bin(aux2,nbits);  
    f = r(end-nbits+1:end);    
end

% Conversion punto fijo a flotante
function f = b2d(nbits, b, value)                        
    detector = str2double(value(1));   
    aux = bin2dec(value) - detector*2^(nbits); 
    f = aux/(2^b);     
end