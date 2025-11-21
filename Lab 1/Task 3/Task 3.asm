

org 100h

mov ah, 1 
int 21h
mov bl, al
mov ah, 2 
mov dl, 32 
int 21h
mov dl, bl 
int 21h

ret




