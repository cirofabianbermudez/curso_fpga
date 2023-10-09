# Author: Ciro Fabian Bermudez Marquez
# Name:
#
# Description: 

import sys
import re

try:
    import serial
    import numpy as np
    import pandas as pd
except ImportError:
    missing_modules = []
    if "numpy" not in locals():
        missing_modules.append("numpy")
    if "pandas" not in locals():
        missing_modules.append("pandas")
    if "pyserial" not in locals():
        missing_modules.append("matplotlib")
    print('The following packages are missing:')
    for package in missing_modules:
        print(" - {}".format(package))
    print('Run following command to install missing packages:')
    print('pip install <package_name>')
    sys.exit()

def cmd_0x01():
    # Initialize vectors
    count = 0
    rows = 20460 + 1
    x = np.arange(1, rows+1)
    y = np.zeros(rows, dtype=np.uint8)
    
    # Read RS232 
    while True:
        data = fpga.read(size = 1)
        if (data == b''):
            print(">> Timeout, process finished.")
            break
        else:
            data_int = int.from_bytes(data)
            y[count] = data_int
            count = count + 1
            
        #print(count)
    
    # Export data to csv
    filename = "data.csv"
    df = pd.DataFrame({'Items': x, 'Voltage': y})
    df.to_csv(filename, index = False, header = False)
    print(">> File 'data.csv' created.")

if __name__ == '__main__':
    # Port name
    port_name = 'COM12'
    
    # Open serial communication
    try: 
        fpga = serial.Serial(
            port          = port_name,
            baudrate      = 115200,
            bytesize      = serial.EIGHTBITS,
            parity        = serial.PARITY_NONE,
            stopbits      = serial.STOPBITS_ONE, 
            timeout       = 2,
            write_timeout = 2
        )
    except serial.SerialException:
        print(f">> Port {port_name} is busy, please close the port and try again.")
        sys.exit()
        
    print(f">> Port {port_name} is available and open.")

    while True:
        # Read user input
        cmd = input(">> Enter a command, example (0xa2): ")
        
        # Check if input is correct
        pattern = r'^0x[0-9]{2}$'
        match = re.match(pattern, cmd)
        
        # Check for exit command
        if (cmd == "exit" ):
            cmd_int = 0
            break
        
        if not match:
            print(f">> The command is not in the correct format.")
            continue
            
        # Convert input to byte
        cmd_int = int(cmd, 16)
        cmd_byte = cmd_int.to_bytes(1)
        cmd_hex = f'0x{cmd_int:02x}'
        
        # Write to fpga
        fpga.write(cmd_byte)
        
        # Decode command   
        if (cmd_int == 1):
            print(f">> Command {cmd_hex}: START SYSTEM.")
            cmd_0x01()
        else:
            print(f">> Command {cmd_hex} is not a valid command.")
    
    # Close serial communication
    fpga.close()
    print(f">> Port {port_name} is closed.")
