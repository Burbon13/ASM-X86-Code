bits 32

global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    a dd 21
    b dd 49
    c dd 0
    format db "%d + %d = %d"
    
segment code use32 class=code
start:
    mov eax, [a]
    add eax, dword [b]
    mov [c], eax
    
    push dword [c]
    push dword [b]
    push dword [a]
    push dword format
    
    call [printf]
    
    add esp, 4*4
    
    push dword 0
    call [exit]