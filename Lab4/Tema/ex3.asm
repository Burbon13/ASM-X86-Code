bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 0;byte
    b db 4 ;byte
    d db 7 ;byte
    c dd 3 ;double word
    x dq 5 ;quad word
    
    
segment code use32 class=code
start:
    ;(8-a*b*100+c)/d+x
    ;interpretare fara semn
    
    mov al, [a]
    mul byte [b] ;ax = a * b
    mov bx, 100
    mul bx ;dx:ax = a * b * 100
    
    add ax, word [c]
    adc dx, word [c+2] ;dx:ax = a * b * 100 + c
    
    mov cx, 0
    mov bx, 8
    
    sub bx, ax
    sbb cx, dx ;cx:bx =8 -  a * b * 100 + c
    
    mov ax, bx
    mov dx, cx ;dx:ax = ...
    
    mov bh, 0
    mov bl, [d]
   
    div bx ;ax = (8 -  a * b * 100 + c)/d
    
    mov bx, ax
    mov eax, 0
    mov ax, bx ;eax = a
    
    mov ebx, dword [x]
    mov ecx, dword [x+4]
    
    add ebx, eax
    adc ecx, 0 ;
    
    push dword 0
    call [exit]