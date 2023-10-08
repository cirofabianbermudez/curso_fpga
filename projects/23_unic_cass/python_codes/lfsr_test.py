# Author: Ciro Fabian Bermudez Marquez
# Name:
#
# Description: 

def bit_not(n, numbits = 8):
    return (1 << numbits) - 1 - n

def xnor(A, B, n):
    return bit_not(A ^ B, n)

seed = 0b00001
state = seed
n = 5

for i in range(100):
    print("i = {:02d} {:05b} ".format(i,state), end = "")
    print( state & 1 , end = "")
    if (state == seed):
        print(" Period ")
    else:
        print("")
    newbit = xnor( state, (state >> 2) , n) & 1
    state = (state >> 1) | (newbit << (n-1) )


