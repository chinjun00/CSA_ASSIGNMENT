.model small
.stack 100
.data

    headln1            DB 10,10,13,2 DUP(9), 'Definitely Not Public Bank Logo','$'
    systemPauseMsg DB 10,13," Press Any Key To Continue...$"  

    userID              DB 'ABC12345'
    usrBuffer           DB 8 DUP(?)
    userMsg             DB 10,10,13,' Enter your user id: $'
    validMsg            DB 10,10,13,'   Access Granted',10,13,'$'
	invalidMsg          DB 10,10,13,'   Invalid Password',10,13,'$'



.code

main proc
    mov ax, @data
	mov ds, ax
	call cls
    call userLogin  

exit: 
    mov ah,4ch
    int 21h



cls proc
    mov ax,0600h ;CLEAR SCREEN	
    mov bh,07h		
    mov cx,0	
    mov dx,184Fh	
    int 10H
    mov ah,02h  ;set cursor
    mov bh,00
    mov dh,00
    mov dl,00
    int 10h
    ret
cls endp 

displaylogo proc
    	mov ah, 9h		            ;display HEADER
    	lea dx, headln1            
    	int 21h
	ret
displaylogo endp

systemPause proc
    mov ah,09h
    lea dx,systemPauseMsg
    int 21h 
    
    mov ah,01h
    int 21h
    ret
    
systemPause endp



main endp
end main