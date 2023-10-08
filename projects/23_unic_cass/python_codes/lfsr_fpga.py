# Author: Ciro Fabian Bermudez Marquez
# Name:
#
# Description: 

seed = 0b0001
state = seed
n = 4
for i in range(50):
    print("i = {:03d} {:04b} ".format(i,state), end = "")
    print( state & 1 , end = "")
    if (state == seed):
        print(" Period ")
    else:
        print("")
    newbit = ( state ^ (state >> 1) ) & 1
    state = (state >> 1) | ( newbit << (n-1) )



