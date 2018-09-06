bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 1010110110001010b
    b dw 1100101001010101b
    c dd 0
    
segment code use32 class=code
start:
    mov ax, [a]  ;ax = a15 14 ... a1 a0
    shl eax, 16   ;eax = a15 141 ... a1 a0 0 0 ... 0
    
    mov ax, [b]  ;ax = b15 b14 .... b1 b0
    shl ax, 4    ;ax = b11 b10 ... b0 0 0 0 0  ->  ah = b11 b10 b9 b8 b7 b6 b5 b4
    or ah, 00001111b ;ah = b11 b10 b9 b8 1 1 1 1 
    
    mov al, byte [a+1] ;al = a15 a14 a13 a12 a11 a10 a9 a8
    shr al, 3  ;al = 0 0 0 a15 a14 a13 a12 a11
    or al, 11100000b ;al = 1 1 1 a15 a14 a13 a12 a11
    
    mov [c], eax  ; c = rez cerut
    
    push dword 0
    call [exit]