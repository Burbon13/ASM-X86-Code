bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 1001010101110100b 
    b dw 1010110101111001b
    c dd 0

segment code use32 class=code
start:
    ;punem rezultatul in dx:ax
    
    mov dx, [b]   ;dx = b15 b14 ... b1 b0
    
    mov ax, [a]   ;ah = a15 14 .. a8  al = a7 a6 ... a0
    shl ax, 3     ;ah = a12 a11 a10 a9 a8 a7 a6 a5
    and al, 11111110b ;ah = a12 a11 a10 a9 a8 a7 a6 0
    
    mov al, byte [a] ;al = a7 a6 a5 a4 a3 a2 a1 a0  ???
    shr al, 4        ;al = 0  0  0  0  a7 a6 a5 a4
    and al, 00000001b;al = 0  0  0  0  0  0  0  a4
    
    
    
    push dword 0
    call [exit]