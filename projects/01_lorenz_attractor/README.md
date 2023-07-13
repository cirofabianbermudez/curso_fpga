# Atractor de Lorenz

## Sistema dinámico
$$
\begin{array}{lcl}
  \dot{x} & = &  \sigma(y-x)\\
  \dot{y} & = &  x(\rho - z) - y\\
  \dot{z} & = &  xy - \beta z
\end{array}
$$

## Método numérico (forward Euler)

El método de forward Euler es el siguiente:
$$
y_{n+1} = y_{n} + h f(x_{n},y_{n})
$$
El sistema discretizado resulta:
$$
\begin{array}{lcl}
		x_{{n+1}} & = & x_{n} + h [  \sigma(y_{n}-x_{n}) ]  \\
		y_{{n+1}} & = & y_{n} + h [x_{n}(\rho - z_{n}) - y_{n} ] \\
		z_{{n+1}} & = & z_{n} + h [x_{n}y_{n} - \beta z_{n}]  \\
\end{array}
$$
donde
$$
\begin{array}{lcl}
		\sigma & = & 10\\
		\rho & = &  28\\
		\beta & = &  8/3\\
\end{array}
$$
con las siguientes condiciones iniciales:
$$
\begin{array}{lcl}
		x_{0} & = & 1\\
		y_{0} & = & 1\\
		z_{0} & = & 1
\end{array}
$$




## Simulación con python

1. Crear un entorno virtual con `python3 -m venv venv`

2. Activar el entorno virtual

3. Instalar paquetes básicos

   ```plain
   pip install numpy
   pip install matplotlib
   ```

   
