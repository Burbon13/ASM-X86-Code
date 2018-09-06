bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 1001011110000101b
    n db 0
    b dw 0
    c dd 0
    
segment code use32 class=code
start:
    mov cl, byte [a]   ;cl = a7 a6 a5 a4 a3 a2 a1 a0
    and cl, 00000111b  ;cl = 0  0  0  0  0  a2 a1 a0
    mov [c], cl
    
    mov bx, [a]
    ror bx, cl
    mov [b], bx
    
    mov ax, [a] ;ax = a15 a14 ... a0
    shl ax, 1   ;ax = a14 a13 ... a0 0 -> ah = a14 a13 a12 a11 a10 a9 a8 a7   
    
    mov bx, [b]
    shr bx, 2   ;bx = 0 0 b15 ... b2 -> bl = b9 b8 b7 b6 b5 b4 b3 b2
    mov al, bl  ;al = b9 b8 b7 b6 b5 b4 b3 b2
    
    ;ax = a14 a13 ... a7 b9 b8 ... b2
    
    shl eax, 16 ;eax = a14 a13 ... a7 b9 b8 ... b2 0 ... 0
    
    mov al, 0ffh 
    
    mov [c], eax
    
    push dword 0
    call [exit]