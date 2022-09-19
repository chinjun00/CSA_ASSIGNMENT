.model small    
.stack 100
.data
    welcMsg db "Welcome to Defintely-Not Public Bank !" ,'$'
    msgLog db "Login your ID" ,'$'
    msgPass db "Input your password", '$'

    UserInput db 100 dup(0), '$'

.code
ORG 01h
main proc
    mov ax,@data
    mov ds,ax
    mov si, 0
    mov ah,01h
    int 21h

again:
    mov UserInput[si], al
    inc si
    cmp UserInput[si], 
    loop again

stop:
    mov ah,4ch
    int 21h
main endproc
 end main