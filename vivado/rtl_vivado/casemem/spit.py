import os
import numpy as np

#ADDRWIDTH = 17
#MEMDEPT = 2**(ADDRWIDTH-2)
def ram32():
    MEMDEPT = 1416

    # read in memory file
    mem_temp = []
    f =  open("./case.pat", "r") 
    mem_temp_list = f.readline()
    while(mem_temp_list):
        mem_temp.append(mem_temp_list)
        mem_temp_list = f.readline()
    #mem_temp = f.readline()
    f.close()
    mem = []
    with open("./caseram.pat", "w") as file:
        for i in range(MEMDEPT):
            memaddr0 = mem_temp[i][11:19]
            mem.append(memaddr0)
            memaddr1 = mem_temp[i][21:29]
            mem.append(memaddr1)
            memaddr2 = mem_temp[i][31:39]
            mem.append(memaddr2)
            memaddr3 = mem_temp[i][41:49]
            mem.append(memaddr3)
            # write byte0 to file 0
            for j in range (4):
                file.write(f"@{i*4+j:04x} {mem[j+i*4]} \n")


def ram32to8():
    MEMDEPT = 5664
    mem_temp = []
    f =  open("./caseram.pat", "r") 
    mem_temp_list = f.readline()
    while(mem_temp_list):
        mem_temp.append(mem_temp_list)
        mem_temp_list = f.readline()
    f.close
    mem = []
    with open("./caseram8.pat", "w") as file:
        for i in range(MEMDEPT):
            memaddr0 = mem_temp[i][12:14]
            mem.append(memaddr0)
            memaddr1 = mem_temp[i][10:12]
            mem.append(memaddr1)
            memaddr2 = mem_temp[i][8:10]
            mem.append(memaddr2)
            memaddr3 = mem_temp[i][6:8]
            mem.append(memaddr3)
            # write byte0 to file 0
            for j in range (4):
                file.write(f"@{i*4+j:04x} {mem[j+i*4]} \n")

ram32to8()
