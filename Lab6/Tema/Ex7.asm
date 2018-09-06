bits 32

global start

extern exit,scanf,printf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    a dd 14
    b dd 7
    mout db "%d mod %d = %d", 0
    
segment code use32 class=code
start:
    mov eax, [a]
    mov edx, 0
    
    div dword [b]
    
    push edx
    push dword [b]
    push dword [a]
    push dword mout
    call [printf]
    add esp, 4 * 4
    
    push dword 0
    call [exit]