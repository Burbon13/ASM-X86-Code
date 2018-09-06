bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 10010110b
    b db 10111000b
    c dd 0
    
segment code use32 class=code
start:
    mov ax, 0FFFFh 
    shl eax, 16  ;eax = 1...10...0
    
    mov ah, [a]
    shl ah, 3 ;ah = a4 a3 a2 a1 a0 0 0 0
    or ah, 00000110b ;ah = a4 a3 a2 a1 a0 1 1 0
    
    mov al, [b] ;al = b7 b6 b5 b4 b3 b2 b1 b0
    shr al, 3   ;al = 0  0  0  b7 b6 b5 b4 b3
    and al, 00001111b ;al = 0 0 0 0 b6 b5 b4 b3
    
    mov [c], eax ;rezultat
    
    push dword 0
    call [exit]