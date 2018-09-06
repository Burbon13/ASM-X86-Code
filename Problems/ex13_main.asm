;Se dau trei siruri de caractere. Sa se afiseze cel mai lung sufix comun pentru fiecare din cele trei perechi de cate doua siruri ce se pot forma.
bits 32

global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll
extern sufix

segment data use32 public data
    sir1 db '5435abcd', 0
    lungime1 equ $ - sir1
    sir2 db '5435abcd', 0
    lungime2 equ $ - sir2
    sir3 db 'aabcd', 0
    lungime3 equ $ - sir3
    format_out db '%s ', 0
    
segment code use32 public code
    start:
        ;1 si 2
        push dword lungime2
        push dword sir2
        push dword lungime1
        push dword sir1
        call sufix
        add esp, 4 * 4
        
        push dword ecx
        push dword format_out
        call [printf]
        add esp, 4*2
        
        ;1 si 3
        push dword lungime3
        push dword sir3
        push dword lungime1
        push dword sir1
        call sufix
        add esp, 4 * 4
        
        push dword ecx
        push dword format_out
        call [printf]
        add esp, 4*2
        
        ;2 si 3
        push dword lungime3
        push dword sir3
        push dword lungime2
        push dword sir2
        call sufix
        add esp, 4 * 4
        
        push dword ecx
        push dword format_out
        call [printf]
        add esp, 4*2
        
        push dword 0
        call [exit]