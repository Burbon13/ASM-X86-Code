bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 10010110b
    n db 0
    b db 0
    c dd 0
    
segment code use32 class=code
start:
    mov al, [a] ;al = a7 a6 a5 a4 a3 a2 a1 a0
    shr al, 2   ;al = 0  0  a7 a6 a5 a4 a3 a2
    and al, 00000111b ;al = 0 0 0 0 0 a4 a3 a2
    mov [n], al
    
    mov al, [a]
    mov cl, [n]
    ror al, cl
    mov [b], al
    
    mov ah, [a]
    mov al, [b] ;ax = a7 a6 ... a0 b7 b6 ... b0
    shl eax, 16 ;eax = a7 a6 ... a0 b7 b6 ... b0 0 0 ... 0
    
    mov ah, 0
    mov al, 0ffffh;
    
    mov [c], eax
    
    push dword 0
    call [exit]