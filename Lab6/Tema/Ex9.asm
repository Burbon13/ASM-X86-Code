bits 32

global start

extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    a dd 0
    b dd 0
    rezultat dd 0
    format_a db "a = ", 0
    format_b db "b = ", 0
    format_in db "%d", 0
    format_out db "(%d + %d) / (%d - %d) = %d", 0
    
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
    cdq ;edx:eax = a+b
    
    mov ebx, [a]
    sub ebx, [b] ;ebx = a - b
    
    div ebx ;eax = (a+b)/(a-b)
    
    mov [rezultat], eax
    
    push dword [rezultat]
    push dword [b]
    push dword [a]
    push dword [b]
    push dword [a]
    push dword format_out
    call [printf]
    add esp, 4*6
    
    push dword 0
    call [exit]