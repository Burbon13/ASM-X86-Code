bits 32

global start

extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    format_a db "a = ", 0
    format_b db "b = ", 0
    format_in db "%d", 0
    format_rezultat db "%d(10) + %d(10) = %x(16):" ,0
    a dd 0
    b dd 0
    c dd 0
    
segment code use32 class=code
start:
    push dword format_a
    call [printf]
    add esp, 4*1
    
    push dword a
    push dword format_in
    call [scanf]
    add esp, 4*2
        
    push dword format_b
    call [printf]
    add esp, 4*1
    
    push dword b
    push dword format_in
    call [scanf]
    add esp, 4*2
        
    mov eax, [a]
    add eax, [b]
    mov [c], eax
    
    push dword [c]
    push dword [b]
    push dword [a]
    push dword format_rezultat
    call [printf]
    add esp, 4*4
    
    push dword 0
    call [exit]