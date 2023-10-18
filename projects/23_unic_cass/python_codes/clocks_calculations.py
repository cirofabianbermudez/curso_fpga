# Author: Ciro Fabian Bermudez Marquez
# Name:
#
# Description: 

import math

if __name__ == '__main__':
    fpga_freq = 10_000_000
    rs232_freq = 115200
    oversampling = 16
    
    print(f" Parameters:")
    print(f" FPGA freq     = {fpga_freq}")
    print(f" RS232 freq    = {rs232_freq}")
    print(f" Oversampling  = {oversampling}")
    
    print("")
    
    # RS232 conter values
    maxval = fpga_freq/(rs232_freq*oversampling)
    print(f" BaudRate MaxVal = {maxval:15.2f} = {round( maxval ):15d}")
    nbits = math.log2(maxval)
    print(f" BaudRate nbits  = {nbits:15.2f} = {math.ceil( nbits ):15d}")
    
    # 10 ms conter values
    txt_string = "10 ms"
    time = 10e-3
    maxval = fpga_freq * time
    print(f" MaxVal {txt_string}    = {maxval:15.2f} = {round( maxval ):15d}")
    nbits = math.log2(maxval)
    print(f" nbits  {txt_string}    = {nbits:15.2f} = {math.ceil( nbits ):15d}")
    
    # 10 ms conter values
    txt_string = "1 ms"
    time = 1e-3
    maxval = fpga_freq * time
    print(f" MaxVal {txt_string}     = {maxval:15.2f} = {round( maxval ):15d}")
    nbits = math.log2(maxval)
    print(f" nbits  {txt_string}     = {nbits:15.2f} = {math.ceil( nbits ):15d}")
    
    
    # 10 MHz conter values
    fpga_freq = 100_000_000
    txt_string = "10 MHz"
    time = 1/(10e6)
    maxval = fpga_freq * time / 2
    print(f" MaxVal {txt_string}   = {maxval:15.2f} = {round( maxval ):15d}")
    nbits = math.log2(maxval)
    print(f" nbits  {txt_string}   = {nbits:15.2f} = {math.ceil( nbits ):15d}")