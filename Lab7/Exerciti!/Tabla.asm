bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 2
    b dw 22h,11h
    c dd 123h,0abch
    
segment code use32 class=coda
    start:
        cld
        mov esi, a
        lodsw
        lodsw
        lodsb
        
        push dword 0
        call [exit]