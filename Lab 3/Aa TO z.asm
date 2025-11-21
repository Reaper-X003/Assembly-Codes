
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
MOV BL ,97
lOOP:
MOV AH, 2
MOV DL, BL
INT 21H
MOV DL,32
INT 21H
INC BL
CMP BL, 122
JLE LOOP

ret




