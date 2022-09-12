.model small    
.stack 100
.data
    secret db 20 dup(0), '$'
    encrypted db 20 dup(0), '$'
    key db 0
    msg1 db 13, 10, "Enter encrypted word: ", '$'
    msg2 db 13, 10, "Enter decryption key (1-9): ", '$'
    msg3 db 13, 10, "The secret word is ", '$'
    newline db 13, 10, '$'

.code
main proc
    mov ax,@data
    mov ds,ax
    mov bl, '$'
    lea di, secret
    mov ah, 9h
    lea dx, msg1
    int 21h
again:
    mov ah, 1
    int 21h
    cmp al, 13
    je next
    mov [di], al
    inc di
    jmp again

next:
    mov [di], bl
    mov ah, 9h
    lea dx, msg2
    int 21h
    mov ah, 1
    int 21h
    sub al, 30h
    mov key, al

process:
    lea si, secret
    lea di, encrypted
pAgain:
    cmp bl, [si]
    je stop
    mov al, key
    add al, [si]
    mov [di], al
    inc si
    inc di
    jmp pAgain
stop:
    mov ah, 9h
    lea dx, msg3
    int 21h
    lea dx, encrypted
    int 21h
    mov ah,4ch
    int 21h
main     endp
end     main