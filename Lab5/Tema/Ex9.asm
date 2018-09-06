bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 0111011100001110b
    b db 11110001b
    c dd 0
    
segment code use32 class=code
start:
    mov ah, [b]        ;ah = b7 b6 b5 b4 b3 b2 b1 b0
    mov al, byte [a+1] ;al = a15 a14 ... a8
    
    shl eax, 16 ;eax = b7 ... b0 a15 ... a8
    
    mov ah, byte [a] ;ah = a7 ... a0
    
    mov al, [b] ;al = b7 ... b0
    shl al, 5   ;al = b2 b1 b0 0 0 0 0 07
    
    and al, 11000000b ;al = b2 b1 0 0 0 0 0 0
    or al, 00110000b  ;al = b2 b1 1 1 0 0 0 0
    
    mov bx, [a]
    shr bx, 6 ;bl = a13 a12 a11 a10 a9 a8 a7 a6
    and bl, 00001111b ;bl = 0 0 0 0 a9 a8 a7 a6
    
    or al, bl ;al = b2 b1 1 1 a9 a8 a7 a6
    
    mov [c], eax ;rezultatul
    
    push dword 0
    call [exit]