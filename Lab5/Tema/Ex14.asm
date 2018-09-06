bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dd 01110101011101010111010101110101b
    n db 0
    b dd 0
    
segment code use32 class=code
start:
    mov eax, [a]
    shr eax, 14 ; al = a21 a20 a19 a18 a17 a16 a15 a14
    
    and al, 0Fh ;al = 0 0 0 0 a17 a16 a15 a14
    mov [n], al
    
    mov eax, [a]
    mov cl, [n]
    rol eax, cl
    mov [b], eax ;rezultat
    
    push dword 0
    call [exit]