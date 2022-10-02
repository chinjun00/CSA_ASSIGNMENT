.model small
.stack 10h
.data
prompt db 10 dup(3),10,13
  db  "Enter your pass (9 Chars):$"
  db 10 dup(3)
greet   db  "Hello $"
pass     db  10 dup(?) ; 7 plus term char $
Ast     db  "*$"
crlf   db  13, 10, 24H

.code
    mov     ax, @data
    mov     ds,ax
  
    ; Display Name prompt
    lea     dx, prompt
    mov     ah, 9
    int     21h

    mov     cx, 9   ; get 7 chars  
    lea     si, pass ; buffer to hold name
    lea     dx, Ast ; display *
   
balik:
    ; get char typed
    mov     ah, 7
    int     21h
    ; save in our buffer
    mov     byte ptr[si], al
   
    ; Display Asterick
    ; Asterick already in dx
    mov     ah, 9
    int     21h
   
    ; increase our buffer pointer
    inc     si
   
  
    dec     cx
    jnz     balik ;continue until met 0

    ; properly terminate our string
    mov     byte ptr[si], "$"

    ; insert blank line
    lea     dx, crlf
    mov     ah, 9
    int     21h
   
    ; display hello
    lea     dx, greet
    mov     ah, 9
    int     21h

    ; Now display entered name
    lea     dx, pass
    mov     ah, 9
    int     21h

    ; exit
    mov     ah, 4ch
    int     21h
end