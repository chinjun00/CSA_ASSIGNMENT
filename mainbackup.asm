.model small
.stack 100
.data
;header 
    headln1             DB 10,10,13,'   Welcome to Definitely-Not Public Bank! ',10,13,'$'

;login 
	loginMsg            DB 10,10,13,' Enter password to login: $'
	passwrd             DB '12341234'
	pwbuffer            DB 8 DUP(?)
	count               DW 8
	
    
    
    userid              DB 10,10,9,'User ID :B1001 $'
	validMsg            DB 10,10,13,'   Access Granted',10,13,'$'
	invalidMsg          DB 10,10,13,'   Invalid Password',10,13,'$'

;balance
    balance DW 2000
    balanceMenu1        DB 10,13,9,"Balance :",'$'


;menu 
    menuBoxTop      DB 10,10,13,9,9,201,40 DUP(205),187,'$'
    menuBoxBottom   DB 10,13,9,9,200,6 DUP(205),202,20 DUP(205),202,12 DUP(205),188,'$'                  
    menuBoxLine1    DB 10,13,9,9,40 DUP(205),'$'
    menuBoxLine2    DB 10,13,9,9,204,6 DUP(205),203,20 DUP(205),203,12 DUP(205),185,'$'
    menuBoxLine3    DB 10,13,9,9,204,6 DUP(205),206,20 DUP(205),206,12 DUP(205),185,'$'     
    menu1           DB 10,13,9,9,186,"                  Menu                  ",186,'$'
    menu2           DB 10,13,9,9,186," No.  ",186,"     Pizza Name     ",186," Price (RM) ",186,'$' 
    menu3           DB 10,13,9,9,186," 1    ",186," Crispy Chicken     ",186,"      10.00 ",186,'$'
    menu4           DB 10,13,9,9,186," 2    ",186," Veggie Lover       ",186,"      12.00 ",186,'$'
    menu5           DB 10,13,9,9,186," 3    ",186," Beef Pepperoni     ",186,"      13.00 ",186,'$'
    menu6           DB 10,13,9,9,186," 4    ",186," Blazing Seafood    ",186,"      15.00 ",186,'$'      
    pricePizza      DB 10,12,13,15                

;withdraw
    withdrawMenu1           DB 10,13,9,9,186,"    How much cash do you want to withdraw?       ",186,'$'
    withdrawMenu2           DB 10,13,9,"Enter the amount :$"  




;order
    maxOrder     = 9
    discountRate = 5
    taxRate      = 5     
    
    orderID     DW 1 
    orderCount  DB 0
    pizzaName   DB " Crispy Chicken",10,13,','
                DB " Veggie Lover",10,13,',' 
                DB " Beef Pepperoni",10,13,','
                DB " Blazing Seafood$"   
    index       DW 0 
    found       DB 0      
    
    priceValue  DB ?
    
    selectPizza DB ?                     
    quantity    DB ?
    
    orderedQtyList  DB 0,0,0,0
    orderedPriceList DB 0,0,0,0
       
    subtotal    DW ?
 
    
    orderStr1           DB 10,10,13," Order ID : $"
    orderStr2           DB 10,13," Choose A Pizza [Enter 0 To Exit]  : $"
    orderStr3           DB 10,13," Enter Quantity                    : $" 
    comfirmOrderMsg     DB 10,10,13," Comfirm Order?   [Y/N] : $" 
    comfirmOrderTotal   DB 10,13," Total        RM $"
    confirmOrderStr1    DB 10,10,13," You Had Selected $" 
    
    anymoreItemMsg  DB 10,13," Anymore Item?    [Y/N] : $"   
    
    receipt     DB 10,13,"                DOMINO PIZZA"
                DB 10,13,"         Lot 123, Jalan Genting Kelang,"
                DB 10,13,"          Setapak, 53300 Kuala Lumpur"
             DB 10,10,13," Receipt No : PZ$"
    
    orderLine   DB 10,13," ==========================================$"            
    orderStr4   DB 10,13," Item              Quantity     Price (RM)$"
    orderStr5   DB 10,13,"                               ============$"
    orderStr6   DB 10,13," Subtotal                      RM $"
    orderStr7   DB 10,13," Discount [5%]                 RM $" 
    orderStr8   DB 10,13,"                               RM $"
    orderStr9   DB 10,13," Tax      [5%]                 RM $"
    orderStr10  DB 10,13," Grand Total                   RM $"
    orderStr11  DB 10,13," Cash Received                 RM $" 
    orderStr12  DB 10,13," Change                        RM $" 
    thanksStr   DB 10,13,"                Thank You!$"
    
    paymentStr1 DB 10,10,13," Choose Payment Method"
                DB 10,13," [1] Cash"
                DB 10,13," [2] E-wallet"
                DB 10,13," Enter Selection : $"
   
    paymentCashStr DB 10,10,13," Enter Cash Amount : $"  
    paymentError   DB 10,13," You do not have this many cash in your account!$"
    paymentEw1  DB 10,10,13," Waiting For Transaction...$"
    paymentEw2  DB 10,10,13," Transaction Successfully!$"    
    
    paymentMethod DB ?
    
    nextOrderMsg DB 10,10,13," Next Order?  [Y/N] : $"
      
;floating number    
    number              DW ?     ;store number before .
    decimal_1           DW ?     ;first and sec decimal point 
    decimal_2           DW ?     ;third and forth decimal point 
    
    discountAmount      DW 0,0   ;discount value (subtotal * discount rate)  
    totalAfterDiscount  DW 0,0  
    taxAmount           DW 0,0,0   ;tax value (total after discount * tax rate) 
    grandTotal          DW 0,0  

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
    
;summary
    totalQtySold        DB 0,0,0,0
    totalEachSold       DB 0,0,0,0
    totalSales          DW 0,0     
    
    sumBoxTop      DB 10,10,13,32,201,60 DUP(205),187,'$'         
    sumBoxBottom   DB 10,13,32,200,60 DUP(205),188,'$'                                                  
    sumPizzaName   DB " Crispy Chicken",45 DUP (32),186,10,13,32,186
                DB " Veggie Lover",47 DUP (32),186,10,13,32,186 
                DB " Beef Pepperoni",45 DUP (32),186,10,13,32,186
                DB " Blazing Seafood",44 DUP (32),186,'$'
    
    
    boxLeft     DB 10,13,32,186, '$'   
    sumHeader   DB "                           Summary Order$"
    sumStr1     DB 10,10, 13, "  Total order of the day: $"
    sumRowTitle DB 10,13,32,186,"                    Total Quantity Sold     Total Sales(RM) ",186,'$' 
    sumOfTotal  DB 10,13,32,186,60 DUP(32),186,10,13,32,186,32,58 DUP(205),32,186
                DB 10,13,32,186,60 DUP(32),186,10,13,32,186,32,"Total Sales of the Day", 37 DUP(32),186
                DB 10,13,32,186,32,"Total Sales Include Discount And Tax",23 DUP (32), 186, '$' 

;mainmenu
    mmBoxTop            DB 10,10,13,9,9,201,40 DUP(205),187,'$'
    mmBoxBottom         DB 10,13,9,9,200,6 DUP(205),202,20 DUP(205),13 DUP(205),188,'$'                  
    mmBoxLine1          DB 10,13,9,9,40 DUP(205),'$'
    mmBoxLine2          DB 10,13,9,9,204,6 DUP(205),203,20 DUP(205),13 DUP(205),185,'$'
    mmtitle             DB 10,13,9,9,186,"               Main Menu                ",186,'$'
    mainmenu1           DB 10,13,9," 1    Check User Account Balance  $"
    mainmenu2           DB 10,13,9," 2    Withdraw Cash               $"
    mainmenu3           DB 10,13,9," 3    Deposit Account             $"
    mmselect            DB 10,13," Enter your choice (0 to exit)     : $"

    mmreturn            DB 10,13," Enter 0 to return to Main Menu    : $" 
    nextLine DB 10,13,'$'


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
        call getCash	
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

withdraw proc
        mov ah,09h ;print out shit
        lea dx,withdrawMenu1   ;  How much cash do you want to withdraw?
        int 21h


withdraw endp


getCash proc ;getCash proc


    withdrawMenuDisplay:
        call displayAccount

    
    reEnter:
        mov ah,09h
        lea dx,withdrawMenu2  ; Enter your amount: 
        int 21h
        
        
    enterCash:


        mov ah,1h ;user input for cash
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
    jmp enterCash 
checkIsNull:
	cmp si,0
	je enterCash	;check is input empty or not
	jmp nextCash

	
	backSpace:
	cmp si,0 ;if index is 0, block for backspace
	jne	deleteNum

	mov ah,02h
	mov dl,32
	int 21h
	jmp enterCash
	
	deleteNum:
	mov ah,02h
	mov dl,0
	int 21h
	mov dl,8
	int 21h
	mov input[si],'*'	;set back to empty
	dec si
	jmp enterCash

    invalidCash:
    mov ah,02h
    mov dl,8
    int 21h
    mov dl,0
    int 21h 
    mov dl,8
    int 21h
    jmp enterCash 
    
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
    lea dx,paymentError ; print You do not have this many cash in your account!
    int 21h
    jmp reEnter
    


    ; user input amount of cash to take out
    ; confirmation check
    ; return to main menu

getCash endp

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
    ; User input amount to deposit
    ; Update to account balance 
    ; return to main menu

deposit endp

investCompany proc
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