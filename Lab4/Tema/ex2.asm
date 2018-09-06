bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db -22 ;byte
    b db 3 ;byte
    c db 10;byte
    d dd 6 ;double word
    e dq 7 ;quad word

segment code use32 class=code
start:
    ;2/(a+b*c-9)+e-d = -2 + 7 - 6 = -1
    ;interpretare cu semn
    
    mov al, [b]
    imul byte [c]  ;ax = b * c
    
    ;mov bx, ax
    
    ;mov al, [a]
    ;cbw ;ax = a
    
    ;add ax, bx
    
    add al, [a]
    adc ah, 0 ;ax = b * c + a
    
    sub ax, 9
    
    mov bx, ax ;bx = a+b*c-9
    
    mov ax, 2
    mov dx, 0
    idiv bx ;ax = 2 / (a+b*c-9)
    cwde ;eax = 2 / (a+b*c-9)
    
    mov ebx, dword [e]
    mov ecx, dword [e+4] ;ecx:ebx = e
    
    add ebx, eax
    adc ecx, 0 ;ecx:ebx = 2 / (a+b*c-9)+e
    
    sub ebx, dword [e]
    sbb ecx, 0 ;ecx:ebx = 2 / (a+b*c-9)+e - d
    
    push dword 0
    call [exit]