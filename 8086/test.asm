.MODEL SMALL
.STACK 100H
.DATA
.CODE
  
   MAIN PROC
       MOV AH,1   ;FOR INPUT
       INT 21H    ;call INTERRUPT
      
       MOV DL,AL
      
       MOV AH,2   ;FOR OUTPUT
       INT 21H      ;call INTERRUPT
                     
   
   MAIN ENDP
  
END MAIN
