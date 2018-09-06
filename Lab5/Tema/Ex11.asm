bits 32

global start

extern exit
import exit msvcrt.dll

segment daca use32 class=data
    a db 10011101b
    b dw 1011011011100011b
    c db 0
    
segment code use32 class=code
start:
    mov al, [a]
    shr al, 2   ;al = 0 0 a7 a6 a5 a4 a3 a2
    and al, 00001111b ;al = 0000 a5 a4 a3 a2
    
    mov bx, [b]
    shr bx, 2 ;bl = b9 b8 b7 b6 b5 b4 b3 b2
    and bl, 11110000b ;bl = b9 b8 b7 b6 0 0 0 0
    
    or al, bl ;bl = b9 b8 b7 b6 a5 a4 a3 a2
    
    mov [c], al
    
    push dword 0
    call [exit]