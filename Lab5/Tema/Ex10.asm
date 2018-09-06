bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    b db 01110110b
    a dw 1100000110011011b
    
segment code use32 class=code
start:
    mov ah, byte [a+1] ;ah = a15 ... a8
    mov bh, [b] ;bh = b7 b6 .... b0
    
    shl eax, 4  
    shl ebx, 4
    
    xor ah, bh
    xor bh, ah
    xor ah, bh
    
    shr eax, 4
    shr ebx, 4
    
    mov [b], bh
    mov al, byte [a]
    mov [a], ax
    
    push dword 0
    call [exit]