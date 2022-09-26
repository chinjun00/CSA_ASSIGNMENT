.model small
.stack 100
.data
;header 
    headln1            DB 10,10,13,2 DUP(9), 'OOOOo     OOOO   OO   OO  OO  OO   OO   OOOO'
    			DB 10,13,2 DUP(9),'OO  OO   OO  OO  OOO OOO  OO  OOO  OO  OO  OO'
    			DB 10,13,2 DUP(9),'OO  OOO  OO  OO  OO O OO  OO  OO O OO  OO  OO'
    			DB 10,13,2 DUP(9),'OO  OO   OO  OO  OO   OO  OO  OO  OOO  OO  OO'
    			DB 10,13,2 DUP(9),'OOOOo     OOOO   OO   OO  OO  OO   OO   OOOO','$'

;login 
	loginMsg            DB 10,10,13,' Enter password to login: $'
	passwrd             DB 'meowmeow'
	pwbuffer            DB 8 DUP(?)
	count               DW 8
	validMsg            DB 10,10,13,'   Access Granted',10,13,'$'
	invalidMsg          DB 10,10,13,'   Invalid Password',10,13,'$'
;mainmenu
    mmBoxTop            DB 10,10,13,9,9,201,40 DUP(205),187,'$'
    mmBoxBottom         DB 10,13,9,9,200,6 DUP(205),202,20 DUP(205),13 DUP(205),188,'$'                  
    mmBoxLine1          DB 10,13,9,9,40 DUP(205),'$'
    mmBoxLine2          DB 10,13,9,9,204,6 DUP(205),203,20 DUP(205),13 DUP(205),185,'$'
    mmtitle             DB 10,13,9,9,186,"               Main Menu                ",186,'$'
    mainmenu1           DB 10,13,9,9,186," 1    ",186," Display Menu                    ",186,'$'
    mainmenu2           DB 10,13,9,9,186," 2    ",186," Start Order                     ",186,'$'
    mainmenu3           DB 10,13,9,9,186," 3    ",186," Order Summary                   ",186,'$'
    mmselect            DB 10,13," Enter your choice (0 to exit)     : $"
    mmreturn            DB 10,13," Enter 0 to return to Main Menu    : $" 
    nextLine DB 10,13,'$'
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
    paymentError   DB 10,13," insufficient Amount!$"
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

dispMainMenu proc
	call cls
	call displaylogo 

        mov ah,09h
        lea dx,mmBoxTop
        int 21h
        lea dx,mmtitle
        int 21h  
        lea dx,mmBoxLine2
        int 21h       
        lea dx,mainmenu1
        int 21h    
        lea dx,mainmenu2
        int 21h
        lea dx,mainmenu3
        int 21h  
        lea dx,mmBoxBottom
        int 21h 
        ret
dispMainMenu endp  

mainMenu proc 
    redo:
        call cls
	call displaylogo 
        call dispMainMenu          
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
        
        cmp bl, '2'                 ;input:2 - proceed order
        je select2                                            
        
        cmp bl, '3'                 ;input:3 - order summary
        je select3
	jne redo
        
    select1:        
        call displayMenu  
        call systemPause
        jmp redo

    select2:        
        call order       		
		jmp redo 

    select3: 
        call orderSummary  
        call systemPause
        jmp redo

    quitmm:
        ret 
        
mainMenu endp


order proc
       startOrder:
    call cls   
    call displayMenu
    call displayOrderId
     
    choosePizza:
    mov si,0
    mov ah,09h
    lea dx,orderStr2
    int 21h 
    
    mov ah,01h  ;get order
    int 21h     
    sub al,30h  ;convert to int
    mov selectPizza,al
    
    cmp selectPizza,0 ;if 0 exit
    je backMainMenu    
   
    cmp selectPizza,4 ;check input is 1 to 4
    jbe orderQty      ;ask quantity of order
    
    call displayErrorMsg 
    jmp choosePizza
    
    orderQty:   
    mov si,0    
    mov ah,09h   
    lea dx,orderStr3
    int 21h 
    
    mov ah,01h    ;get quantity
    int 21h
    
    sub al,30h    ;convert to int
    mov quantity,al 

    cmp quantity,1  ;check input is 1 to 9
    jl invalidNum 
    cmp quantity,9
    jg invalidNum     
    
    jmp comfirmOrder  

	backMainMenu:	
    ret
	
	backStartOrder:
	jmp startOrder
	
	backChoosePizza:
	jmp choosePizza
	
    invalidNum:
    call displayErrorMsg 
    jmp orderQty  
      
    comfirmOrder:       ;ask user comfirm the order details 
    mov ah,09h
    lea dx,confirmOrderStr1
    int 21h 
    
    mov ah,02h          ;print quantity ordered
    mov dl,quantity
    add dl,30h
    int 21h 
    
    call displaySelectedPizza
    
    getOrderComfirmation:  
    mov ah,09h
    lea dx,comfirmOrderTotal
    int 21h 
    
    mov ah,00       ;clear ah   
    mov si,index
    mov bl,pricePizza[si]
    mov al,quantity 
    mul bl          ;multiply:quantity*price
    call displayEachDigit
    
    mov ah,09h
    lea dx,comfirmOrderMsg
    int 21h 
    
    mov ah,01h
    int 21h
    
    cmp al,'N'
    je backStartOrder
    
    cmp al,'n'
    je backStartOrder
    
    cmp al,'y'
    je storeOrderedQty 
           
    cmp al,'Y'
    je storeOrderedQty 
    
    call displayErrorMsg
    jmp comfirmOrder 

    addItem:       ;comfirm user want to add other item or not
    mov ah,09h
    lea dx,anymoreItemMsg
    int 21h   
    
    mov ah,01h
    int 21h
    
    cmp al,'N'
    je payment
    
    cmp al,'n'
    je payment
    
    cmp al,'y'
    je backChoosePizza
    
    cmp al,'Y'
    je backChoosePizza 
    
    call displayErrorMsg
    jmp addItem
    
    storeOrderedQty:       ;store pizzaA quantity 
    mov bx,0               ;clear bx
    mov bl,selectPizza
    mov si,bx              
    dec si                 ;index of selected pizza
    mov al,quantity
    add orderedQtyList[si],al   
    jmp addItem
    
    payment:
    call cls
    call calcEachSubtotal  
    mov ah,09h
    lea dx,orderStr4
    int 21h
    lea dx,orderLine
    int 21h
    lea dx,nextLine
    int 21h
    call displayOrderedItem
    
    mov dl,25   ;set cursor position X,Y(25,3)
    mov dh,3
    call movCursor  
    
    call displayOrderedItemQty
    
    mov dl,34
    mov dh,3 
    call movCursor  
    
    call displayOrderedItemPrice
    
    call calcSubtotal
    
    mov ah,09h
    lea dx,orderLine
    int 21h
    lea dx,orderStr6
    int 21h
    
    mov ax,subtotal
    call displayEachDigit 
    
    cmp subtotal,100        ;less than or equal 100, no discount given
    jle goToNoDiscount          ;direct calculate grand total
     
    printDiscount:
    mov ah,09h
    lea dx,orderStr7
    int 21h
    mov ax,subtotal         ;pass subtotal and discountRate
    mov bx,discountRate 
    call calc2DecimalPoint 
    
    mov ax,number           ;calculated discount(before decimal point) 
    mov discountAmount[0],ax 
    call displayEachDigit

    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h  
    
    mov ax,decimal_1        ;calculated discount(after decimal point)
    mov discountAmount[2],ax     ;store decimal 
    call display2Digit
    
    printDiscountedPrice:
    mov ah,09h
    lea dx,orderStr5
    int 21h
    lea dx,orderStr8 
    int 21h
    
    mov ax,subtotal
    mov bx,discountAmount[0]
    mov dx,discountAmount[2]
    call deductDiscount   
    
    mov ax,number           ;calculated discount(before decimal point) 
    mov totalAfterDiscount[0],ax 
    call displayEachDigit

    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h  
    
    mov ax,decimal_1        ;calculated discount(after decimal point)
    mov totalAfterDiscount[2],ax
    call display2Digit    

	goToNoDiscount:
	cmp subtotal,100        ;less than or equal 100, no discount given
    jle noDiscount          ;direct calculate grand total	
       
    printTax:
    mov ah,09h
    lea dx,orderStr9 
    int 21h

    mov ax,totalAfterDiscount[0]    ;pass calculated discount(before decimal point)  
    mov dx,totalAfterDiscount[2]    ;pass calculated discount(decimal point)
    mov bx,taxRate                  ;pass taxRate
    call calc3DecimalPoint          ;return number, decimal_1, decimal_2
    
    mov ax,number           ;calculated tax(before decimal point)
    mov taxAmount[0],ax
    call displayEachDigit

    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h  
    
    mov ax,decimal_1        ;calculated tax decimal(2 digit of decimal)     
    mov taxAmount[2],ax
    call display2Digit    
    
    mov ax,decimal_2        ;calculated tax decimal(3 digit of decimal)        
    mov taxAmount[4],ax
    call display2Digit

    printGrandTotal:
    mov ah,09h
    lea dx,orderStr5
    int 21h
    lea dx,orderStr10 
    int 21h
    
    mov ax,taxAmount[2]
    mov bx,100
    mul bx
    mov bx,ax
    add bx,taxAmount[4]      ;pass combined float numbers of tax
    
    mov ax,taxAmount[0]      ;pass number amount of tax  
    
    mov cx,totalAfterDiscount[0] ;pass total after discount
    mov dx,totalAfterDiscount[2]
    call sumTotal   
    
    mov ax,number           ;calculated total(before decimal point)
    mov grandTotal[0],ax
    call displayEachDigit

    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h  
    
    mov ax,decimal_1        ;calculated total decimal(2 digit of decimal)     
    mov grandTotal[2],ax
    call display4Digit  
    jmp choosePayment
    
    noDiscount:
    mov ah,09h
    lea dx,orderStr9
    int 21h
    mov ax,subtotal         ;pass subtotal and taxRate
    mov bx,taxRate 
    call calc2DecimalPoint 
    
    mov ax,number           ;calculated tax*(before decimal point) 
    mov taxAmount[0],ax 
    call displayEachDigit

    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h  
    
    mov ax,decimal_1        ;calculated tax*(after decimal point)
    mov taxAmount[2],ax     ;store decimal 
    call display2Digit

    mov ah,09h
    lea dx,orderStr5
    int 21h
    lea dx,orderStr10 
    int 21h
    
    mov ax,subtotal
    mov bx,taxAmount[0]
    add ax,bx
    
    mov grandTotal[0],ax
    call displayEachDigit

    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h  
    
    mov ax,taxAmount[2]       ;store for summary  
    mov bx,100
    mul bx
    mov grandTotal[2],ax 
    
    mov ax,taxAmount[2]         ;calculated total(after decimal point)
    call display2Digit     
       
    choosePayment:
    mov ah,09h
    lea dx,orderLine
    int 21h
    
    call makePayment  
    call printReceipt 
    call settingForNextOrder   
    
	askNextOrder:
    mov ah,09h
    lea dx,nextOrderMsg
    int 21h 
    
    mov ah,01h
    int 21h
    
    cmp al,'N'
    je endOrder ;same with back to main menu
    
    cmp al,'n'
    je endOrder
    
    cmp al,'Y'
    je nextOrder
    
    cmp al,'y'
    je nextOrder
    
    call displayErrorMsg
	jmp askNextOrder
    
    nextOrder:
    inc orderID
    jmp startOrder
	
	endOrder:
	ret
           
order endp  

    
displayErrorMsg proc
        mov ah,09h
        lea dx,errorMsg
        int 21h
        ret
displayErrorMsg endp 

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

displayMenu proc
        mov ah,09h
        lea dx,menuBoxTop
        int 21h
        lea dx,menu1
        int 21h  
        lea dx,menuBoxLine2
        int 21h       
        lea dx,menu2
        int 21h 
        lea dx,menuBoxLine3
        int 21h    
        lea dx,menu3
        int 21h
        lea dx,menu4
        int 21h  
        lea dx,menu5
        int 21h
        lea dx,menu6
        int 21h  
        lea dx,menuBoxBottom
        int 21h
        ret
displayMenu endp 

displayOrderId proc
        mov ah,09h          
        lea dx,orderStr1
        int 21h
        mov ax,orderID
        call display4digit
        ret 
displayOrderId endp

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

display4digit proc  ;receive 1 parameter, ax                                                   
        xor dx,dx       ;clear dx 
         
        mov bx,0100
        div bx          ;ax=0012 dx=0034
      
        push dx         ;stack dx       (+1)  
        aam             ;ax=0102 
        add ax, 3030h   ;ah="1" al="2"
        push ax         ;stack ax       (+2)
        
        mov dl,ah       ;print 1st digit
        mov ah,02h
        int 21h
        
        pop dx          ;dh="1" dl="2"  (-2)
        mov ah,02h      ;print 2nd digit
        int 21h
        
        pop ax          ;ax=0034        (-1)
        aam             ;ax=0304
        add ax,3030h    ;ah="3" al="4"
        push ax         ;stack ax       {+3}
        
        mov dl,ah       ;print 3rd digit
        mov ah,02h
        int 21h
        
        pop dx          ;dh="3" dl="4"  (-3)
        mov ah,02h
        int 21h         ;print 4th digit           
        ret   
display4digit endp 

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

calcEachSubtotal proc
    xor ax,ax
    xor bx,bx
    xor cx,cx       ;clear registers
    mov si,0
    mov cx,4
    storeEachSubtotal:
    mov al,pricePizza[si]
    mov bl,orderedQtyList[si]
    mul bl  ;quantity * price
    mov orderedPriceList[si],al 
    inc si
    loop storeEachSubtotal
    ret
calcEachSubtotal endp 

calcSubtotal proc
    xor ax,ax
    xor bx,bx
    xor cx,cx       ;clear registers
    mov si,0
    mov cx,4
    addEachPrice:
    mov al,orderedPriceList[si]
    add subtotal,ax 
    inc si
    loop addEachPrice
    ret    
calcSubtotal endp

calc2DecimalPoint proc     ;receive 2 parameter, ax = amount ,bx = rate 
    push bx         ;stack bx from main (+1)
    xor dx,dx       ;clear dx
    mov bx,100      ;separate 1230 into [12][30]
    div bx          ;ax=0012 dx=0030 
    
    pop bx          ;bx from main (-1)   
                    ;solving the number before decimal      
    mul bl          ;multiply the rate, ax=0060
    push ax         ;stack 0060 (+2), to store the number before decimal point 
                    ;solving the decimal
    mov ax,dx       ;ax=0030
    mul bl          ;ax=0150 
    
    xor dx,dx       ;clear dx
    mov bx,0100     
    div bx          ;ax=0001 dx=0050, ax is part of number
    
    pop bx          ;bx=0060 (-2) get back the number before decimal
    add ax,bx       ;ax=0061 , add the overflow number to number before decimal point 
                    
                    
    mov number,ax       ;now ax store the number before decimal point
    mov ax,dx           ;store decimal to ax  
    xor dx,dx           ;clear dx
    mov bx,0100
    div bx              ;divide decimal with 100
    add number,ax       ;ax will be the number for rounding up (if any)  
    
    mov decimal_1,dx    ;store decimal

    ret
    
calc2DecimalPoint endp   

calc3DecimalPoint proc  ;receive 3 parameter, ax = amount, bx = rate, dx = decimal 
  
    push bx             ;stack rate
    push dx             ;stack decimal  
    
    call calc2DecimalPoint   ;calculate number (return number and decimal_1)
    pop ax              ;get decimal
    pop bx              ;get rate                    
    mul bx              ;ax = decimal * rate
    
    mov bx,100          ;seperate digits
    div bx              ;ax = first 2 decimal  dx = last 2 decimal     
    mov decimal_2,dx    ;return decimal
    
    xor dx,dx           ;clear dx
    
    add ax,decimal_1    ;add previous decimal for rounding up(if any)
    div bx              ;separate to ax,dx. ax will be round up number
    
    add number,ax       ;round up    
    mov decimal_1,dx


    ret       
calc3DecimalPoint endp 

deductDiscount proc  ;receive 3 parameter ax = subtotal, bx = discount amount, dx = discount decimal
    push ax     ;stack subtotal 
    push dx     ;stack decimal
    
    mov ax,bx   
    mov bx,100       
    mul bx      ;multiply 100
                ;no remainder will store is dx
    pop dx      ;get decimal
    add ax,dx   ;discount amount + decimal
    
    pop dx      ;get subtotal
    push ax     ;stack discount amount
    
    mov ax,dx
    mul bx      ;decimal multiply 100
                
    pop dx      ;perform deduction
    sub ax,dx   ;subtotal - discount 
    xor dx,dx   ;clear dx 
    div bx      ;ax is number, dx is decimal(if any)
    mov number,ax
    mov decimal_1,dx
    ret
deductDiscount endp    

sumTotal proc    ;receive 4 parameter: tax[ax.(bh)(bl)] total after discount[cx.dx]
    push ax    ;stack numbers, sum decimal first
    push cx     
    
    mov ax,dx   ;store in ax for calculation       
    mov dx,100
    mul dx      ;before ax=0050 after ax=5000 (used to sum the decimal)
    xor dx,dx   ;clear dx to store round up number 
    add ax,bx   ;sum of decimals
    
    mov bx,10000 ;check round up
    div bx      ;ax=round up number dx=decimals
    
    mov decimal_1,dx ;return decimal
     
    pop dx
    pop bx
    add dx,bx      ;add numbers
    add dx,ax      ;round up(if any)
    mov number,dx  ;return number
    xor cx,cx      ;clear cx(avoid effect looping)                          
    ret
sumTotal endp
    
settingForNextOrder proc  
    
        mov subtotal,0    
    mov priceValue,0
    mov selectPizza,0
    mov quantity,0 
    
    mov dx,grandTotal[0]  
    mov ax,grandTotal[2]        ;pass grand total   
    
    mov cx,totalSales[0]        ;pass total sales
    mov bx,totalSales[2]
    
    push dx
    
    xor dx,dx
    add ax,bx
    mov bx,10000
    div bx        
    
    mov totalSales[2],dx
    pop bx
    add cx,bx
    add cx,ax
    mov ax,cx
    mov totalSales[0],ax

    mov cx,4
    mov si,0
    setList: 
    mov al,orderedQtyList[si]   ;store for summary 
    add totalQtySold[si],al      
   
    mov al,orderedPriceList[si]
    add totalEachSold[si],al
    
    mov orderedQtyList[si],0    ;clear
    mov orderedPriceList[si],0       
    mov discountAmount[si],0    
    mov totalAfterDiscount[si],0
    mov taxAmount[si],0   
    mov grandTotal[si],0
    mov cashIn[si],0 		;clear for cash in function
    mov input[si],'*'
    mov amount[si],0 
    inc si
    loop setList 
    
    inc orderCount
    
    ret  
settingForNextOrder endp

systemPause proc
    mov ah,09h
    lea dx,systemPauseMsg
    int 21h 
    
    mov ah,01h
    int 21h
    ret
    
systemPause endp

movCursor proc
    mov ah,2
    mov bh,0
    int 10h
    ret
movCursor endp 
  
   
displaySelectedPizza proc
    mov si,0    
    mov found,0 
    mov index,0
    mov bl,selectPizza
    dec bl              ;convert to index
    mov bh,0            ;clear bh, later will compare bx
    findIndex:
        mov dl,pizzaName[si]      
        
        cmp pizzaName[si],'$'  ;end of the array
        je endChecking
        
        cmp pizzaName[si],','  ;end of a string index
        je addIndex   
        
        cmp bx,index
        je print
   
        cont:
        inc si
        jmp findIndex  
        
        addIndex:                    
        cmp found,1
        je endFind ;break if found   
        inc index   ;count the index   
        jmp cont 
        
        print:
        mov found,1 ;found count   
        mov ah,02h
        int 21h 
        jmp cont
        
    endFind:      
    ret
displaySelectedPizza endp    

displayOrderedItem proc
    mov si,0     
    mov di,0 
    checkZeroQty:
                    
        cmp pizzaName[si],'$'  ;end of the array
        je endChecking
        
        cmp pizzaName[si],','  ;end of a string index
        je checkNext   
        
        cmp orderedQtyList[di],0   ;check the qty list
        je skip
        
        mov dl,pizzaName[si] 
        mov ah,02h
        int 21h
        
        skip: 
        inc si
        jmp checkZeroQty
        
        checkNext:                
        inc di
        inc si
        jmp checkZeroQty
      
    endChecking:      
    ret
    
displayOrderedItem endp  

displayOrderedItemQty proc
    mov cx,4
    mov si,0
    printOrderedItemQty:  
    mov ax,0                    ;clear ax
    mov al,orderedQtyList[si]   ;ordered qty for each item
    cmp al,0
    je skipQty
    mov ah,02h                  ;print qty  
    mov dl,orderedQtyList[si]               
    add dl,30h
    int 21h  
    
	mov dl,25   ;set cursor position X,Y(25,3)
    inc dh
    call movCursor
	
    skipQty:
    inc si
    loop printOrderedItemQty
    ret
displayOrderedItemQty endp    

displayOrderedItemPrice proc   
    mov cx,4 
    mov si,0   
    printOrderedItemPrice: 
    push cx ;stack cx *nested loop
    mov ax,0                      ;clear ax
    mov al,orderedPriceList[si]   ;ordered price for each item 
    cmp al,0
    je skipPrice
	push dx ;position
    call displayEachdigit    
    
	pop dx  
    inc dh
    call movCursor
    
    skipPrice:
    inc si 
    pop cx
    loop printOrderedItemPrice
    ret 
displayOrderedItemPrice endp   

makePayment proc
    
    redoPayment:
    mov ah,09h 
    lea dx,paymentStr1
    int 21h     
    
    mov ah,01h  ;choose payment method
    int 21h    
    
    sub al,30h  ;change to int
    cmp al,1      ;check input is 1 or 2
    jl invalid 
    cmp al,2
    jg invalid     
    
    jmp checkPayment        
    
    invalid:
    call displayErrorMsg 
    jmp redoPayment 
    
    checkPayment:
    mov paymentMethod,al      ;store payment type
    
    cmp paymentMethod,1 ;cash
    je cashPayment
    
    cmp paymentMethod,2 ;ewallet
    je ewalletPayment
    
    cashPayment:   
    call getCash
    ret
    
    ewalletPayment:     
    mov ah,09h
    lea dx,paymentEw1
    int 21h          
    call systemPause
    mov ah,09h
    lea dx,paymentEw2
    int 21h          
    call systemPause
    ret

makePayment endp 

getCash proc
     reEnter:  
    mov ah,09h
    lea dx,paymentCashStr ;Enter Cash Amount : 
    int 21h       
    mov si,0
    
    enterCash:
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
    lea dx,paymentError
    int 21h
    jmp reEnter
    
getCash endp

printReceipt proc
    call cls
    mov ah,09h
    lea dx,receipt
    int 21h      
    
    mov ax,orderId
    call display4Digit
    
    
    mov ah,09h
    lea dx,orderStr4
    int 21h
    lea dx,orderLine
    int 21h
    lea dx,nextLine
    int 21h
    call displayOrderedItem
    
    mov dl,25   ;set cursor position X,Y(25,8)
    mov dh,8
    call movCursor  
    
    call displayOrderedItemQty
    
    mov dl,34
    mov dh,8 
    call movCursor  
    
    call displayOrderedItemPrice
    
    mov ah,09h
    lea dx,orderLine
    int 21h
    lea dx,orderStr6
    int 21h
    
    mov ax,subtotal               ;print everything..
    call displayEachDigit    
    
    cmp subtotal,100
    jle skipPrintDiscount
    
    mov ah,09h
    lea dx,orderStr7
    int 21h
    
    mov ax,discountAmount[0]
    call displayEachDigit

    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h  
    
    mov ax,discountAmount[2]      
    call display2Digit
    
    mov ah,09h
    lea dx,orderStr5
    int 21h
    lea dx,orderStr8 
    int 21h
    

    mov ax,totalAfterDiscount[0] 
    call displayEachDigit

    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h  
    
    mov ax,totalAfterDiscount[2] 
    call display2Digit     
    
    skipPrintDiscount:
    mov ah,09h
    lea dx,orderStr9 
    int 21h

    mov ax,taxAmount[0]
    call displayEachDigit

    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h  
    
    mov ax,taxAmount[2]
    call display2Digit    
    
    mov ax,taxAmount[4]
    call display2Digit

    mov ah,09h
    lea dx,orderLine
    int 21h
    lea dx,orderStr10 
    int 21h

    
    mov ax,grandTotal[0]
    call displayEachDigit

    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h  
    
    mov ax,grandTotal[2]
    call display4Digit 
    
    cmp paymentMethod,1 ;if not cash
    jne endReceipt            
    
    mov ah,09h
    lea dx,orderStr5
    int 21h
    lea dx,orderStr11 
    int 21h
 
    mov ax,cashIn[0]
    call displayEachDigit

    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h  
    
    mov ax,cashIn[2]
    call display2Digit
    
    mov ah,09h              ;print change
    lea dx,orderStr12 
    int 21h                
                            ;calc change
    mov ax,cashIn[0]        ;cash - grandtotal 
    mov bx,grandTotal[0]
    sub ax,bx
    mov change[0],ax
                            
    mov ax,cashIn[2]        ;sub decimals
    mov bx,100
    mul bx                  ;multiply 100 for calculation
    mov bx,grandTotal[2] 
    cmp bx,ax               ;check which greater
    jg deductOne   
    
    sub ax,bx
    mov change[2],ax
    jmp printChange
    
    deductOne:
	cmp ax,0	;if no decimal
	je noDecimalCash
	
    sub bx,ax  
    mov change[2],bx
    dec change[0]           ;deduce 1 because decimal is smaller
	jmp printChange
	
	noDecimalCash:
	mov ax,10000
	sub ax,bx
	mov change[2],ax
    dec change[0]           ;deduce 1 
	                     
    printChange:
    mov ax,change[0]
    call displayEachDigit   
    
    mov ah,02h              ;print dot
    mov dl,'.'
    int 21h 
    
    mov ax,change[2] 
    call display4Digit
    
    endReceipt:
    mov ah,09h
    lea dx,orderLine
    int 21h 
    
    lea dx,thanksStr
    int 21h
     
    ret
 
    
printReceipt endp
 
 
orderSummary proc 
    mov ah, 09h
    lea dx, sumHeader
    int 21h
    
    lea dx, sumStr1
    int 21h  
    
    mov ah,02h 
    mov dl,orderCount
    add dl,30h
    int 21h
    
    mov ah,09h
    lea dx, sumBoxTop
    int 21h   
    
    lea dx, sumRowTitle
    int 21h  
    
    lea dx, boxLeft
    int 21h
    
    lea dx, sumPizzaName
    int 21h 
    
    lea dx, sumOfTotal
    int 21h  
    
    lea dx, sumBoxBottom
    int 21h     
    
    mov dh,6              ;set a cursor position
    mov dl,37 
    push dx 
    call movCursor   
    
    
    
    mov si,0
    mov cx,4
    printEachQtySales:
    mov ax,0            
    push cx ;nested loop
    
    mov al,totalQtySold[si]
    call display4Digit 
    pop cx
    
    pop dx          
    inc si
    
    inc dh      ;mov to next line  
    push dx
    call movCursor    
    loop printEachQtySales 
    pop dx  ;last looping will left one push   
    
    
    mov dh,6              ;set a cursor position
    mov dl,57 
    push dx 
    call movCursor  
    
    mov si,0
    mov cx,4
    printEachSales:
    mov ax,0            
    push cx ;nested loop
    
    mov al,totalEachSold[si]
    call display4Digit 
    pop cx
    
    pop dx          
    inc si
    
    inc dh      ;mov to next line  
    push dx
    call movCursor    
    loop printEachSales 
    pop dx  ;last looping will left one push 

	printTotalSales:
	mov dh,13
	mov dl,48
	call movCursor
	
	mov si,0
	mov cx,4
	mov ax,0
	sumUp:
	add al,totalEachSold[si]
	inc si
	loop sumUp
	
	call display4Digit
	
	printTotalSalesAfterDiscount:
	mov dh,14             ;set a cursor position
    mov dl,48 
    call movCursor  
	
	mov ax,totalSales[0] 
	call display4Digit
	
	mov ah,02h
	mov dl,'.'
	int 21h
	
	mov ax,totalSales[2]
	call display4Digit
    
    mov ah,09h
	lea dx,nextLine
	int 21h
    ret
orderSummary endp

end main
