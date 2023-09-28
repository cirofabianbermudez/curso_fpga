# Author: Ciro Fabian Bermudez Marquez
# Name:
#
# Description: 

import sys

try:
    import serial
except ImportError:
    print('This program uses the Python pip package "pyserial"')
    print('Run following command to install it:')
    print('pip install  pyserial')
    sys.exit()

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
            timeout       = 10,
            write_timeout = 10
        )
    except serial.SerialException:
        print(f">> Port {port_name} is busy, please close the port and try again.")
        sys.exit()
        
    print(f">> Port {port_name} is available and open.")

    # Read user input
    #cmd = input(">> Enter a command, example (0xa2): ")

    # Convert input to byte
    for i in range(256):
        #cmd_int = int(cmd, 16)
        cmd_int = i
        cmd_byte = cmd_int.to_bytes(1)
        #cmd_byte = cmd_int.to_bytes(1, byteorder = "big", signed = False)

        # Write to fpga
        fpga.write(cmd_byte)

        # Read from fpga
        data = fpga.read(size = 1)
        if (data == b''):
            print(">> Timeout, data not received.")
        else:
            print(">>\n>> The command was: ", end='')
            data_int = int.from_bytes(data)
            data_hex = f'0x{data_int:02x}'
            data_bin = f'{data_int:08b}'
            print(data_hex)

    fpga.close()