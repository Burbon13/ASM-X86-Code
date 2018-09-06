;Se citeste de la tastatura un sir de mai multe numere in baza 2. Sa se afiseze aceste numere in baza 16.
bits 32

global start

extern exit, printf, scanf, convert
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll


segment data use32 public data
    format_in db "%s", 0
    format_out db "%x", 0
    sir resb 100
    
segment code use32 public code
    start:
        
        repetare:
        push dword sir
        push dword format_in
        call [scanf]
        add esp, 4*2
        
        push dword sir
        call convert ;returneaza rezultatul in eax
        add esp, 4
        
        cmp eax, 0
        je exitt
        
        push eax
        push dword format_out
        call [printf]
        add esp, 4*2
        
        
        jmp repetare
        
    exitt:
        push dword 0
        call [exit]