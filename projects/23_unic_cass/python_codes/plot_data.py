# Author: Ciro Fabian Bermudez Marquez
# Name:
#
# Description: 

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Lee el archivo CSV en un DataFrame de pandas
df = pd.read_csv("data.csv")

# Accede a la primera y segunda columna
x = df.iloc[:, 0]  # Primera columna
y = df.iloc[:, 1]  # Segunda columna

# Tamaño de la figura
plt.figure(figsize=(8, 6))

# Usar fuente de LaTeX
plt.rc('font', family='serif') 

# Tamaño de letra de los ejes
plt.rc('xtick', labelsize=7)
plt.rc('ytick', labelsize=7)

# Tamaño de la letra de los números de los ejes
plt.xticks(fontsize=12)
plt.yticks(fontsize=12)

plt.plot(x, y, linewidth=0.6)

# Nombres de ejes y legenda
#plt.xlabel(r'Título del eje x', size=12)
#plt.ylabel(r'Título del eje y', size=12)
#plt.legend(shadow=True, loc='upper right', fontsize='small')

# Configuraciones de Grid
#plt.grid(visible=True, which='major', color='#666666', linestyle='-', alpha=0.4)
#plt.minorticks_on()
#plt.grid(visible = True, which='minor', color='#999999', linestyle='--', alpha=0.2)

# Cambiar los limites de los ejes
#plt.axis([x.min(), x.max(), y.min(), y.max()])

# Titulo de la grafica
#plt.title(r'Titulo de la gráfica', size=12)      # Add an r Raw String Literal

# Mostrar la grafica
plt.show()