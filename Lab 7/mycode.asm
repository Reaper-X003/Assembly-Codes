.model small
.stack 100h

.data
prompt1 db 10,13, 'Input first integer: $'
prompt2 db 10,13, 'Input second integer: $'
menu db 10,13, 'Select Operation:',10,13,'A. Add',10,13,'B. Subtract',10,13,'C. Multiply',10,13,'D. Divide',10,13,'Option: $'
resultMsg db 10,13, 'Solution: $'
errMsg db 10,13, 'Unknown selection!$'
zeroErr db 10,13, 'Cannot divide by zero!$'

firstVal dw ?
secondVal dw ?
finalVal dw ?

.code

main proc
    mov ax, @data
    mov ds, ax

    ; Input first number
    mov ah, 9
    lea dx, prompt1
    int 21h
    call getInteger
    mov firstVal, bx

    ; Input second number
    mov ah, 9
    lea dx, prompt2
    int 21h
    call getInteger
    mov secondVal, bx

    ; Show menu and get operation
    mov ah, 9
    lea dx, menu
    int 21h

    mov ah, 1
    int 21h
    mov bl, al

    cmp bl, 'A'
    je plusOp
    cmp bl, 'a'
    je plusOp
    cmp bl, 'B'
    je minusOp
    cmp bl, 'b'
    je minusOp
    cmp bl, 'C'
    je timesOp
    cmp bl, 'c'
    je timesOp
    cmp bl, 'D'
    je divideOp
    cmp bl, 'd'
    je divideOp

    ; Unknown selection
    mov ah, 9
    lea dx, errMsg
    int 21h
    jmp endProg

plusOp:
    mov ax, firstVal
    add ax, secondVal
    mov finalVal, ax
    jmp displayAnswer

minusOp:
    mov ax, firstVal
    sub ax, secondVal
    mov finalVal, ax
    jmp displayAnswer

timesOp:
    mov ax, firstVal
    imul secondVal
    mov finalVal, ax
    jmp displayAnswer

divideOp:
    mov ax, secondVal
    cmp ax, 0
    jne okToDivide
    mov ah, 9
    lea dx, zeroErr
    int 21h
    jmp endProg

okToDivide:
    mov dx, 0
    mov ax, firstVal
    idiv secondVal
    mov finalVal, ax
    jmp displayAnswer

displayAnswer:
    mov ah, 9
    lea dx, resultMsg
    int 21h
    mov ax, finalVal
    call showInteger
    jmp endProg

endProg:
    mov ah, 4Ch
    int 21h
main endp

;-------------------------------------
; getInteger: read multi-digit input, returns value in BX
;-------------------------------------
getInteger proc
    mov bx, 0
inputNext:
    mov ah, 1
    int 21h
    cmp al, 13
    je intDone
    sub al, '0'                 ; ASCII to integer (0..9)
    mov cx, bx                  ; previous value
    mov dx, 10
    mov ax, cx
    mul dx                      ; ax = bx * 10
    mov cl, al                  ; new digit to cl
    xor ch, ch                  ; zero-extend cl -> cx
    add ax, cx                  ; ax = bx*10 + digit
    mov bx, ax                  ; store new sum
    jmp inputNext
intDone:
    ret
getInteger endp

;-------------------------------------
; showInteger: prints integer value in AX
;-------------------------------------
showInteger proc
    push ax
    cmp ax, 0
    jge doPrint
    neg ax
    mov dl, '-'
    mov ah, 2
    int 21h

doPrint:
    mov bx, 10
    mov cx, 0
    mov dx, 0
    cmp ax, 0
    jne pushLoop
    mov dl, '0'
    mov ah, 2
    int 21h
    pop ax
    ret

pushLoop:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne pushLoop

printNext:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop printNext
    pop ax
    ret
showInteger endp

end main
