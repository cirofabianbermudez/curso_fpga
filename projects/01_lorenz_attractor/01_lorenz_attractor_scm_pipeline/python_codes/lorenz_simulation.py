import numpy as np
import matplotlib.pyplot as plt

h = 0.001
inicio = 0.0
fin  = 100.0 + h
t = np.arange(inicio, fin, h)

# Condiciones iniciales
x0 = 1.0
y0 = 1.0
z0 = 1.0

# Parametros
sigma = 10.0
rho = 28.0
beta = 8.0/3.0

tam = np.size(t)

xn = np.zeros(tam)
yn = np.zeros(tam)
zn = np.zeros(tam)

xn[0] = x0
yn[0] = y0
zn[0] = z0

for i in range(1,tam):
    xn[i] = xn[i-1] + h*( sigma*( yn[i-1] - xn[i-1] ) )
    yn[i] = yn[i-1] + h*( xn[i-1]*( rho - zn[i-1] ) - yn[i-1] )
    zn[i] = zn[i-1] + h*( xn[i-1] * yn[i-1] - beta*zn[i-1] )


# Generar grafica 2d
plt.plot(xn, zn)

plt.show()