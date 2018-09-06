bits 32

global start

extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    fa db "a(16) = ", 0
    fb db "b(16) = ", 0
    fin db "%x", 0
    fout db "%x(16) + %x(16) = %d(10)", 0
    a dd 0
    b dd 0
    c dd 0
    
segment code use32 class=code
start:
    push dword fa
    call [printf]
    add esp, 4*1
    
    push dword a
    push dword fin
    call [scanf]
    add esp, 4*2
    
    push dword fb
    call [printf]
    add esp, 4*1
    
    push dword b
    push dword fin
    call [scanf]
    add esp, 4*2
    
    mov eax, [a]
    add eax, [b]
    mov [c], eax
    
    push dword [c]
    push dword [b]
    push dword [a]
    push fout
    call [printf]
    add esp, 4*4
    
    push dword 0
    call [exit]