import serial

fpga = serial.Serial(
    port          = 'COM12',
    baudrate      = 9600,
    bytesize      = serial.EIGHTBITS,
    parity        = serial.PARITY_EVEN,
    stopbits      = serial.STOPBITS_ONE, 
    timeout       = 5,
    write_timeout = None
)

while True:
    data = fpga.read(size = 1)
    if (data == b''):
        print("Timeout, data not received.")
        break
    else:
        print("\nThe character was:")
        dataint = int.from_bytes(data)
        #dataint = int.from_bytes(data, byteorder = "big", signed = False)
        #datachar = data.decode('utf-8')
        databin = f'{dataint:08b}'
        datahex = f'0x{dataint:02x}'
        print(databin)

# print("\nLeer un caracter:")
# data = fpga.read(size = 1)
# if (data == b''):
    # print("Ningun dato recibido")
# else:
    # print("El caracter fue:")
    # print(data)

fpga.close()