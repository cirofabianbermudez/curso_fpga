# Author: Ciro Fabian Bermudez Marquez
# Name:
#
# Description: 

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
df = pd.read_csv("data.csv")

# Extract columns
x = df.iloc[:, 0]
y = df.iloc[:, 1]

# Plot size
plt.figure(figsize=(8, 6))

# Select font
plt.rc('font', family='serif') 

# Label size
plt.rc('xtick', labelsize=7)
plt.rc('ytick', labelsize=7)

# Ticks size
plt.xticks(fontsize=12)
plt.yticks(fontsize=12)

# Plot 
plt.plot(x, y, label='RS232-RX' ,linewidth=0.6)

# Label and legend and title
plt.title('Mesuarements', size=12)      # Add an r Raw String Literal
plt.xlabel('Sample', size=12)
plt.ylabel('Voltage', size=12)
plt.legend(shadow=True, loc='upper right', fontsize='small')

# Grid configuration
plt.grid(visible=True, which='major', color='#666666', linestyle='-', alpha=0.4)
plt.minorticks_on()
plt.grid(visible=True, which='minor', color='#999999', linestyle='--', alpha=0.2)

# Axis configuration
plt.axis([x.min(), x.max()*1.1, y.min(), y.max()*1.1])

# Save as pdf
plt.savefig('plot.pdf', format='pdf')

# Save as png
plt.savefig('plot.png', format='png')

# Show plot
#plt.show()