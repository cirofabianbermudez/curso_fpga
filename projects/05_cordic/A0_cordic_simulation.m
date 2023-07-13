clear; close all; clc;

% Numero de iteraciones
iter = 12;

% Vectores del algoritmo
xi = zeros(1,iter+1);
yi = zeros(1,iter+1);
zi = zeros(1,iter+1);
ki = zeros(1,iter+1);

% Variables de entrada  Nota: y0 = 0 y xo = 1/An = Kn entonces tenemos una calculadora de seno
xi(1) = 0.607253;
yi(1) = 0;       % este es el valor aproximado de Kn
zi(1) = 20;

ki(1) = 1/ sqrt(1 + 2^(-2*0));
fprintf("Datos de entrada\n");
fprintf("0\t%f\t%f\t%f\t%f\t%2d\t%f\n",xi(1),yi(1),zi(1),ki(1), d_fun( zi(1) ), 2^-(0));
fprintf("i\txi\t\t\tyi\t\t\tzi\t\t\tki\t\t\tdi\t2^(-i)\n");
for i = 1:1:iter+1
    ki(i+1) = 1/ sqrt(1 + 2^(-2*(i)));
    xi(i+1) = xi(i) - yi(i) * d_fun( zi(i) ) * 2^-(i-1);
    yi(i+1) = yi(i) + xi(i) * d_fun( zi(i) ) * 2^-(i-1);
    zi(i+1) = zi(i) -  d_fun( zi(i) ) * atand(2^-(i-1));
    fprintf("%d\t%f\t%f\t%f\t%f\t%2d\t%f\n",i,xi(i+1),yi(i+1),zi(i+1),ki(i+1),d_fun( zi(i+1) ),2^-(i) );
end
kn =  prod(ki);					% comprobar ki
xn = xi(iter+1);                % Multiplicar por *kn para rotacion normal
yn = yi(iter+1);
fprintf("Ki = %f\n", kn);
fprintf("xn = %f\tyn = %f\n", xn,yn);
fprintf("Resultados de CORDIC\n");
fprintf("xn = cos(%2.2f) = %f\tyn = sin(%2.2f) = %f\n",zi(1),xn,zi(1),yn);
fprintf("Resultados \n");
fprintf("xn = cos(%2.2f) = %f\tyn = sin(%2.2f) = %f\n",zi(1),cosd(zi(1)),zi(1),sind(zi(1)));

function R = d_fun(x)
    if x >= 0
        R = 1;
    else
        R = -1;
    end
end