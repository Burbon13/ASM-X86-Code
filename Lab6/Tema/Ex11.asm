bits 32

global start

extern exit,printf,scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    a dd 0
    m1 db "a = ", 0
    min db "%x", 0
    mout db "%x(16) = %d(10)", 0
    
segment code use32 class=code
start:
    push dword m1
    call [printf]
    add esp, 4 * 1
    
    push dword a
    push dword min
    call [scanf]
    add esp, 4 * 2
    
    push dword [a]
    push dword [a]
    push dword mout
    call [printf]
    add esp, 4 * 3
    
    
    push dword 0
    call [exit]