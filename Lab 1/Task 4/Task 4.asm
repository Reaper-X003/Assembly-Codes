
org 100h

mov ah, 1 
int 21h
mov bl, al
mov ah, 2
mov dl, 10 
int 21h
mov dl, 13 
int 21h
mov dl, bl 
int 21h
ret





