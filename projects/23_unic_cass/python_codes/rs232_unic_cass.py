# Author: Ciro Fabian Bermudez Marquez
# Name:
#
# Description: 

import sys

try:
    import serial
    import numpy as np
    import pandas as pd
except ImportError:
    print('This program uses the Python pip package "pyserial"')
    print('Run following command to install it:')
    print('pip install  pyserial')
    sys.exit()

if __name__ == '__main__':
    # Port name
    port_name = 'COM12'
    
    # # Open serial communication
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
        
        # Check for exit command
        if (cmd == "exit" ):
            cmd_int = 0
            break

        # Convert input to byte
        cmd_int = int(cmd, 16)
        cmd_byte = cmd_int.to_bytes(1)
        cmd_hex = f'0x{cmd_int:02x}'
        #cmd_byte = cmd_int.to_bytes(1, byteorder = "big", signed = False)
        
        # Write to fpga
        fpga.write(cmd_byte)
        
        if (cmd_int != 1):
            print(f">> Command {cmd_hex} is not a valid command.")
        else:
            print(f">> Command {cmd_hex}: START SYSTEM.")
            break
    
    count = 0
    x = np.arange(1,20462+1)
    y = np.zeros(20462, dtype=np.uint8)
    if (cmd_int == 1):
      while True:
        data = fpga.read(size = 1)
        data_int = int.from_bytes(data)
        y[count] = data_int
        if (data == b''):
            print(">> Timeout, data not received.")
            break
        else:
            count = count + 1

    print(count)
    #data_uint8 = np.frombuffer(data, dtype = np.uint8)
    #print(np.shape(data_uint8))
    #x = np.arange(1,20461+1)
    
    # Export to csv
    filename = "data.csv"
    df = pd.DataFrame({'Items': x, 'Voltage': y})
    df.to_csv(filename, index = False, header = False)

    fpga.close()
    print(f">> Port {port_name} is closed.")
