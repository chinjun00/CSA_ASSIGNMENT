.model small
.stack 100
.data
;header 
    headln1             DB 10,10,13,'   Welcome to Definitely-Not Public Bank! ',10,13,'$'
;temporary
    grandTotal          DW 0,0  
    paymentError   DB 10,13," insufficient Amount!$"


;login 
	loginMsg            DB 10,10,13,' Enter password to login: $'
	passwrd             DB '12341234'
	pwbuffer            DB 8 DUP(?)
	count               DW 8    
    userid              DB 10,10,9,'User ID :B1001 $'
	validMsg            DB 10,10,13,'   Access Granted',10,13,'$'
	invalidMsg          DB 10,10,13,'   Invalid Password',10,13,'$'

;mainmenu
    mainmenu1           DB 10,13,9," 1.    Check User Account Balance  $"
    mainmenu2           DB 10,13,9," 2.    Withdraw Cash               $"
    mainmenu3           DB 10,13,9," 3.    Deposit Account             $"
    mainmenu4           DB 10,13,9," 4.    Investment                  $"
    mmselect            DB 10,13," Enter your choice (0 to exit)     : $"

    mmreturn            DB 10,13," Enter 0 to return to Main Menu    : $" 

;balance
    balance DW 2000
    balanceMenu1        DB 10,13,9,"Balance :",'$'     

;deposit
    depositMenu1    DB 10,13,9,"Please enter the Deposit Account Number:",'$'
    accountNumber   DB 15 DUP(?)       
    depositMenu2    DB 10,13,9,"Enter the amount of cash to deposit:",'$'
    depositAmount   DB 15 DUP(?)
    nextLine        DB 10,13,'$'
    confirmMsg      DB 10,13,9,"Amount confirmed?(Y/N)",'$'
    amountConfirm   DB 10 DUP(?)

;withdraw
    withdrawMenu1           DB 10,13,9,"How much cash do you want to withdraw?       ",'$'
    withdrawMenu2           DB 10,13,9,"Enter the amount :$"   

;investment

    investMenu1 DB 10,13,9,"Please select the company you wish to invest.",'$'
    investMenu2 DB 10,13,9,"1.  Tesla Company.",'$'
    investMenu3 DB 10,13,9,"2.  Highlands Company .",'$'
    investMenu4 DB 10,13,9,"3.  Daybreak Company .",'$'

;cashIn
    input  DB 4 DUP('*')
    amount DB 0,0,0,0  
    cashIn DW 0,0         
    cashDecimal DB 0,0   
    change DW 0,0 
    
;other
    errorMsg    DB 10,13," **Invalid Input**$" 
    systemPauseMsg DB 10,13," Press Any Key To Continue...$"  
    unitRM      DB "RM$"
    boxTop      DB 10,10,13,32,201,20 DUP(205),187,'$'
    boxBottom   DB 10,13,32,200,20 DUP(205),188,'$'
    boxRight    DB 186,'$'
    


.code	
main proc
	mov ax, @data
	mov ds, ax
	call cls
	call login        	    
    call mainMenu
            
    exit: 
    mov ah, 4ch
    int 21h      
main endp   

displaylogo proc
    	mov ah, 9h		            ;display HEADER
    	lea dx, headln1            
    	int 21h
	    ret
displaylogo endp

login proc
    begin:
	call cls
	call displaylogo 

        mov cx,8		            ;num of char of pasword
    	lea si, passwrd
    	lea di, pwbuffer 
    
    	mov ah, 9h		            ;display msg
    	lea dx, loginMsg	
    	int 21h
    	
    	mov bl, 0h                  ;initialise input counter	


   enter:	
        mov ah, 07h		    ;read char in al with no echo
    	int 21h
    	mov bh, al  
    	mov ah, 08h                 ;check if backspace
        xor al, ah
        jnz store    
    
        cmp bl,0
        je enter        
                            
        mov ah, 02h                 ;move cursor backward
        mov dl, 08h
        int 21h 
        
        mov ah,02h
        mov dl,20h                  ;display space
        int 21h 
                    
        mov ah, 02h 
        mov dl, 08h                 ;move cursor backward 
        
        dec di
        dec bl 
	mov bh, 0h
        mov [di], bh
        inc cx
    
        int 21h
        jmp enter 
       
	
    store: 
        mov ah, 13h                 ;check if RC(enter)
        xor al, ah         
        jz checkpw
        mov [di], bh		        ;store they user's input
        inc di
        inc bl
    	mov ah, 2h
    	mov dl, '*'		            ;display  * on screen to hide pw
    	int 21h
    	loop enter  
    	
    	lea si, passwrd
    	lea di, pwbuffer 
    
    	mov cx, 8h
    	mov bx, 0h		            ;clear bx
	
	
    checkpw:
        mov bl, [si]
    	mov bh, [di]
        cmp bl, bh	                ;compare passwor input & pw in system 
        jne error	                ;jump to error if invalid
    	inc si 
    	inc di   
    
    	loop checkpw
    
        mov ah, 9h
    	lea dx, validMsg
    	int 21h
    	jmp vpass
	
    error:
        call cls
		call displaylogo 			
        lea dx, invalidMsg
    	mov ah, 9h
    	int 21h
        call systemPause
    	jmp begin  

    vpass:
        call systemPause
        call cls 	
        ret

login endp


mainMenu proc 
    redo:
        call cls
    	call displaylogo 
        call displayMenu
        mov ah, 09h
        lea dx, mmselect
        int 21h
            
        mov ah, 01h                 ;user input for choice
        int 21h
        
        mov bl, al

        push bx
        call cls   
        pop bx

        cmp bl, '0'                 ;input:0 - quitmm
        je quitmm                                  
        
        cmp bl, '1'                 ;input:1 - display menu
        je select1                                      
        
        cmp bl, '2'                 ;input:2 - withdraw menu
        je select2                                            
        
        cmp bl, '3'                 ;input:3 - deposit menu
        je select3  

        cmp bl, '4'                 ;input:4 - invest menu
        je select4

        

	jne redo
        
    select1:        
        call displayAccount  
        call systemPause
        jmp redo

    select2:        
        call withdraw	
        call systemPause
		jmp redo 

    select3: 
        call deposit 
        call systemPause
        jmp redo

    select4:
        call investCompany
        call systemPause
        jmp redo

    quitmm:
        ret 
        
mainMenu endp

displayAccount proc ; order proc

    mov ah,09h
    lea dx,userid
    int 21h
    lea dx,balanceMenu1
    int 21h

    mov ax,balance
    call displayEachDigit
    int 21h


    ret 

    ; change to read from database if have time
    ;print user name
    ;print user balance
    ;return to main menu    

displayAccount endp




withdraw proc ;getCash proc


    reEnter:
        call displayAccount
        mov ah,09h
        lea dx,withdrawMenu1  ; How much cash do you want to withdraw? 
        int 21h
        mov si,0
           
    

    ; user input amount of cash to take out
    ; confirmation check
    ; return to main menu


    withdrawMenuDisplay:
        mov ah,9h
        lea dx,nextline
        int 21h
        lea dx,withdrawMenu2   ;  Enter your amount:
        int 21h
        
        mov ah,01h
        int 21h
        
        cmp al,'.'
        je enterCashDecimal ;check for decimal
		
		cmp al,8
		je backSpace
        
        cmp al,13   ;stop if input <enter>
        je checkIsNull
        
        sub al,30h  ;change to int
        
        cmp al,0    ;check input is 0 to 9
        jl invalidCash
        cmp al,9
        jg invalidCash
        
        mov input[si],al
		cmp si,3 ;if 4 digit (maximum) jmp out
		je nextCash
        
        inc si
    jmp withdrawMenuDisplay 

    checkIsNull:
	cmp si,0
	je withdrawMenuDisplay	;check is input empty or not
	jmp nextCash

	
	backSpace:
	cmp si,0 ;if index is 0, block for backspace
	jne	deleteNum

	mov ah,02h
	mov dl,32
	int 21h
	jmp withdrawMenuDisplay
	
	deleteNum:
	mov ah,02h
	mov dl,0
	int 21h
	mov dl,8
	int 21h
	mov input[si],'*'	;set back to empty
	dec si
	jmp withdrawMenuDisplay

    invalidCash:
    mov ah,02h
    mov dl,8
    int 21h
    mov dl,0
    int 21h 
    mov dl,8
    int 21h
    jmp withdrawMenuDisplay 
    
    invalidCashDecimal:
    mov ah,02h
    mov dl,8
    int 21h
    mov dl,0
    int 21h 
    mov dl,8
    int 21h
    jmp contEnterCashDecimal 
    
    enterCashDecimal:
    mov cx,2
    mov bx,10   
    mov si,0
    
    contEnterCashDecimal:
        mov ah,01h
        int 21h 
        
        sub al,30h  ;change to int   
        cmp al,0    ;check input is 0 to 9
        jl invalidCashDecimal
        cmp al,9
        jg invalidCashDecimal 
        
        mov cashDecimal[si],al 
        inc si
    loop contEnterCashDecimal
    
    nextCash:
    mov cx,4
    mov si,3
    mov di,3
    check:
        cmp input[si],'*' ;400*
        jne exchange
        
        dec si
    loop check    
    
    mov si,3               ;if 4 digits, copy array  
    
    exchange: 
        mov al,input[si]
        mov amount[di],al
        
        cmp si,0
        je done
        
        dec di
        dec si
    jmp exchange
    
    
    done:
    mov bx,1000
    mov ax,0    
    mov cx,4
    mov si,0
        convertToInt:     ;store cash
            mov ax,0
            mov al,amount[si]
            mul bx
            add cashIn,ax
            
            mov ax,bx 
            mov bx,10
            div bx
            mov bx,ax
            
            inc si
        loop convertToInt   
    
    mov ax,0   ;clear ax    
    mov bx,10  ;store cash decimal         
    mov al,cashDecimal[0]
    mul bx
    mov cashIn[2],ax
    
    mov al,cashDecimal[1]
    add cashIn[2],ax 
    
    mov ax,cashIn[0]    ;check cash is greater than grand total
    mov bx,grandTotal[0]
    cmp ax,bx
    jl notEnough
    cmp ax,bx           ;if equal,compare decimal
    je checkCashDecimal
    ret
    
    checkCashDecimal:
    mov ax,cashIn[2]    ;multiply 100 to compare since grandtotal is 4 decimal
    mov bx,100
    mul bx    
    mov bx,grandTotal[2]
    cmp ax,bx
    jl notEnough  
    ret
    
    
    notEnough:  
    mov ah,09h
    lea dx,paymentError
    int 21h
    jmp reEnter
    



    

withdraw endp

display2digit proc     ;receive 1 parameter, ax 
        mov bx,0010    ;e.g al=12
        div bl         ;ax=0201   
        add ax,3030h   ;convert to char
        push ax        ;stack ax (+1) 
        
        mov ah,02h
        mov dl,al
        int 21h 
        
        pop dx
        mov dl,dh
        int 21h
        ret   
display2digit endp

displayEachDigit proc  		;without zero ;receive 1 parameter, ax
         xor  cx,cx             ;clear cx
         mov  bx,10             ;fixed divider = 10  
     
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


calculateCash proc
calculateCash endp


 deposit proc
;     call cls
; ;prompt message for Deposit Account Number
;     lea dx,depositMenu1
;     mov ah,09h
;     int 21h

; ;input Account Number
;     lea si, accountNumber
;     mov ah, 1h
;     mov accountNumber[si], al
;     int 21h
;     lea dx, nextLine
;     int 21h

; ;prompt message for amount input
;     lea dx, depositMenu2
;     mov ah, 9h
;     int 21h

; ;input Amount of Cash for Deposit
;     lea di, depositAmount
;     mov ah, 1h
;     int 21h

; ;confirm message
;     lea dx, confirmMsg
;     mov ah, 9h
;     int 21h
    
;     ret

;     depositError :
;         call cls
; 		call displaylogo 			
;         lea dx, invalidMsg
;     	mov ah, 9h
;     	int 21h
;         call systemPause
;     	jmp begin  


;     ; User input amount to deposit
;     ; Update to account balance 
;     ; return to main menu

 deposit endp

investCompany proc
    call cls
    mov ah,9h
    lea dx,investMenu1
    int 21h
    lea dx,investMenu2
    int 21h
    lea dx,investMenu3
    int 21h
    lea dx,investMenu4
    int 21h
    lea dx,nextline
    int 21h
    ret
    ; List company to invest
    ; User input company to select
    ; User enter amount of cash to invest
    ; Must be below balance account
    ; update bank account
    ; return to main menu
investCompany endp


;Display format
displayMenu proc
        mov ah,09h    
        lea dx,mainmenu1
        int 21h    
        lea dx,mainmenu2
        int 21h
        lea dx,mainmenu3
        int 21h     
        lea dx,mainmenu4
        int 21h
        ret
displayMenu endp 


;Display Format




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

systemPause proc
    mov ah,09h
    lea dx,systemPauseMsg
    int 21h 
    
    mov ah,01h
    int 21h
    ret
    
systemPause endp





end     main