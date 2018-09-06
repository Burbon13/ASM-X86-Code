bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 3  ;byte
    b db 7  ;byte
    c dw 4  ;word
    e dd 2  ;double word
    x dq 5  ;quad word
    aux dw 0;double word
    
segment code use32 class=code
start:
    ;(100+a+b*c)/(a-100)+e+x/a
    ;intepretare cu semn
    
    mov al, [b]
    cbw          ;ax = b
    imul word [c] ;dx:ax = b*c
    
    add ax, 100
    adc dx, 0    ;dx:ax = 100 + b*c
    
    mov cx, dx
    mov bx, ax
    
    mov al, [a]
    cbw          ;ax = a
    
    add bx, ax
    adc cx, 0    ;cx:bx = 100+a+b*c
    
    mov al, [a]
    cbw         ;ax = a
    sub ax, 100 ;ax = a - 100
    
    push ax
    
    mov ax, bx
    mov dx, cx ;dx:ax = 100+a+b*c
    
    pop bx
    
    idiv bx ;ax = (100+a+b*c)/(a-100)
    
    cwd ;dx:ax = (100+a+b*c)/(a-100)
    add ax, word [e]
    adc dx, word [e+2] ;dx:ax = (100+a+b*c)/(a-100) + e
    
    push dx
    push ax
    pop eax
    mov [aux], eax
    
    mov al, [a]
    cbw
    cwde ;eax = a
    mov ebx, eax ;ebx = a
    
    mov eax, dword [x]
    mov edx, dword [x+4]
    
    idiv ebx ;eax = x/a
    add eax, [aux] ;eax = (100+a+b*c)/(a-100) + e + x/a
    
    push dword 0
    call [exit]