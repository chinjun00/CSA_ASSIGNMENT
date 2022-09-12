.model small    
.stack 100
.data
    character db 'A', 13, 10, '$'
    msg1 db "Do you want to continue printing (y/n)? $"
    msg2 db "Please enter 'y' or 'n' only. $"
    newline db 13, 10, '$'

.code
main proc
    mov ax,@data
    mov ds,ax
again:
    mov ah, 9h
    lea dx, character
    int 21h
    mov dl, character
    inc dl
    mov character, dl
msg11:
    mov ah, 9h
    lea dx, msg1
    int 21h

    mov ah, 1h
    int 21h

    mov ah, 9h
    lea dx, newline
    int 21h

    cmp al, 'y'
    je again
    cmp al, 'n'
    je stop    

    mov ah, 9h
    lea dx, msg2
    int 21h
    mov ah, 9h
    lea dx, newline
    int 21h
    jmp msg11

stop:
    mov ah,4ch
    int 21h
main     endp
end     main