bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 1000111010111101b
    b dw 1101010110101010b
    c dd 0
    
segment code use32 class=code
start:
    mov ax, [a] ;ax = a15 a14 ... a0
    shl eax, 16 ;eax = 15 a14 ... a0 0 0 ... 0
    
    mov ax, [a] ;ax = a15 a14 ... a0
    shl ax, 6   ;ax = a9 a8 ... a0 0 0 0 0 0 0 -> ah = a9 a8 a7 a6 a5 a4 a3 a2
    and ah, 11111110b ;ah = a9 a8 a7 a6 a5 a4 a3 0
    
    mov bx, [b] ;bx = b15 b14 ... b1 b0
    
    shl bx, 3   ;bh = b12 b11 b10 b9 b8 b7 b6 b5   bl = b4 b3 b2 b1 b0 0 0 0 0
    and bh, 00000001b ;bh = 0 0 0 0 0 0 0 0 b5
    
    or ah, bh ;ah = a9 a8 a7 a6 a5 a4 a3 b5
    mov al, bl ;al = b4 b3 b2 b1 b0 0 0 0 0
    
    mov bl, byte [a+1] ;bl = a15 a14 a13 a12 a11 a10 a9 a8 
    shr bl, 4  ;bl = 0 0 0 0 a15 a14 a13 a12
    and bl, 00000111b ;bl = 0 0 0 0 0 a14 a13 a12
    or al, bl ;bl = b4 b3 b2 b1 b0 a14 a13 a12
    
    mov [c], eax ;rezultat
    
    push dword 0
    call [exit]