bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 5  ;word
    b db 3  ;byte
    c db 91;byte
    e dd 4  ;double word
    x dq 6  ;quad word
    
segment code use32 class=code
start:
    ;a*b-(100-c)/(b*b)+e+x
    ;interpretare fara semn
    
    mov al, [b]
    mul al     ;ax = b*b
    mov bx, ax
    
    mov dx, 0
    mov ax, 0  ;dx:ax = 0
    mov al, 100
    sub al, [c] ;dx:ax = 100 - c
    
    div bx ;ax = (100-c)/(b*b)
    mov bx, ax ;bx = (100-c)/(b*b)
    
    mov al, [b]
    mov ah, 0   ;ax = b
    mul word [a] ;dx:ax = a*b
    
    sub ax, bx
    sbb dx, 0 ;dx:ax = a*b - (100-c)/(a*a)
    
    add ax, word [e]
    adc dx, word [e+2] ;dx:ax = a*b - (100-c)/(a*a) + e
    
    push dx
    push ax
    pop ebx ;ebx = a*b - (100-c)/(a*a) + e
    
    mov eax, dword [x]
    mov edx, dword [x+4]
    
    add eax, ebx
    adc edx, 0   ;edx:eax = a*b - (100-c)/(a*a) + e + x
    
    push dword 0
    call [exit]