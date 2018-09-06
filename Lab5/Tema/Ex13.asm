bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 01110101b
    b db 10110010b
    c db 10101010b
    d db 11100100b
    
segment code use32 class=code
start:
    mov ax, 0
    
    mov bl, [a] ;bl = a7 a6 a5 a4 a3 a2 a1 a0
    shr bl, 4   ;bl = 0  0  0  0  a7 a6 a5 a4
    and bl, 00000111b ;bl = 0 0 0 0 0 a6 a5 a4
    add al, bl
    adc ah, 0
    
    mov bl, [b] 
    shr bl, 4   
    and bl, 00000111b 
    add al, bl
    adc ah, 0
    
    mov bl, [c] 
    shr bl, 4   
    and bl, 00000111b
    add al, bl
    adc ah, 0
    
    mov bl, [d] 
    shr bl, 4   
    and bl, 00000111b
    add al, bl
    adc ah, 0
    
    push dword 0
    call [exit]