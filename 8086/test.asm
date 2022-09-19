.model small
.stack 100
.data

    arrayB db 10h,20h,30h,40h,50h
.code

main proc
    mov ax,@data
    mov ds,ax
    mov al,arrayB
    mov al,[arrayB+1]
    mov al,[arrayB+2]

    mov ah,09h
    int 21h

    mov ah,4ch
    int 21h
main endp
end main