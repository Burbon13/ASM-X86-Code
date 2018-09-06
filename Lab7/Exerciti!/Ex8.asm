;Ex 8 lab 7
bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    sir DB 2, 4, 2, 5, 2, 2, 4, 4 
    lsir equ $ - sir
    rez resb lsir
    
segment code us32 class=code
    start:
        
        
        
        push dword 0
        call [exit]