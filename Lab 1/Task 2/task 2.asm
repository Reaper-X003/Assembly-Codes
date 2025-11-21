
org 100h

main proc
    mov ah, 1 
    int 21h
    mov bl, al
    mov ah, 2 
    mov dl, 9 
    int 21h
    mov dl, bl 
    int 21h
end main

ret




