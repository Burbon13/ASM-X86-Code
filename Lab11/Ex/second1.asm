bits 32

extern printf
import printf msvcrt.dll

segment data use32 public data
    format8 db "%o ", 0
    formatA db "%c", 0
    formatNL db "%c", 0

    
segment code use32 public code
    global afish
    afish:
        mov edx, [esp + 4]
        
        push edx
        push dword format8
        call [printf]
        add esp, 4
        pop edx
        
        push edx
        push dword formatA
        call [printf]
        add esp, 4 * 2
        
        push dword 10
        push dword formatNL
        call [printf]
        add esp, 4 * 2
        
        ret