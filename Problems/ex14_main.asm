;Se citesc mai multe numere de la tastatura, in baza 2. Sa se afiseze aceste numere in baza 8.
bits 32

global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
extern conv    

segment data use32 public data
    sir resb 100
    format_in db "%s", 0
    format_out db " %o", 0

segment code use32 public code
    start:
        
        repeta:
            
            push dword sir
            push dword format_in
            call [scanf]
            add esp, 4*2
            
            push dword sir
            call conv
            
            cmp ecx, 0
            je final
            
            push dword ecx
            push dword format_out
            call [printf]
            add esp, 4*2
            
        jmp repeta
        
    final:
        push dword 0
        call [exit]