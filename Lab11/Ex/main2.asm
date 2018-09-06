bits 32

global start

extern citire
extern exit
import exit msvcrt.dll

segment data use32 public data
    sir resb 100 * 4
    
segment code use32 public code
    start:
        
        
        push dword 0
        call [exit]