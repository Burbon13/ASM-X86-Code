bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 5 ;byte
    b db 4 ;byte
    c dw 8 ;word
    e dd 3 ;double word
    x dq 6 ;quad word
    
segment code use32 class=code
start:
    ;(a-b+c*128)/(a+b)+e-x
    ;fara semn
    
    mov ax, [c]
    mov dx, 128
    mul dx      ;dx:ax = c * 128
    
    
    mov bh, 0
    mov bl, [a]
    sub bl, [b] ;bx = a - b
    
    add ax, bx
    adc dx, 0   ;dx:ax = a-b+c*128
    
    mov bh, 0
    mov bl, [a]
    add bl, [b] 
    adc bh, 0 ;bx = a+b
    
    div bx   ;ax = (a-b+c*128)/(a+b)
    
    mov ebx, 0
    mov bx, ax  ;ebx=(a-b+c*128)/(a+b)
    
    add ebx, [e] ;ebx = (a-b+c*128)/(a+b)
    
    mov ecx, 0 
    mov eax, dword [x]
    mov edx, dword [x+4]
    
    sub ebx, eax
    sbb ecx, edx ;edx:eax = (a-b+c*128)/(a+b)+e-x
    
    push dword 0
    call [exit]