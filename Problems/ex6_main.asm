;Se citesc trei siruri de caractere. Sa se determine si sa se afiseze rezultatul concatenarii lor.
bits 32

global start

extern exit, printf, scanf, conc
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll


segment data use32 public data
    format db "%s", 0
    sir resb 100
    sirFinal resb 300
    iter db 3
    

segment code use32 public code
    start:
        
        mov ecx, 3
        
        repeta:
            
            cmp byte [iter], 0
            je fin_repeta
            
            dec byte [iter]
            
            push dword sir
            push dword format
            call [scanf]
            add esp, 4 * 2
            
            push dword sirFinal
            push dword sir
            call conc ;conc(sir, sirFinal);
            add esp, 4 * 2
            
        jmp repeta
        fin_repeta:
        
        push dword sirFinal
        push dword format
        call [printf]
        add esp, 4 * 2
        
        push dword 0
        call [exit]