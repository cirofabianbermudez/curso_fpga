clear; close all; clc;

% Definicion del problema
samples = 200;
n = 0:1:samples; % muestras
w1 = 1e3; % En Hz
w2 = 60; % En Hz
Ts = (1/w1)/20; % Periodo de muestreo 10 veces periodo de la señal mas grande
x1 = 1.0*sin(2*pi*w1*Ts*n); % 2*w1*Ts
x2 = 6.0*pinknoise(1,samples+1);

x = x1+x2;
save('A1_x_values.mat', "x");

figure(1);
subplot(3,1,1), stem(n,x1), grid on; grid minor; title('Señal sin ruido');
subplot(3,1,2), plot(n,x2), grid on; grid minor; title('Ruido rosa');
subplot(3,1,3), plot(n,x), grid on; grid minor; title('Señal con ruido');

% Analisis de frecuencia
[X1,w] = freqz(x1,1);
[X2,w] = freqz(x2,1);
[X,w] = freqz(x,1);
figure(2);
subplot(3,1,1), plot(w/pi , abs(X1) ), grid on; grid minor; title('x1');
subplot(3,1,2), plot(w/pi, abs(X2) ), grid on; grid minor; title('x2');
subplot(3,1,3), plot(w/pi, abs(X) ), grid on; grid minor; title('x=x1+x2');

% Diseño de filtro
orden = 20;
h1 = fir1(orden,[0.05 0.15],hamming(orden+1)); % 250 Hz 0.05/(2*Ts)
save('A1_filter_val.mat', "h1");
figure(3); freqz(h1);

% Filtrado
y1 = filter(h1,1,x);
figure(4);
subplot(3,1,1), plot(n,x), grid on; grid minor; title('Señal con ruido');
subplot(3,1,2), plot(n,x2), grid on; grid minor; title('Ruido rosa');
subplot(3,1,3), plot(n,y1), grid on; grid minor; title('Señal filtrada');
save('A1_y_output.mat', "y1");
save('A1_all_variables.mat');


% Respuesta al impulso
figure(5);
stem(h1); grid on; grid minor;

