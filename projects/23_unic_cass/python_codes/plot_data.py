# Author: Ciro Fabian Bermudez Marquez
# Name:
#
# Description: 

import sys

try:
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
except ImportError:
    print('This program uses the Python pip package "numpy", "pandas" and  "matplotlib"')
    print('Run following command to install missing packages:')
    print('pip install <pip_package>')
    sys.exit()

# Read csv file into pandas dataframe
df = pd.read_csv("data.csv", header = None)

# Number con rows
rows = 20461

# Extract columns
x = df.iloc[:rows, 0]
y = df.iloc[:rows, 1]

# Plot size
plt.figure(figsize = (8, 6))

# Select font
plt.rc('font', family = 'serif') 

# Label font size
plt.rc('xtick', labelsize = 7)
plt.rc('ytick', labelsize = 7)

# Ticks font size
plt.xticks(fontsize = 12)
plt.yticks(fontsize = 12)

# Plot 
#plt.plot(x, y, label = 'RS232-RX', linewidth = 0.6, markersize = 4, c = 'black', marker = 'o')
plt.scatter(x, y, label = 'RS232-RX', s = 5, c = 'black', marker = 'o')

# Label and legend and title
plt.title('Mesuarements', size = 12)      # Add an r Raw String Literal
plt.xlabel('Sample', size = 12)
plt.ylabel('Voltage', size = 12)
plt.legend(shadow = True, loc = 'upper right', fontsize = 'small')

# Grid configuration
plt.grid(visible = True, which = 'major', color = '#666666', linestyle = '-', alpha = 0.4)
plt.minorticks_on()
plt.grid(visible = True, which = 'minor', color = '#999999', linestyle = '--', alpha = 0.2)

# Ticks configuration
xmin = 0; xmax = rows; xstep = 4000;
ymin = 0; ymax = 255; ystep = 25;
plt.xticks(np.arange(xmin, xmax+xstep, step = xstep))
plt.yticks(np.arange(ymin, ymax+ystep, step = ystep))

# Axis configuration
plt.axis([x.min(), x.max()*1.1, y.min(), y.max()*1.1])

# Save as pdf
plt.savefig('plot.pdf', format = 'pdf')

# Save as png
plt.savefig('plot.png', format = 'png')

# Show plot
#plt.show()
