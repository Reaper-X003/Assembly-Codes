org 100h
MOV CL, 1

LOOP1:
MOV CH, 1

LOOP2:
MOV AH, 2 
MOV DL, '*' 
INT 21H 

MOV AH, 2 
MOV DL, ' ' 
INT 21H 

INC CH 
CMP CH, CL 

JLE LOOP2

MOV AH, 2 
MOV DL, 10 
INT 21H   
MOV DL, 13 
INT 21H 

INC CL 
CMP CL, 5 
JLE LOOP1     
ret