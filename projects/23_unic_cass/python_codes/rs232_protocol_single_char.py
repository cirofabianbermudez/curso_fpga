import serial

fpga = serial.Serial(
    port          = 'COM12',
    baudrate      = 9600,
    bytesize      = serial.EIGHTBITS,
    parity        = serial.PARITY_EVEN,
    stopbits      = serial.STOPBITS_ONE, 
    timeout       = 5,
    write_timeout = 5
)

value = b'\xaa'
fpga.write(value)
data = fpga.read(size = 1)
if (data == b''):
    print("Timeout, data not received.")
else:
    print("\nThe character was:")
    print(data)

fpga.close()