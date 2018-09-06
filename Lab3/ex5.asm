bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 10; 2 word
    b db 8; 1 byte
    c dw 4; 2 word
    d dd 2; 4 dword
    x dq 5; 8 qword
    
segment class use32 class=code
start:
    ;(a*a+b/c-1)/(b+c)+d-x
    
    mov ax, [a]
    mul word [a] ;dx:ax = a * a
    
    mov cx, dx
    mov bx, ax ;cx:bx = a * a
    
    mov dx, 0
    mov ah, 0
    mov al, [b] ;dx:ax = b 
    div word [c] ;ax = b / c
    
    add bx, ax
    adc cx, 0 ;cx:bx = a * a + b / c
        
    mov dx, cx
    mov ax, bx ;dx:ax = a * a + b / c
    
    sub 
    
    mov bl, [b]
    mov bh, 0 ;bx = b
    add bx, word [c] ;bx = b + c
    
    div bx; ax = (a*a+b/c-1/(b+c)
    
    push dword 0
    call [exit]