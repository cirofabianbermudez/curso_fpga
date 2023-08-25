clear; close all; clc;
n_bits = 32;
p_fracc = 25;
% for i = 1:15
%     ang(i) = atand(2^(-(i-1)));
%     fun(i) = d2b(n_bits, b, ang(i));
%     fprintf("%2d : angulo = 32'b%s; // %5.3f \n", (i-1), fun, i);
% end

for i = 1:15
    t = atand(2^(-(i-1)));
    res1 = d2b(n_bits, p_fracc, t);
    res2 = b2d(n_bits, p_fracc, res1);
    fprintf("%2d: angulo = 32'b%s; // %40.35f \n", i-1, res1, res2);
end



%Decimal a binario
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