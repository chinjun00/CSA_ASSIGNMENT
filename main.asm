.model small    
.stack 100
.data
    welcMsg db "Welcome to Defintely-Not Public Bank !" ,'$'
    msgLog db "Login your ID" ,'$'
    msgPass db "Input your password", '$'

    UserInput db 100 dup(0), '$'
 
 
 
 
    msgEnd db 13, 10, "5. Exit Program",'$'

 
    output db 8 dup(0), '$'
    strOutput   db 13,10,"output: "
    newline db 13, 10, '$'

.code
ORG 0h
main proc
    mov ax,@data
    mov ds,ax


    ; Print output
    mov ah,9h
    lea dx,welcMsg
    int 21h

Login:

    ;Prompt Username Login
    mov ah,9h
    lea dx,msgLog
    int 21h

    ;User Input Name
    mov ah,01h
    int 21h
    mov bh,ah ; << need store user login

    ;Prompt User Password
    mov ah,9h
    lea dx,msgPass

    ;User Input Password
    mov ah,01h 
    int 21h
    mov bh,ah ; << need store user password

    cmp dh,bh ; compare username in database


    
    mov ah,01h 
    int 21h
    mov bh,ah

Relogin:


;Store username
StoreName:
    
main     endp
end     main