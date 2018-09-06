bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 1101011101010110b 
    b dw 1010111010010100b
    c dd 0
    
segment code use32 class=code
start:
    mov dx, [c] ;dx = a15 14 ... a1 a0
    
    mov ah, byte [b+1] ;ah = b15 b14 b13 b12 b11 b10 b9 b8
    shl ah, 4          ;ah = b11 b10 b9  b8  0   0   0  0
    or ah, 00001111b   ;ah = b11 b10 b9  b8  1   1   1  1
    
    mov al, byte [a+1] ;al = a15 a14 a13 a12 a11 a10 a9  a8
    shr al, 3          ;al = 0   0   0   a15 a14 a13 a12 a11
    or al, 11100000b   ;al = 1   1   1  a15 a14 a13 a12 a11
    
    ;-->dx:ax = c
    
    push dx
    push ax
    pop eax
    mov [c], eax ;c = rezultatul
    
    push dword 0
    call [exit]