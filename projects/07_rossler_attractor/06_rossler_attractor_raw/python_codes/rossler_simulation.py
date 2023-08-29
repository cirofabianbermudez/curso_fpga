import numpy as np
import matplotlib.pyplot as plt

# Tiempo de simulación (t) y paso de integración (h)
h = 0.0001
inicio = 0.0
fin  = 500.0 + h
t = np.arange(inicio, fin, h)

# Condiciones iniciales
x0 = 1.0
y0 = 1.0
z0 = 1.0

# Parametros
#a = 0.4
#b = 2.0
#c = 4.0

#a = 0.2
#b = 0.2
#c = 5.7

#a = 0.1
#b = 0.1
#c = 14.0

tam = np.size(t)

xn = np.zeros(tam)
yn = np.zeros(tam)
zn = np.zeros(tam)

xn[0] = x0
yn[0] = y0
zn[0] = z0

for i in range(1,tam):
    xn[i] = xn[i-1] + h*( -yn[i-1] -zn[i-1] )
    yn[i] = yn[i-1] + h*( xn[i-1] + a*yn[i-1] )
    zn[i] = zn[i-1] + h*( b + zn[i-1]*(xn[i-1] - c) )


# Generar grafica 2d
plt.plot(xn, zn, lw=0.5)

# Generar grafica 3d
# ax = plt.figure().add_subplot(projection='3d')
# ax.plot(xn, yn, zn)

plt.show()