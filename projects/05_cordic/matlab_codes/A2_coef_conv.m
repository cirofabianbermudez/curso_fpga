clear; close all; clc;

load C1_coeficientes.mat;
an = p;
an = flip(an);
n_bits = 32;
p_fracc = 28;

file = fopen("real_coef.txt", "w");

real_coef = zeros(1,numel(an));
for i = 1:numel(an)
    res1 = d2b(n_bits, p_fracc, an(i));
    res2 = b2d(n_bits, p_fracc, res1);
    fprintf("%2d: an_o = 32'b%s; // %40.35f \n", i-1, res1, res2);
    fprintf(file,'%40.35f\n',res2);
end
% -0.00977396208327263593673706054687500
% -0.00977396208327264
% Conversion flotante a punto fijo

test = pi/2;
x = d2b(n_bits, p_fracc, test)
x_c = b2d(n_bits, p_fracc, x)


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