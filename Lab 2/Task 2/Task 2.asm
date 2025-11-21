
org 100h

main proc
    
mov ah, 1 
int 21h
mov bl, al

mov ah, 2 
mov dl, 20h 
int 21h

mov ah, 1 
int 21h 
mov bh, al
 
sub bl, bh
add bl, 48

mov ah, 2 
mov dl, 10 
int 21h
mov dl, 13 
int 21h
mov dl, bl 
int 21h

end main

ret




