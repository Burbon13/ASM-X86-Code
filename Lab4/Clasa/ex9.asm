bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    b db 01101011b ;word
    a dw 1010010110101010b ;word
    c dd 0 ;double word
    
segment code use32 class=code
start:
    mov dh, [b]   ;dh = b7 b6 b5 b4 b3 b2 b1 b0
    mov dl, byte [a+1] ;dl = a15 a14 a13 a12 a11 a10 a9 a8
    mov ah, byte [a] ;ah = a7 a6 a5 a4 a3 a2 a1 a0
    
    mov al, [b] ;al =b7 b6 b5 b4 b3 b2 b1 b0
    shl al, 5 ;al = b2 b1 b0 0 0 0 0 0
    and al, 11000000b ;al = b2 b1 0 0 0 0 0 0 
    or al, 00110000b ;al = b2 b1 1 1 0 0 0 0
    
    mov bx, [a] ;bx = a15 a14 ... a1 a0
    shr bx, 6 ;bx = 0 0 0 0 0 0 a15 a14 | a13 a12 a11 a10 a9 a7 a7 a6 -> bl = a13 a12 a11 a10 a9 a7 a7 a6
    and bl, 00001111b;bl = 0 0 0 0 a9 a8 a7 a6
    or al, bl ;al = b2 b1 1 1 a9 a8 a7 a6
    
    ;-->dx:ax = c
    
    push dx
    push ax
    pop eax
    mov [c], eax
    
    push dword 0
    call [exit]