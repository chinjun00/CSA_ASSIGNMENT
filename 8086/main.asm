.model large   
.stack 1000
.data
    welcMsg db "Welcome to Defintely-Not Public Bank !" ,'$'
    
    
    msgLog db 13,10,  "Login your ID" ,'$'
    msgPass db 13,10, "Input your password", '$'

    reloginMsg1 db 13,10, "Wrong Input Of Username or Password!" ,'$'
    reloginMsg2 db 13,10, "Plesae sign in your user ID Correctly" ,'$'

    arrayID db 50 dup(0),'$';Store Username
    arrayPass db 50  dup(0);Store Password

    arrayRegisteredId db "50 dup(0) ,'$'" 
    arrayRegisteredPass db 50 dup(0) 

    UserInput db 100 dup(0), '$' 
 

    newline db 13, 10, '$'

    msgEnd db 13, 10, "Exit Program",'$'


.code
main proc
    mov ax,@data
    mov ds,ax


    ; Print output
    mov ah,9h
    lea dx,welcMsg ;"Welcome to Defintely-Not Public Bank !"
    int 21h
    jmp Login
    

Login:

    ;Prompt Username Login
    mov ah,9h
    lea dx,msgLog ;"Login your ID"
    int 21h

    ;User Input Name
    mov ah,01h
    int 21h
    mov si,0
    mov arrayID[si],al ; << Stored user input ID in array

    ; Jump to relogin if not the same input
    mov ax,arrayID[si]
    

    cmp arrayID[si],al           ; memory cannot cmp with memory
    inc si

    jne Relogin
    je MainMenu



Relogin:
    mov ah,9h
    lea dx,reloginMsg1
    int 21h
    lea dx,reloginMsg2
    int 21h
    jmp Login

    jmp MainMenu


    ;Prompt User Password
    mov ah,9h
    lea dx,msgPass

    ;User Input Password
    mov ah,01h 
    int 21h
    mov bh,ah ; << need store user password
    mov [si],bh ; store user pass in array

    cmp dh,bh ; compare username in database


    
    mov ah,01h 
    int 21h
    mov bh,ah





;Store username


MainMenu:



StoreName:
    
main     endp
end     main