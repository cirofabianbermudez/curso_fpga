import serial

# Open serial communication
fpga = serial.Serial(
    port          = 'COM12',
    baudrate      = 9600,
    bytesize      = serial.EIGHTBITS,
    parity        = serial.PARITY_EVEN,
    stopbits      = serial.STOPBITS_ONE, 
    timeout       = 5,
    write_timeout = 5
)

while True:
    # Read user input
    cmd = input("Enter a command, example (0xa2): ")
    
    # Convert input to byte
    cmd_int = int(cmd, 16)
    cmd_byte = cmd_int.to_bytes()
    #cmd_byte = cmd_int.to_bytes(1, byteorder = "big", signed = False)
    
    # Agregar logica de comando invalida

    if (cmd_byte == b'\x00') :
        print("Exit")
        break
    
    # Write to fpga
    fpga.write(cmd_byte)

    # Read from fpga
    data = fpga.read(size = 1)
    if (data == b'') :
        print("Timeout, data not received.")
    else:
        print("The command was: ")
        data_int = int.from_bytes(data)
        data_hex = f'0x{data_int:02x}'
        data_bin = f'{data_int:08b}'
        print(data_hex, "\n")

fpga.close()