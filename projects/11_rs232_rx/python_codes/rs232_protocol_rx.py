import serial

fpga = serial.Serial(
    port          = 'COM12',
    baudrate      = 9600,
    bytesize      = serial.EIGHTBITS,
    parity        = serial.PARITY_EVEN,
    stopbits      = serial.STOPBITS_ONE, 
    timeout       = 10,
    write_timeout = 10
)

value = b'\xaa'
fpga.write(value)

fpga.close()