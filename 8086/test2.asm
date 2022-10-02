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
    name_in DB 7 dup ('$')
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




    systemPauseMsg DB 10,13," Press Any Key To Continue...$"  


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
    call systemPause
    ret
EXITALL: 
   mov ax,4c00h
   int 21h

systemPause proc
    mov ah,09h
    lea dx,systemPauseMsg
    int 21h 
    
    mov ah,01h
    int 21h
    
    call EXITALL  
systemPause endp
main endp
end main