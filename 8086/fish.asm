.model small    
.stack 100
.data

a db "test$"
;loginmenu
loginmenu   db 13,10,"1.Login"
            db 13,10,"2.Register"
            db 13,10,"Please Enter Your Choice:",'$'     
;deliveryOption
deliveryoption db "Do you want Delivery?(RM5)"
;login enter
strpassword1 db 13,10,"Please Login Now",'$'
strpassword db 13,10,"Password:",'$'
;register password
strregisterpassword db 13,10,"New Password:",'$'
;wrong password
strwrongpass db 13,10,"Wrong Password",'$'
;correct password
strcorrectpass db 13,10,"Welcome",'$'

;store Password
passwrd db 8 dup(?)
passwrd1 db "abc123",'$'
regpassword db 8 dup(?)

count dw 6


mainMenu    db 13,10,"    Main Menu     "
            db 13,10,"=================="
            db 13,10,"1.Fish Order Menu"
            db 13,10,"2.Payment"
            db 13,10,"3.Exit"
            db 13,10,"Enter Your Selection : ",'$'

fishmenu    db 13,10," Fish Order Menu"
            db 13,10,"=================="
            db 13,10,"1.Salmon"
            db 13,10,"2.Squid"
            db 13,10,"3.Tuna"
            db 13,10,"4.Eel"
            db 13,10,"5.Back"
            db 13,10,"Enter Fish Choice : ",'$'

quan DB 30h, 30h, 30h, 30h
price DB 4,2,6,8
promtselect   db 10,13,"Please Enter Quantity : ",'$'
orderQtyEror db 10,13," only 1-4 ",'$'
orderPaymentEror db 10,13," not more than 99",'$'

disPayment      db  13,10,"Item          Quantity       Price"
                db  13,10,"===================================",'$'
disPayment1     db  13,10,"Salmon           ",'$'
disPayment2     db  13,10,"Squid            ",'$'
disPayment3     db  13,10,"Tuna             ",'$'
disPayment4     db  13,10,"Eel              ",'$'
disPayment5     db  "             ",'$'
disPayment6     db  13,10,"Final Payment :                ",'$'

cashget  db  13,10,"Enter Cash Received : ",'$'

cashreturn db  13,10,"Money to return : RM",'$'

disQty db 0,'$'

nextline db 10,13,'$'

total db 0,0,0,0

three db 0,0,0
 
useramount db 0,0,0
 
num64 db 64h 
num10 db 0AH


.code
MAIN proc
    mov ax,@DATA
    mov ds,ax

mov cx,4
start:
    mov cx,8


menulogin:
;display login menu
    mov ah, 9h
    lea dx, loginmenu
    int 21h
    mov ah, 01
    int 21h
    cmp al,31h
    je Login;if selection 1, jump to login
    cmp al,32h
    je Register;if selection 2,jump to register
    mov ah,4ch
    int 21h  

;register

Register:
mov ah, 9h
lea dx,strregisterpassword
int 21h
mov si,0
mov cx,count
jmp again


;check register
again:
mov ah,1
int 21h
mov [passwrd1+si],al
inc si
loop again
mov ah, 9h
lea dx,strpassword1
int 21h
jmp login


;login
Login:
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h
mov ah, 9h
lea dx,strpassword
int 21h
mov bx,offset passwrd1
mov cx,count
jmp again1


;check  Login
again1:
mov ah,08       
  int 21h       

  cmp al,[bx]
  jne error
  inc bx
  loop again1
  
  
  mov dx,10
  mov ah,2
  int 21h
  mov dx,13
  mov ah,2
  int 21h  
  lea dx,strcorrectpass
  mov ah,09h
  int 21h
  jmp menumain

error:
  mov dx,10
  mov ah,2
  int 21h
  mov dx,13
  mov ah,2
  int 21h  
  mov dx,offset strwrongpass
  mov ah,09h
  int 21h

  jmp menulogin


menumain:
mov ah,09h   
    lea dx,mainmenu    ;display menu  
    int 21h
    mov ah,1h
	int 21h
	cmp al, 33h
	je stop
	cmp al, 31h
	je Order
	cmp al, 32h
    je payment1


jmp menumain

Order:
    mov ah,09h   
    lea dx,fishmenu    ;display fishmenu   
    int 21h
    mov ah,1h
	int 21h
	cmp al, 35h
	je menumain
	cmp al, 31h
	je Salmon
	cmp al, 32h
	je Squid
	cmp al, 33h
	je Tuna
	cmp al, 34h
	je Eeldes

    cmp al,37h
    je payment1

    cmp al,36h
    je destination
	jmp Order

payment1:
    jmp payment

Eeldes:
jmp Eel

    destination:
    jmp display
stop:
    mov ah,4ch
    int 21h

display:
    
    mov ah,09h   
    lea dx,quan    ;display quantity 
    int 21h
    

orderError:
    mov ah,09h
    lea dx,orderQtyEror
    int 21h

    jmp Salmon

Salmon:

    mov si,0    ;display promptselect message
    mov ah,09h   
    lea dx,promtselect 
    int 21h 
    

    mov ah,01h    ;get quantity
    int 21h

    cmp al,31h  ;check input is 1 to 4
    jl orderError 
    cmp al,34h
    jg orderError  

    lea si, quan
    mov [si],al ;store quantity
    lea si, quan

    jmp Order    
  
Squid:
    ;display promptselect message
    mov ah,09h   
    lea dx,promtselect 
    int 21h 
    

    mov ah,01h    ;get quantity
    int 21h

    lea si, quan
    mov [si+1],al ;store quantity
    lea si, quan

    jmp Order   
    lea si,quan

Tuna:
;display promptselect message
    mov ah,09h   
    lea dx,promtselect 
    int 21h 
    

    mov ah,01h    ;get quantity
    int 21h

    lea si, quan
    mov [si+2],al ;store quantity
    lea si, quan

    jmp Order   
    lea si,quan

Eel:
    ;display promptselect message
    mov ah,09h   
    lea dx,promtselect 
    int 21h 
    

    mov ah,01h    ;get quantity
    int 21h

    lea si, quan
    mov [si+3],al ;store quantity
    lea si, quan

    jmp Order   
    lea si,quan


payment:
    mov ah,09h   
    lea dx,disPayment    ;display salmon  
    int 21h

    mov ah,09h   
    lea dx,disPayment1    ;display salmon  
    int 21h

    mov si,0 
    lea si,quan
    mov al,[si]
    mov disQty,al   

    mov ah,09h
    lea dx,disQty    ;display quantity 
    int 21h 

    mov ah,09h
    lea dx,disPayment5
    int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;
    mov ah,00
    mov si,0
    mov bl,price[si]
    mov al,quan[si]
    sub al,30h
    mul bl    
    lea si,total
    mov [si],al       ;multiply:quantity*price
    call displayEachDigit
    
    mov ah,09h
    lea dx,disPayment5
    int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;
    mov ah,09h   
    lea dx,disPayment2    ;display salmon  
    int 21h

    mov si,0 
    lea si,quan
    mov al,[si+1]
    mov disQty,al   

    mov ah,09h
    lea dx,disQty    ;display quantity 
    int 21h 

    mov ah,09h
    lea dx,disPayment5
    int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;
    mov ah,00
    mov si,0
    mov bl,price[si+1]
    mov al,quan[si+1]
    sub al,30h
    mul bl   
    lea si,total
    mov [si+1],al      ;multiply:quantity*price
    call displayEachDigit

    mov ah,09h
    lea dx,disPayment5
    int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;
    mov ah,09h   
    lea dx,disPayment3    ;display salmon  
    int 21h

    mov si,0 
    lea si,quan
    mov al,[si+2]
    mov disQty,al   

    mov ah,09h
    lea dx,disQty    ;display quantity 
    int 21h   

    mov ah,09h
    lea dx,disPayment5
    int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;
    mov ah,00
    mov si,0
    mov bl,price[si+2]
    mov al,quan[si+2]
    sub al,30h
    mul bl    
    lea si,total
    mov [si+2],al       ;multiply:quantity*price
    call displayEachDigit  

    mov ah,09h
    lea dx,disPayment5
    int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;
    mov ah,09h   
    lea dx,disPayment4    ;display salmon  
    int 21h

    mov si,0 
    lea si,quan
    mov al,[si+3]
    mov disQty,al   

    mov ah,09h
    lea dx,disQty    ;display quantity 
    int 21h 

    mov ah,09h
    lea dx,disPayment5
    int 21h
;;;;;;;;;;;;;;;;;;;
    mov ah,00
    mov si,0
    mov bl,price[si+3]
    mov al,quan[si+3]
    sub al,30h
    mul bl    
    lea si,total
    mov [si+3],al       ;multiply:quantity*price
    call displayEachDigit  

    mov ah,09h
    lea dx,disPayment5
    int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;
    mov ah, 9h
    lea dx, nextline
    int 21h

    mov ah, 9h
    lea dx, nextline
    int 21h

    mov cx,4      
    mov al,0

    lea si,total  
    
    again5:    
        add al, [si]
         inc si	       ;increase
         dec cx	       ;decrease
         jnz again5
    
	
    mov ah, 0
	mov cx, 10  
	div cl
	mov cx, ax


    mov ah,09h
    lea dx,disPayment6
    int 21h
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      mov ah,02h     ;display the 1st digit of result
      mov dl,cl 
	add dl, 30h       
      int 21h
	mov dl,ch
	add dl, 30h

	int 21h
    
    mov ah,09h
    lea dx,nextline
    int 21h

getCash:
    mov ah,09h
    lea dx,cashget
    int 21h
    
    mov cx,4      
    mov al,0
    mov ah,0

    lea si,total  
    
    again6:    
        add al, [si]
         inc si	       ;increase
         dec cx	       ;decrease
         jnz again6

    mov cx,ax
scanInput:
mov ah ,08h 
int 21h 
sub al,30h
mov [three+0],al         ;store to variable
int 21h
sub al,30h
mov [three+1],al
int 21h
sub al,30h
mov [three+2],al

                         ; take out the value
                         
mov al,[three+0]                        
mul num64

mov bx,ax
mov ah,0
mov al,[three+1]
mul num10

add bx,ax
mov ax,0

mov al,[three+2]
add bx,ax

sub bx,cx               
   

   

    mov ah,09h
    lea dx,cashreturn
    int 21h

    mov ax,bx
    div num10
    
    mov [useramount+2],ah
    mov ah,0
    div num10
    
    mov [useramount+1],ah
    mov ah,0
    div num10
    
    mov [useramount+0],ah
    
    mov dx,0
    mov ax,0
    
    mov dl,[useramount+0]
    add dl,30h
    mov ah,2h
    int 21h
    
    mov dl,[useramount+1]
    add dl,30h
    mov ah,2h
    int 21h
    
    mov dl,[useramount+2]
    add dl,30h
    mov ah,2h
    int 21h

jmp menumain
stop1:
jmp stop
paymenterror:
    mov ah,09h
    lea dx,orderPaymentEror
    int 21h

    jmp getCash

displayEachDigit proc          ;without zero ;receive 1 parameter, ax
         xor  cx,cx             ;clear cx
         mov  bx,10              ;fixed divider = 10

    storeEachDigit:
         xor  dx,dx             ;clear dx
         div  bx                ;get last digit
         push dx                ;remainder store to stack
         inc  cx                ;add loop for printing
         test ax,ax             ;check ax is zero
         jnz  storeEachDigit    ;loop until ax is empty

    printEachDigit:
         pop  dx                ;get back digit from stack
         add  dl,30h            ;convert to char
         mov  ah,02h
         int  21h               ;print
         loop printEachDigit    ;loop printing all digit from stack 
         ret
displayEachDigit endp

 

 


MAIN ENDP
END MAIN