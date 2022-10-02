.model small
.stack 100
.data

    ;;; title
    HEA         DB         13,10,13,10,"                      +==================================+"
                DB         13,10,"                      |     WELCOME TO LIM & KO. CAFE    |"
                DB         13,10,"                      +==================================+$"

    ;;; login
    LGIN_HEA1   DB 13,10,13,10,"  +-------+"
                DB 13,10,"  | LOGIN |"
                DB 13,10,"  +-------+$"
    
    username    DB 13,10,13,10,"  Enter username : $"
    LGIN		DB 13,10,"  Enter Password : $"
	LGIN_ERROR	DB 13,10,13,10,"                    INVALID LOGIN, PLEASE TRY AGAIN.$"
	LGIN_E3		DB 13,10,13,10,"                    INVALID LOGIN 3 TIMES, USER AUTHENTICATION FAILED.$"
    NEWL DB 13,10,"$"

    name_ini DB "Jane", '$'
    name_in DB 5 dup ('$')
    ;Erase_name DB 8,' ',8,'$'

    PASSWRD DB "password$"
	PASS_IN	DB 9 DUP ('$')
	ERASE	DB 8,' ',8,'$'
	FAILED_COUNT DB 0
    done123 db 13,10,13,10,13,10, "  ~~~LOGIN SUCCESSED!~~~$"

    ;;; main menu
   	strMenu db 13, 10, 13, 10, 13, 10, "    +====================+"
	    	db 13, 10, "    |     MAIN MENU      |"
		    db 13, 10, "    +====================+"
		    db 13, 10, "    |  1. Item Menu      |"
	 	    db 13, 10, "    |  2. logout         |"	
		    db 13, 10, "    +====================+"
		    db 13, 10, 13, 10, "Enter a value(1 - 2) > ", '$'
	LOGOUT db 13,10, 13, 10,  "Thank you!", '$'
	ErrorMenu db 13,10, 13, 10,  "Only 1 or 2 can be accepted.", '$'
    newline db 13,10,'$'

    ;;; list of the Item and order
    itemMenu db 13,10,"                  | Meal Menu |"
            db 13,10,"--------------------------------------------------"
            db 13,10,"SET A : Chicken Chop with Cola (RM15.59)"
            db 13,10,"SET B : Fish & Chip with Cola (RM16.59)"
            db 13,10,"SET C : Carbonara Pasta with Lemon Tea (RM18.59)"
            db 13,10,"SET D : Mashroom soup with garlic bread (RM8.20)$"

   msg1 db 13,10,"Enter SET : ",'$'
   msg2 db 13,10,"Enter quantity : ",'$'
   msg3 db 13,10,"Only SET A,B,C and D available. Please enter again.",'$'
   msg4 db 13,10,"You have ordered ",'$'
   msg5 db "set(s) of SET ",'$'
   showSet db 2 dup(0), '$'
   showQty db 2 dup(0),'$'
   showQtys dw 3
   msg6 db 13,10,"Proceed to make payment (y/n) : ",'$'
   msg7 db 13, 10, "Process Payment ....", '$'
   msg8 db 13,10,"Order cancelled.",'$'
   msg9 db 13,10,"Invalid input.Please enter again.",'$'

    ; Hung jiat's Data
   header db 13,10,"               Six Group's Diner               "
          db 13,10,"***********************************************"
          db 13,10,"QTY      DESC                             AMT", 13,'$'

    footer db 13,10,"***********************************************",13,10,'$'

    setADesc db "Chicken Chop with Cola",'$'
    setBDesc db "Fish & Chip with Cola",'$'
    setCDesc db "Carbonara Pasta with Lemon Tea",'$'
    setDDesc db "Mushroom soup with garlic bread",'$'

    priceList dw 15590,16590,18590,08200

    setAPrice db "15.59",'$'
    setBPrice db "16.59",'$'
    setCPrice db "18.59",'$'
    setDPrice db "8.20",'$'

    showInvalid db "Invalid Input, Please try again",'$'

    showSubtotal db "Subtotal: ",'$'
    showPaid db "Paid: ",'$'
    showtotal db "total: ",'$'
    showGst db "Gst: ",'$'

    subtotal dw ?
    
    paidInputText db "Paid: ",'$'

    gst dw ?

    gstPercent dw 5
    gstDiv dw 100

.code
main proc
   mov ax,@data
   mov ds,ax

   mov ah, 09H
   lea dx, HEA
   int 21H
   
lea dx, LGIN_HEA1
    mov ah, 09h
    int 21h
    lea si, name_in

RELOGIN:
    MOV AH,09H	
	LEA DX,username 
	INT 21H
    mov si, 0

InputName:
    mov ah, 01H
    int 21h
    cmp al, 13
    je Pass

    mov name_in[si], al
    inc si
    jmp InputName
    
Pass:
    lea si, PASS_IN
    mov ah,09H
    lea dx, LGIN
    int 21H
    mov si, 0

InputPass:
    mov ah, 07H
    int 21H
    cmp al, 13
    je Compare
    cmp al, 8
    je InputPass_Backspace

    cmp si, 8
    je InputPass

    mov PASS_IN[si], al

    mov ah, 02h
    mov dl, "*"
    int 21h

    inc si
    jmp InputPass

InputPass_Backspace:
    cmp si, 0
    je InputPass

    MOV AH,09H	
	LEA DX,ERASE
	INT 21H

    dec si
    MOV PASS_IN[si], "$"
    jmp InputPass

Compare:
    mov cx, 4
    mov si, 0
Compare_inside:
    mov al, name_ini[si]
    cmp al, name_in[si]
    jne LogError
    inc si
    loop Compare_inside
    
ComparePass:
    mov cx, 8
    mov si, 0
ComparePass_inside:
    mov al, PASSWRD[si]
    cmp al, PASS_IN[si]
    jne LogError
    inc si
    loop ComparePass_inside
    
    jmp LogSuccess
    

LogError:
    INC FAILED_COUNT

	CMP FAILED_COUNT, 3
	JE  Terminate	
	
	MOV AH,09H	
	LEA DX,LGIN_ERROR
	INT 21H	
	
	JMP RELOGIN

LogSuccess:
    mov ah, 09H
    LEA DX,done123
    int 21h
    jmp MyMenu ;THIS PART IS GO TO MAIN MENU

Terminate:
    MOV AH,09H	
	LEA DX,LGIN_E3
	INT 21H 
    JMP EXITALL

MyMenu:
    call mainMenu

mainMenu:
	mov ah, 9h
	lea dx, strMenu
	int 21h
	mov ah,1h
	int 21h
	cmp al, 32h
	je exit
	cmp al, 31h
	je myItem
	jmp menuError
    
menuError:
    mov ah, 9h
    lea dx, ErrorMenu
    int 21H
    jmp mainMenu

myItem:
   call listItem
   jmp mainMenu

exit:
   mov ah, 9h
   lea dx, LOGOUT
   int 21h
   call EXITALL

EXITALL: 
   mov ax,4c00h
   int 21h

listItem:
   mov ah, 09h
   lea dx, newline
   int 21h
	mov ah,09h
   lea dx,itemMenu
   int 21h

   mov ah,09h
   lea dx,newline
   int 21h

enterAgain:
   mov ah,09h
   lea dx,msg1
   int 21h

   mov ah,01h ; read user input data
   int 21h
   mov showSet,al
   cmp al,41h
   je quantity
   cmp al,42h
   je quantity
   cmp al,43h
   je quantity
   cmp al,44h
   je quantity

    mov ah,09h
    lea dx, msg3
    int 21h
    mov ah, 09h
    lea dx, newline
    int 21h
    jmp enterAgain

quantity:
   mov ah,09h
   lea dx,msg2
   int 21h

   mov ah,01h
   int 21h 
   sub al,30h
   mov ShowQty,al
   jmp show

show:
   mov ah, 09h
   lea dx, newline
   int 21h

   mov ah,09h
   lea dx,msg4
   int 21h
   add showQty,30h
   lea dx,showQty
   int 21h

   mov ah,09h
   lea dx, msg5
   int 21h
   lea dx,showSet
   int 21h 
  
   jmp proceed


proceed:
    mov ah,09h
    lea dx,msg6
    int 21h

    mov ah,01h
    int 21h

    cmp al,'y'
    je payment
    cmp al,'n'
    je cancel

    mov ah,09h
    lea dx,msg9
    int 21h 
    mov ah, 09h
    lea dx, newline
    int 21h
    jne proceed

payment:
    mov ah,09h
    lea dx,msg7
    int 21h
    jmp cls

cancel:
   mov ah,09h
   lea dx,msg8
   int 21h

   mov ah, 09h
   lea dx, newline
   int 21h

   jmp mainMenu

cls:
    ;clear screen
    mov ax, 3
    int 10h

    ;display receipt header
    mov ah,09h
    lea dx,header
    int 21h

    ;get cursor current position
    mov ah,03h
    int 10h
    inc dh  ;move vertical position down 1

    ;set cursor to (x,y) pos (dl,dh)
    mov  ah, 02h
    int  10h

    jmp displayQty

displayQty:
    ;print qty
    mov ah,02h
    mov dl,showQty
    int 21h

    jmp findSet

findSet:
    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor positon
    mov  dl, 09h
    mov  ah, 02h
    int  10h

    ;compare if set is set A
    mov al,41h
    cmp al,showSet
    je displayA

    ;compare if set is set B
    mov al,42h
    cmp al,showSet
    je displayB

    ;compare if set is set C
    mov al,43h
    cmp al,showSet
    je displayC

    ;compare if set is set D
    mov al,44h
    cmp al,showSet
    je displayDBridge

displayA:
    ;print desc
    mov ah,09h
    lea dx,setADesc
    int 21h

    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor position
    mov  dl, 2Ah
    mov  ah, 02h    
    int  10h

    ;print price
    mov ah,09h
    lea dx,setAPrice
    int 21h
    
    mov ah,09h
    lea dx,footer
    int 21h

    mov ah,09h
    lea dx,showTotal
    int 21h

    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor position
    mov  dl, 2Ah
    mov  ah, 02h    
    int  10h

    mov ax,priceList[0]
    jmp calcSubtotal

displayB:
    ;print desc
    mov ah,09h
    lea dx,setBDesc
    int 21h

    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor position
    mov  dl, 2Ah
    mov  ah, 02h    
    int  10h

    ;print price
    mov ah,09h
    lea dx,setBPrice
    int 21h

    mov ah,09h
    lea dx,footer
    int 21h

    mov ah,09h
    lea dx,showTotal
    int 21h

    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor position
    mov  dl, 2Ah
    mov  ah, 02h    
    int  10h

    mov ax,priceList[1]
    jmp calcSubtotal


displayDBridge:
    jmp displayD

displayC:
    ;print desc
    mov ah,09h
    lea dx,setBDesc
    int 21h

    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor position
    mov  dl, 2Ah
    mov  ah, 02h    
    int  10h

    ;print price
    mov ah,09h
    lea dx,setBPrice
    int 21h

    mov ah,09h
    lea dx,footer
    int 21h

    mov ah,09h
    lea dx,showTotal
    int 21h

    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor position
    mov  dl, 2Ah
    mov  ah, 02h    
    int  10h

    mov ax,priceList[2]
    jmp calcSubtotal

displayD:
    ;print desc
    mov ah,09h
    lea dx,setDDesc
    int 21h

    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor position
    mov  dl, 2Ah
    mov  ah, 02h    
    int  10h

    ;print price
    mov ah,09h
    lea dx,setDPrice
    int 21h

    mov ah,09h
    lea dx,footer
    int 21h

    mov ah,09h
    lea dx,showTotal
    int 21h

    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor position
    mov  dl, 2Ah
    mov  ah, 02h    
    int  10h

    mov ax,priceList[3]
    jmp calcSubtotal

calcSubtotal:
    mul showQtys; multiply by quantity, base al is by the display set
    mov subtotal,ax
    call displayNum


calcGst:
    ;get cursor position
    mov ah,03h
    int 10h
    inc dh ;move 1 row down

    ;move cursor position
    mov  dl, 0h
    mov  ah, 02h    
    int  10h

    mov ah,09H
    lea dx,showGst
    int 21h

    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor position
    mov  dl, 2Ah
    mov  ah, 02h    
    int  10h

    mov ax,subtotal     
    mul gstPercent
    div gstDiv
    mov gst,ax
    call displayNum

    ;get cursor position
    mov ah,03h
    int 10h
    inc dh ;move 1 row down

    ;move cursor position
    mov  dl, 0h
    mov  ah, 02h    
    int  10h

    mov ah,09H
    lea dx,showSubtotal
    int 21h

    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor position
    mov  dl, 2Ah
    mov  ah, 02h    
    int  10h

    mov ax,subtotal
    add ax,gst
    call displayNum

    jmp getPaid

getPaid:
    ;get cursor position
    mov ah,03h
    int 10h
    inc dh ;move 1 row down

    ;move cursor position
    mov  dl, 0h
    mov  ah, 02h    
    int  10h

    mov ah,09H
    lea dx,showPaid
    int 21h

    ;get cursor position
    mov ah,03h
    int 10h

    ;move cursor position
    mov  dl, 2Ah
    mov  ah, 02h    
    int  10h

    mov si,0

    inputPaid:
        mov ah,01h
        int 21h     

        cmp al,'.'
        je inputPaid ;check for decimal
		
        cmp al,13   ;stop if input <enter>
        je toFooter
        
        sub al,30h  ;change to int

        cmp al,0    ;check input is 0 to 9
        jl invalidInput
        cmp al,9
        jg invalidInput

		cmp si,4
		je toFooter
        
        inc si
    jmp inputPaid 

invalidInput:
    mov ah,09H
    lea dx,showInvalid
    int 21H
    
    jmp cls

toFooter:
    mov ah,09H
    lea dx,footer
    int 21H
    jmp stop

stop:
    mov ax,4c00h
    int 21h

displayNum proc
        xor  cx,cx
        mov  bx,10              
    storeToStack:
        xor  dx,dx             
        div  bx                
        push dx                
        inc  cx                
        test ax,ax             
        jnz  storeToStack

    printNum:
        cmp cx,3
        je printDot

        pop  dx            
        mov  ah,02h  
        add  dl,30h
        int  21h
        loop printNum          
        ret

    printDot:
        mov ah,02h
        mov dl,2Eh
        int 21h
        
        pop dx
        mov  ah,02h  
        add  dl,30h
        int  21h
        dec cx
        jmp printNum
        
displayNum endp 

main endp 
end main
   
            