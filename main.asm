.model small    
.stack 100
.data
    strMenu     msg1 db "Please Login your username and Password." ,'$'
               
                db 13, 10, "5. Exit Program",'$'
    strX    db 13,10,"x: (0-9 only)",'$'
    stry    db 13,10,"y: (0-9 only)",'$'
    x db 0
    y db 0
    output db 8 dup(0), '$'
    strOutput   db 13,10,"output: "
 
    newline db 13, 10, '$'

.code
ORG 0h
main proc
    mov ax,@data
    mov ds,ax

main     endp
end     main