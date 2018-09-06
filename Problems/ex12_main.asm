;Se dau doua siruri de caractere de lungimi egale. Se cere sa se calculeze si afiseze rezultatele intercalarii literelor, pentru cele doua intercalari posibile (literele din primul sir pe pozitii pare, si literele din primul sir pe pozitii impare).
bits 32

global start

extern exit, conc, printf
import exit msvcrt.dll
import printf msvcrt.dll


segment data use32 public data
    sir1 db 'abcdefg', 0
    sir2 db '1234567', 0
    ls equ $ - sir2
    format db "%s - ", 0
    

segment code use32 public code
    start:
        
        push dword ls
        push dword sir2
        push dword sir1
        call conc
        add esp, 4 * 3
        
        push eax
        push dword format
        call [printf]
        
        push dword ls
        push dword sir1
        push dword sir2
        call conc
        add esp, 4 * 3
        
        push eax
        push dword format
        call [printf]
        
        push dword 0
        call [exit]