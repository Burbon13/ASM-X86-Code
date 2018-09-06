bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 1001011101110001b;
    b dw 1001010101001010b;
    c db 0
    d dd 0
    
segment code use32 class=code
start:
    mov ax, [a]
    shr ax, 5  ;al = a12 a11 a10 a9 a8 a7 a6 a5
    and al, 00111111b ;al = 0 0 a10 a9 a8 a7 a6 a5
    
    mov ah, [b] ;ah = b7 b6 b5 b4 b3 b2 b1 b0
    shl ah, 5   ;ah = b2 b1 b0 0  0  0  0  0
    and ah, 11000000b ;ah = b2 b1 0 0 0 0 0 0
    
    or al, ah   ;al = b2 b1 a10 a9 a8 a7 a6 a5
    
    mov [c], al
    
    mov ax, [a]  ;ax = a15 ... a0
    rol ax, 8    ;ax = a7 ... a0 a15 ... a8
    shl eax, 16  ;eax = a7 ... a0 a15 ... a8 0 ... 0
    
    mov ah, [c]  ;ah = c7 ... c0
    
    mov al, byte [b+1] ;al = b15 ... b8
    
    mov [d], eax
    
    push dword 0
    call [exit]