.model small
.stack
.data
msg1 db "please enter a digit: $"    
msg2 db " times $"            
msg3 db " returns: $"
.code
main     proc
      mov ax,@data    ;initialise data segment
      mov ds,ax

      mov ah,09h    
      lea dx,msg1    ;display msg1
      int 21h
      mov ah,01h    ;input a digit
      int 21h
      sub al,30h    ;ASCII value - 30h = ACTUAL value
    mov bl,al        ;store the digit in bl
      mul bl           ;al times bl (result stored in al)
      mov cl,al     ;store first digit of result in cl
      mov ah,02h    
      mov dl,0dh
      int 21h        ;new line
      mov dl,0ah
      int 21h
      mov ah,02h    ;display user input digit
      mov dl,bl
     add dl,30h    ;add 30h to get the ASCII value
      int 21h    
      mov ah,09h    
      lea dx,msg2    ;display "times"
      int 21h
      mov ah,02h    ;display again user input digit
      mov dl,bl    
     add dl,30h    ;add 30h to get the ASCII value
      int 21h
      mov ah,09h    
      lea dx,msg3        ;display the message "returns"
      int 21h
      mov ah,02h        ;display the 1st digit of result
      mov dl,cl        
    add dl,30h        ;add 30h to get the ASCII value
      int 21h

      mov ah,4ch        ;exit
      int 21h
main endp
end main