import numpy as np
import matplotlib.pyplot as plt

# Tiempo de simulación (t) y paso de integración (h)
h = 0.0001
inicio = 0.0
fin  = 500.0 + h
t = np.arange(inicio, fin, h)

# Condiciones iniciales
x0 = 1.0
y0 = 0.0
z0 = 4.5

# Parametros
a = 2.0
b = 6.7

tam = np.size(t)

xn = np.zeros(tam)
yn = np.zeros(tam)
zn = np.zeros(tam)

xn[0] = x0
yn[0] = y0
zn[0] = z0

for i in range(1,tam):
    xn[i] = xn[i-1] + h*( b*yn[i-1] - yn[i-1]*zn[i-1] - a*xn[i-1] )
    yn[i] = yn[i-1] + h*( xn[i-1] )
    zn[i] = zn[i-1] + h*( yn[i-1]*yn[i-1] - zn[i-1] )


# Generar grafica 2d
plt.plot(xn, zn, lw=0.5)

# Generar grafica 3d
# ax = plt.figure().add_subplot(projection='3d')
# ax.plot(xn, yn, zn)

plt.show()