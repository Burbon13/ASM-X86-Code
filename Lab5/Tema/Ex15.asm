bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 1101001111000001b
    b dw 1001010101010100b
    c dd 0
    
segment code use32 class=code
start:
    mov ax, 0ffffh
    shl eax, 16   ;eax = 11...100...0
    
    mov ax, [a]
    shl ax, 7 ;ah = a8 a7 a6 a5 a4 a3 a2 a1   al = a0 0 0 0 0 0 0 0
    
    and ah, 03h ;ah = 0 0 0 0 0 0 a2 a1
    
    mov bl, byte [b+1] ;bl = b15 ... b8
    shl bl, 2 ;bl = b13 b12 b11 b10 b9 b8 0 0
    
    or ah, bl  ;al = b13 b12 b11 b10 b9 b8 a2 a1
    
    mov [c], eax
    
    push dword 0
    call [exit]