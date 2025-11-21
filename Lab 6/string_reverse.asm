DATA SEGMENT
    msg1 DB 'String: $'
    msg2 DB 0DH,0AH,'Reversed String: $'
    str1 DB 'JAKARIA$', 0
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX

    LEA DX, msg1
    MOV AH, 9
    INT 21H

    LEA DX, str1
    MOV AH, 9
    INT 21H

    LEA SI, str1
    MOV CX, 0

FIND_LEN:
    MOV AL, [SI]
    CMP AL, '$'
    JE GOT_LEN
    INC SI
    INC CX
    JMP FIND_LEN

GOT_LEN:
    DEC SI
    LEA DI, str1

    MOV BX, CX
    SHR BX, 1

REVERSE_LOOP:
    MOV AL, [DI]
    MOV DL, [SI]
    MOV [DI], DL
    MOV [SI], AL

    INC DI
    DEC SI
    DEC BX
    JNZ REVERSE_LOOP

    LEA DX, msg2
    MOV AH, 9
    INT 21H

    LEA DX, str1
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H
CODE ENDS
END START
