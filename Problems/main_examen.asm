bits 32

global start

extern exit
import exit msvcrt.dll
extern apel

    
segment code use32 public code
    start:
        mov eax, 2
        
        call apel
        
        push dword 0
        call [exit]
    