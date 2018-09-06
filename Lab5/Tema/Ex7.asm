bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 1001011101110001b;
    b dw 1001010101001010b;
    c dd 0
    
segment code use32 class=code
start:
    mov eax, 650000h
    
    mov ax, [a] ;ax = a15 a14 ... a1 a0
    shl ax, 5   ;ah = a11 a10 a9 a8 a7 a6 a5 a4 a3    al = a2 a1 a0 0 0 0 0 0
    
    and ah, 00001111b ;ah = 0 0 0 0 a6 a5 a4 a3
    or al, 00011111b ;al = a2 a1 a0 1 1 1 1 1
    
    mov bl, [b+1] ;bl = b15 b14 b13 b12 b11 b10 b9 b8
    shl bl, 4     ;bl = b11 b10 b9 b8 0 0 0 0
    
    or ah, bl     ;ah = b11 b10 b9 b8 a6 a5 a4 a3
    
    mov [c], eax ;rezultat
    
    push dword 0
    call [exit]
    