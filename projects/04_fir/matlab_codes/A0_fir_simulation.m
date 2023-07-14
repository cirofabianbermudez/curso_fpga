clear; close all; clc;

n = 0:1:200;         % Muestas
w1 = 1e3;            % En Hz
w2 = 60;             % En Hz
Ts = (1/w1)/10;      % Periodo de muestreo 10 veces periodo de la señal mas grande
x1 = 0.2*sin(2*pi*w1*Ts*n);     % 2*w1*Ts
x2 = sin(2*pi*w2*Ts*n);         % 2*w2*Ts
x = x1+x2;

figure(1);
subplot(3,1,1), stem(n,x1), grid on; grid minor; title('x1');
subplot(3,1,2),  stem(n,x2), grid on; grid minor; title('x2');
subplot(3,1,3), stem(n,x), grid on; grid minor; title('x=x1+x2');

% Analisis de frecuencia
[X1,w] = freqz(x1,1);
[X2,w] = freqz(x2,1);
[X,w] = freqz(x,1);
figure(2);
subplot(3,1,1), plot(w/pi , abs(X1) ), grid on; grid minor; title('x1');
subplot(3,1,2), plot(w/pi, abs(X2) ), grid on; grid minor; title('x2');
subplot(3,1,3), plot(w/pi, abs(X) ), grid on; grid minor; title('x=x1+x2');

orden = 15;
h1 = fir1(orden,0.05,hamming(orden+1));         % 250 Hz  0.05/(2*Ts)
figure(3); freqz(h1);

% Filtrado
y1 = filter(h1,1,x);
figure(3);
subplot(3,1,1), stem(n,x), grid on; grid minor; title('x');
subplot(3,1,2),  stem(n,x2), grid on; grid minor; title('x2');
subplot(3,1,3), stem(n,y1), grid on; grid minor; title('y1');

figure(4);
stem(h1); grid on; grid minor;