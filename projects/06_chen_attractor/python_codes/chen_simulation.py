import numpy as np
import matplotlib.pyplot as plt

# Tiempo de simulación (t) y paso de integración (h)
h = 0.001
inicio = 0.0
fin  = 100.0 + h
t = np.arange(inicio, fin, h)

# Condiciones iniciales
x0 = -0.1
y0 = 0.5
z0 = -0.6

# Parametros
a = 40.0
b = 3.0
c = 28.0

tam = np.size(t)

xn = np.zeros(tam)
yn = np.zeros(tam)
zn = np.zeros(tam)

xn[0] = x0
yn[0] = y0
zn[0] = z0

for i in range(1,tam):
    xn[i] = xn[i-1] + h*( a*( yn[i-1] - xn[i-1] ) )
    yn[i] = yn[i-1] + h*( (c - a)*xn[i-1] - xn[i-1]*zn[i-1] + c*yn[i-1] )
    zn[i] = zn[i-1] + h*( xn[i-1]*yn[i-1] - b*zn[i-1] )


# Generar grafica 2d
plt.plot(yn, zn, lw=0.5)

t_xn = np.abs(xn).max()
t_yn = np.abs(yn).max()
t_zn = np.abs(zn).max()

print("Max xn ",t_xn)
print("Max yn ",t_yn)
print("Max zn ",t_zn)

# Generar grafica 3d
# ax = plt.figure().add_subplot(projection='3d')
# ax.plot(xn, yn, zn)

plt.show()