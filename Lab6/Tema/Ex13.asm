bits 32

global start

extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    a dd 0
    b dd 0
    mesaja db "a = ", 0
    mesajb db "b = ", 0
    mesajin db "%d", 0
    mesahout db"(%d+%d)/(%d-%d) = %d", 0
    c dd 0
    
segment code use32 class=code
start:
    push dword mesaja
    call [printf]
    add esp, 4 * 1
    
    push dword a
    push dword mesajin
    call [scanf]
    add esp, 4 * 2
    
    push dword mesajb
    call [printf]
    add esp, 4 * 1
    
    push dword b
    push dword mesajin
    call [scanf]
    add esp, 4 * 2
    
    mov eax, [a]
    add eax, [b]
    mov ebx, [a]
    sub ebx, [b]
    imul ebx ;edx:eax = a^2 - b^2
    
    mov [c], eax
    
    push dword [c]
    push dword [b]
    push dword [a]
    push dword [b]
    push dword [a]
    push dword mesahout
    call [printf]
    add esp, 4 * 6
    
    push dword 0
    call [exit]