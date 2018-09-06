bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 75
    b dw 3
    c dw 7
    d db 14
    e dd 3
   
segment code use32 class=code
start:
    ; a/b + c*d - exit
    
    mov dx, 0
    mov ax, 0
    mov al, [a]     ; dx:ax = a
    div word [b]    ; ax = a / b
    
    
    mov bx,ax       ; bx = a / b
    
    mov ah, 0
    mov al, [d]     ; ax = d
    mul word [c]    ; dx:ax = d * c
    
    add ax, bx
    adc dx, 0       ; dx:ax = a/b + d * c
    
    mov bx, word [e]
    mov cx, word [e+2] ;cx:bx = e
    
    sub ax, bx
    sbb dx, cx      ; dx:ax = a/b + c*d - e
        
    push dword 0
    call [exit]