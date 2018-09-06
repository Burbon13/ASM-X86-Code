bits 32

global start

extern exit,scanf,printf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    a dd -1
    outm db "%d = %u (baza 10), %d = %x (baza 16)", 0
    
segment code use32 class=code
start:
    push dword [a]
    push dword [a]
    push dword [a]
    push dword [a]
    push dword outm
    call [printf]
    add esp, 4 * 5
    
    push dword 0
    call [exit]