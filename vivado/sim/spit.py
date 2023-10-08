import os
import numpy as np

#ADDRWIDTH = 17
#MEMDEPT = 2**(ADDRWIDTH-2)
MEMDEPT = 1416

# read in memory file
mem_temp = []
f =  open("D:/PHM/code/aging_SoC/vivado/sim/case.pat", "r") 
mem_temp_list = f.readline()
while(mem_temp_list):
    mem_temp.append(mem_temp_list)
    mem_temp_list = f.readline()
#mem_temp = f.readline()
f.close()
print(mem_temp,type(mem_temp))
for j in range(4):
    with open(f"case{j}.pat", "w") as file:
        file.truncate()
# split memory into four files
for i in range(MEMDEPT):
    mem0addr0 = mem_temp[i][47:49]
    mem0addr1 = mem_temp[i][37:39]
    mem0addr2 = mem_temp[i][27:29]
    mem0addr3 = mem_temp[i][17:19]
    mem1addr0 = mem_temp[i][45:47]
    mem1addr1 = mem_temp[i][35:37]
    mem1addr2 = mem_temp[i][25:27]
    mem1addr3 = mem_temp[i][15:17]
    mem2addr0 = mem_temp[i][43:45]
    mem2addr1 = mem_temp[i][33:35]
    mem2addr2 = mem_temp[i][23:25]
    mem2addr3 = mem_temp[i][13:15]
    mem3addr0 = mem_temp[i][41:43]
    mem3addr1 = mem_temp[i][31:33]
    mem3addr2 = mem_temp[i][21:23]
    mem3addr3 = mem_temp[i][11:13]
    
    

    # write byte0 to file 0
    with open("case0.pat", "a") as f0:
        f0.write(f"@{4*i:04x} {mem0addr3} {mem0addr2} {mem0addr1} {mem0addr0} \n")

    # write byte1 to file 1
    with open("case1.pat", "a") as f1:
        f1.write(f"@{4*i:04x} {mem1addr3} {mem1addr2} {mem1addr1} {mem1addr0} \n")

    # write byte2 to file 2
    with open("case2.pat", "a") as f2:
        f2.write(f"@{4*i:04x} {mem2addr3} {mem2addr2} {mem2addr1} {mem2addr0} \n")

    # write byte3 to file 3
    with open("case3.pat", "a") as f3:
        f3.write(f"@{4*i:04x} {mem3addr3} {mem3addr2} {mem3addr1} {mem3addr0} \n")